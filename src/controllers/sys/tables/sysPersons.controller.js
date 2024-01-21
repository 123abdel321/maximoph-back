import Joi  from "joi";
import { poolSys } from "../../../db.js";
import axios from "axios";
import { getSysEnv, getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { genLog } from "../../../helpers/sysLogs.js";

import fs from "fs";
import path from "path";
import multer from "multer";
import CryptoJS from "crypto-js";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(__dirname, "../../../../public/uploads/photoPersons")); // use path.join to join path components correctly
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

const getAllPersons = async (req, res) => {
  try {
    let pool = poolSys.getPool(req.user.token_db);

    const [listPersons] = await pool.query(
        `SELECT 
        
            t1.*,
            IF(t1.tipo_documento=0,'CÉDULA','NIT') As tipo_documento_text,
            TRIM(REPLACE(REPLACE(CONCAT(
              IFNULL(t1.primer_nombre,''),' ',
              IFNULL(t1.segundo_nombre,''),' ',
              IFNULL(t1.primer_apellido,''),' ',
              IFNULL(t1.segundo_apellido,''),' '
            ),'  ',' '),'  ',' ')) AS nombres,
            t1.id AS value,
            TRIM(REPLACE(REPLACE(CONCAT(
              IFNULL(t1.primer_nombre,''),' ',
              IFNULL(t1.segundo_nombre,''),' ',
              IFNULL(t1.primer_apellido,''),' ',
              IFNULL(t1.segundo_apellido,''),' '
            ),'  ',' '),'  ',' ')) AS label,
            IF(t1.sexo=0,'MASCULINO','FEMENINO') As sexo_text,
            CONCAT(t2.codigo,' - ',t2.nombre) AS ciudadLabel,
            
            (SELECT
              GROUP_CONCAT(t5.numero_interno_unidad) As numeros_unidades
            FROM inmueble_personas_admon t4
              INNER JOIN inmuebles t5 ON t5.id = t4.id_inmueble
            WHERE t4.id_persona = t1.id) AS numero_unidades

        FROM personas t1
        
        LEFT OUTER JOIN erp_maestras t2 ON t2.id = t1.id_ciudad_erp
        
        WHERE
              t1.eliminado = 0 
              ${req.erp ? " AND (t1.numero_documento!='') ": ''}
        `);

    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 3, 
      pool
    });

    //pool.end();

    return res.json({success: true, data: listPersons, access });
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createPerson = async (req, res) => {     
  try {
    const registerSchema = Joi.object({
      id_tercero_erp: Joi.number().allow(null,''), 
      id_ciudad_erp: Joi.number().allow(null,''), 
      direccion: Joi.string().allow(null,''), 
      tipo_documento: Joi.number().allow(null,''), 
      numero_documento: Joi.number().allow(null,''), 
      primer_nombre: Joi.string().required(),
      segundo_nombre: Joi.string().allow(null,''),
      primer_apellido: Joi.string().allow(null,''), 
      segundo_apellido: Joi.string().allow(null,''), 
      telefono: Joi.string().allow(null,''), 
      celular: Joi.string().allow(null,''), 
      email: Joi.string().allow(null,''), 
      fecha_nacimiento: Joi.date().allow(null,''), 
      sexo: Joi.number()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    let { id_tercero_erp, id_ciudad_erp, direccion, tipo_documento, numero_documento, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, celular, email, fecha_nacimiento, sexo } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    //VALIDATE NUMERO_DOCUMENTO EXIST
    if(numero_documento){
        const [existPerson] = await pool.query(
        "SELECT * FROM personas WHERE numero_documento = ?",
        [numero_documento]
        );

        if (existPerson.length) {
          return res.status(201).json({ success: false, error: `El número de documento ${numero_documento} ya se encuentra registrado.` });
        }

        const caracteresEspeciales = /[^a-zA-Z0-9]/g;
        numero_documento = numero_documento.split("-")[0].replace(caracteresEspeciales, '');
    }

    //VALIDATE EMAIL EXIST
    if(email){
        const [existPerson] = await pool.query(
        "SELECT * FROM personas WHERE email = ?",
        [email]
        );

        if (existPerson.length) {
          return res.status(201).json({ success: false, error: `El email ${email} ya se encuentra registrado.` });
        }
    }

    //CREATE NEW PERSON
    const [insertedNewPerson] = await pool.query(`INSERT INTO personas 
      (id_tercero_erp, id_ciudad_erp, direccion, tipo_documento, numero_documento, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, celular, email, fecha_nacimiento, sexo, avatar, created_by) 
        VALUES 
      (?, ?, UPPER(?), ?, ?, UPPER(?), UPPER(?), UPPER(?), UPPER(?), ?, ?, UPPER(?), ?, ?, ?, ?)`,
      [id_tercero_erp, id_ciudad_erp, direccion, (tipo_documento ? tipo_documento : 0), (numero_documento ? numero_documento : ''), primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, (telefono ? telefono : null), null, email, null, sexo, null, req.user.id]
    );
    
    //GET NEW PERSON
    const [rows] = await pool.query(`SELECT 
        t1.*,
        IF(t1.tipo_documento=0,'CÉDULA','NIT') As tipo_documento_text,
        CONCAT(t2.codigo,' - ',t2.nombre) AS ciudadLabel
    FROM personas t1
    LEFT OUTER JOIN erp_maestras t2 ON t2.id = t1.id_ciudad_erp
    WHERE t1.id = ?`, [ insertedNewPerson.insertId ]);
    
    let person = rows[0];
    
    let responseSync = await syncERPPersonInner(insertedNewPerson.insertId, pool, res);
    
    await genLog({
        module: 'personas', 
        idRegister: person.id, 
        recordBefore: person, 
        oper: 'CREATE', 
        detail: `PERSONA CON DOCUMENTO ${person.numero_documento} CREADA POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {person}});
    
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const uploadPhotoPerson = async (req, res) => {
  try {
    multer({ storage }).single('photo')(req, res, async(err) => {
      if (err) {
        console.log(err);
        return res.status(400).json({ message: "Failed image processing" });
      }

      const image = req.file ? path.basename(req.file.path) : null;

      const registerSchema = Joi.object({
        peso: Joi.number().required(),
        tipo: Joi.string().required(),
        id: Joi.number().allow(null,''),
        id_visitor: Joi.number().allow(null,'')
      });
  
      //VALIDATE FORMAT FIELDS
      const { error } = registerSchema.validate(req.body);
      if (error) {
        try {
         return res.status(201).json({ success: false, error: error.message });
        } catch(error){ }
      }  

      const { id, id_visitor, peso, tipo } = req.body;
      
      if(!id&&!id_visitor){
        return res.status(201).json({ success: false, error: `Debe especificar la persona o visitante.` });
      }

      let pool = poolSys.getPool(req.user.token_db);
      
      let tipoMultimedia = id ? 0 : 1;
      let idTable = id ? id : id_visitor;
      let table = id ? 'personas' : 'inmueble_personas_visitantes';
      let avatarField = id ? 'avatar' : 'persona_visitante_avatar';

      let [existPerson] = await pool.query(`SELECT IFNULL(${avatarField},'') AS avatar, id As id_persona FROM ${table} WHERE id = ? `,[idTable]);
    
      if (!existPerson.length) {
        try {
          return res.status(201).json({ success: false, error: `La persona no se encuentra registrada.` });
        } catch(error){ }
      }
  
      existPerson = existPerson[0];

      if(existPerson.avatar.length){
        try{
          fs.unlinkSync(path.join(__dirname, `../../../../public/uploads/photoPersons/${existPerson.avatar}`));
        } catch(error){ }
      }
      
      await pool.query(`DELETE FROM multimedia WHERE tipo = ? AND id_registro = ?`, [tipoMultimedia, existPerson.id_persona]);
      
      await pool.query(`INSERT INTO multimedia 
      (tipo, id_registro, nombre, peso, tipo_multimedia, created_by)
        VALUES
      (?, ?, ?, ?, ?, ?)
      `, [tipoMultimedia, existPerson.id_persona, image, peso, tipo, req.user.id]);
      
      await pool.query(`UPDATE ${table} SET ${avatarField} = ?, updated_by = ? WHERE id = ?`,[image, req.user.id, idTable]);
      
      //pool.end();

      return res.json({success: true, data: {photo: image}});
    });
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putPerson = async (req, res) => {  
  try {
    const registerSchema = Joi.object({
      id_tercero_erp: Joi.number().allow(null,''), 
      id_ciudad_erp: Joi.number().allow(null,''), 
      tipo_documento: Joi.number().allow(null,''), 
      numero_documento: Joi.number().allow(null,''), 
      primer_nombre: Joi.string().required(),
      segundo_nombre: Joi.string().allow(null,''),
      primer_apellido: Joi.string().allow(null,''), 
      segundo_apellido: Joi.string().allow(null,''), 
      telefono: Joi.string().allow(null,''), 
      direccion: Joi.string().allow(null,''), 
      celular: Joi.string().allow(null,''), 
      email: Joi.string().allow(null,''), 
      fecha_nacimiento: Joi.date().allow(null,''), 
      avatar: Joi.string().allow(null,''), 
      created_by: Joi.allow(null,''), 
      created_at: Joi.date(), 
      updated_at: Joi.string().allow(null,''), 
      numero_unidades: Joi.string().allow(null,''), 
      updated_by: Joi.allow(null,''), 
      importado: Joi.number().allow(null,''),
      sexo: Joi.number(),
      id: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    let { id, id_tercero_erp, id_ciudad_erp, direccion, tipo_documento, numero_documento, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, celular, email, fecha_nacimiento, sexo } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    //VALIDATE NUMERO_DOCUMENTO EXIST
    if(numero_documento){
        const [existPerson] = await pool.query(
        "SELECT * FROM personas WHERE numero_documento = ? AND id <> ?",
        [numero_documento, id]
        );

        if (existPerson.length) {
          return res.status(201).json({ success: false, error: `El número de documento ${numero_documento} ya se encuentra registrado.` });
        }
                
        const caracteresEspeciales = /[^a-zA-Z0-9]/g;
        numero_documento = numero_documento.split("-")[0].replace(caracteresEspeciales, '');
    }

    //VALIDATE EMAIL EXIST
    if(email){
        const [existPerson] = await pool.query(
        "SELECT * FROM personas WHERE email = ? AND id <> ?",
        [email, id]
        );

        if (existPerson.length) {
          return res.status(201).json({ success: false, error: `El email ${email} ya se encuentra registrado.` });
        }
    }

    //GET BEFORE EDITED PERSON
    const [rowsBefore] = await pool.query(`SELECT * FROM personas WHERE id = ?`, [ id ]);

    let personBefore = rowsBefore[0];

    //EDIT PERSON
    await pool.query(`UPDATE personas SET
        id_tercero_erp = ?,
        id_ciudad_erp = ?,
        direccion = UPPER(?),
        tipo_documento = ?,
        numero_documento = ?,
        primer_nombre = UPPER(?),
        segundo_nombre = UPPER(?),
        primer_apellido = UPPER(?),
        segundo_apellido = UPPER(?),
        telefono = ?,
        celular = ?, 
        email = UPPER(?), 
        fecha_nacimiento = ?, 
        sexo = ?, 
        avatar = ?, 
        updated_at = NOW(),
        updated_by = ?
      WHERE 
        id = ?`,
      [id_tercero_erp, id_ciudad_erp, direccion, (tipo_documento ? tipo_documento : 0), (numero_documento ? numero_documento : ''), primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, celular, email, (fecha_nacimiento ? fecha_nacimiento : '0000-00-00'), sexo, '', req.user.id, id]
    );
    
    //GET EDITED PERSON
    const [rows] = await pool.query(`SELECT 
        t1.*,
        IF(t1.tipo_documento=0,'CÉDULA','NIT') As tipo_documento_text,
        CONCAT(t2.codigo,' - ',t2.nombre) AS ciudadLabel
    FROM personas t1
    LEFT OUTER JOIN erp_maestras t2 ON t2.id = t1.id_ciudad_erp 
    WHERE t1.id = ?`, [ id ]);
    
    let person = rows[0];
    
    let responseSync = await syncERPPersonInner(id, pool, res);
    await genLog({
        module: 'personas', 
        idRegister: person.id, 
        recordBefore: personBefore, 
        oper: 'UPDATE', 
        detail: `PERSONA CON NÚMERO DE DOCUMENTO ${person.numero_documento} ACTUALIZADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });

    //pool.end();

    return res.json({success: true, data: {person}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deletePerson = async (req, res) => {     
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

    //DELETE PERSON
    await pool.query(`UPDATE personas SET eliminado = 1, updated_by = ? WHERE id = ?`,
      [req.user.id, id]
    );

    //DELETE PERSON CYCLICAL BILL
    await pool.query(`DELETE
        t3
    FROM personas t1 
        LEFT OUTER JOIN facturas_ciclica t2 ON t2.id_persona =t1.id
        LEFT OUTER JOIN factura_ciclica_detalles t3 ON t3.id_factura_ciclica =t2.id
    WHERE 
        t1.eliminado = 1;
    
    DELETE
        t2
    FROM personas t1 
        LEFT OUTER JOIN facturas_ciclica t2 ON t2.id_persona =t1.id
        LEFT OUTER JOIN factura_ciclica_detalles t3 ON t3.id_factura_ciclica =t2.id
    WHERE 
        t1.eliminado = 1;`);

    //GET PERSON
    let [person] = await pool.query(`SELECT * FROM personas WHERE id = ?`,[id]);
    person = person[0];
        
    await genLog({
        module: 'personas', 
        idRegister: person.id, 
        recordBefore: {}, 
        oper: 'DELETE', 
        detail: `PERSONA CON NÚMERO DE DOCUMENTO ${person.numero_documento} ELIMINADA POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });

    //pool.end();

    return res.json({success: true, data: {person: { id }}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const syncERPPersonInner = async (id, pool, res) => { 
  try {
    let [existPerson] = await pool.query(`SELECT
        P.*,
        MC.id_erp AS id_ciudad
      FROM
        personas P
        
      LEFT JOIN erp_maestras MC ON P.id_ciudad_erp = MC.id AND MC.tipo = 3
      
      WHERE P.id = ${id}`
    );

    existPerson = existPerson[0];
    
    let errorSync = [];

    if(existPerson.tipo_documento===""||existPerson.tipo_documento===null){
      errorSync.push("Tipo de Documento");
    }

    if(existPerson.numero_documento==""||existPerson.numero_documento===null){
      errorSync.push("Número de Documento");
    }

    if(existPerson.primer_nombre==""||existPerson.primer_nombre===null){
      errorSync.push("Primer Nombre");
    }

    if(existPerson.id_ciudad_erp==""||existPerson.id_ciudad_erp===null){
      errorSync.push("Ciudad");
    }

    if(existPerson.direccion==""||existPerson.direccion===null){
      errorSync.push("Dirección");
    }

    if(existPerson.email==""){
      errorSync.push("E-Mail");
    }

    errorSync = errorSync.join(", ");

    if (errorSync.length) {
      return { success: false, error: `The fields missing are: ${errorSync} for synchronized with this person.` };
    }

    let apiKeyERP = await getSysEnv({
      name: 'api_key_erp',
      pool: pool
    });
    
    //VALIDATE ERP API KEY
    if (!apiKeyERP) {
      return { success: false, error: 'The API KEY ERP missing.' };
    }

    const instance = axios.create({
			baseURL: `${process.env.URL_API_ERP}`,
			headers: {
				'Authorization': apiKeyERP,
				'Content-Type': 'application/json'
			}
		});

    let personERP = await instance.get(`nit?numero_documento=${existPerson.numero_documento}`);
    personERP = personERP.data.data;

    let dataPersonERP = {
      "nit_1": existPerson.numero_documento,
      "documento": (existPerson.tipo_documento==0 ? 2 : 5),
      "apellido_1": existPerson.primer_apellido,
      "apellido_2": existPerson.segundo_apellido,
      "nombres": `${existPerson.primer_nombre} ${existPerson.segundo_nombre}`,
      "razon_social": `${existPerson.primer_nombre} ${existPerson.segundo_nombre} ${existPerson.primer_apellido} ${existPerson.segundo_apellido}`,
      "direccion": existPerson.direccion,
      "municipio": existPerson.id_ciudad_erp,
      "email": existPerson.email
    };
    
    if(personERP.length == 0){ //CREAR NIT
			var url = `nit?numero_documento=${existPerson.numero_documento}&id_tipo_documento=${(existPerson.tipo_documento==0 ? 3 : 6)}&id_ciudad=${existPerson.id_ciudad}&primer_apellido=${existPerson.primer_apellido}&segundo_apellido=${existPerson.segundo_apellido}&primer_nombre=${existPerson.primer_nombre}&otros_nombres=${existPerson.segundo_nombre}&razon_social=${existPerson.primer_nombre} ${existPerson.segundo_nombre} ${existPerson.primer_apellido} ${existPerson.segundo_apellido}&direccion=${existPerson.direccion}&email=${existPerson.email}`;

			let resultNewPersonERP = await instance.post(url);
			personERP = resultNewPersonERP.data.data.id;
		} else { //ACTUALIZAR NIT
			personERP = personERP[0].id;
			var url = `nit?id=${personERP}&numero_documento=${existPerson.numero_documento}&id_tipo_documento=${(existPerson.tipo_documento==0 ? 3 : 6)}&id_ciudad=${existPerson.id_ciudad}&primer_apellido=${existPerson.primer_apellido}&segundo_apellido=${existPerson.segundo_apellido}&primer_nombre=${existPerson.primer_nombre}&otros_nombres=${existPerson.segundo_nombre}&razon_social=${existPerson.primer_nombre} ${existPerson.segundo_nombre} ${existPerson.primer_apellido} ${existPerson.segundo_apellido}&direccion=${existPerson.direccion}&email=${existPerson.email}`;
			await instance.put(url);
		}

    if(existPerson.id_tercero_erp===null||existPerson.id_tercero_erp===""){//ACTUALIZAR ID_TERCERO_ERP
      await pool.query(`UPDATE personas SET id_tercero_erp = ? WHERE id = ?`,
        [personERP, id]
      );
    }

    return true;
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const syncERPPerson = async (req, res) => { 
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
    let responseSync = await syncERPPersonInner(id, pool, res);

    if(responseSync==true){
      //pool.end();
      return res.json({success: true});
    }else{
      return res.status(201).json(responseSync);
    }
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  uploadPhotoPerson,
  getAllPersons,
  syncERPPerson,
  createPerson,
  deletePerson,
  putPerson
};
