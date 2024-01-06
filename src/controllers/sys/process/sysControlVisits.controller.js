import Joi  from "joi";
import { poolSys } from "../../../db.js";
import { getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { sendFBPushMessageUser } from "../../../helpers/firebasePushNotification.js";
import { genLog } from "../../../helpers/sysLogs.js";

import path from "path";
import multer from "multer";
import CryptoJS from "crypto-js";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(__dirname, "../../../../public/uploads/photoVisitors"));
  },
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname);
    const filenameWithoutExt = path.basename(file.originalname, ext);
    const hash = CryptoJS.SHA256(filenameWithoutExt).toString(CryptoJS.enc.Hex);
    const filename = hash + ext;
    const date = Date.now();
    cb(null, `${date}-${filename}`);
  },
});

const getControlVisits = async (pool, id) => {
  try {
    let [listControlVisits] = await pool.query(`SELECT 
        t1.id, 
        
        t1.persona_visita, 
        
        t1.persona_visita_cedula, 
        
        IFNULL(t1.persona_visita,'') AS personaVisitanteText,
        
        IFNULL(t1.id_persona_autoriza,'') AS id_persona_autoriza, 
        TRIM(REPLACE(REPLACE(CONCAT(
          IFNULL(t5.primer_nombre,''),' ',
          IFNULL(t5.segundo_nombre,''),' ',
          IFNULL(t5.primer_apellido,''),' ',
          IFNULL(t5.segundo_apellido,''),' '
        ),'  ',' '),'  ',' ')) AS personaAutorizaText,
        
        IFNULL(t4.nombre,'') AS tipoVehiculoText,

        IFNULL(t1.id_inmueble,'') AS id_inmueble, 
        (CASE IFNULL(t6.tipo,0)
            WHEN 0 THEN 'INMUEBLE'
            WHEN 1 THEN 'PARQUEADERO'
            WHEN 2 THEN 'CUARTO ÚTIL'
        END) AS inmuebleTipoText,
        IFNULL(t6.numero_interno_unidad,'') AS inmuebleText,

        IFNULL(t1.id_inmueble_zona,'') AS id_inmueble_zona, 
        IFNULL(t7.nombre,'') AS zonaText,

        IFNULL(t1.id_concepto_visita,'') AS id_concepto_visita, 
        IFNULL(t8.nombre,'') AS conceptoText,

        IFNULL(t1.placa,'') As placa, 
        IFNULL(t1.id_tipo_vehiculo,'') AS id_tipo_vehiculo, 
        IFNULL(t1.fecha_ingreso,'') AS fecha_ingreso, 
        IFNULL(t1.fecha_salida,'') As fecha_salida, 
        IFNULL(t1.observacion,'') AS observacion, 
        IFNULL(t9.nombre,'') AS imagen,

        t1.created_by, 
        t1.created_at, 
        t1.updated_by, 
        t1.updated_at
      FROM control_ingresos t1
        LEFT OUTER JOIN maestras_base t4 ON t4.id = t1.id_tipo_vehiculo
        LEFT OUTER JOIN personas t5 ON t5.id = t1.id_persona_autoriza
        LEFT OUTER JOIN inmuebles t6 ON t6.id = t1.id_inmueble AND t6.tipo = 0
        LEFT OUTER JOIN zonas t7 ON t7.id = t1.id_inmueble_zona
        LEFT OUTER JOIN maestras_base t8 ON t8.id = t1.id_concepto_visita
        LEFT OUTER JOIN multimedia t9 ON t9.id_registro = t1.id AND t9.tipo = 7
      WHERE ${(id ? `t1.id = ${id}` : `1`)} AND (t6.eliminado=0 OR t6.eliminado IS NULL) AND (t8.eliminado = 0 OR t8.eliminado IS NULL) AND (t4.eliminado = 0 OR t4.eliminado IS NULL)`);

    return listControlVisits;
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const getSearchVisitors = async (req, res) => {
  try {
    const registerSchema = Joi.object({
      patternSearch: Joi.string().allow(null,'')
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.params);
    if (error) {
      return error.message;
    }

    let pool = poolSys.getPool(req.user.token_db);
    
    let { patternSearch } = req.params;
    patternSearch = patternSearch.toUpperCase();
    
    const [paternVisitors] = await pool.query(`SELECT 
          t1.*,
          CONCAT(IFNULL(t3.primer_nombre,''),' ',IFNULL(t3.segundo_nombre,''),' ',IFNULL(t3.primer_apellido,''),' ',IFNULL(t3.segundo_apellido,'')) AS personaAutorizaText,
          IFNULL(t1.persona_visitante_avatar,'') AS avatar,
          'VISITANTE' AS tipoPatern,
          t5.nombre AS zonaText,
          t4.numero_interno_unidad,
          DAYOFWEEK(NOW()) AS dayofweek,
          IF(t1.fecha_autoriza=DATE_FORMAT(NOW(),"%Y-%m-%d"),1,0) AS dateAutorize
      FROM inmueble_personas_visitantes t1 
        INNER JOIN personas t3 ON t3.id = t1.id_persona_autoriza
        INNER JOIN inmuebles t4 ON t4.id = t1.id_inmueble AND (t4.eliminado = 0 OR t4.eliminado IS NULL) AND t4.tipo = 0
        INNER JOIN zonas t5 ON t5.id = t4.id_inmueble_zona
      WHERE 
        (t4.eliminado = 0 OR t4.eliminado IS NULL) AND
        UPPER(t1.persona_visitante) LIKE "%${patternSearch}%" OR 
        UPPER(t5.nombre) LIKE "%${patternSearch}%" OR
        UPPER(t1.observacion) LIKE "%${patternSearch}%" OR 
        t1.fecha_autoriza = "${patternSearch}" OR
        t4.numero_interno_unidad LIKE "%${patternSearch}%" OR
        UPPER(CONCAT(IFNULL(t3.primer_nombre,''),' ',IFNULL(t3.segundo_nombre,''),' ',IFNULL(t3.primer_apellido,''),' ',IFNULL(t3.segundo_apellido,''))) LIKE "%${patternSearch}%"`);
    
    paternVisitors.map(visitor=>{
      let diasText = [];
      
      visitor.diaAutorizado = false;

      if(visitor.dias_autorizados&1) diasText.push("Lunes");
      if(visitor.dias_autorizados&1&&visitor.dayofweek==2) visitor.diaAutorizado = true;

      if(visitor.dias_autorizados&2) diasText.push("Martes");
      if(visitor.dias_autorizados&2&&visitor.dayofweek==3) visitor.diaAutorizado = true;
      
      if(visitor.dias_autorizados&4) diasText.push("Miércoles");
      if(visitor.dias_autorizados&4&&visitor.dayofweek==4) visitor.diaAutorizado = true;

      if(visitor.dias_autorizados&8) diasText.push("Jueves");
      if(visitor.dias_autorizados&8&&visitor.dayofweek==5) visitor.diaAutorizado = true;

      if(visitor.dias_autorizados&16) diasText.push("Viernes");
      if(visitor.dias_autorizados&16&&visitor.dayofweek==6) visitor.diaAutorizado = true;

      if(visitor.dias_autorizados&32) diasText.push("Sábado");
      if(visitor.dias_autorizados&32&&visitor.dayofweek==7) visitor.diaAutorizado = true;

      if(visitor.dias_autorizados&64) diasText.push("Domingo");
      if(visitor.dias_autorizados&64&&visitor.dayofweek==1) visitor.diaAutorizado = true;

      if(visitor.dateAutorize==1) visitor.diaAutorizado = true;

      visitor.diasText = diasText.join(", ");
    });

    const [paternOwnersRentals] = await pool.query(`SELECT 
          t1.*,
          CONCAT(IFNULL(t3.primer_nombre,''),' ',IFNULL(t3.segundo_nombre,''),' ',IFNULL(t3.primer_apellido,''),' ',IFNULL(t3.segundo_apellido,'')) AS nombre,
          IFNULL(t3.avatar,'') AS avatar,
          IF(t1.tipo=0,'PROPIETARIO','INQUILINO') AS tipoPatern,
          t5.nombre AS zonaText,
          t4.numero_interno_unidad
      FROM inmueble_personas_admon t1 
        INNER JOIN personas t3 ON t3.id = t1.id_persona
        INNER JOIN inmuebles t4 ON t4.id = t1.id_inmueble AND (t4.eliminado = 0 OR t4.eliminado IS NULL) AND t4.tipo = 0
        INNER JOIN zonas t5 ON t5.id = t4.id_inmueble_zona
      WHERE 
        (t4.eliminado = 0 OR t4.eliminado IS NULL) AND
        t4.numero_interno_unidad LIKE "%${patternSearch}%" OR
        UPPER(CONCAT(IFNULL(t3.primer_nombre,''),' ',IFNULL(t3.segundo_nombre,''),' ',IFNULL(t3.primer_apellido,''),' ',IFNULL(t3.segundo_apellido,''))) LIKE "%${patternSearch}%"`);

    const [paternVehicles] = await pool.query(`SELECT 
      t1.*, 
      CONCAT(IFNULL(t2.primer_nombre,''),' ',IFNULL(t2.segundo_nombre,''),' ',IFNULL(t2.primer_apellido,''),' ',IFNULL(t2.segundo_apellido,'')) AS personaAutorizaText, 
      t3.nombre AS tipoText,
      IFNULL(t1.avatar,'') AS avatar,
      'VEHICULO' AS tipoPatern,
      t5.nombre AS zonaText,
      t4.numero_interno_unidad,
      DAYOFWEEK(NOW()) AS dayofweek,
      IF(t1.fecha_autoriza=DATE_FORMAT(NOW(),"%Y-%m-%d"),1,0) AS dateAutorize
    FROM inmueble_vehiculos t1 
      INNER JOIN personas t2 ON t2.id = t1.id_persona_autoriza
      INNER JOIN maestras_base t3 ON t3.id = t1.id_tipo_vehiculo
      INNER JOIN inmuebles t4 ON t4.id = t1.id_inmueble AND (t4.eliminado = 0 OR t4.eliminado IS NULL) AND t4.tipo = 0
      INNER JOIN zonas t5 ON t5.id = t4.id_inmueble_zona
    WHERE 
      (t4.eliminado = 0 OR t4.eliminado IS NULL) AND
      UPPER(t3.nombre) LIKE "%${patternSearch}%" OR
      UPPER(t5.nombre) LIKE "%${patternSearch}%" OR
      UPPER(t1.placa) LIKE "%${patternSearch}%" OR 
      UPPER(t1.observacion) LIKE "%${patternSearch}%" OR 
        t1.fecha_autoriza = "${patternSearch}" OR
        t4.numero_interno_unidad = "${patternSearch}" OR 
      UPPER(CONCAT(IFNULL(t2.primer_nombre,''),' ',IFNULL(t2.segundo_nombre,''),' ',IFNULL(t2.primer_apellido,''),' ',IFNULL(t2.segundo_apellido,''))) LIKE "%${patternSearch}%"
    `);
    
    paternVehicles.map(vehicle=>{
      let diasText = [];
      
      vehicle.diaAutorizado = false;

      if(vehicle.dias_autorizados&1) diasText.push("Lunes");
      if(vehicle.dias_autorizados&1&&vehicle.dayofweek==2) vehicle.diaAutorizado = true;

      if(vehicle.dias_autorizados&2) diasText.push("Martes");
      if(vehicle.dias_autorizados&2&&vehicle.dayofweek==3) vehicle.diaAutorizado = true;
      
      if(vehicle.dias_autorizados&4) diasText.push("Miércoles");
      if(vehicle.dias_autorizados&4&&vehicle.dayofweek==4) vehicle.diaAutorizado = true;

      if(vehicle.dias_autorizados&8) diasText.push("Jueves");
      if(vehicle.dias_autorizados&8&&vehicle.dayofweek==5) vehicle.diaAutorizado = true;

      if(vehicle.dias_autorizados&16) diasText.push("Viernes");
      if(vehicle.dias_autorizados&16&&vehicle.dayofweek==6) vehicle.diaAutorizado = true;

      if(vehicle.dias_autorizados&32) diasText.push("Sábado");
      if(vehicle.dias_autorizados&32&&vehicle.dayofweek==7) vehicle.diaAutorizado = true;

      if(vehicle.dias_autorizados&64) diasText.push("Domingo");
      if(vehicle.dias_autorizados&64&&vehicle.dayofweek==1) vehicle.diaAutorizado = true;

      if(vehicle.dateAutorize==1) vehicle.diaAutorizado = true;
      
      vehicle.diasText = diasText.join(", ");
    });

    //pool.end();

    return res.json({success: true, data: [...paternVisitors, ...paternVehicles, ...paternOwnersRentals]});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const getAllControlVisits = async (req, res) => {
  try {
    let pool = poolSys.getPool(req.user.token_db);

    const listControlVisits = await getControlVisits(pool);
        
    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 5, 
      pool
    });
    
    //pool.end();

    return res.json({success: true, data: listControlVisits, access});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error });
  }
};

const createControlVisit = async (req, res) => {   
  try {
    multer({ storage }).single('image')(req, res, async(err) => {
      if (err) {
        console.log(err.message);
        return res.status(400).json({ message: "Failed image processing" });
      }

      const image = req.file ? path.basename(req.file.path) : null;
      const registerSchema = Joi.object({
        persona_visita: Joi.string().allow(null,''),
        persona_visita_cedula: Joi.string().allow(null,''),
        id_persona_autoriza: Joi.allow(null,''),
        id_inmueble: Joi.number().allow(null,''),
        id_inmueble_zona: Joi.number().allow(null,''),
        id_concepto_visita: Joi.number().allow(null,''),
        id_tipo_vehiculo: Joi.allow(null,''),
        placa: Joi.string().allow(null,''),
        observacion: Joi.string().allow(null,''),
        image: Joi.allow(null,''),
        tipo_image: Joi.string().required().allow(null,''),
        observacion_visita_previa: Joi.string().allow(null,'')
      });

      //VALIDATE FORMAT FIELDS
      const { error } = registerSchema.validate(req.body);
      if (error) {
        return res.status(201).json({ success: false, error: error.message });
      }

      let { persona_visita, persona_visita_cedula, id_persona_autoriza, tipo_image, id_inmueble, id_inmueble_zona, id_concepto_visita, id_tipo_vehiculo, placa, observacion, observacion_visita_previa } = req.body;

      let pool = poolSys.getPool(req.user.token_db);

      //CREATE CONTROL VISIT
      const [insertedNewControlVisit] = await pool.query(`INSERT INTO control_ingresos 
        (persona_visita, persona_visita_cedula, id_persona_autoriza, id_inmueble, id_inmueble_zona, id_concepto_visita, id_tipo_vehiculo, placa, fecha_ingreso, observacion, observacion_visita_previa, created_by) 
          VALUES 
        (?, ?, ?, ?, ?, ?, ?, ?, NOW(), UPPER(?), UPPER(?), ?)`,
        [persona_visita, persona_visita_cedula, (id_persona_autoriza=='null'?null:id_persona_autoriza), id_inmueble, id_inmueble_zona, id_concepto_visita, (id_tipo_vehiculo=='null'?null:id_tipo_vehiculo), placa, observacion, observacion_visita_previa, req.user.id]
      );

      const [personaAutoriza] = await pool.query(`SELECT 
        t2.id AS id_usuario
      FROM personas t1
        LEFT OUTER JOIN cli_maximo_ph_admin.usuarios t2 ON t2.email = t1.email
      WHERE 
        t1.id = ?`,[id_persona_autoriza]);
      if(personaAutoriza.length){
        await sendFBPushMessageUser(personaAutoriza[0].id_usuario, {
          title: `Nueva ingreso al inmueble`,
          body: `Se acaba de registrar un ingreso autorizado por ti.`
        }, pool);
      }

      let idNewControlVisit = insertedNewControlVisit.insertId;

      //ADD IMAGE
      if(image){
        await pool.query(`INSERT INTO multimedia 
        (tipo, id_registro, nombre, peso, tipo_multimedia, created_by)
            VALUES
        (?, ?, ?, ?, ?, ?)
        `, [7, idNewControlVisit, image, 0, tipo_image, req.user.id]);
      }

      //GET NEW CONTROL VISIT
      const rows = await getControlVisits(pool, idNewControlVisit);
      
      let controlVisit = rows[0];
      
      await genLog({
          module: 'control_ingresos', 
          idRegister: idNewControlVisit, 
          recordBefore: controlVisit, 
          oper: 'CREATE', 
          detail: `CONTROL DE INGRESO CREADO POR ${req.user.email}`, 
          user: req.user.id,
          pool
      });
          
      //pool.end();

      return res.json({success: true, data: {controlVisit}});
    });
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putControlVisit = async (req, res) => {   
  try {  
    const registerSchema = Joi.object({
      persona_visita: Joi.string().allow(null,''),
      persona_visita_cedula: Joi.string().allow(null,''),
      id_persona_autoriza: Joi.allow(null,''),
      id_inmueble: Joi.number().allow(null,''),
      id_inmueble_zona: Joi.number().allow(null,''),
      id_concepto_visita: Joi.number().allow(null,''),
      id_tipo_vehiculo: Joi.allow(null,''),
      placa: Joi.string().allow(null,''),
      imagen: Joi.allow(null,''),
      observacion: Joi.string().allow(null,''),
      observacion_visita_previa: Joi.string().allow(null,''),
      
      personaVisitanteText: Joi.string().allow(null,''),
      personaAutorizaText: Joi.string().allow(null,''),
      tipoVehiculoText: Joi.string().allow(null,''),
      inmuebleText: Joi.string().allow(null,''),
      conceptoText: Joi.string().allow(null,''),
      zonaText: Joi.string().allow(null,''),
      inmuebleTipoText: Joi.string().allow(null,''),
      fecha_ingreso: Joi.string().allow(null,''),
      fecha_salida: Joi.string().allow(null,''),

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

    const { id, persona_visita, persona_visita_cedula, id_persona_autoriza, id_inmueble, id_inmueble_zona, id_concepto_visita, id_tipo_vehiculo, placa, observacion, observacion_visita_previa } = req.body;

    let pool = poolSys.getPool(req.user.token_db);
    
    //GET BEFORE EDITED CONTROL VISIT
    const [rowsBefore] = await pool.query(`SELECT * FROM control_ingresos WHERE id = ?`, [ id ]);
    let controlVisitBefore = rowsBefore[0];

    //UPDATE CONTROL VISIT
    await pool.query(`UPDATE control_ingresos
      SET 
        persona_visita = ?,
        persona_visita_cedula = ?,
        id_persona_autoriza = ?,
        id_inmueble = ?,
        id_inmueble_zona = ?,
        id_concepto_visita = ?,
        id_tipo_vehiculo = ?,
        placa = ?,
        observacion = UPPER(?),
        observacion_visita_previa = UPPER(?),
        updated_by = ?
      WHERE
        id = ?`,
      [persona_visita, persona_visita_cedula, (id_persona_autoriza=='null'?null:id_persona_autoriza), id_inmueble, id_inmueble_zona, id_concepto_visita, (id_tipo_vehiculo=='null'?null:id_tipo_vehiculo), placa, observacion, observacion_visita_previa, req.user.id, id]
    );

    //GET UPDATED CONTROL VISIT
    const rows = await getControlVisits(pool, id);
    
    let controlVisit = rows[0];
    
    await genLog({
        module: 'control_ingresos', 
        idRegister: id, 
        recordBefore: controlVisitBefore, 
        oper: 'UPDATE', 
        detail: `CONTROL DE INGRESO ACTUALIZADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {controlVisit}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteControlVisit = async (req, res) => {  
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

    
    await genLog({
        module: 'control_ingresos', 
        idRegister: id, 
        recordBefore: {}, 
        oper: 'DELETE', 
        detail: `CONTROL DE INGRESO ELIMINADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });

    //DELETE CONTROL VISIT
    await pool.query(`DELETE FROM control_ingresos WHERE id = ?`,[id]);
    
    //pool.end();

    return res.json({success: true, data: {controlVisit: { id }}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  getAllControlVisits,
  createControlVisit,
  getSearchVisitors,
  putControlVisit,
  deleteControlVisit
};
