import Joi  from "joi";
import { poolSys } from "../../../db.js";
import { getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { genLog } from "../../../helpers/sysLogs.js";

const getAllVehicleTypes = async (req, res) => {
  try {
    let pool = poolSys.getPool(req.user.token_db);

    const [vehcileTypes] = await pool.query(
        `SELECT 
          id, nombre, id AS value, nombre AS label, created_by, created_at, updated_by, updated_at
        FROM maestras_base WHERE tipo = 2`);

    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 36, 
      pool
    });
    
    //pool.end();

    return res.json({success: true, data: vehcileTypes, access});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createVehicleType = async (req, res) => {   
  try {
    const registerSchema = Joi.object({
      nombre: Joi.string().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { nombre } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    const [vehicleTypeExist] = await pool.query(
        "SELECT * FROM maestras_base WHERE tipo = 2 AND nombre = ?",
        [nombre]
    );

    if (vehicleTypeExist.length) {
        return res.status(201).json({ success: false, error: `El tipo de vehículo ${nombre} ya se encuentra registrado.` });
    }

    //CREATE VEHICLE TYPE
    const [insertedNewConcept] = await pool.query(`INSERT INTO maestras_base 
      (nombre, tipo, created_by) 
        VALUES 
      (UPPER(?), ?, ?)`,
      [nombre, 2, req.user.id]
    );
    
    //GET NEW VEHICLE TYPE
    const [rows] = await pool.query(`SELECT 
      id, nombre, created_by, created_at, updated_by, updated_at
    FROM maestras_base 
    WHERE id = ?`, [ insertedNewConcept.insertId ]);
    
    let vehicleType = rows[0];
    
    await genLog({
        module: 'tipos_vehiculo', 
        idRegister: vehicleType.id, 
        recordBefore: vehicleType, 
        oper: 'CREATE', 
        detail: `TIPO DE VEHICULO CON NOMBRE ${vehicleType.nombre} CREADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {vehicleType}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putVehicleType = async (req, res) => { 
  try{    
    const registerSchema = Joi.object({
      nombre: Joi.string().required(),
      descripcion: Joi.string().allow(null,''), 
      created_by: Joi.number(), 
      created_at: Joi.date(), 
      updated_at: Joi.string().allow(null,''), 
      updated_by: Joi.number().allow(null,''), 
      id: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { nombre, id } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    const [vehicleTypeExist] = await pool.query(
        "SELECT * FROM maestras_base WHERE tipo = 2 AND nombre = ? AND id <> ?",
        [nombre, id]
    );

    if (vehicleTypeExist.length) {
        return res.status(201).json({ success: false, error: `El tipo de vehículo ${nombre} ya se encuentra registrado.` });
    }

    //GET BEFORE EDITED VEHICLE TYPE
    const [rowsBefore] = await pool.query(`SELECT * FROM maestras_base WHERE id = ?`, [ id ]);
    let vehicleTypeBefore = rowsBefore[0];

    //UPDATE VEHICLE TYPE
    await pool.query(`UPDATE maestras_base SET
        nombre = UPPER(?),
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [nombre, req.user.id, id]
    );
    
    //GET EDITED VEHICLE TYPE
    const [rows] = await pool.query(`SELECT 
      id, nombre, created_by, created_at, updated_by, updated_at
    FROM maestras_base 
    WHERE id = ?`, [ id ]);
    
    let vehicleType = rows[0];
    
    await genLog({
        module: 'tipos_vehiculo', 
        idRegister: id, 
        recordBefore: vehicleTypeBefore, 
        oper: 'UPDATE', 
        detail: `TIPO DE VEHICULO CON NOMBRE ${vehicleType.nombre} ACTUALIZADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {vehicleType}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteVehicleType = async (req, res) => {   
  try {  
    const registerSchema = Joi.object({
      id: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.params);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }
    
    const { id } = req.params;

    let pool = poolSys.getPool(req.user.token_db);

    //GET VEHICLE TYPE
    let [vehicleType] = await pool.query(`SELECT * FROM maestras_base WHERE id = ?`,[id]);
    vehicleType = vehicleType[0];
    
    await genLog({
      module: 'tipos_vehiculo', 
      idRegister: id, 
      recordBefore: {}, 
      oper: 'DELETE', 
      detail: `TIPO DE VEHICULO CON NOMBRE ${vehicleType.nombre} ELIMINADO POR ${req.user.email}`, 
      user: req.user.id,
      pool
  });

    //DELETE VEHICLE TYPE
    await pool.query(`DELETE FROM maestras_base WHERE id = ?`,
      [id]
    );
    
    //pool.end();

    return res.json({success: true, data: {vehicleType: { id }}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  getAllVehicleTypes,
  createVehicleType,
  deleteVehicleType,
  putVehicleType
};
