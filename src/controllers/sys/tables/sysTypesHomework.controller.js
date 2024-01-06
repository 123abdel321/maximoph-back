import Joi  from "joi";
import { poolSys } from "../../../db.js";
import { getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { genLog } from "../../../helpers/sysLogs.js";

const getAllTypesHomeworks = async (req, res) => {
  try {
    let pool = poolSys.getPool(req.user.token_db);

    const [listHomeworksTypes] = await pool.query(
        `SELECT 
          id, nombre, descripcion, created_by, created_at, updated_by, updated_at
        FROM maestras_base WHERE tipo = 4 AND eliminado = 0`);
    
    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 34, 
      pool
    });

    //pool.end();

    return res.json({success: true, data: listHomeworksTypes, access});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createTypeHomework = async (req, res) => {   
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

    const [typeHomeworkExist] = await pool.query(
        "SELECT * FROM maestras_base WHERE tipo = 4 AND nombre = ?",
        [nombre]
    );

    if (typeHomeworkExist.length) {
        return res.status(201).json({ success: false, error: `El tipo de tarea ${nombre} ya se encuentra registrado.` });
    }

    //CREATE HOMEWORK TYPE
    const [insertedNewConcept] = await pool.query(`INSERT INTO maestras_base 
      (nombre, descripcion, tipo, created_by) 
        VALUES 
      (UPPER(?), UPPER(?), ?, ?)`,
      [nombre, descripcion, 4, req.user.id]
    );
    
    //GET NEW HOMEWORK TYPE
    const [rows] = await pool.query(`SELECT 
      id, nombre, descripcion, created_by, created_at, updated_by, updated_at
    FROM maestras_base 
    WHERE id = ?`, [ insertedNewConcept.insertId ]);
    
    let typeHomework = rows[0];
    
    await genLog({
        module: 'tipos_tarea', 
        idRegister: typeHomework.id, 
        recordBefore: typeHomework, 
        oper: 'CREATE', 
        detail: `TIPO DE TAREA CON NOMBRE ${typeHomework.nombre} CREADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });

    //pool.end();

    return res.json({success: true, data: {typeHomework}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putTypeHomework = async (req, res) => {   
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

    const [typeHomeworkExist] = await pool.query(
        "SELECT * FROM maestras_base WHERE tipo = 4 AND nombre = ? AND id <> ?",
        [nombre, id]
    );

    if (typeHomeworkExist.length) {
        return res.status(201).json({ success: false, error: `El tipo de tarea ${nombre} ya se encuentra registrado.` });
    }

    //GET BEFORE EDITED HOMEWORK TYPE
    const [rowsBefore] = await pool.query(`SELECT * FROM maestras_base WHERE id = ?`, [ id ]);

    let typeHomeworkBefore = rowsBefore[0];

    //UPDATE HOMEWORK TYPE
    await pool.query(`UPDATE maestras_base SET
        nombre = UPPER(?),
        descripcion = UPPER(?),
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [nombre, descripcion, req.user.id, id]
    );
    
    //GET EDITED HOMEWORK TYPE
    const [rows] = await pool.query(`SELECT 
      id, nombre, descripcion, created_by, created_at, updated_by, updated_at
    FROM maestras_base 
    WHERE id = ?`, [ id ]);
    
    let typeHomework = rows[0];
    
    await genLog({
        module: 'tipos_tarea', 
        idRegister: id, 
        recordBefore: typeHomeworkBefore, 
        oper: 'UPDATE', 
        detail: `TIPO DE TAREA CON NOMBRE ${typeHomeworkBefore.nombre} ACTUALIZADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });

    //pool.end();

    return res.json({success: true, data: {typeHomework}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteTypeHomework = async (req, res) => {    
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
    let [typeHomework] = await pool.query(`SELECT * FROM maestras_base WHERE id = ?`,[id]);
    typeHomework = typeHomework[0];

    await genLog({
        module: 'tipos_tarea', 
        idRegister: id, 
        recordBefore: {}, 
        oper: 'DELETE', 
        detail: `TIPO DE TAREA CON NOMBRE ${typeHomework.nombre} ELIMINADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });

    //DELETE TYPE HOMEWORK
    await pool.query(`UPDATE maestras_base SET eliminado = 1 WHERE id = ?`,
      [id]
    );
    
    //pool.end();

    return res.json({success: true, data: {typeHomework: { id }}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  getAllTypesHomeworks,
  createTypeHomework,
  deleteTypeHomework,
  putTypeHomework
};
