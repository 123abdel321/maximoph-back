import Joi  from "joi";
import { poolSys } from "../../../db.js";
import { getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { genLog } from "../../../helpers/sysLogs.js";

import { sendFBPushMessageUser } from "../../../helpers/firebasePushNotification.js";

import path from "path";
import multer from "multer";
import CryptoJS from "crypto-js";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(__dirname, "../../../../public/uploads/photoMessages"));
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

const getOwnMessages = async (req, res) => {
    try {
        let pool = poolSys.getPool(req.user.token_db);

        let queryOwnMessages = `SELECT 
            t1.id, t1.titulo, t1.descripcion, IF(t1.id_persona, DATE_FORMAT(t1.read_at,"%Y-%m-%d %H:%i"),'MENSAJE MASIVO') AS read_at,
            t1.notificacion_push, DATE_FORMAT(t1.created_at,"%Y-%m-%d %H:%i") AS created_at,
            t1.id_zona, IFNULL(t2.nombre,'') AS zona,
            t1.id_persona,
            CONCAT(IFNULL(t3.primer_nombre,''),' ',IFNULL(t3.segundo_nombre,''),' ',IFNULL(t3.primer_apellido,''),' ',IFNULL(t3.segundo_apellido,'')) AS persona,
            t1.id_rol_persona, t4.nombre AS rol,
            IFNULL(t9.nombre,'') AS imagen

        FROM mensajes t1 
            LEFT OUTER JOIN zonas t2 ON t2.id = t1.id_zona
            LEFT OUTER JOIN personas t3 ON t3.id = t1.id_persona
            LEFT OUTER JOIN inmueble_personas_admon t5 ON t5.id_persona = t3.id
            LEFT OUTER JOIN inmuebles t6 ON t6.id = t5.id_inmueble AND t6.id_inmueble_zona = t2.id
            LEFT OUTER JOIN cli_maximo_ph_admin.maestras_base t4 ON t4.id = t1.id_rol_persona
            LEFT OUTER JOIN multimedia t9 ON t9.id_registro = t1.id AND t9.tipo = 8
        WHERE 
            (
                (IF(t1.id_zona='',NULL,t1.id_zona) IS NULL AND IF(t1.id_persona='',NULL,t1.id_persona) IS NULL AND IF(t1.id_rol_persona='',NULL,t1.id_rol_persona) IS NULL)

                OR

                t3.email='${req.user.email}'

                OR

                t1.id_rol_persona='${req.user.id_rol}'
            )
        GROUP BY t1.id`;


        const [massiveMessages] = await pool.query(queryOwnMessages);
        
        let queryOwnMessagesZones = `SELECT 
            t1.id, t1.titulo, t1.descripcion,
            t1.notificacion_push, DATE_FORMAT(t1.created_at,"%Y-%m-%d %H:%i") AS created_at, IF(t1.id_persona, DATE_FORMAT(t1.read_at,"%Y-%m-%d %H:%i"),'MENSAJE MASIVO') AS read_at,
            t1.id_zona, IFNULL(t2.nombre,'') AS zona,
            t1.id_persona,
            CONCAT(IFNULL(t3.primer_nombre,''),' ',IFNULL(t3.segundo_nombre,''),' ',IFNULL(t3.primer_apellido,''),' ',IFNULL(t3.segundo_apellido,'')) AS persona,
            t1.id_rol_persona, t4.nombre AS rol,
            IFNULL(t9.nombre,'') AS imagen

        FROM mensajes t1 
            INNER JOIN zonas t2 ON t2.id = t1.id_zona
            INNER JOIN personas t3 ON t3.email='${req.user.email}'
            INNER JOIN inmueble_personas_admon t5 ON t5.id_persona = t3.id
            INNER JOIN inmuebles t6 ON t6.id = t5.id_inmueble AND t6.id_inmueble_zona = t2.id
            LEFT OUTER JOIN cli_maximo_ph_admin.maestras_base t4 ON t4.id = t1.id_rol_persona
            LEFT OUTER JOIN multimedia t9 ON t9.id_registro = t1.id AND t9.tipo = 8
        WHERE 
            1=1
        GROUP BY t1.id`;


        const [massiveMessagesZones] = await pool.query(queryOwnMessagesZones);
        
        //pool.end();

        return res.json({success: true, data: [...massiveMessages, ...massiveMessagesZones]});
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};

const getAllMassiveMessages = async (req, res) => {
    try {
        let pool = poolSys.getPool(req.user.token_db);

        const [massiveMessages] = await pool.query(`SELECT 
            t1.id, t1.titulo, t1.descripcion,
            t1.notificacion_push, DATE_FORMAT(t1.created_at,"%Y-%m-%d %H:%i") AS created_at, IF(t1.id_persona, DATE_FORMAT(t1.read_at,"%Y-%m-%d %H:%i"),'MENSAJE MASIVO') AS read_at,
            t1.id_zona, IFNULL(t2.nombre,'') AS zona,
            t1.id_persona,
            CONCAT(IFNULL(t3.primer_nombre,''),' ',IFNULL(t3.segundo_nombre,''),' ',IFNULL(t3.primer_apellido,''),' ',IFNULL(t3.segundo_apellido,'')) AS persona,
            t1.id_rol_persona, t4.nombre AS rol,
            IFNULL(t9.nombre,'') AS imagen

        FROM mensajes t1 
            LEFT OUTER JOIN zonas t2 ON t2.id = t1.id_zona
            LEFT OUTER JOIN personas t3 ON t3.id = t1.id_persona
            LEFT OUTER JOIN cli_maximo_ph_admin.maestras_base t4 ON t4.id = t1.id_rol_persona
            LEFT OUTER JOIN multimedia t9 ON t9.id_registro = t1.id AND t9.tipo = 8
        WHERE 1
        ORDER BY t1.id DESC`);
    
        let access = await getModuleAccess({
          user: req.user.id, 
          client: req.user.id_cliente, 
          module: 41, 
          pool
        });
        
        //pool.end();

        return res.json({success: true, data: massiveMessages, access});
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};

const createMassiveMessage = async (req, res) => {     
    try {
        multer({ storage }).single('image')(req, res, async(err) => {
            if (err) {
              console.log(err.message);
              return res.status(400).json({ message: "Failed image processing" });
            }
      
            const image = req.file ? path.basename(req.file.path) : null;
            const registerSchema = Joi.object({
                id_zona: Joi.number().required().allow(null,''),
                id_rol_persona: Joi.number().required().allow(null,''),
                id_persona: Joi.number().required().allow(null,''),
                notificacion_push: Joi.number().required(),
                titulo: Joi.string().required(),
                image: Joi.allow(null,''),
                tipo_image: Joi.string().required().allow(null,''),
                descripcion: Joi.string().required()
            });

            //VALIDATE FORMAT FIELDS
            const { error } = registerSchema.validate(req.body);
            if (error) {
            return res.status(201).json({ success: false, error: error.message });
            }

            const { id_zona, id_rol_persona, id_persona, tipo_image, notificacion_push, titulo, descripcion } = req.body;

            let pool = poolSys.getPool(req.user.token_db);

            //CREATE MASSIVE MESSAGE
            const [insertedNewMessage] = await pool.query(`INSERT INTO mensajes 
            (id_zona, id_rol_persona, id_persona, notificacion_push, titulo, descripcion, created_by) 
                VALUES 
            (?, ?, ?, ?, UPPER(?), ?, ?)`,
            [(id_zona||null), (id_rol_persona||null), (id_persona||null), notificacion_push, titulo, descripcion, req.user.id]
            );
            
            //GET NEW MESSAGE
            const [rows] = await pool.query(`SELECT 
                t1.id, t1.titulo, t1.descripcion,
                t1.notificacion_push, DATE_FORMAT(t1.created_at,"%Y-%m-%d %H:%i") AS created_at,
                t1.id_zona, IFNULL(t2.nombre,'') AS zona,
                t1.id_persona,
                CONCAT(IFNULL(t3.primer_nombre,''),' ',IFNULL(t3.segundo_nombre,''),' ',IFNULL(t3.primer_apellido,''),' ',IFNULL(t3.segundo_apellido,'')) AS persona,
                t1.id_rol_persona, t4.nombre AS rol
            FROM mensajes t1 
                LEFT OUTER JOIN zonas t2 ON t2.id = t1.id_zona
                LEFT OUTER JOIN personas t3 ON t3.id = t1.id_persona
                LEFT OUTER JOIN cli_maximo_ph_admin.maestras_base t4 ON t4.id = t1.id_rol_persona
            WHERE t1.id = ?`, [ insertedNewMessage.insertId ]);
            
            let idNewMessage = insertedNewMessage.insertId;
            //ADD IMAGE
            if(image){
              await pool.query(`INSERT INTO multimedia 
              (tipo, id_registro, nombre, peso, tipo_multimedia, created_by)
                  VALUES
              (?, ?, ?, ?, ?, ?)
              `, [8, idNewMessage, image, 0, tipo_image, req.user.id]);
            }

            if(notificacion_push){
                
                let usersToNotify = [];

                if(id_zona){
                    let queryUsersMessageWithZone = `SELECT 
                        t7.id_rol AS id_rol_persona, t5.id AS id_persona, t6.id AS id_usuario
                    FROM mensajes t1 
                        INNER JOIN zonas t2 ON t2.id = t1.id_zona
                        INNER JOIN inmuebles t3 ON t3.id_inmueble_zona = t2.id
                        INNER JOIN inmueble_personas_admon t4 ON t4.id_inmueble = t3.id
                        INNER JOIN personas t5 ON t5.id = t4.id_persona
                        INNER JOIN cli_maximo_ph_admin.usuarios t6 ON t6.email = t5.email
                        INNER JOIN cli_maximo_ph_admin.usuario_roles t7 ON t7.id_usuario = t6.id
                    WHERE 
                        t1.id = '${insertedNewMessage.insertId}' AND t7.id_cliente = '${req.user.id_cliente}'`;

                    [usersToNotify] = await pool.query(queryUsersMessageWithZone);

                    await Promise.all(usersToNotify.map(async (userToNotify)=>{
                        if((userToNotify.id_rol_persona==id_rol_persona || id_rol_persona==null)&&(userToNotify.id_persona==id_persona || id_persona==null)){
                            await sendFBPushMessageUser(userToNotify.id_usuario, {
                                title: `Nueva mensaje`,
                                body: `Haz recibo un nuevo mensaje con el Asunto: ${titulo}`
                            }, pool);
                        }
                    }));
                }else if(id_persona){
                    let queryUsersMessageWithPerson = `SELECT 
                        t7.id_rol AS id_rol_persona, t5.id AS id_persona, t6.id AS id_usuario
                    FROM personas t5
                        INNER JOIN cli_maximo_ph_admin.usuarios t6 ON t6.email = t5.email
                        INNER JOIN cli_maximo_ph_admin.usuario_roles t7 ON t7.id_usuario = t6.id
                    WHERE 
                        t5.id = ${id_persona} AND t7.id_cliente = '${req.user.id_cliente}'`;
                    
                    [usersToNotify] = await pool.query(queryUsersMessageWithPerson);

                    await Promise.all(usersToNotify.map(async (userToNotify)=>{
                        if((userToNotify.id_rol_persona==id_rol_persona || id_rol_persona==null)){
                            await sendFBPushMessageUser(userToNotify.id_usuario, {
                                title: `Nueva mensaje`,
                                body: `Haz recibo un nuevo mensaje con el Asunto: ${titulo}`
                            }, pool);
                        }
                    }));
                }else if(id_rol_persona){
                    let queryUsersMessageWithRole = `SELECT 
                        t7.id_rol AS id_rol_persona, t6.id AS id_usuario
                    FROM cli_maximo_ph_admin.usuarios t6 
                        INNER JOIN cli_maximo_ph_admin.usuario_roles t7 ON t7.id_usuario = t6.id
                    WHERE 
                        t7.id_cliente = '${req.user.id_cliente}' AND t7.id_rol = '${id_rol_persona}'`;


                    [usersToNotify] = await pool.query(queryUsersMessageWithRole);

                    await Promise.all(usersToNotify.map(async (userToNotify)=>{
                        await sendFBPushMessageUser(userToNotify.id_usuario, {
                            title: `Nueva mensaje`,
                            body: `Haz recibo un nuevo mensaje con el Asunto: ${titulo}`
                        }, pool);
                    }));
                }
            }
            
            let message = rows[0];
            
            await genLog({
                module: 'mensajes', 
                idRegister: message.id, 
                recordBefore: message, 
                oper: 'CREATE', 
                detail: `MENSAJE CON TÍTULO ${message.titulo} ENVIADO POR ${req.user.email}`, 
                user: req.user.id,
                pool
            });
            
            //pool.end();

            return res.json({success: true, data: {message}});
        });
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};

const readMassiveMessage = async (req, res) => {    
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
      
      //UPDATE READ MASSIVE MESSAGE
      await pool.query(`UPDATE mensajes t1 
        INNER JOIN personas t2 ON t2.id = t1.id_persona
      SET read_at = NOW()
      WHERE t1.id = ? AND t2.email = '${req.user.email}' AND read_at IS NULL`,[id]);
      
      //pool.end();
  
      return res.json({success: true, data: {message: { id }}});
    } catch (error) {
        return { success: false, error: 'Internal Server Error', error: error.message };
    }
  };

export {
    getAllMassiveMessages,
    getOwnMessages,
    readMassiveMessage,
    createMassiveMessage
};
  