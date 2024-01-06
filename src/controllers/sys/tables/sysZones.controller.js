import Joi  from "joi";
import { poolSys } from "../../../db.js";
import { getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { genLog } from "../../../helpers/sysLogs.js";

const getAllZones = async (req, res) => {
  try {
    let pool = poolSys.getPool(req.user.token_db);

    const [listZones] = await pool.query(`SELECT 
      t1.*,
      t1.id AS value,
      t1.nombre AS label,
      CASE t1.tipo 
        WHEN 0 THEN 'USO COMÚN'
        WHEN 1 THEN 'INMUEBLE'
        WHEN 2 THEN 'PORTERIA'
      END AS tipoText,
      CONCAT(t2.codigo,' - ',t2.nombre) AS centroCostosLabel
      FROM 
        zonas t1 
      INNER JOIN erp_maestras t2 ON t2.id = t1.id_centro_costos_erp
      WHERE 1`);

    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 30, 
      pool
    });

    //pool.end();

    return res.json({success: true, data: listZones, access});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createZone = async (req, res) => {     
  try {
    const registerSchema = Joi.object({
      nombre: Joi.string().required(),
      tipo: Joi.number().required(),
      id_centro_costos_erp: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { nombre, tipo, id_centro_costos_erp } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    const [existZone] = await pool.query(
        "SELECT * FROM zonas WHERE nombre = ?",
        [nombre]
    );

    if (existZone.length) {
        return res.status(201).json({ success: false, error: `La zona ${nombre} ya se encuentra registrada.` });
    }

    //CREATE ZONE
    const [insertedNewZone] = await pool.query(`INSERT INTO zonas 
      (nombre, tipo, id_centro_costos_erp, created_by) 
        VALUES 
      (UPPER(?), ?, ?, ?)`,
      [nombre, tipo, id_centro_costos_erp, req.user.id]
    );
    
    //GET NEW ZONE
    const [rows] = await pool.query(`SELECT 
      *,
      CASE tipo 
        WHEN 0 THEN 'USO COMÚN'
        WHEN 1 THEN 'INMUEBLE'
        WHEN 2 THEN 'PORTERIA'
      END AS tipoText
    FROM zonas WHERE id = ?`, [ insertedNewZone.insertId ]);
    
    let zone = rows[0];
    
    await genLog({
        module: 'zonas', 
        idRegister: zone.id, 
        recordBefore: zone, 
        oper: 'CREATE', 
        detail: `ZONA CON NOMBRE ${zone.nombre} CREADA POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {zone}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putZone = async (req, res) => {   
  try {  
    const registerSchema = Joi.object({
      nombre: Joi.string().required(),
      tipo: Joi.number().required(),
      id_centro_costos_erp: Joi.number().required(),
      tipoText: Joi.required(),
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

    const { nombre, tipo, id_centro_costos_erp, id } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    const [existZone] = await pool.query(
        "SELECT * FROM zonas WHERE nombre = ? AND id <> ?",
        [nombre, id]
    );
      
    if (existZone.length) {
        return res.status(201).json({ success: false, error: `La zona ${nombre} ya se encuentra registrada.` });
    }

    //GET BEFORE EDITED ZONE
    const [rowsBefore] = await pool.query(`SELECT * FROM zonas WHERE id = ?`, [ id ]);

    let zoneBefore = rowsBefore[0];

    //UPDATE ZONE
    await pool.query(`UPDATE zonas SET
        nombre = UPPER(?), 
        tipo = ?, 
        id_centro_costos_erp = ?,
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [nombre, tipo, id_centro_costos_erp, req.user.id, id]
    );
    
    //GET EDITED ZONE
    const [rows] = await pool.query(`SELECT 
      *,
      CASE tipo 
        WHEN 0 THEN 'USO COMÚN'
        WHEN 1 THEN 'INMUEBLE'
        WHEN 2 THEN 'PORTERIA'
      END AS tipoText
    FROM zonas WHERE id = ?`, [id ]);
    
    let zone = rows[0];
        
    await genLog({
        module: 'zonas', 
        idRegister: zone.id, 
        recordBefore: zoneBefore, 
        oper: 'UPDATE', 
        detail: `ZONA CON NOMBRE ${zone.nombre} ACTUALIZADA POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {zone}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteZone = async (req, res) => {  
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

    //GET ZONE
    let [zone] = await pool.query(`SELECT * FROM zonas WHERE id = ?`,[id]);
    zone = zone[0];

    //GET PROPERTIES
    let [properties] = await pool.query(`SELECT * FROM inmuebles WHERE id_zona = ?`,[id]);
    if(properties.length){
      return res.status(201).json({ success: false, error: `La zona ${zone.nombre} tiene asociados ${properties.length} inmuebles, por favor valide.` });
    }
        
    await genLog({
        module: 'zonas', 
        idRegister: zone.id, 
        recordBefore: {}, 
        oper: 'DELETE', 
        detail: `ZONA CON NOMBRE ${zone.nombre} ELIMINADA POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });

    //DELETE ZONE
    await pool.query(`DELETE t1 FROM zonas t1 LEFT OUTER JOIN inmuebles t2 ON t2.id_zona = t1.id WHERE t1.id = ? AND t2.id IS NULL`,
      [id]
    );
    
    //pool.end();

    return res.json({success: true, data: {zone: { id }}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  getAllZones,
  createZone,
  deleteZone,
  putZone
};
