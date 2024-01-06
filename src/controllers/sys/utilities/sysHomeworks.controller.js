import Joi  from "joi";
import { poolSys } from "../../../db.js";
import { getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { genLog } from "../../../helpers/sysLogs.js";

import path from "path";
import multer from "multer";
import CryptoJS from "crypto-js";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(__dirname, "../../../../public/uploads/photoHomeworks"));
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

const getAllHomeworks = async (req, res) => {
  try {
    let pool = poolSys.getPool(req.user.token_db);

    const [listHomeworks] = await pool.query(
        `SELECT 
          t1.*,
          t2.nombre AS tipoTareaText,
          IF(IFNULL(t3.nombre,'')='',t3.email,t3.nombre) AS usuarioText,
          (CASE t4.tipo 
              WHEN 0 THEN 'INMUEBLE'
              WHEN 1 THEN 'PARQUEADERO'
              WHEN 2 THEN 'CUARTO ÚTIL'
          END) AS tipoInmuebleText,
          CONCAT(IFNULL(t5.nombre,''),':',IFNULL(t4.numero_interno_unidad,'')) AS inmuebleText,
          IFNULL(t6.nombre,'') AS zonaText,
          
          DATE_FORMAT(t1.created_at,"%Y-%m-%d %H:%i") AS created_at,
          DATE_FORMAT(t1.started_at,"%Y-%m-%d %H:%i") AS started_at,
          DATE_FORMAT(t1.fecha_completada,"%Y-%m-%d %H:%i") AS completada_at,
           DATE_FORMAT(t1.fecha_programada_inicial,"%Y-%m-%d %H:%i") AS programada_at_init,
          DATE_FORMAT(t1.fecha_programada_final,"%Y-%m-%d %H:%i") AS programada_at_end,
          DATE_FORMAT(t1.fecha_programada_final,"%Y-%m-%d %H:%i") AS programada_at_end,
          IFNULL(t7.nombre,'') AS imagen

        FROM tareas t1 
          INNER JOIN maestras_base t2 ON t2.id = t1.id_tipo_tarea
          INNER JOIN cli_maximo_ph_admin.usuarios t3 ON t3.id = t1.id_usuario_responsable
          LEFT OUTER JOIN inmuebles t4 ON t4.id = t1.id_inmueble
          LEFT OUTER JOIN zonas t5 ON t5.id = t4.id_inmueble_zona
          LEFT OUTER JOIN zonas t6 ON t6.id = t1.id_inmueble_zona
          LEFT OUTER JOIN multimedia t7 ON t7.id_registro = t1.id AND t7.tipo = 4
        WHERE 
          1`);

    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 43, 
      pool
    });

    listHomeworks.map((tarea)=>{
      let aTiempo = '';
      let aTiempoColor = '';
      if(tarea.completada_at){
        if(new Date(tarea.completada_at)<=new Date(tarea.programada_at_end)){
          aTiempo = 'SI';
          aTiempoColor = 'text-primary';
        }else{
          aTiempo = 'NO';
          aTiempoColor = 'text-warning';
        }
      }else if(new Date()>new Date(tarea.programada_at_end)){
        aTiempo = 'EN MORA';
        aTiempoColor = 'error';
      }

      tarea.aTiempo = aTiempo;
      tarea.aTiempoColor = aTiempoColor;
    });

    //pool.end();

    return res.json({success: true, data: listHomeworks, access});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const getOwnHomeworks = async (req, res) => {
  try {
    let pool = poolSys.getPool(req.user.token_db);

    const [listHomeworks] = await pool.query(
        `SELECT 
          t1.*,
          t2.nombre AS tipoTareaText,
          IF(IFNULL(t3.nombre,'')='',t3.email,t3.nombre) AS usuarioText,
          (CASE t4.tipo 
              WHEN 0 THEN 'INMUEBLE'
              WHEN 1 THEN 'PARQUEADERO'
              WHEN 2 THEN 'CUARTO ÚTIL'
          END) AS tipoInmuebleText,
          CONCAT(IFNULL(t5.nombre,''),':',IFNULL(t4.numero_interno_unidad,'')) AS inmuebleText,
          IFNULL(t6.nombre,'') AS zonaText,
          
          DATE_FORMAT(t1.created_at,"%Y-%m-%d %H:%i") AS created_at,
          DATE_FORMAT(t1.started_at,"%Y-%m-%d %H:%i") AS started_at,
          DATE_FORMAT(t1.fecha_completada,"%Y-%m-%d %H:%i") AS completada_at,
           DATE_FORMAT(t1.fecha_programada_inicial,"%Y-%m-%d %H:%i") AS programada_at_init,
          DATE_FORMAT(t1.fecha_programada_final,"%Y-%m-%d %H:%i") AS programada_at_end,
          IFNULL(t7.nombre,'') AS imagen

        FROM tareas t1 
          INNER JOIN maestras_base t2 ON t2.id = t1.id_tipo_tarea
          INNER JOIN cli_maximo_ph_admin.usuarios t3 ON t3.id = t1.id_usuario_responsable
          LEFT OUTER JOIN inmuebles t4 ON t4.id = t1.id_inmueble
          LEFT OUTER JOIN zonas t5 ON t5.id = t4.id_inmueble_zona
          LEFT OUTER JOIN zonas t6 ON t6.id = t1.id_inmueble_zona
          LEFT OUTER JOIN multimedia t7 ON t7.id_registro = t1.id AND t7.tipo = 4
        WHERE 
          t1.id_usuario_responsable='${req.user.id}'`);

      listHomeworks.map((tarea)=>{
        let aTiempo = '';
        let aTiempoColor = '';
        if(tarea.completada_at){
          if(new Date(tarea.completada_at)<=new Date(tarea.programada_at_end)){
            aTiempo = 'SI';
            aTiempoColor = 'text-primary';
          }else{
            aTiempo = 'NO';
            aTiempoColor = 'text-warning';
          }
        }else if(new Date()>new Date(tarea.programada_at_end)){
          aTiempo = 'EN MORA';
          aTiempoColor = 'error';
        }
  
        tarea.aTiempo = aTiempo;
        tarea.aTiempoColor = aTiempoColor;
      });
    
    //pool.end();
    
    return res.json({success: true, data: listHomeworks});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createHomeworkLite = async (data, pool, req) => {   
  try {
    const { id_tipo_tarea, id_usuario_responsable, estado, prioridad, id_inmueble, id_inmueble_zona, descripcion_tarea, fecha_programada_inicial, fecha_programada_final } = data;

    //CREATE HOMEWORK
    const [insertHomeWork] = await pool.query(`INSERT INTO tareas 
      (id_tipo_tarea, id_usuario_responsable, estado, prioridad, id_inmueble, id_inmueble_zona, descripcion_tarea, fecha_programada_inicial, fecha_programada_final, created_by) 
        VALUES 
      (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [id_tipo_tarea, id_usuario_responsable, estado, prioridad, (id_inmueble||null), (id_inmueble_zona||null), descripcion_tarea, fecha_programada_inicial, fecha_programada_final, req.user.id]
    );
    
    //GET NEW HOMEWORK
    const [rows] = await pool.query(`SELECT 
        t1.*,
        t2.nombre AS tipoTareaText,
        IF(IFNULL(t3.nombre,'')='',t3.email,t3.nombre) AS usuarioText,
        (CASE t4.tipo 
            WHEN 0 THEN 'INMUEBLE'
            WHEN 1 THEN 'PARQUEADERO'
            WHEN 2 THEN 'CUARTO ÚTIL'
        END) AS tipoInmuebleText,
        CONCAT(IFNULL(t5.nombre,''),':',IFNULL(t4.numero_interno_unidad,'')) AS inmuebleText,
        IFNULL(t6.nombre,'') AS zonaText,
        
        DATE_FORMAT(t1.created_at,"%Y-%m-%d %H:%i") AS created_at,
        DATE_FORMAT(t1.started_at,"%Y-%m-%d %H:%i") AS started_at,
        DATE_FORMAT(t1.fecha_completada,"%Y-%m-%d %H:%i") AS completada_at,
         DATE_FORMAT(t1.fecha_programada_inicial,"%Y-%m-%d %H:%i") AS programada_at_init,
          DATE_FORMAT(t1.fecha_programada_final,"%Y-%m-%d %H:%i") AS programada_at_end,
          IFNULL(t7.nombre,'') AS imagen

      FROM tareas t1 
        INNER JOIN maestras_base t2 ON t2.id = t1.id_tipo_tarea
        INNER JOIN cli_maximo_ph_admin.usuarios t3 ON t3.id = t1.id_usuario_responsable
        LEFT OUTER JOIN inmuebles t4 ON t4.id = t1.id_inmueble
        LEFT OUTER JOIN zonas t5 ON t5.id = t4.id_inmueble_zona
        LEFT OUTER JOIN zonas t6 ON t6.id = t1.id_inmueble_zona
          LEFT OUTER JOIN multimedia t7 ON t7.id_registro = t1.id AND t7.tipo = 4
      WHERE 
        t1.id = ?`, 
      [ insertHomeWork.insertId ]);
    
    let homework = rows[0];
    
    await genLog({
        module: 'tareas', 
        idRegister: homework.id, 
        recordBefore: homework, 
        oper: 'CREATE', 
        detail: `TAREA ${homework.tipoTareaText} CREADA POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });

    return {success: true, data: {homework}};
  } catch (error) {
    return { success: false, error: 'Internal Server Error', error: error.message };
  }
};

const createHomework = async (req, res) => {   
  try {
    const registerSchema = Joi.object({
      id_tipo_tarea: Joi.number().required(),
      id_usuario_responsable: Joi.number().required(),
      estado: Joi.number().required(),
      prioridad: Joi.number().required(),
      id_inmueble: Joi.number().allow(null,''),
      id_inmueble_zona: Joi.number().allow(null,''),
      descripcion_tarea: Joi.string().required().allow(null,''),
      fecha_programada_inicial: Joi.string().required(),
      fecha_programada_final: Joi.string().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    let pool = poolSys.getPool(req.user.token_db);

    let response = await createHomeworkLite(req.body, pool, req);

    //pool.end();
    if(response.success){
      return res.json(response);
    }else{
      return res.status(500).json(response);
    }
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const getBitwiseDayNumber = (day)=>{
  let bitwiseNumber = 1; // 0 = Lunes

  switch(day){
    case 1: bitwiseNumber = 2; break; //Martes
    case 2: bitwiseNumber = 4; break; //Miércoles
    case 3: bitwiseNumber = 8; break; //Jueves
    case 4: bitwiseNumber = 16; break; //Viernes
    case 5: bitwiseNumber = 32; break; //Sábado
    case 6: bitwiseNumber = 64; break; //Domingo
  }

  return bitwiseNumber;
};

const createHomeworkMassive = async (req, res) => {   
  try {
    const registerSchema = Joi.object({
      id_tipo_tarea: Joi.number().required(),
      id_usuario_responsable: Joi.number().required(),
      estado: Joi.number().required(),
      prioridad: Joi.number().required(),
      id_inmueble: Joi.number().allow(null,''),
      id_inmueble_zona: Joi.number().allow(null,''),
      descripcion_tarea: Joi.string().required().allow(null,''),
      fecha_desde: Joi.string().required(),
      fecha_hasta: Joi.string().required(),
      hora_inicial: Joi.string().required(),
      hora_final: Joi.string().required(),
      dias: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { id_tipo_tarea, id_usuario_responsable, estado, prioridad, id_inmueble, id_inmueble_zona, descripcion_tarea, fecha_desde, fecha_hasta, hora_inicial, hora_final, dias } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    let homeworksToInsert = [];
    
    let fechaA = new Date(fecha_desde);
    let fechaB = new Date(fecha_hasta);

    let fechaActual = fechaA;
    let fechaText = "";
    let bitwiseDayNumber = 0;

    while (fechaActual <= fechaB) {
      fechaText = fechaActual.toISOString().split("T")[0];
      
      bitwiseDayNumber = getBitwiseDayNumber(fechaActual.getDay());
      bitwiseDayNumber = (dias&bitwiseDayNumber) ? true : false;

      if(bitwiseDayNumber){
        homeworksToInsert.push({
          id_tipo_tarea, 
          id_usuario_responsable, 
          estado, 
          prioridad, 
          id_inmueble, 
          id_inmueble_zona, 
          descripcion_tarea,
          fecha_programada_inicial: `${fechaText} ${hora_inicial}`,
          fecha_programada_final: `${fechaText} ${hora_final}`
        });
        
      }
      
      fechaActual.setDate(fechaActual.getDate() + 1);
    }

    await Promise.all(homeworksToInsert.map(async (dataHW) => {
      await createHomeworkLite(dataHW, pool, req);
    }));

    //pool.end();
    return res.json({success: true});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putHomework = async (req, res) => {   
  try {  
    const registerSchema = Joi.object({
      id_tipo_tarea: Joi.number().required(),
      id_usuario_responsable: Joi.number().required(),
      id_inmueble: Joi.number().allow(null,''),
      id_inmueble_zona: Joi.number().allow(null,''),
      descripcion_tarea: Joi.string().required().allow(null,''),
      fecha_programada_inicial: Joi.string().required(),
      fecha_programada_final: Joi.string().required(),
      estado: Joi.number().required(),
      prioridad: Joi.number().required(),
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

    const { id_tipo_tarea, id_usuario_responsable, estado, prioridad, id_inmueble, id_inmueble_zona, descripcion_tarea, fecha_programada_inicial, fecha_programada_final, id } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    //GET BEFORE EDITED HOMEWORK
    const [rowsBefore] = await pool.query(`SELECT * FROM tareas WHERE id = ?`, [ id ]);

    let homeworkBefore = rowsBefore[0];

    //UPDATE HOMEWORK
    await pool.query(`UPDATE tareas SET
        id_tipo_tarea = ?,
        id_usuario_responsable = ?,
        estado = ?,
        prioridad = ?,
        id_inmueble = ?,
        id_inmueble_zona = ?,
        descripcion_tarea = ?,
        fecha_programada_inicial = ?,
        fecha_programada_final = ?,
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [id_tipo_tarea, id_usuario_responsable, estado, prioridad, id_inmueble, id_inmueble_zona, descripcion_tarea, fecha_programada_inicial, fecha_programada_final, req.user.id, id]
    );
    
    //GET EDITED HOMEWORK
    const [rows] = await pool.query(`SELECT 
        t1.*,
        t2.nombre AS tipoTareaText,
        IF(IFNULL(t3.nombre,'')='',t3.email,t3.nombre) AS usuarioText,
        (CASE t4.tipo 
            WHEN 0 THEN 'INMUEBLE'
            WHEN 1 THEN 'PARQUEADERO'
            WHEN 2 THEN 'CUARTO ÚTIL'
        END) AS tipoInmuebleText,
        CONCAT(IFNULL(t5.nombre,''),':',IFNULL(t4.numero_interno_unidad,'')) AS inmuebleText,
        IFNULL(t6.nombre,'') AS zonaText,
        
        DATE_FORMAT(t1.created_at,"%Y-%m-%d %H:%i") AS created_at,
        DATE_FORMAT(t1.started_at,"%Y-%m-%d %H:%i") AS started_at,
        DATE_FORMAT(t1.fecha_completada,"%Y-%m-%d %H:%i") AS completada_at,
         DATE_FORMAT(t1.fecha_programada_inicial,"%Y-%m-%d %H:%i") AS programada_at_init,
          DATE_FORMAT(t1.fecha_programada_final,"%Y-%m-%d %H:%i") AS programada_at_end,
          IFNULL(t7.nombre,'') AS imagen

      FROM tareas t1 
        INNER JOIN maestras_base t2 ON t2.id = t1.id_tipo_tarea
        INNER JOIN cli_maximo_ph_admin.usuarios t3 ON t3.id = t1.id_usuario_responsable
        LEFT OUTER JOIN inmuebles t4 ON t4.id = t1.id_inmueble
        LEFT OUTER JOIN zonas t5 ON t5.id = t4.id_inmueble_zona
        LEFT OUTER JOIN zonas t6 ON t6.id = t1.id_inmueble_zona
          LEFT OUTER JOIN multimedia t7 ON t7.id_registro = t1.id AND t7.tipo = 4
      WHERE 
        t1.id = ?`, [ id ]);
    
    let homework = rows[0];
    
    await genLog({
        module: 'tareas', 
        idRegister: id, 
        recordBefore: homeworkBefore, 
        oper: 'UPDATE', 
        detail: `TAREA ${homework.tipoTareaText} ACTUALIZADA POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });

    //pool.end();

    return res.json({success: true, data: {homework}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putCompleteHomework = async (req, res) => {   
  try {  
    multer({ storage }).single('image')(req, res, async(err) => {
      if (err) {
        console.log(err.message);
        return res.status(400).json({ message: "Failed image processing" });
      }

      const image = req.file ? path.basename(req.file.path) : null;

      const registerSchema = Joi.object({
        estado: Joi.number().required(),
        image: Joi.allow(null,''),
        tipo_image: Joi.string().required().allow(null,''),
        fecha_completada: Joi.allow(null,''),
        observacion_completada: Joi.string().required().allow(null,''),
        id: Joi.number().required()
      });

      //VALIDATE FORMAT FIELDS
      const { error } = registerSchema.validate(req.body);
      if (error) {
        return res.status(201).json({ success: false, error: error.message });
      }

      const { estado, observacion_completada, tipo_image, fecha_completada, id } = req.body;

      let pool = poolSys.getPool(req.user.token_db);

      //GET BEFORE EDITED HOMEWORK
      const [rowsBefore] = await pool.query(`SELECT * FROM tareas WHERE id = ?`, [ id ]);

      let homeworkBefore = rowsBefore[0];

      //UPDATE HOMEWORK
      await pool.query(`UPDATE tareas SET
          estado = ?,
          observacion_completada = ?,
          fecha_completada = ?,
          updated_at = NOW(), 
          updated_by = ?,
          started_at = IF(${estado}=3,NOW(),started_at)
        WHERE 
          id = ?`,
        [estado, observacion_completada, (fecha_completada||null), req.user.id, id]
      );
      
      //GET EDITED HOMEWORK
      const [rows] = await pool.query(`SELECT 
          t1.*,
          t2.nombre AS tipoTareaText,
          IF(IFNULL(t3.nombre,'')='',t3.email,t3.nombre) AS usuarioText,
          (CASE t4.tipo 
              WHEN 0 THEN 'INMUEBLE'
              WHEN 1 THEN 'PARQUEADERO'
              WHEN 2 THEN 'CUARTO ÚTIL'
          END) AS tipoInmuebleText,
          CONCAT(IFNULL(t5.nombre,''),':',IFNULL(t4.numero_interno_unidad,'')) AS inmuebleText,
          IFNULL(t6.nombre,'') AS zonaText,
          
          DATE_FORMAT(t1.created_at,"%Y-%m-%d %H:%i") AS created_at,
          DATE_FORMAT(t1.started_at,"%Y-%m-%d %H:%i") AS started_at,
          DATE_FORMAT(t1.fecha_completada,"%Y-%m-%d %H:%i") AS completada_at,
           DATE_FORMAT(t1.fecha_programada_inicial,"%Y-%m-%d %H:%i") AS programada_at_init,
          DATE_FORMAT(t1.fecha_programada_final,"%Y-%m-%d %H:%i") AS programada_at_end,
          IFNULL(t7.nombre,'') AS imagen

        FROM tareas t1 
          INNER JOIN maestras_base t2 ON t2.id = t1.id_tipo_tarea
          INNER JOIN cli_maximo_ph_admin.usuarios t3 ON t3.id = t1.id_usuario_responsable
          LEFT OUTER JOIN inmuebles t4 ON t4.id = t1.id_inmueble
          LEFT OUTER JOIN zonas t5 ON t5.id = t4.id_inmueble_zona
          LEFT OUTER JOIN zonas t6 ON t6.id = t1.id_inmueble_zona
          LEFT OUTER JOIN multimedia t7 ON t7.id_registro = t1.id AND t7.tipo = 4
        WHERE 
          t1.id = ?`, [ id ]);
      
      let homework = rows[0];
      
      //ADD IMAGE
      if(image){
        await pool.query(`INSERT INTO multimedia 
        (tipo, id_registro, nombre, peso, tipo_multimedia, created_by)
            VALUES
        (?, ?, ?, ?, ?, ?)
        `, [4, homework.id, image, 0, tipo_image, req.user.id]);
      }

      await genLog({
          module: 'tareas', 
          idRegister: id, 
          recordBefore: homeworkBefore, 
          oper: 'UPDATE', 
          detail: `TAREA CAMBIO ESTADO ${homework.tipoTareaText} ACTUALIZADA POR ${req.user.email}`, 
          user: req.user.id,
          pool
      });

      //pool.end();

      return res.json({success: true, data: {homework}});
    });
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteHomeworkLite = async (data, pool, req) => {    
  try {  
    const { id } = data;
    
    //GET HOMEWORK
    let [homework] = await pool.query(`SELECT * FROM tareas WHERE id = ?`,[id]);
    homework = homework[0];

    await genLog({
        module: 'tareas', 
        idRegister: id, 
        recordBefore: {}, 
        oper: 'DELETE', 
        detail: `TAREA ${homework.id} ELIMINADA POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });

    //DELETE HOMEWORK
    await pool.query(`DELETE FROM tareas WHERE id = ?`,
      [id]
    );
    
    //pool.end();

    return {success: true, data: {homework: { id }}};
  } catch (error) {
      return { success: false, error: 'Internal Server Error', error: error.message };
  }
};

const deleteHomework = async (req, res) => {    
  try {  
    const registerSchema = Joi.object({
      id: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.params);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }
    
    let pool = poolSys.getPool(req.user.token_db);
    
    let response = await deleteHomeworkLite(req.params, pool, req);
    
    //pool.end();

    return res.json(response);
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteHomeworkMassive = async (req, res) => {    
  try {  
    const registerSchema = Joi.object({
      id_tipo_tarea: Joi.number().required(),
      id_usuario_responsable: Joi.number().required(),
      estado: Joi.number().required(),
      fecha: Joi.string().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }
    
    let pool = poolSys.getPool(req.user.token_db);
    
    let { id_tipo_tarea, id_usuario_responsable, estado, fecha } = req.body;
    
    fecha = fecha.split("T")[0];

    let conditionalsQuery = [`id_tipo_tarea = ${id_tipo_tarea}`, `id_usuario_responsable = ${id_usuario_responsable}`, `DATE_FORMAT(created_at,'%Y-%m-%d') = '${fecha}'`];

    if(estado!='3'){
      conditionalsQuery.push(`estado = ${estado}`);
    }

    conditionalsQuery = conditionalsQuery.length ? conditionalsQuery.join(' AND ') : '1';

    const [homeworkDetails] = await pool.query(`SELECT * FROM tareas WHERE ${conditionalsQuery}`);

    if(!homeworkDetails.length) {
      return res.status(201).json({ success: false, error: 'No se encontraron tareas asociadas a los términos.' });
    }

    //DELETE HOMEWORK MASSIVE
    await pool.query(`DELETE FROM tareas WHERE ${conditionalsQuery}`);
    
    await genLog({
        module: 'tareas', 
        idRegister: '1', 
        recordBefore: {}, 
        oper: 'DELETE', 
        detail: `TAREAS ELIMINADAS MASIVAMENTE POR ${req.user.email} - FECHA: ${fecha} - TIPO: ${id_tipo_tarea} - USUARIO: ${id_usuario_responsable}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  getAllHomeworks,
  getOwnHomeworks,
  createHomework,
  createHomeworkMassive,
  deleteHomework,
  putHomework,
  putCompleteHomework,
  deleteHomeworkMassive
};
