import Joi  from "joi";
import { poolSys } from "../../../db.js";
import { getSysEnv } from "../../../helpers/sysEnviroment.js";
import { createUpdatePropertyCyclicalBill } from "../../../helpers/sysPropertyCyclicalBill.js";

const getAllPropertyOwnersRenters = async (req, res) => {
  try {
    const registerSchema = Joi.object({
        id_inmueble: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.params);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }
    const { id_inmueble } = req.params;

    let pool = poolSys.getPool(req.user.token_db);

    const [propertieOwnersRenters] = await pool.query(
        `SELECT 
            t1.*,
            IFNULL(t2.email,'') As email,
            IFNULL(t2.telefono,'') AS telefono,
            IFNULL(t2.celular,'') AS celular,
            IF(t1.enviar_notificaciones='0','NO','SI') AS notificacionesText,
            IF(t1.tipo='0','PROPIETARIO','INQUILINO') AS tipoText,
            CONCAT(IFNULL(t2.primer_nombre,''),' ',IFNULL(t2.segundo_nombre,''),' ',IFNULL(t2.primer_apellido,''),' ',IFNULL(t2.segundo_apellido,'')) AS personaText,
            IFNULL(t2.numero_documento,'') AS personaDocumento,
            IFNULL(t2.avatar,'') AS avatar
        FROM inmueble_personas_admon t1 
        INNER JOIN personas t2 ON t2.id = t1.id_persona
        WHERE t1.id_inmueble = ? `,[id_inmueble]);
    
    //pool.end();

    return res.json({success: true, data: propertieOwnersRenters});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const getAllPropertiesByOwnerRenter = async (req, res) => {
  try {
    const registerSchema = Joi.object({
        email: Joi.string().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.params);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }
    const { email } = req.params;

    let pool = poolSys.getPool(req.user.token_db);

    const [propertiesOwnerRenter] = await pool.query(
        `SELECT 
            t3.id,
            t3.numero_interno_unidad As numero,
            t4.nombre AS zonaText,
            t1.id_persona,
            CASE t3.tipo 
                WHEN 0 THEN 'INMUEBLE'
                WHEN 1 THEN 'PARQUEADERO'
                WHEN 2 THEN 'CUARTO ÚTIL'
            END AS tipoText
        FROM inmueble_personas_admon t1 
        INNER JOIN personas t2 ON t2.id = t1.id_persona
        INNER JOIN inmuebles t3 ON t3.id = t1.id_inmueble
        INNER JOIN zonas t4 ON t4.id = t3.id_inmueble_zona
        WHERE t2.email = ? AND t3.tipo = 0 GROUP BY t1.id_inmueble`,[email]);
    
    //pool.end();

    return res.json({success: true, data: propertiesOwnerRenter});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createPropertyOwnerRenter = async (req, res) => { 
  
  try {
    const registerSchema = Joi.object({
        id_inmueble: Joi.number().required(), 
        id_persona: Joi.number().required(), 
        tipo: Joi.number().required(), 
        porcentaje_administracion: Joi.number().required(), 
        paga_administracion: Joi.number().required(), 
        enviar_notificaciones: Joi.number().required(),
        enviar_notificaciones_mail: Joi.number().required(),
        enviar_notificaciones_fisica: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }
    
    const { id_inmueble, id_persona, porcentaje_administracion, paga_administracion, enviar_notificaciones, enviar_notificaciones_mail, enviar_notificaciones_fisica, tipo } = req.body;

    let pool = poolSys.getPool(req.user.token_db);
    
    //VALIDATE EXISTS OWN OR RENTAL
    const [existOwnerRental] = await pool.query(
      "SELECT * FROM inmueble_personas_admon WHERE id_persona = ? AND id_inmueble = ?",
      [id_persona, id_inmueble]
    );
    
    if (existOwnerRental.length) {
      return res.status(201).json({ success: false, error: `El propietario/inquilinos ya se encuentra asociado al inmueble.` });
    }

    let [tipoInmueble] = await pool.query("SELECT tipo FROM inmuebles WHERE id = ?",[id_inmueble]);
        tipoInmueble = tipoInmueble[0];

    let adminConcept = await getSysEnv({
        name: 'id_concepto_administracion',
        pool: pool
    });
    
    let adminConceptParqueadero = await getSysEnv({
        name: 'id_concepto_administracion_parqueadero',
        pool: pool
    });

    let adminConceptCuartoUtil = await getSysEnv({
        name: 'id_concepto_administracion_cuarto_util',
        pool: pool
    });

    let conceptAdmonToUpdate = adminConcept;

    switch(Number(tipoInmueble)){
        case 0: 
            conceptAdmonToUpdate = adminConcept;
        break;
        case 1:
            conceptAdmonToUpdate = adminConceptParqueadero ? adminConceptParqueadero : adminConcept;
        break;
        case 2: 
            conceptAdmonToUpdate = adminConceptCuartoUtil ? adminConceptCuartoUtil : adminConcept;   
        break;
    }

    if (!conceptAdmonToUpdate) {
      return res.status(201).json({ success: false, error: `El sistema no tiene los conceptos configurados;<br/> Entorno > Configuración General Máximo PH` });
    }

    //CREATE PROPERTY OWNER RENTER
    const [insertedNewPropertyOwnerRenter] = await pool.query(`INSERT INTO inmueble_personas_admon 
            (id_inmueble, id_persona, porcentaje_administracion, paga_administracion, enviar_notificaciones, enviar_notificaciones_mail, enviar_notificaciones_fisica, tipo, created_by) 
                VALUES 
            (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [id_inmueble, id_persona, porcentaje_administracion, paga_administracion, enviar_notificaciones, enviar_notificaciones_mail, enviar_notificaciones_fisica, tipo, req.user.id]
    );
    
    //CREATE OR UPDATE CYCLICAL BILL
    await createUpdatePropertyCyclicalBill({ idInmueble: id_inmueble, pool, adminConcept: conceptAdmonToUpdate, admonValidate: 0, percent: 0, req });
    
    //GET NEW PROPERTY OWNER RENTER
    const [rows] = await pool.query(`SELECT 
        t1.*, 
        CONCAT(IFNULL(t2.primer_nombre,''),' ',IFNULL(t2.segundo_nombre,''),' ',IFNULL(t2.primer_apellido,''),' ',IFNULL(t2.segundo_apellido,'')) AS personaText
    FROM inmueble_personas_admon t1 
    INNER JOIN personas t2 ON t2.id = t1.id_persona
    WHERE t1.id = ? `, [ insertedNewPropertyOwnerRenter.insertId ]);
    
    let propertyOwnerRenter = rows[0];
    
    //pool.end();

    return res.json({success: true, data: {propertyOwnerRenter}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putPropertyOwnerRenter = async (req, res) => {
  
  try {
    //BUSCAR FACTURAS CICLICAS SIN INMUEBLES RELACIONADOS

    const registerSchema = Joi.object({
        id_inmueble: Joi.number().required(), 
        id_persona: Joi.number().required(), 
        tipo: Joi.number().required(), 
        porcentaje_administracion: Joi.number().required(), 
        paga_administracion: Joi.number().required(),
        enviar_notificaciones: Joi.number().required(),
        enviar_notificaciones_mail: Joi.number().required(),
        enviar_notificaciones_fisica: Joi.number().required(),
        email: Joi.string().allow(null,''),
        avatar: Joi.allow(null,''),
        importado: Joi.allow(null,''),
        telefono: Joi.string().allow(null,''),
        celular: Joi.string().allow(null,''),
        tipoText: Joi.string().allow(null,''),
        personaText: Joi.string().allow(null,''),
        personaDocumento: Joi.string().allow(null,''),
        notificacionesText: Joi.string().allow(null,''),
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

    const { id_persona, id_inmueble, porcentaje_administracion, paga_administracion, enviar_notificaciones, enviar_notificaciones_mail, enviar_notificaciones_fisica, tipo, id } = req.body;

    let pool = poolSys.getPool(req.user.token_db);
    
    //VALIDATE EXISTS OWN OR RENTAL
    const [existOwnerRental] = await pool.query(
      "SELECT * FROM inmueble_personas_admon WHERE id_persona = ? AND id_inmueble = ? AND id <> ?",
      [id_persona, id_inmueble, id]
    );
    
    if (existOwnerRental.length) {
      return res.status(201).json({ success: false, error: `El propietario/inquilinos ya se encuentra asociado al inmueble.` });
    }

    //UPDATE PROPERTY OWNER RENTER
    await pool.query(`UPDATE inmueble_personas_admon SET
        id_persona = ?, 
        porcentaje_administracion = ?, 
        paga_administracion = ?, 
        enviar_notificaciones = ?,
        enviar_notificaciones_mail = ?,
        enviar_notificaciones_fisica = ?,
        tipo = ?,
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [id_persona, porcentaje_administracion, paga_administracion, enviar_notificaciones, enviar_notificaciones_mail, enviar_notificaciones_fisica, tipo, req.user.id, id]
    );

    //BUSCAR PERSONAS DESASOCIADAS DE INMUEBLES 
    const [existInmueblesPerson] = await pool.query(
      `SELECT
        *
      FROM inmueble_personas_admon
        WHERE id_inmueble = ${id_inmueble}
      GROUP BY id_persona`,
    );
    
    var personasExistentes = []; 
    await Promise.all(existInmueblesPerson.map(async existInmueble=>{
      personasExistentes.push(existInmueble.id_persona);
    }));

    if (personasExistentes.length > 0) {//SI ENCUENTRA FACTURAS SIN % LAS ELIMINA

      var facturasExistentes = [];

      const [facturasCiclicas] = await pool.query(
        `SELECT
          *
        FROM
          facturas_ciclica
          
        WHERE id_persona NOT IN (${personasExistentes.toString()})
          AND id_inmueble = ${id_inmueble}`,
      );
  
      await Promise.all(facturasCiclicas.map(async facturaCiclica=>{
        facturasExistentes.push(facturaCiclica.id);
      }));

      if (facturasExistentes.length) {
        await pool.query(
          `DELETE
          FROM
            facturas_ciclica
          WHERE id IN (${facturasExistentes.toString()})`,
        );
    
        await pool.query(
          `DELETE
          FROM
            factura_ciclica_detalles
          WHERE id_factura_ciclica IN (${facturasExistentes.toString()})`,
        );
      }
    }
    //FINALIZAR DESASOCIAMIENTO DE INMUBLES

    let [tipoInmueble] = await pool.query("SELECT tipo FROM inmuebles WHERE id = ?",[id_inmueble]);
        tipoInmueble = tipoInmueble[0];

    let adminConcept = await getSysEnv({
        name: 'id_concepto_administracion',
        pool: pool
    });
    
    let adminConceptParqueadero = await getSysEnv({
        name: 'id_concepto_administracion_parqueadero',
        pool: pool
    });

    let adminConceptCuartoUtil = await getSysEnv({
        name: 'id_concepto_administracion_cuarto_util',
        pool: pool
    });

    let conceptAdmonToUpdate = adminConcept;

    switch(Number(tipoInmueble)){
        case 0: 
            conceptAdmonToUpdate = adminConcept;
        break;
        case 1:
            conceptAdmonToUpdate = adminConceptParqueadero ? adminConceptParqueadero : adminConcept;
        break;
        case 2: 
            conceptAdmonToUpdate = adminConceptCuartoUtil ? adminConceptCuartoUtil : adminConcept;   
        break;
    }

    //CREATE OR UPDATE CYCLICAL BILL
    await createUpdatePropertyCyclicalBill({ idInmueble: id_inmueble, pool, adminConcept: conceptAdmonToUpdate, admonValidate: 0, percent: 0, req });

    //GET EDITED PROPERTY OWNER RENTER
    const [rows] = await pool.query(`SELECT 
        t1.*, 
        CONCAT(IFNULL(t2.primer_nombre,''),' ',IFNULL(t2.segundo_nombre,''),' ',IFNULL(t2.primer_apellido,''),' ',IFNULL(t2.segundo_apellido,'')) AS personaText
    FROM inmueble_personas_admon t1 
    INNER JOIN personas t2 ON t2.id = t1.id_persona
    WHERE t1.id = ? `, [ id ]);
    
    let propertyOwnerRenter = rows[0];
    
    //pool.end();

    return res.json({success: true, data: {propertyOwnerRenter}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deletePropertyOwnerRenter = async (req, res) => {
        
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

    let [propertyOwnerToDelete] = await pool.query(`SELECT * FROM inmueble_personas_admon WHERE id = ? `, [ id ]);
    propertyOwnerToDelete = propertyOwnerToDelete[0];

    let [facturas_ciclica] = await pool.query(`SELECT * FROM facturas_ciclica WHERE id_persona = ? AND id_inmueble = ?`,
      [propertyOwnerToDelete.id_persona, propertyOwnerToDelete.id_inmueble]
    );
    facturas_ciclica = facturas_ciclica[0];

    //DELETE CYCLICAL BILL
    await pool.query(`DELETE FROM facturas_ciclica WHERE id = ?`,
      [facturas_ciclica.id]
    );

    await pool.query(`DELETE FROM factura_ciclica_detalles WHERE id_factura_ciclica = ?`,
      [facturas_ciclica.id]
    );

    //DELETE PROPERTY OWNER RENTER
    await pool.query(`DELETE FROM inmueble_personas_admon WHERE id = ?`,
      [id]
    );
    
    //pool.end();

    return res.json({success: true, data: {propertyOwnerRenter: { id }}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
    getAllPropertyOwnersRenters,
    getAllPropertiesByOwnerRenter,
    createPropertyOwnerRenter,
    deletePropertyOwnerRenter,
    putPropertyOwnerRenter
};
