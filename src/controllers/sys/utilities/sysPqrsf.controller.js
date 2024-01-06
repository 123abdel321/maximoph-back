import Joi  from "joi";
import { poolSys } from "../../../db.js";
import { getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { genLog } from "../../../helpers/sysLogs.js";

import path from "path";
import multer from "multer";
import CryptoJS from "crypto-js";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

import { sendFBPushMessageUser } from "../../../helpers/firebasePushNotification.js";

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(__dirname, "../../../../public/uploads/photoPqrsf"));
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

const getOwnPqrsf = async (req, res) => {
    try {
        let pool = poolSys.getPool(req.user.token_db);

        let queryOwnPqrsf = `SELECT 
            t1.*,
            
            (CASE t2.tipo 
                WHEN 0 THEN 'INMUEBLE'
                WHEN 1 THEN 'PARQUEADERO'
                WHEN 2 THEN 'CUARTO ÚTIL'
            END) AS tipoInmuebleText,

            CONCAT(t3.nombre,':',t2.numero_interno_unidad) AS inmuebleText,
            
            DATE_FORMAT(t1.created_at,"%Y-%m-%d %H:%i") AS created_at,

            IFNULL(t4.nombre,'') AS imagen,

            CONCAT(IFNULL(t5.primer_nombre,''),' ',IFNULL(t5.segundo_nombre,''),' ',IFNULL(t5.primer_apellido,''),' ',IFNULL(t5.segundo_apellido,'')) AS personaText,

            (SELECT COUNT(t6.id) 
		     FROM mensajes t6 
		     WHERE t6.titulo LIKE CONCAT('%RESPUESTA PQRSF # ', t1.id, '%')
		    ) AS respuestas,
            
            (SELECT t7.descripcion
		     FROM mensajes t7 
		     WHERE t7.titulo LIKE CONCAT('%RESPUESTA PQRSF # ', t1.id, '%')
             ORDER BY t7.id DESC LIMIT 1
		    ) AS ultima_respuesta

        FROM pqrsf t1 
            INNER JOIN inmuebles t2 ON t2.id = t1.id_inmueble
            INNER JOIN zonas t3 ON t3.id = t2.id_inmueble_zona
            LEFT OUTER JOIN multimedia t4 ON t4.id_registro = t1.id AND t4.tipo = 3
            INNER JOIN personas t5 ON t5.id = t1.id_persona

        WHERE 
            t1.created_by='${req.user.id}' 
        ORDER BY t1.id ASC`;


        const [ownPqrsf] = await pool.query(queryOwnPqrsf);
        
        //pool.end();

        return res.json({success: true, data: ownPqrsf});
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};

const getAllPqrsf = async (req, res) => {
    try {
        let pool = poolSys.getPool(req.user.token_db);

        const [pqrsf] = await pool.query(`SELECT 
            t1.*,
            
            (CASE t2.tipo 
                WHEN 0 THEN 'INMUEBLE'
                WHEN 1 THEN 'PARQUEADERO'
                WHEN 2 THEN 'CUARTO ÚTIL'
            END) AS tipoInmuebleText,

            CONCAT(t3.nombre,':',t2.numero_interno_unidad) AS inmuebleText,
            
            DATE_FORMAT(t1.created_at,"%Y-%m-%d %H:%i") AS created_at,

            IFNULL(t4.nombre,'') AS imagen,

            CONCAT(IFNULL(t5.primer_nombre,''),' ',IFNULL(t5.segundo_nombre,''),' ',IFNULL(t5.primer_apellido,''),' ',IFNULL(t5.segundo_apellido,'')) AS personaText,

            (SELECT COUNT(t6.id) 
		     FROM mensajes t6 
		     WHERE t6.titulo LIKE CONCAT('%RESPUESTA PQRSF # ', t1.id, '%')
		    ) AS respuestas,
            
            (SELECT t7.descripcion
		     FROM mensajes t7 
		     WHERE t7.titulo LIKE CONCAT('%RESPUESTA PQRSF # ', t1.id, '%')
             ORDER BY t7.id DESC LIMIT 1
		    ) AS ultima_respuesta
            
        FROM pqrsf t1 
            INNER JOIN inmuebles t2 ON t2.id = t1.id_inmueble
            INNER JOIN zonas t3 ON t3.id = t2.id_inmueble_zona
            LEFT OUTER JOIN multimedia t4 ON t4.id_registro = t1.id AND t4.tipo = 3
            INNER JOIN personas t5 ON t5.id = t1.id_persona

        WHERE 1 = 1
        ORDER BY t1.id ASC`);
    
        let access = await getModuleAccess({
          user: req.user.id, 
          client: req.user.id_cliente, 
          module: 42, 
          pool
        });
        
        //pool.end();

        return res.json({success: true, data: pqrsf, access});
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};

const createPqrsf = async (req, res) => {     
    try {
        multer({ storage }).single('image')(req, res, async(err) => {
            if (err) {
              console.log(err.message);
              return res.status(400).json({ message: "Failed image processing" });
            }
      
            const image = req.file ? path.basename(req.file.path) : null;

            const registerSchema = Joi.object({
                id_inmueble: Joi.number().required(),
                id_persona: Joi.number().required(),
                tipo: Joi.number().required(),
                image: Joi.allow(null,''),
                tipo_image: Joi.string().required().allow(null,''),
                asunto: Joi.string().required(),
                descripcion: Joi.string().required()
            });

            //VALIDATE FORMAT FIELDS
            const { error } = registerSchema.validate(req.body);
            if (error) {
            return res.status(201).json({ success: false, error: error.message });
            }

            const { id_inmueble, id_persona, tipo, tipo_image, asunto, descripcion } = req.body;

            let pool = poolSys.getPool(req.user.token_db);

            //CREATE PQRSF
            const [insertedNewPqrsf] = await pool.query(`INSERT INTO pqrsf 
            (id_inmueble, id_persona, tipo, asunto, descripcion, created_by) 
                VALUES 
            (?, ?, ?, UPPER(?), ?, ?)`,
            [id_inmueble, id_persona, tipo, asunto, descripcion, req.user.id]
            );
            
            //GET NEW PQRSF
            const [rows] = await pool.query(`SELECT 
                t1.*,
                
                (CASE t2.tipo 
                    WHEN 0 THEN 'INMUEBLE'
                    WHEN 1 THEN 'PARQUEADERO'
                    WHEN 2 THEN 'CUARTO ÚTIL'
                END) AS tipoInmuebleText,

                CONCAT(t3.nombre,':',t2.numero_interno_unidad) AS inmuebleText,
                
                DATE_FORMAT(t1.created_at,"%Y-%m-%d %H:%i") AS created_at,

                IFNULL(t4.nombre,'') AS imagen,

                CONCAT(IFNULL(t5.primer_nombre,''),' ',IFNULL(t5.segundo_nombre,''),' ',IFNULL(t5.primer_apellido,''),' ',IFNULL(t5.segundo_apellido,'')) AS personaText

            FROM pqrsf t1 
                INNER JOIN inmuebles t2 ON t2.id = t1.id_inmueble
                INNER JOIN zonas t3 ON t3.id = t2.id_inmueble_zona
                LEFT OUTER JOIN multimedia t4 ON t4.id_registro = t1.id AND t4.tipo = 3
                INNER JOIN personas t5 ON t5.id = t1.id_persona

            WHERE t1.id = ?`, [ insertedNewPqrsf.insertId ]);
            
            let pqrsf = rows[0];
            
            //ADD IMAGE
            if(image){
                await pool.query(`INSERT INTO multimedia 
                (tipo, id_registro, nombre, peso, tipo_multimedia, created_by)
                    VALUES
                (?, ?, ?, ?, ?, ?)
                `, [3, pqrsf.id, image, 0, tipo_image, req.user.id]);
            }

            let queryUsersMessageWithRoleAdmin = `SELECT 
                t7.id_rol AS id_rol_persona, t6.id AS id_usuario
            FROM cli_maximo_ph_admin.usuarios t6 
                INNER JOIN cli_maximo_ph_admin.usuario_roles t7 ON t7.id_usuario = t6.id
            WHERE 
                t7.id_cliente = '${req.user.id_cliente}' AND t7.id_rol = '1'`;


            let [usersToNotify] = await pool.query(queryUsersMessageWithRoleAdmin);

            await Promise.all(usersToNotify.map(async (userToNotify)=>{
                await sendFBPushMessageUser(userToNotify.id_usuario, {
                    title: `Nueva PQRSF`,
                    body: `Haz recibo un nuevo PQRSF con el Asunto: ${asunto}`
                }, pool);
            }));

            //pool.end();

            return res.json({success: true, data: {pqrsf}});
        });
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};

export {
    getAllPqrsf,
    getOwnPqrsf,
    createPqrsf
};
  