import Joi  from "joi";
import { poolSys } from "../../../db.js";
import { getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { genLog } from "../../../helpers/sysLogs.js";

const getAllVisitConcepts = async (req, res) => {
  try { 
    let pool = poolSys.getPool(req.user.token_db);

    const [listVisitConcepts] = await pool.query(
        `SELECT 
          t1.id, t1.nombre, t1.id AS value, t1.nombre AS label, t1.descripcion, t1.created_by, t1.created_at, t1.updated_by, t1.updated_at
        FROM maestras_base t1 WHERE t1.tipo = 3 AND t1.eliminado = 0`);
    
    const [defaultVisitConcept] = await pool.query(`SELECT IFNULL(t2.valor,'') AS valor FROM entorno t2 WHERE t2.campo='id_concepto_visita'`);
    
    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 33, 
      pool
    });

    //pool.end();

    return res.json({success: true, data: listVisitConcepts, default: defaultVisitConcept, access});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createVisitConcept = async (req, res) => {     
  try {
    const registerSchema = Joi.object({
      nombre: Joi.string().required(),
      descripcion: Joi.string().allow(null,'')
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { nombre, descripcion } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    const [existVisitConcept] = await pool.query(
        "SELECT * FROM maestras_base WHERE tipo = 3 AND nombre = ?",
        [nombre]
    );

    if (existVisitConcept.length) {
        return res.status(201).json({ success: false, error: `El concepto de visita ${nombre} ya se encuentra registrado.` });
    }

    //CREATE VISIT CONCEPT
    const [insertedNewConcept] = await pool.query(`INSERT INTO maestras_base 
      (nombre, descripcion, tipo, created_by) 
        VALUES 
      (UPPER(?), UPPER(?), ?, ?)`,
      [nombre, descripcion, 3, req.user.id]
    );
    
    //GET NEW VISIT CONCEPT
    const [rows] = await pool.query(`SELECT 
      id, nombre, descripcion, created_by, created_at, updated_by, updated_at
    FROM maestras_base 
    WHERE id = ?`, [ insertedNewConcept.insertId ]);
    
    let visitConcept = rows[0];
    
    await genLog({
        module: 'conceptos_visitas', 
        idRegister: visitConcept.id, 
        recordBefore: visitConcept, 
        oper: 'CREATE', 
        detail: `CONCEPTO DE VISITA CON NOMBRE ${visitConcept.nombre} CREADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {visitConcept}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putVisitConcept = async (req, res) => {  
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

    const { nombre, descripcion, id } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    const [existVisitConcept] = await pool.query(
        "SELECT * FROM maestras_base WHERE tipo = 3 AND nombre = ? AND id <> ?",
        [nombre, id]
    );

    if (existVisitConcept.length) {
        return res.status(201).json({ success: false, error: `El concepto de visita ${nombre} ya se encuentra registrado.` });
    }

    //GET BEFORE EDITED VISIT CONCEPT
    const [rowsBefore] = await pool.query(`SELECT * FROM maestras_base WHERE id = ?`, [ id ]);

    let conceptVisitBefore = rowsBefore[0];

    //UPDATE VISIT CONCEPT
    await pool.query(`UPDATE maestras_base SET
        nombre = UPPER(?),
        descripcion = UPPER(?),
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [nombre, descripcion, req.user.id, id]
    );
    
    //GET EDITED VISIT CONCEPT
    const [rows] = await pool.query(`SELECT 
      id, nombre, descripcion, created_by, created_at, updated_by, updated_at
    FROM maestras_base 
    WHERE id = ?`, [ id ]);
    
    let visitConcept = rows[0];
    
    await genLog({
        module: 'conceptos_visitas', 
        idRegister: conceptVisitBefore.id, 
        recordBefore: conceptVisitBefore, 
        oper: 'UPDATE', 
        detail: `CONCEPTO DE VISITA CON NOMBRE ${conceptVisitBefore.nombre} ACTUALIZADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {visitConcept}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteVisitConcept = async (req, res) => {    
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

    //GET VISIT CONCEPT
    let [visitConcept] = await pool.query(`SELECT * FROM maestras_base WHERE id = ?`,[id]);
    visitConcept = visitConcept[0];
    
    await genLog({
        module: 'conceptos_visitas', 
        idRegister: visitConcept.id, 
        recordBefore: {}, 
        oper: 'DELETE', 
        detail: `CONCEPTO DE VISITA CON NOMBRE ${visitConcept.nombre} ELIMINADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });

    //DELETE VISIT CONCEPT
    await pool.query(`UPDATE maestras_base SET eliminado = 1 WHERE id = ?`,
      [id]
    );

    //pool.end();

    return res.json({success: true, data: {visitConcept: { id }}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  getAllVisitConcepts,
  createVisitConcept,
  deleteVisitConcept,
  putVisitConcept
};
