import Joi  from "joi";
import { poolSys } from "../../../db.js";

import fs from "fs";
import path from "path";
import multer from "multer";
import CryptoJS from "crypto-js";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(__dirname, "../../../../public/uploads/photoPets")); // use path.join to join path components correctly
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

const getAllPropertyPets = async (req, res) => {
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
    
    let propertyPets = [];
    if(id_inmueble&&id_inmueble!=0){
      [propertyPets] = await pool.query(`SELECT *, IFNULL(avatar,'') AS avatar FROM inmueble_mascotas WHERE id_inmueble = ? `,[id_inmueble]);
    }else{
      [propertyPets] = await pool.query(`SELECT 

        t1.*, 
        IFNULL(t1.avatar,'') AS avatar,
        (CASE IFNULL(t2.tipo,0)
            WHEN 0 THEN 'INMUEBLE'
            WHEN 1 THEN 'PARQUEADERO'
            WHEN 2 THEN 'CUARTO ÚTIL'
        END) AS inmuebleTipoText,
        IFNULL(t2.numero_interno_unidad,'') AS inmuebleText

        FROM inmueble_mascotas t1
        INNER JOIN inmuebles t2 ON t2.id = t1.id_inmueble`,[id_inmueble]);
    }
    //pool.end();

    return res.json({success: true, data: propertyPets});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createPropertyPet = async (req, res) => {   
  try{
    const registerSchema = Joi.object({
        id_inmueble: Joi.number().required(), 
        tipo: Joi.number().required(), 
        nombre: Joi.string().required(),
        observacion: Joi.string().required().allow('',null)
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { id_inmueble, tipo, nombre, observacion } = req.body;

    let pool = poolSys.getPool(req.user.token_db);
    
    //VALIDATE EXIST PET
    const [existOwnerRentalPet] = await pool.query(
      "SELECT * FROM inmueble_mascotas WHERE nombre = ? AND id_inmueble = ?",
      [nombre, id_inmueble]
    );
    
    if (existOwnerRentalPet.length) {
      return res.status(201).json({ success: false, error: `La mascota el nombre ${nombre} ya se encuentra registrada para este inmueble.` });
    }

    //CREATE PROPERTY PET
    const [insertedNewPropertyPet] = await pool.query(`INSERT INTO inmueble_mascotas 
            (id_inmueble, tipo, nombre, observacion, created_by) 
                VALUES 
            (?, ?, UPPER(?), UPPER(?), ?)`,
      [id_inmueble, tipo, nombre, observacion, req.user.id]
    );
    
    //GET NEW PROPERTY PET
    const [rows] = await pool.query(`SELECT *, IFNULL(avatar,'') AS avatar FROM inmueble_mascotas WHERE id = ?`, [ insertedNewPropertyPet.insertId ]);
    
    let propertyPet = rows[0];
    
    //pool.end();

    return res.json({success: true, data: {propertyPet}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putPropertyPet = async (req, res) => {  
  try {   
    const registerSchema = Joi.object({
      id_inmueble: Joi.number().required(), 
      tipo: Joi.number().required(), 
      nombre: Joi.string().required(),
      avatar: Joi.allow(null,''),
      observacion: Joi.string().required().allow('',null),
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

    const { id_inmueble, tipo, nombre, observacion, id } = req.body;

    let pool = poolSys.getPool(req.user.token_db);
           
    //VALIDATE EXIST PET
    const [existOwnerRentalPet] = await pool.query(
      "SELECT * FROM inmueble_mascotas WHERE nombre = ? AND id_inmueble = ? AND id <> ?",
      [nombre, id_inmueble, id]
    );
    
    if (existOwnerRentalPet.length) {
      return res.status(201).json({ success: false, error: `La mascota el nombre ${nombre} ya se encuentra registrada para este inmueble.` });
    }

    //UPDATE PROPERTY PET
    await pool.query(`UPDATE inmueble_mascotas SET
        id_inmueble = ?, 
        tipo = ?, 
        nombre = UPPER(?), 
        observacion = UPPER(?),
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [id_inmueble, tipo, nombre, observacion, req.user.id, id]
    );
    
    //GET EDITED PROPERTY PET
    const [rows] = await pool.query(`SELECT *, IFNULL(avatar,'') AS avatar FROM inmueble_mascotas WHERE id = ?`, [ id ]);
    
    let propertyPet = rows[0];
    
    //pool.end();

    return res.json({success: true, data: {propertyPet}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deletePropertyPet = async (req, res) => {   
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

    //DELETE PROPERTY PET
    await pool.query(`DELETE FROM inmueble_mascotas WHERE id = ?`,
      [id]
    );
    
    //pool.end();

    return res.json({success: true, data: {propertyPet: { id }}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const uploadPhotoPet = async (req, res) => {
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
        id_pet: Joi.number().allow(null,'')
      });
  
      //VALIDATE FORMAT FIELDS
      const { error } = registerSchema.validate(req.body);
      if (error) {
        return res.status(201).json({ success: false, error: error.message });
      }  

      const { id, id_pet, peso, tipo } = req.body;
      
      if(!id&&!id_pet){
        return res.status(201).json({ success: false, error: `Debe especificar la mascota.` });
      }

      let pool = poolSys.getPool(req.user.token_db);
      
      let tipoMultimedia = 6;
      let idTable = id_pet;
      let table = 'inmueble_mascotas';
      let avatarField = 'avatar';

      let [existPet] = await pool.query(`SELECT IFNULL(${avatarField},'') AS avatar, id AS id_mascota FROM ${table} WHERE id = ? `,[idTable]);
    
      if (!existPet.length) {
        try{
          return res.status(201).json({ success: false, error: `La mascota no se encuentra registrado.` });
        } catch(error){ }
      }
  
      existPet = existPet[0];

      if(existPet.avatar.length){
        try{
          fs.unlinkSync(path.join(__dirname, `../../../../public/uploads/photoPets/${existPet.avatar}`));
        } catch(error){ }
      }
      
      await pool.query(`DELETE FROM multimedia WHERE tipo = ? AND id_registro = ?`, [tipoMultimedia, existPet.id_mascota]);
      
      await pool.query(`INSERT INTO multimedia 
      (tipo, id_registro, nombre, peso, tipo_multimedia, created_by)
        VALUES
      (?, ?, ?, ?, ?, ?)
      `, [tipoMultimedia, existPet.id_mascota, image, peso, tipo, req.user.id]);
      
      await pool.query(`UPDATE ${table} SET ${avatarField} = ?, updated_by = ? WHERE id = ?`,[image, req.user.id, idTable]);
      
      //pool.end();

      return res.json({success: true, data: {photo: image}});
    });
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
    getAllPropertyPets,
    createPropertyPet,
    deletePropertyPet,
    putPropertyPet,
    uploadPhotoPet
};
