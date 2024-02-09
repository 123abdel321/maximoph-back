import fs from "fs";
import Joi  from "joi";
import axios from "axios";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { updateSysEnv, getSysEnv } from "../../helpers/sysEnviroment.js";
import { poolAdm, poolSys } from "../../db.js";
import { getRolePermissions } from "../../helpers/getRolePermissions.js";

import { sendMail } from "../../helpers/sendMail.js";

import { welcomeEmailTemplate } from "../../helpers/welcomeEmailTemplate.js";

import path from "path";
import multer from "multer";
import CryptoJS from "crypto-js";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(__dirname, "../../../public/uploads/companyLogo"));
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

const getAllClients = async (req, res) => {
  try {
    let pool = poolAdm;

    const [listClients] = await pool.query(
      "SELECT * FROM clientes WHERE estado>0"
    );

    //pool.end();

    return res.json({success: true, data: listClients});
  } catch (error) {
    return res.json(error.message);
  }
};

const createDBName = (name)=>{
    let removeOne = name.normalize('NFD').replace(/[\u0300-\u036f]/g, ''); // Quitamos acentos y ñ
    let replaceOne = removeOne.replace(/\s+/g, '_'); // Reemplazamos espacios por _
    let replaceTwo = replaceOne.replace(/[^a-zA-Z0-9_]/g, ''); // Eliminamos espacios extras
    let finalText = replaceTwo.toLocaleLowerCase();

    return finalText;
}

const createClient = async (req, res) => {
  
  try {  
    multer({ storage }).single('image')(req, res, async(err) => {
      if (err) {
        return res.status(400).json({ message: "Failed image processing: "+err.message });
      }

      const image = req.file ? path.basename(req.file.path) : null;

      const clientSchema = Joi.object({
        tipo_documento: Joi.number().required(),
        numero_documento: Joi.string().required(),
        nombres: Joi.string().required(),
        razon_social: Joi.string().required().allow(null,''),
        ciudad: Joi.string().required(),
        direccion: Joi.string().required(),
        telefono: Joi.string().required(),
        correo: Joi.string().email().required(),
        estado: Joi.number().required(),
        tipo_unidad: Joi.number().required(),
        numero_unidades: Joi.number().required(),
        numero_documentos: Joi.number().required(),
        descripcion: Joi.string().allow(null,''),
        image: Joi.allow(null,''),
        tipo_image: Joi.string().required().allow(null,''),
        valor_suscripcion_mensual: Joi.number().required(),
        password: Joi.string().required()
      });
      
      //VALIDATE FORMAT FIELDS
      const { error } = clientSchema.validate(req.body);
      if (error) {
        return res.status(201).json({ success: false, error: error.message });
      }
      
      const { tipo_documento, numero_documento, nombres, razon_social, ciudad, direccion, telefono, correo, estado, tipo_unidad, numero_unidades, numero_documentos, descripcion, valor_suscripcion_mensual, password, tipo_image } = req.body;

      let DBName = createDBName(razon_social);
          DBName = `${DBName}_${numero_documento}`;
      
      //VALIDATE CLIENT EXISTS
      
      let poolAdmin = poolAdm;
      
      const [existClient] = await poolAdmin.query(
            "SELECT * FROM clientes WHERE token_db = ? OR numero_documento = ?",
            [DBName, numero_documento]
      );

      if (existClient.length) {
        return res.status(201).json({ success: false, error: "Client already exist." });
      }

      const __dirname = path.dirname(fileURLToPath(import.meta.url));
      const sqlFilePath = path.join(__dirname, '../../../db/maximo_ph.sql');
      let sqlFileContent = fs.readFileSync(sqlFilePath, 'utf-8');

      //CREATE NEW DB
      await poolAdmin.query(`CREATE DATABASE ${process.env.DB_DATABASE_SYSTEM_PREFIX}_${DBName}`);

      let pool = await poolSys.getPool(DBName);
      
      //MIGRATE DB
      await pool.query(sqlFileContent);

      //INSERT NEW CLIENT
      const [newClient] = await poolAdmin.query(
          `INSERT INTO clientes (tipo_documento, numero_documento, nombres, razon_social, ciudad, direccion, telefono, correo, estado, tipo_unidad, numero_unidades, numero_documentos, descripcion, valor_suscripcion_mensual, token_db, logo, tipo_logo) VALUES 
          (?,?,UPPER(?),UPPER(?),?,?,?,?,?,?,?,?,UPPER(?),?,?,?,?)`,
          [tipo_documento, numero_documento, nombres, razon_social, ciudad, direccion, telefono, correo, estado, tipo_unidad, numero_unidades, numero_documentos, descripcion, valor_suscripcion_mensual, DBName, image, tipo_image]
      );
      
      //GET NEW CLIENT
      let [client] = await poolAdmin.query("SELECT * FROM clientes WHERE id = ?", [
        newClient.insertId
      ]);
      client = client[0];

      //INSERT FIRST PERSON
      const [newPerson] = await pool.query(`INSERT INTO personas (tipo_documento, numero_documento, primer_nombre, telefono, celular, email, sexo)
      VALUES
        (?, ?, ?, ?, ?, ?, ?)
      `,
      [tipo_documento, numero_documento, nombres, telefono, telefono, correo, 0]);

      //INSERT ROL PERSON
      await pool.query(`INSERT INTO personas_roles (id_persona, id_rol) VALUES ('1', '1')`);
      
      //CREATE ADMIN USER

      //UPDATE ENVIROMENT
      await pool.query(`
        UPDATE entorno SET valor='${razon_social}' WHERE campo = 'razon_social';
        UPDATE entorno SET valor='${numero_documento}' WHERE campo = 'nit';
        UPDATE entorno SET valor='${numero_unidades}' WHERE campo = 'numero_total_unidades';
        UPDATE entorno SET valor='${direccion}' WHERE campo = 'direccion';
        UPDATE entorno SET valor='${telefono}' WHERE campo = 'telefono';
        UPDATE entorno SET valor='${correo}' WHERE campo = 'email';
      `);
      //UPDATE ENVIROMENT

      let [userExists] = await poolAdmin.query("SELECT * FROM usuarios WHERE email = ?", [
        correo
      ]);
      userExists = userExists[0];
      
      let adminUser = userExists ? {insertId: userExists.id} : {};
      let idUser = '';

      if(!userExists){
        const hashedPassword = await bcrypt.hash(password, 10);
        [adminUser] = await poolAdmin.query(`INSERT INTO usuarios (id_cliente, id_persona_maximo, id_rol, email, nombre, password)
        VALUES
          (?, ?, ?, ?, ?, ?)`, [
          newClient.insertId, newPerson.insertId, 1, correo, nombres, hashedPassword
        ]);
        idUser = adminUser.insertId;
      }else{
        let oneMoreClient = userExists.id_cliente.split(",");
            oneMoreClient.push(newClient.insertId);
            oneMoreClient = oneMoreClient.join(",");

        await poolAdmin.query("UPDATE usuarios SET id_cliente = ? WHERE id = ?", [
          oneMoreClient,
          userExists.id
        ]);

        idUser = userExists.id;
      }

      await poolAdmin.query(`INSERT INTO usuario_roles (id_cliente, id_usuario, id_rol)
      VALUES
        (?, ?, ?)`, [
        newClient.insertId, idUser, 1
      ]);

      //CREATE SESSION NEW USER
      let [newAdminUser] = await poolAdmin.query(`SELECT 
          t1.id, t1.id_cliente, t1.id_persona_maximo, t1.id_rol, t1.email, t2.token_db 
        FROM usuarios  t1 
          INNER JOIN clientes t2 ON t2.id = t1.id_cliente
        WHERE 
          t1.id = ?`, [
        adminUser.insertId
      ]);
      newAdminUser = newAdminUser[0];

      const sessionAdminUser = jwt.sign({ user: newAdminUser }, process.env.SECRET_PRIV_KEY, {
        expiresIn: "24h",
      });

      await poolAdmin.query("UPDATE usuarios SET session_token = ? WHERE id = ?", [
        sessionAdminUser,
        adminUser.insertId
      ]);

      // GET COMPLETE NEW USER
      newAdminUser.session_token = sessionAdminUser;

      // GET PERMISSIONS NEW USER
      let permissions = await getRolePermissions(1);

      newAdminUser.permissions = permissions;

      const instance = axios.create({
        baseURL: `${process.env.URL_API_ERP}`,
        headers: {
          'Content-Type': 'application/json'
        }
      });

      var api_key_token = await instance.post(`register-api-token`, JSON.stringify({
        tipo_documento: tipo_documento,
        numero_documento: numero_documento,
        razon_social: razon_social,
        nombres: nombres,
        telefono: telefono,
        direccion: direccion,
        correo: correo,
        password: password
      }));
      api_key_token = api_key_token.data.api_key_token;

      await updateSysEnv({
          name: 'api_key_erp',
          val: api_key_token,
          pool: pool
      });

      const template = welcomeEmailTemplate(razon_social, correo, numero_documento);

      const to = [
        {
          email: correo,
          type: "to",
          name: razon_social,
        },
      ];

      // await sendMail("Máximo PH", "Máximo PH - Nueva Cuenta", template, to);
      
      //poolAdmin.end();
      //pool.end();

      return res.json({ success: true, data: {client: client, adminUser: newAdminUser} });
    });
  } catch (error) {
    return res.json({error: error.message});
  }
};

const putClient = async (req, res) => {    
  try {
    multer({ storage }).single('image')(req, res, async(err) => {
      if (err) {
        console.log(err.message);
        return res.status(400).json({ message: "Failed image processing" });
      }

      const image = req.file ? path.basename(req.file.path) : null;

      const registerSchema = Joi.object({
        tipo_documento: Joi.number().required(),
        numero_documento: Joi.string().required(),
        nombres: Joi.string().required(),
        razon_social: Joi.string().required().allow(null,''),
        ciudad: Joi.string().required(),
        direccion: Joi.string().required(),
        telefono: Joi.string().required(),
        correo: Joi.string().email().required(),
        token_db: Joi.string().required(),
        estado: Joi.number().required(),
        tipo_unidad: Joi.number().required(),
        descripcion: Joi.string().allow(null,''),
        numero_unidades: Joi.number().required(),
        numero_documentos: Joi.number().required(),
        valor_suscripcion_mensual: Joi.number().required(),
        password: Joi.string().allow(null,''), 
        logo: Joi.string().allow(null,''), 
        tipo_logo: Joi.string().allow(null,''), 
        created_by: Joi.allow(null,''), 
        created_at: Joi.date().allow(null,''), 
        updated_at: Joi.string().allow(null,''), 
        updated_by: Joi.allow(null,''), 
        tipo_image: Joi.string().required().allow(null,''),
        id: Joi.number().required()
      });

      //VALIDATE FORMAT FIELDS
      const { error } = registerSchema.validate(req.body);
      if (error) {
        return res.status(201).json({ success: false, error: error.message });
      }

      const { tipo_documento, numero_documento, nombres, razon_social, ciudad, direccion, telefono, correo, estado, tipo_unidad, numero_unidades, numero_documentos, valor_suscripcion_mensual, descripcion, tipo_image, id } = req.body;

      let poolAdmin = poolAdm;

      const [clientExist] = await poolAdmin.query(
          "SELECT * FROM clientes WHERE numero_documento = ? AND id <> ?",
          [numero_documento, id]
      );

      try {
        const [clientNow] = await poolAdmin.query("SELECT logo FROM clientes WHERE id = ?",[id]);
        if(clientNow[0].logo){
          fs.unlinkSync(path.join(__dirname, `../../../public/uploads/companyLogo/${clientNow[0].logo}`));
        }
      } catch(error){ }

      if (clientExist.length) {
          return res.status(201).json({ success: false, error: `El cliente ${numero_documento} ya se encuentra registrado.` });
      }

      //UPDATE CLIENT
      await poolAdmin.query(`UPDATE clientes SET
          tipo_documento = ?,
          numero_documento = ?,
          nombres = UPPER(?),
          razon_social = UPPER(?),
          ciudad = ?,
          direccion = ?,
          telefono = ?,
          correo = ?,
          estado = ?,
          tipo_unidad = ?,
          numero_unidades = ?,
          numero_documentos = ?,
          descripcion = UPPER(?),
          valor_suscripcion_mensual = ?,
          logo = ?,
          tipo_logo = ?,
          updated_at = NOW(), 
          updated_by = ? 
        WHERE 
          id = ?`,
        [tipo_documento, numero_documento, nombres, razon_social, ciudad, direccion, telefono, correo, estado, tipo_unidad, numero_unidades, numero_documentos, descripcion, valor_suscripcion_mensual, image, tipo_image, req.user.id, id]
      );
      
      return res.json({success: true});
    });
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putClientLogo = async (req, res) => {    
  try {
    multer({ storage }).single('image')(req, res, async(err) => {
      if (err) {
        console.log(err.message);
        return res.status(400).json({ message: "Failed image processing" });
      }

      const image = req.file ? path.basename(req.file.path) : null;

      const registerSchema = Joi.object({
        user: Joi.allow(null,''), 
        logo: Joi.string().allow(null,''), 
        tipo_logo: Joi.string().allow(null,''),
        id: Joi.number().required()
      });

      //VALIDATE FORMAT FIELDS
      const { error } = registerSchema.validate(req.body);
      if (error) {
        return res.status(201).json({ success: false, error: error.message });
      }

      const { tipo_image, id, user } = req.body;

      let poolAdmin = poolAdm;
      
      if(!user){
        try {
          const [clientNow] = await poolAdmin.query("SELECT logo FROM clientes WHERE id = ?",[id]);
          if(clientNow[0].logo){
            fs.unlinkSync(path.join(__dirname, `../../../public/uploads/companyLogo/${clientNow[0].logo}`));
          }
        } catch(error){ }
      }else{
        try {
          const [userNow] = await poolAdmin.query("SELECT avatar FROM usuarios WHERE id = ?",[id]);
          if(userNow[0].avatar){
            fs.unlinkSync(path.join(__dirname, `../../../public/uploads/companyLogo/${userNow[0].avatar}`));
          }
        } catch(error){ }
      }
      
      if(!user){
        //UPDATE CLIENT
        await poolAdmin.query(`UPDATE clientes SET
            logo = ?,
            tipo_logo = ?,
            updated_at = NOW(), 
            updated_by = ? 
          WHERE 
            id = ?`,
          [image, tipo_image, req.user.id, id]
        );
      }else{
        //UPDATE USER
        await poolAdmin.query(`UPDATE usuarios SET
            avatar = ?,
            updated_at = NOW()
          WHERE 
            id = ?`,
          [image, id]
        );

      }
      
      return res.json({success: true, logo: image});
    });
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
    getAllClients,
    putClient,
    putClientLogo,
    createClient
};
