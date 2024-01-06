import Joi  from "joi";
import { poolAdm } from "../../db.js";
import { getModuleAccess } from "../../helpers/sysEnviroment.js";

const getAllRoles = async (req, res) => {
  try {
    let idCustomer = req.user.id_cliente;
    
    let pool = poolAdm;

    const [listRoles] = await pool.query(
      `SELECT id, id_cliente, nombre, descripcion FROM maestras_base WHERE tipo = 0 AND (id_cliente IS NULL OR id_cliente=${idCustomer}) AND nombre!='MAXIMO_ADMIN'AND nombre!='MAXIMO_USUARIO_BASICO'`
    );

    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 11, 
      pool
    });

    //pool.end();
    
    return res.json({success: true, data: listRoles, access});
  } catch (error) {
    return res.json(error.message);
  }
};

const createRole = async (req, res) => {   
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

    let idCustomer = req.user.id_cliente;

    let pool = poolAdm;

    const [roleExist] = await pool.query(
        `SELECT id, nombre FROM maestras_base WHERE tipo = 0 AND UPPER(nombre) = UPPER(?) AND (id_cliente IS NULL OR id_cliente=?)`,
        [nombre, idCustomer]
    );

    if (roleExist.length) {
        return res.status(201).json({ success: false, error: `El rol ${roleExist[0].nombre} ya se encuentra registrado.` });
    }

    //CREATE ROL
    const [insertedNewRol] = await pool.query(`INSERT INTO maestras_base 
      (id_cliente, nombre, descripcion, tipo, created_by) 
        VALUES 
      (?, UPPER(?), UPPER(?), ?, ?)`,
      [idCustomer, nombre, descripcion, 0, req.user.id]
    );
    
    //GET NEW ROL
    const [rows] = await pool.query(`SELECT 
      id, nombre, descripcion, created_by, created_at, updated_by, updated_at
    FROM maestras_base 
    WHERE id = ?`, [ insertedNewRol.insertId ]);
    
    let rol = rows[0];

    //pool.end();

    return res.json({success: true, data: {rol}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putRole = async (req, res) => {   
  try {  
    const registerSchema = Joi.object({
      nombre: Joi.string().required(),
      descripcion: Joi.string().allow(null,''),
      id_cliente: Joi.number().required(),
      id: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { nombre, descripcion, id } = req.body;

    let idCustomer = req.user.id_cliente;
    
    let pool = poolAdm;

    const [roleExist] = await pool.query(
        `SELECT id, nombre FROM maestras_base WHERE tipo = 0 AND UPPER(nombre) = UPPER(?) AND (id_cliente IS NULL OR id_cliente=?) AND id <> ?`,
        [nombre, idCustomer, id]
    );

    if (roleExist.length) {
        return res.status(201).json({ success: false, error: `El rol ${roleExist[0].nombre} ya se encuentra registrado.` });
    }
    
    const [roleMaximo] = await pool.query(
        `SELECT id, nombre FROM maestras_base WHERE id_cliente IS NULL AND id=?`,
        [id]
    );

    if (roleMaximo.length) {
        return res.status(201).json({ success: false, error: `El rol ${roleMaximo[0].nombre} no puede ser editado.` });
    }

    //UPDATE ROLE
    await pool.query(`UPDATE maestras_base SET
        nombre = UPPER(?),
        descripcion = UPPER(?),
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [nombre, descripcion, req.user.id, id]
    );
    
    //GET EDITED ROLE
    const [rows] = await pool.query(`SELECT 
      id, nombre, descripcion, created_by, created_at, updated_by, updated_at
    FROM maestras_base 
    WHERE id = ?`, [ id ]);
    
    let rol = rows[0];
    
    //pool.end();

    return res.json({success: true, data: {rol}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteRole = async (req, res) => {    
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

    let pool = poolAdm;
    
    const [roleMaximo] = await pool.query(
        `SELECT id, nombre FROM maestras_base WHERE id_cliente IS NULL AND id=?`,
        [id]
    );

    if (roleMaximo.length) {
        return res.status(201).json({ success: false, error: `El rol ${roleMaximo[0].nombre} no puede ser eliminado.` });
    }

    //RE-ASIGN ROLE BY MAXIMO_USUARIO_BASICO
    await pool.query(`UPDATE usuario_roles SET id_rol = 27 WHERE id_rol = ?`, [id]);

    //DELETE ROLE
    await pool.query(`DELETE FROM maestras_base WHERE id = ?`, [id]);
    
    //pool.end();

    return res.json({success: true, data: {rol: { id }}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  getAllRoles,
  deleteRole,
  createRole,
  putRole
};
