import Joi  from "joi";
import { poolSys } from "../../../db.js";

const getAllPropertyVisitors = async (req, res) => {
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

    let [propertieVisitors] = await pool.query(
        `SELECT 
            t1.*,
            CONCAT(IFNULL(t3.primer_nombre,''),' ',IFNULL(t3.segundo_nombre,''),' ',IFNULL(t3.primer_apellido,''),' ',IFNULL(t3.segundo_apellido,'')) AS personaAutorizaText,
            IFNULL(t1.persona_visitante_avatar,'') As avatar
        FROM inmueble_personas_visitantes t1 
        INNER JOIN personas t3 ON t3.id = t1.id_persona_autoriza
        WHERE t1.id_inmueble = ? `,[id_inmueble]);
    
        let diasText = [];
        propertieVisitors.forEach((visitor)=>{
          if(visitor.fecha_autoriza){
            const fechaObjeto = new Date(visitor.fecha_autoriza);

            // Obtenemos los componentes de la fecha
            const anio = fechaObjeto.getFullYear();
            const mes = String(fechaObjeto.getMonth() + 1).padStart(2, "0"); // Se suma 1 al mes, ya que los meses en JavaScript van de 0 a 11.
            const dia = String(fechaObjeto.getDate()).padStart(2, "0");

            visitor.diasText = `${anio}-${mes}-${dia}`;
          }else{
            if(visitor.dias_autorizados&1) diasText.push("Lunes");
            if(visitor.dias_autorizados&2) diasText.push("Martes");
            if(visitor.dias_autorizados&4) diasText.push("Miércoles");
            if(visitor.dias_autorizados&8) diasText.push("Jueves");
            if(visitor.dias_autorizados&16) diasText.push("Viernes");
            if(visitor.dias_autorizados&32) diasText.push("Sábado");
            if(visitor.dias_autorizados&64) diasText.push("Domingo");
            visitor.diasText = diasText.join(", ");
          }

          diasText = [];
        });

    //pool.end();

    return res.json({success: true, data: propertieVisitors});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createPropertyVisitor = async (req, res) => {   
  try {   
    const registerSchema = Joi.object({
        id_inmueble: Joi.number().required(),
        persona_visitante: Joi.string().allow(null,''), 
        id_persona_autoriza: Joi.number().allow(null,''), 
        dias_autorizados: Joi.number().allow(null,''), 
        fecha_autoriza: Joi.date().allow(null,''), 
        observacion: Joi.string().allow(null,'')
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { id_inmueble, id_persona_autoriza, persona_visitante, dias_autorizados, fecha_autoriza, observacion } = req.body;

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

    //CREATE PROPERTY VISITOR
    const [insertedNewPropertyVisitor] = await pool.query(`INSERT INTO inmueble_personas_visitantes 
            (id_inmueble, id_persona_autoriza, persona_visitante, dias_autorizados, fecha_autoriza, observacion, created_by) 
                VALUES 
            (?, ?, ?, ?, ?, UPPER(?), ?)`,
      [id_inmueble, (id_persona_autoriza||req.user.id), persona_visitante, dias_autorizados, (fecha_autoriza||null), observacion, req.user.id]
    );
    
    //GET NEW PROPERTY VISITOR
    const [rows] = await pool.query(`SELECT 
          t1.*, 
          CONCAT(IFNULL(t3.primer_nombre,''),' ',IFNULL(t3.segundo_nombre,''),' ',IFNULL(t3.primer_nombre,''),' ',IFNULL(t3.segundo_nombre,'')) AS personaAutorizaText
      FROM inmueble_personas_visitantes t1 
      INNER JOIN personas t3 ON t3.id = t1.id_persona_autoriza
      WHERE t1.id = ?`, [ insertedNewPropertyVisitor.insertId ]);
    
    let propertyVisitor = rows[0];
    
    //pool.end();

    return res.json({success: true, data: {propertyVisitor}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putPropertyVisitor = async (req, res) => {  
  try {   
    const registerSchema = Joi.object({
        id_inmueble: Joi.number().required(),
        id_persona_autoriza: Joi.number().allow(null,''), 
        diasText: Joi.string(),
        dias_autorizados: Joi.number().allow(null,''), 
        avatar: Joi.allow(null,''),
        fecha_autoriza: Joi.date().allow(null,''), 
        observacion: Joi.string().allow(null,''),
        persona_visitante: Joi.string().allow(null,''), 
        personaAutorizaText: Joi.string().allow(null,''),
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

    const { id_inmueble, id_persona_autoriza, persona_visitante, dias_autorizados, fecha_autoriza, observacion, id } = req.body;

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

    //UPDATE PROPERTY VISITOR
    await pool.query(`UPDATE inmueble_personas_visitantes SET
        id_inmueble = ?, 
        id_persona_autoriza = ?, 
        persona_visitante = ?, 
        dias_autorizados = ?, 
        fecha_autoriza = ?, 
        observacion = UPPER(?),
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [id_inmueble, (id_persona_autoriza||req.user.id), persona_visitante, dias_autorizados, (fecha_autoriza||null), observacion, req.user.id, id]
    );
    
    //GET EDITED PROPERTY VISITOR
    const [rows] = await pool.query(`SELECT 
          t1.*, 
          CONCAT(IFNULL(t3.primer_nombre,''),' ',IFNULL(t3.segundo_nombre,''),' ',IFNULL(t3.primer_nombre,''),' ',IFNULL(t3.segundo_nombre,'')) AS personaAutorizaText
      FROM inmueble_personas_visitantes t1 
      INNER JOIN personas t3 ON t3.id = t1.id_persona_autoriza
      WHERE t1.id = ?`, [ id ]);
    
    let propertyVisitor = rows[0];
    
    //pool.end();

    return res.json({success: true, data: {propertyVisitor}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deletePropertyVisitor = async (req, res) => {  
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

    //DELETE PROPERTY VISITOR
    await pool.query(`DELETE FROM inmueble_personas_visitantes WHERE id = ?`,
      [id]
    );

    //pool.end();

    return res.json({success: true, data: {propertyVisitor: { id }}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
    getAllPropertyVisitors,
    createPropertyVisitor,
    deletePropertyVisitor,
    putPropertyVisitor
};
