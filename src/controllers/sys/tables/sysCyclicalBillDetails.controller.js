import Joi  from "joi";
import { poolSys } from "../../../db.js";

const getAllCyclicalBillDetails = async (req, res) => {
  try {
    const registerSchema = Joi.object({
        id_factura_ciclica: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.params);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }
    const { id_factura_ciclica } = req.params;

    let pool = poolSys.getPool(req.user.token_db);

    const [cyclicalBillDetails] = await pool.query(`SELECT 
          t1.*,
        CONCAT(t2.id,' - ',t2.nombre) AS conceptoText
      FROM factura_ciclica_detalles t1 
        INNER JOIN conceptos_facturacion t2 ON t2.id = t1.id_concepto_factura
      WHERE t1.id_factura_ciclica = ?`,[id_factura_ciclica]);
    
    //pool.end();

    return res.json({success: true, data: cyclicalBillDetails});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const calcTotalHeadBillDetail = async (pool) => {
  await pool.query(`UPDATE 
  facturas_ciclica t1 
  SET 
    t1.valor_total = IFNULL(( SELECT 
      SUM(IFNULL(t2.total,0)) 
    FROM factura_ciclica_detalles t2 
    WHERE 
      t2.id_factura_ciclica = t1.id ),0)`)
}

const createCyclicalBillDetail = async (req, res) => {  
  try { 
    const registerSchema = Joi.object({
      id_factura_ciclica: Joi.number().required(), 
      id_concepto_factura: Joi.number().required(), 
      total: Joi.number().required(),
      descripcion: Joi.string().allow(null,'')
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { id_factura_ciclica, id_concepto_factura, total, descripcion } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    //CREATE CYCLICAL BILLING DETAIL
    const [insertedNewCyclicalBillDetail] = await pool.query(`INSERT INTO factura_ciclica_detalles 
            (id_factura_ciclica, id_concepto_factura, cantidad, valor_unitario, total, descripcion, created_by) 
                VALUES 
            (?, ?, ?, ?, ?, UPPER(?), ?)`,
      [id_factura_ciclica, id_concepto_factura, 1, total, total, descripcion, req.user.id]
    );
    
    //GET NEW CYCLICAL BILLING DETAIL
    const [rows] = await pool.query(`SELECT 
        t1.*,
      CONCAT(t2.id,' - ',t2.nombre) AS conceptoText
    FROM factura_ciclica_detalles t1 
      INNER JOIN conceptos_facturacion t2 ON t2.id = t1.id_concepto_factura
    WHERE t1.id = ?`, [ insertedNewCyclicalBillDetail.insertId ]);
    
    let newCyclicalBillDetail = rows[0];

    await calcTotalHeadBillDetail(pool);
    
    //pool.end();

    return res.json({success: true, data: {newCyclicalBillDetail}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putCyclicalBillDetail = async (req, res) => {     
  try {
    const registerSchema = Joi.object({
        id_factura_ciclica: Joi.number().required(), 
        id_concepto_factura: Joi.number().required(), 
        total: Joi.number().required(),
        valor_unitario: Joi.number().required(),
        cantidad: Joi.number().required(),
        descripcion: Joi.string().allow(null,''),
        conceptoText: Joi.string().allow(null,''),
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

    const { id_concepto_factura, total, descripcion, id } = req.body;
    
    let pool = poolSys.getPool(req.user.token_db);

    //UPDATE CYCLICAL BILL DETAIL
    await pool.query(`UPDATE factura_ciclica_detalles SET
        id_concepto_factura = ?, 
        cantidad = ?, 
        descripcion = UPPER(?),
        valor_unitario = ?,
        total = ?,
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [id_concepto_factura, 1, descripcion, total, total, req.user.id, id]
    );
    
    //GET EDITED CYCLICAL BILL DETAIL
    const [rows] = await pool.query(`SELECT 
          t1.*,
        CONCAT(t2.id,' - ',t2.nombre) AS conceptoText
      FROM factura_ciclica_detalles t1 
        INNER JOIN conceptos_facturacion t2 ON t2.id = t1.id_concepto_factura
      WHERE t1.id = ?`, [ id ]);
    
    let newCyclicalBillDetail = rows[0];
    
    await calcTotalHeadBillDetail(pool);
    
    //pool.end();

    return res.json({success: true, data: {newCyclicalBillDetail}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteCyclicalBillDetail = async (req, res) => {  
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

    //DELETE CYCLICAL BILL DETAIL
    await pool.query(`DELETE FROM factura_ciclica_detalles WHERE id = ?`,
      [id]
    );
    
    await calcTotalHeadBillDetail(pool);
    
    //pool.end();

    return res.json({success: true, data: {cyclicalBill: { id }}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
    getAllCyclicalBillDetails,
    createCyclicalBillDetail,
    deleteCyclicalBillDetail,
    putCyclicalBillDetail
};
