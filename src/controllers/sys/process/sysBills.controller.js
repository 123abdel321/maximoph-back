import Joi  from "joi";
import { poolSys } from "../../../db.js";
import { genBillPDF, genBillsPDF } from "../../../helpers/sysGenSystemPDF.js";
import { sendEmailBillPDF } from "../../../helpers/sysEmailBillPDF.js";

const getAllBills = async (req, res) => {
  try {
    let pool = poolSys.getPool(req.user.token_db);

    const [bills] = await pool.query(`SELECT 
        t1.*,
        DATE_FORMAT(t1.created_at,"%Y-%m-%d") AS fecha,
        CONCAT(t3.nombre,' - ',t2.numero_interno_unidad) AS inmuebleText,
        t3.nombre AS zonaText,
        CONCAT(t2.area) AS areaText,
        TRIM(REPLACE(REPLACE(CONCAT(
          IFNULL(t4.primer_nombre,''),' ',
          IFNULL(t4.segundo_nombre,''),' ',
          IFNULL(t4.primer_apellido,''),' ',
          IFNULL(t4.segundo_apellido,''),' '
        ),'  ',' '),'  ',' ')) AS propietarioText,
        t4.id AS propietarioId,
        t4.email AS emailPropietario
      FROM facturas t1 
      INNER JOIN inmuebles t2 ON t2.id = t1.id_inmueble
      INNER JOIN zonas t3 ON t3.id = t2.id_inmueble_zona 
      INNER JOIN personas t4 ON t4.id = t1.id_persona
      `);
    
    //pool.end();

    return res.json({success: true, data: bills});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const getBillPDF = async (req, res) => {
  try {
    const registerSchema = Joi.object({
      id: Joi.string().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.params);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }
    
    const { id } = req.params;
    
    let pool = poolSys.getPool(req.user.token_db);

    let pdfBuffer = await genBillPDF(id, pool, req);
    
    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Disposition', 'attachment; filename=cuenta-cobro.pdf');
    res.send(pdfBuffer);

  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const getBillsPDF = async (req, res) => {
  try {
    const registerSchema = Joi.object({
      id: Joi.string().required(),
      fisico: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.params);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }
    
    const { id, fisico } = req.params;
    
    let pool = poolSys.getPool(req.user.token_db);

    let pdfBuffer = await genBillsPDF(id, fisico, pool, req);
    
    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Disposition', 'attachment; filename=cuenta-cobro.pdf');
    res.send(pdfBuffer);

  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const getSendEmailBillPDF = async (req, res) => {
  try {
    const registerSchema = Joi.object({
      id: Joi.string().required()
    });
    
    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.params);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }
    
    const { id } = req.params;
    
    let pool = poolSys.getPool(req.user.token_db);

    await sendEmailBillPDF(id, pool);
    
    //pool.end();

    return res.json({success: true});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteBill = async (req, res) => {
  try {
    const registerSchema = Joi.object({
      id: Joi.string().required()
    });
    
    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.params);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }
    
    const { id } = req.params;
    
    let pool = poolSys.getPool(req.user.token_db);

    await pool.query(`UPDATE facturas SET estado = 0 WHERE id = ?`,[id]);
    
    //pool.end();

    return res.json({success: true});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteBills = async (req, res) => {
  try {
    const registerSchema = Joi.object({
      id: Joi.string().required()
    });
    
    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.params);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }
    
    const { id } = req.params;
    
    let pool = poolSys.getPool(req.user.token_db);

    await pool.query(`UPDATE factura_ciclica_historial_detalle t1 INNER JOIN facturas t2 ON t2.id = t1.id_factura SET t2.estado = 0 WHERE t1.id_factura_ciclica = ?`,[id]);
    
    await pool.query(`UPDATE factura_ciclica_historial SET estado = 0 WHERE id = ?`,[id]);
    
    //pool.end();

    return res.json({success: true});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
    getSendEmailBillPDF,
    getAllBills,
    getBillPDF,
    getBillsPDF,
    deleteBill,
    deleteBills
};
