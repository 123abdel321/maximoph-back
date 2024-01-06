import Joi  from "joi";
import { poolSys } from "../../../db.js";
import { getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { genLog } from "../../../helpers/sysLogs.js";

const getAllProviderTypes = async (req, res) => {
  try{
    let pool = poolSys.getPool(req.user.token_db);

    const [providerTypes] = await pool.query(
        `SELECT 
          id, nombre, created_by, created_at, updated_by, updated_at
        FROM maestras_base WHERE tipo = 1`);

    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 35, 
      pool
    });

    //pool.end();

    return res.json({success: true, data: providerTypes, access});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createProviderType = async (req, res) => {   
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

    const [providerTypeExist] = await pool.query(
        "SELECT * FROM maestras_base WHERE tipo = 1 AND nombre = ?",
        [nombre]
    );

    if (providerTypeExist.length) {
        return res.status(201).json({ success: false, error: `El tipo de proveedor ${nombre} ya se encuentra registrado.` });
    }

    //CREATE PROVIDER TYPE
    const [insertedNewConcept] = await pool.query(`INSERT INTO maestras_base 
      (nombre, tipo, created_by) 
        VALUES 
      (UPPER(?), ?, ?)`,
      [nombre, 1, req.user.id]
    );
    
    //GET NEW PROVIDER TYPE
    const [rows] = await pool.query(`SELECT 
      id, nombre, created_by, created_at, updated_by, updated_at
    FROM maestras_base 
    WHERE id = ?`, [ insertedNewConcept.insertId ]);
    
    let providerType = rows[0];
    
    await genLog({
        module: 'tipos_proveedor', 
        idRegister: providerType.id, 
        recordBefore: providerType, 
        oper: 'CREATE', 
        detail: `TIPO DE PROVEEDOR CON NOMBRE ${providerType.nombre} CREADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {providerType}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putProviderType = async (req, res) => {    
  try {
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

    const [providerTypeExist] = await pool.query(
        "SELECT * FROM maestras_base WHERE tipo = 1 AND nombre = ? AND id <> ?",
        [nombre, id]
    );

    if (providerTypeExist.length) {
        return res.status(201).json({ success: false, error: `El tipo de proveedor ${nombre} ya se encuentra registrado.` });
    }

    //GET BEFORE EDITED PROVIDER TYPE
    const [rowsBefore] = await pool.query(`SELECT * FROM maestras_base WHERE id = ?`, [ id ]);
    let providerTypeBefore = rowsBefore[0];

    //UPDATE PROVIDER TYPE
    await pool.query(`UPDATE maestras_base SET
        nombre = UPPER(?),
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [nombre, req.user.id, id]
    );
    
    //GET EDITED PROVIDER TYPE
    const [rows] = await pool.query(`SELECT 
      id, nombre, created_by, created_at, updated_by, updated_at
    FROM maestras_base 
    WHERE id = ?`, [ id ]);
    
    let providerType = rows[0];
    
    await genLog({
        module: 'tipos_proveedor', 
        idRegister: id, 
        recordBefore: providerTypeBefore, 
        oper: 'UPDATE', 
        detail: `TIPO DE PROVEEDOR CON NOMBRE ${providerTypeBefore.nombre} ACTUALIZADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {providerType}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteProviderType = async (req, res) => {     
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
    
    //GET PROVIDER TYPE
    let [providerType] = await pool.query(`SELECT * FROM maestras_base WHERE id = ?`,[id]);
    providerType = providerType[0];

    await genLog({
        module: 'tipos_proveedor', 
        idRegister: id, 
        recordBefore: {}, 
        oper: 'DELETE', 
        detail: `TIPO DE PROVEEDOR CON NOMBRE ${providerType.nombre} ELIMINADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });

    //DELETE PROVIDER TYPE
    await pool.query(`DELETE FROM maestras_base WHERE id = ?`,
      [id]
    );
    
    //pool.end();

    return res.json({success: true, data: {providerType: { id }}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  getAllProviderTypes,
  createProviderType,
  deleteProviderType,
  putProviderType
};
