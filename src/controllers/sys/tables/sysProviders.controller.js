import Joi  from "joi";
import { poolSys } from "../../../db.js";
import { getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { genLog } from "../../../helpers/sysLogs.js";

const getAllProviders = async (req, res) => {
  try{
    let pool = poolSys.getPool(req.user.token_db);

    const [providers] = await pool.query(`SELECT 
        t1.*,
        CONCAT(
          IFNULL(t2.primer_nombre,''),' ',
          IFNULL(t2.segundo_nombre,''),' ',
          IFNULL(t2.primer_apellido,''),' ',
          IFNULL(t2.segundo_apellido,''),' '
        ) AS nombreProveedor,
        IFNULL(t2.telefono,'') AS telefonoProveedor,
        IFNULL(t2.celular,'') AS celularProveedor,
        IFNULL(t2.email,'') AS emailProveedor,
        IFNULL(t2.direccion,'') AS direccionProveedor,
        IFNULL(t3.nombre,'') AS actividadProveedor
        FROM proveedores t1
          LEFT OUTER JOIN personas t2 ON t2.id = t1.id_persona
          LEFT OUTER JOIN maestras_base t3 ON t3.id = t1.id_actividad
        WHERE 1`);
            
    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 4, 
      pool
    });

    //pool.end();

    return res.json({success: true, data: providers, access});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createProvider = async (req, res) => {   
  try {
    const registerSchema = Joi.object({
      id_persona: Joi.number().allow(null,''),
      id_actividad: Joi.number().allow(null,''),
      nombre_negocio: Joi.string().required(),
      observacion: Joi.string().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { id_persona, id_actividad, nombre_negocio, observacion } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    const [providerExist] = await pool.query("SELECT * FROM proveedores WHERE nombre_negocio = ?",[nombre_negocio]);

    if (providerExist.length) {
        return res.status(201).json({ success: false, error: `El proveedor ${nombre_negocio} ya se encuentra registrado.` });
    }

    //CREATE PROVIDER
    const [insertedNewProvider] = await pool.query(`INSERT INTO proveedores 
      (id_persona, id_actividad, nombre_negocio, observacion, created_by) 
        VALUES 
      (?, ?, UPPER(?), UPPER(?), ?)`,
      [id_persona, id_actividad, nombre_negocio, observacion, req.user.id]
    );
    
    //GET NEW PROVIDER
    const [rows] = await pool.query(`SELECT 
      t1.*,
      CONCAT(
        IFNULL(t2.primer_nombre,''),' ',
        IFNULL(t2.segundo_nombre,''),' ',
        IFNULL(t2.primer_apellido,''),' ',
        IFNULL(t2.segundo_apellido,''),' '
      ) AS nombreProveedor,
      IFNULL(t2.telefono,'') AS telefonoProveedor,
      IFNULL(t2.celular,'') AS celularProveedor,
      IFNULL(t2.email,'') AS emailProveedor,
      IFNULL(t2.direccion,'') AS direccionProveedor,
      IFNULL(t3.nombre,'') AS actividadProveedor
      FROM proveedores t1
        LEFT OUTER JOIN personas t2 ON t2.id = t1.id_persona
        LEFT OUTER JOIN maestras_base t3 ON t3.id = t1.id_actividad
      WHERE t1.id = ?`, [ insertedNewProvider.insertId ]);
    
    let provider = rows[0];
    
    await genLog({
        module: 'proveedores', 
        idRegister: provider.id, 
        recordBefore: provider, 
        oper: 'CREATE', 
        detail: `PROVEEDOR CON NOMBRE ${provider.nombreProveedor} CREADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {provider}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putProvider = async (req, res) => {    
  try {
    const registerSchema = Joi.object({
      id_persona: Joi.number().allow(null,''),
      id_actividad: Joi.number().allow(null,''),
      nombre_negocio: Joi.string().required(),
      observacion: Joi.string().required(),
      id: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { nombre_negocio, id_persona, id_actividad, observacion, id } = req.body;

    let pool = poolSys.getPool(req.user.token_db);
    
    const [providerExist] = await pool.query("SELECT * FROM proveedores WHERE nombre_negocio = ? AND id <> ?", [nombre_negocio, id]);

    if (providerExist.length) {
      return res.status(201).json({ success: false, error: `El proveedor ${nombre_negocio} ya se encuentra registrado.` });
    }

    //GET BEFORE EDITED PROVIDER
    const [rowsBefore] = await pool.query(`SELECT * FROM proveedores WHERE id = ?`, [ id ]);

    let providerBefore = rowsBefore[0];

    //UPDATE PROVIDER
    await pool.query(`UPDATE proveedores SET
        id_persona = ?,
        id_actividad = ?,
        nombre_negocio = UPPER(?),
        observacion = UPPER(?),
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [id_persona, id_actividad, nombre_negocio, observacion, req.user.id, id]
    );
    
    //GET EDITED PROVIDER
    const [rows] = await pool.query(`SELECT 
        t1.*,
        CONCAT(
          IFNULL(t2.primer_nombre,''),' ',
          IFNULL(t2.segundo_nombre,''),' ',
          IFNULL(t2.primer_apellido,''),' ',
          IFNULL(t2.segundo_apellido,''),' '
        ) AS nombreProveedor,
        IFNULL(t2.telefono,'') AS telefonoProveedor,
        IFNULL(t2.celular,'') AS celularProveedor,
        IFNULL(t2.email,'') AS emailProveedor,
        IFNULL(t2.direccion,'') AS direccionProveedor,
        IFNULL(t3.nombre,'') AS actividadProveedor
      FROM proveedores t1
        LEFT OUTER JOIN personas t2 ON t2.id = t1.id_persona
        LEFT OUTER JOIN maestras_base t3 ON t3.id = t1.id_actividad
      WHERE t1.id = ?`, [ id ]);
    
    let provider = rows[0];
        
    await genLog({
        module: 'proveedores', 
        idRegister: provider.id, 
        recordBefore: providerBefore, 
        oper: 'UPDATE', 
        detail: `PROVEEDOR CON NOMBRE ${provider.nombreProveedor} ACTUALIZADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {provider}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteProvider = async (req, res) => {     
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


    //GET PROVIDER
    let [provider] = await pool.query(`SELECT * FROM proveedores WHERE id = ?`,[id]);
    provider = provider[0];
        
    await genLog({
        module: 'proveedores', 
        idRegister: provider.id, 
        recordBefore: {}, 
        oper: 'DELETE', 
        detail: `PROVEEDOR CON NOMBRE ${provider.nombre_negocio} ELIMINADA POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });

    //DELETE PROVIDER
    await pool.query(`DELETE FROM proveedores WHERE id = ?`,
      [id]
    );
    
    //pool.end();

    return res.json({success: true, data: {provider: { id }}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  getAllProviders,
  createProvider,
  deleteProvider,
  putProvider
};
