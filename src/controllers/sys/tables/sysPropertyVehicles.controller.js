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
    cb(null, path.join(__dirname, "../../../../public/uploads/photoVehicles")); // use path.join to join path components correctly
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

const getAllPropertyVehicles = async (req, res) => {
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

    let [propertyVehicles] = await pool.query(
        `SELECT 
            t1.*, 
            CONCAT(IFNULL(t2.primer_nombre,''),' ',IFNULL(t2.segundo_nombre,''),' ',IFNULL(t2.primer_apellido,''),' ',IFNULL(t2.segundo_apellido,'')) AS personaAutorizaText,
            t3.nombre AS tipoText,
            IFNULL(t1.avatar,'') As avatar
        FROM inmueble_vehiculos t1 
        INNER JOIN personas t2 ON t2.id = t1.id_persona_autoriza
        INNER JOIN maestras_base t3 ON t3.id = t1.id_tipo_vehiculo
        WHERE t1.id_inmueble = ? `,[id_inmueble]);
    
    let diasText = [];
    propertyVehicles.forEach((vehicle)=>{
      if(vehicle.fecha_autoriza){
        const fechaObjeto = new Date(vehicle.fecha_autoriza);

        // Obtenemos los componentes de la fecha
        const anio = fechaObjeto.getFullYear();
        const mes = String(fechaObjeto.getMonth() + 1).padStart(2, "0"); // Se suma 1 al mes, ya que los meses en JavaScript van de 0 a 11.
        const dia = String(fechaObjeto.getDate()).padStart(2, "0");

        vehicle.diasText = `${anio}-${mes}-${dia}`;
      }else{
        if(vehicle.dias_autorizados&1) diasText.push("Lunes");
        if(vehicle.dias_autorizados&2) diasText.push("Martes");
        if(vehicle.dias_autorizados&4) diasText.push("Miércoles");
        if(vehicle.dias_autorizados&8) diasText.push("Jueves");
        if(vehicle.dias_autorizados&16) diasText.push("Viernes");
        if(vehicle.dias_autorizados&32) diasText.push("Sábado");
        if(vehicle.dias_autorizados&64) diasText.push("Domingo");

        vehicle.diasText = diasText.join(", ");
      }
      
      diasText = [];
    });
    
    //pool.end();

    return res.json({success: true, data: propertyVehicles});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createPropertyVehicle = async (req, res) => {   
  try{
    const registerSchema = Joi.object({
        id_inmueble: Joi.number().required(), 
        id_tipo_vehiculo: Joi.number().required(), 
        id_persona_autoriza: Joi.number().allow(null,''), 
        placa: Joi.string().required(),
        dias_autorizados: Joi.number().allow(null,''), 
        fecha_autoriza: Joi.date().allow(null,''), 
        observacion: Joi.string().allow(null,'')
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { id_inmueble, id_tipo_vehiculo, id_persona_autoriza, placa, dias_autorizados, fecha_autoriza, observacion } = req.body;

    let pool = poolSys.getPool(req.user.token_db);
    
    //VALIDATE OWN OR RENTAL
    const [existOwnerRental] = await pool.query(
      "SELECT * FROM inmueble_personas_admon WHERE id_persona = ? AND id_inmueble = ?",
      [id_persona_autoriza, id_inmueble]
    );
    
    if (!existOwnerRental.length) {
      return res.status(201).json({ success: false, error: `Pueden autorizar ingresos propietarios o inquilinos, no externos.` });
    }

    //VALIDATE PLACA
    const [existPlaca] = await pool.query(
      "SELECT * FROM inmueble_vehiculos WHERE id_inmueble = ? AND placa = ?",
      [id_inmueble, placa]
    );
    
    if (existPlaca.length) {
      return res.status(201).json({ success: false, error: `La placa ${placa} ya se encuentra autorizada.` });
    }

    if (!dias_autorizados&&!fecha_autoriza) {
      return res.status(201).json({ success: false, error: `Debes especficicar una fecha o días de ingreso.` });
    }

    //CREATE PROPERTY VEHICLE
    const [insertedNewPropertyVehicle] = await pool.query(`INSERT INTO inmueble_vehiculos 
            (id_inmueble, id_tipo_vehiculo, id_persona_autoriza, placa, dias_autorizados, fecha_autoriza, observacion, created_by) 
                VALUES 
            (?, ?, ?, ?, ?, ?, UPPER(?), ?)`,
      [id_inmueble, id_tipo_vehiculo, (id_persona_autoriza||req.user.id), placa, dias_autorizados, (fecha_autoriza||null), observacion, req.user.id]
    );
    
    //GET NEW PROPERTY VEHICLE
    const [rows] = await pool.query(`SELECT 
              t1.*, 
              CONCAT(IFNULL(t2.primer_nombre,''),' ',IFNULL(t2.segundo_nombre,''),' ',IFNULL(t2.primer_apellido,''),' ',IFNULL(t2.segundo_apellido,'')) AS personaAutorizaText,
              t3.nombre AS tipoText
          FROM inmueble_vehiculos t1 
          INNER JOIN personas t2 ON t2.id = t1.id_persona_autoriza
          INNER JOIN maestras_base t3 ON t3.id = t1.id_tipo_vehiculo
          WHERE t1.id = ?`, [ insertedNewPropertyVehicle.insertId ]);
    
    let propertyVehicle = rows[0];
    
    //pool.end();

    return res.json({success: true, data: {propertyVehicle}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putPropertyVehicle = async (req, res) => {  
  try {   
    const registerSchema = Joi.object({
        id_inmueble: Joi.number().required(), 
        id_tipo_vehiculo: Joi.number().required(), 
        id_persona_autoriza: Joi.number().allow(null,''), 
        placa: Joi.string().required(),
        dias_autorizados: Joi.number().allow(null,''), 
        fecha_autoriza: Joi.date().allow(null,''), 
        observacion: Joi.string().allow(null,''),
        tipoText: Joi.string().allow(null,''),
        diasText: Joi.string().allow(null,''),
        avatar: Joi.allow(null,''),
        personaAutorizaText: Joi.string(),
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

    const { id_inmueble, id_tipo_vehiculo, id_persona_autoriza, placa, dias_autorizados, fecha_autoriza, observacion, id } = req.body;

    let pool = poolSys.getPool(req.user.token_db);
    
    //VALIDATE OWN OR RENTAL
    const [existOwnerRental] = await pool.query(
      "SELECT * FROM inmueble_personas_admon WHERE id_persona = ? AND id_inmueble = ?",
      [id_persona_autoriza, id_inmueble]
    );
    
    if (!existOwnerRental.length) {
      return res.status(201).json({ success: false, error: `Pueden autorizar ingresos propietarios o inquilinos, no externos.` });
    }

    if (!dias_autorizados&&!fecha_autoriza) {
      return res.status(201).json({ success: false, error: `Debes especficicar una fecha o días de ingreso.` });
    }

    //VALIDATE PLACA
    const [existPlaca] = await pool.query(
      "SELECT * FROM inmueble_vehiculos WHERE id_inmueble = ? AND placa = ? AND id <> ?",
      [id_inmueble, placa, id]
    );
    
    if (existPlaca.length) {
      return res.status(201).json({ success: false, error: `La placa ${placa} ya se encuentra autorizada.` });
    }

    //UPDATE PROPERTY VEHICLE
    await pool.query(`UPDATE inmueble_vehiculos SET
        id_inmueble = ?, 
        id_tipo_vehiculo = ?, 
        id_persona_autoriza = ?, 
        placa = ?,
        dias_autorizados = ?, 
        fecha_autoriza = ?, 
        observacion = UPPER(?),
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [id_inmueble, id_tipo_vehiculo, (id_persona_autoriza||req.user.id), placa, dias_autorizados, (fecha_autoriza||null), observacion, req.user.id, id]
    );
    
    //GET EDITED PROPERTY VEHICLE
    const [rows] = await pool.query(`SELECT 
        t1.*, 
        CONCAT(IFNULL(t2.primer_nombre,''),' ',IFNULL(t2.segundo_nombre,''),' ',IFNULL(t2.primer_apellido,''),' ',IFNULL(t2.segundo_apellido,'')) AS personaAutorizaText,
        t3.nombre AS tipoText
    FROM inmueble_vehiculos t1 
    INNER JOIN personas t2 ON t2.id = t1.id_persona_autoriza
    INNER JOIN maestras_base t3 ON t3.id = t1.id_tipo_vehiculo
    WHERE t1.id = ?`, [ id ]);
    
    let propertyVehicle = rows[0];
    
    //pool.end();

    return res.json({success: true, data: {propertyVehicle}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deletePropertyVehicle = async (req, res) => {   
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

    //DELETE PROPERTY VEHICLE
    await pool.query(`DELETE FROM inmueble_vehiculos WHERE id = ?`,
      [id]
    );
    
    //pool.end();

    return res.json({success: true, data: {propertyVehicle: { id }}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const uploadPhotoVehicle = async (req, res) => {
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
        id_vehicle: Joi.number().allow(null,'')
      });
  
      //VALIDATE FORMAT FIELDS
      const { error } = registerSchema.validate(req.body);
      if (error) {
        return res.status(201).json({ success: false, error: error.message });
      }  

      const { id, id_vehicle, peso, tipo } = req.body;
      
      if(!id&&!id_vehicle){
        return res.status(201).json({ success: false, error: `Debe especificar el vehiculo.` });
      }

      let pool = poolSys.getPool(req.user.token_db);
      
      let tipoMultimedia = 2;
      let idTable = id_vehicle;
      let table = 'inmueble_vehiculos';
      let avatarField = 'avatar';

      let [existVehicle] = await pool.query(`SELECT IFNULL(${avatarField},'') AS avatar, id AS id_vehiculo FROM ${table} WHERE id = ? `,[idTable]);
    
      if (!existVehicle.length) {
        try{
          return res.status(201).json({ success: false, error: `El vehiculo no se encuentra registrado.` });
        } catch(error){ }
      }
  
      existVehicle = existVehicle[0];

      if(existVehicle.avatar.length){
        try{
          fs.unlinkSync(path.join(__dirname, `../../../../public/uploads/photoVehicles/${existVehicle.avatar}`));
        } catch(error){ }
      }
      
      await pool.query(`DELETE FROM multimedia WHERE tipo = ? AND id_registro = ?`, [tipoMultimedia, existVehicle.id_vehiculo]);
      
      await pool.query(`INSERT INTO multimedia 
      (tipo, id_registro, nombre, peso, tipo_multimedia, created_by)
        VALUES
      (?, ?, ?, ?, ?, ?)
      `, [tipoMultimedia, existVehicle.id_vehiculo, image, peso, tipo, req.user.id]);
      
      await pool.query(`UPDATE ${table} SET ${avatarField} = ?, updated_by = ? WHERE id = ?`,[image, req.user.id, idTable]);
      
      //pool.end();

      return res.json({success: true, data: {photo: image}});
    });
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
    getAllPropertyVehicles,
    createPropertyVehicle,
    deletePropertyVehicle,
    putPropertyVehicle,
    uploadPhotoVehicle
};
