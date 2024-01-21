import Joi  from "joi";
import { poolSys } from "../../../db.js";
import { roundValues, getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { genLog } from "../../../helpers/sysLogs.js";

const getAllBillingConcepts = async (req, res) => {
  console.log('getAllBillingConcepts');
  try {
    const registerSchema = Joi.object({
      strict: Joi.number().allow(null,'')
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { strict } = req.query;

    let pool = poolSys.getPool(req.user.token_db);

    const [listBillingConcepts] = await pool.query(`SELECT 
        t1.*, 
        t1.id AS value,
        CONCAT(t1.id,' - ',t1.nombre) AS label,
        CONCAT(t2.codigo,' - ',t2.nombre)  AS cuentaIngresoLabel,
        CONCAT(IFNULL(t3.codigo,''),' - ',IFNULL(t3.nombre,''))  AS cuentaInteresLabel,
        CONCAT(IFNULL(t4.codigo,''),' - ',IFNULL(t4.nombre,''))  AS cuentaIvaLabel,
        CONCAT(t5.codigo,' - ',t5.nombre) AS cuentaXCobrarLabel
      FROM conceptos_facturacion t1
        INNER JOIN erp_maestras t2 ON t2.id = t1.id_cuenta_ingreso_erp
        LEFT OUTER JOIN erp_maestras t3 ON t3.id = t1.id_cuenta_interes_erp
        LEFT OUTER JOIN erp_maestras t4 ON t4.id = t1.id_cuenta_iva_erp
        INNER JOIN erp_maestras t5 ON t5.id = t1.id_cuenta_por_cobrar
      WHERE 
        t1.eliminado = 0
    `);
    
    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 31, 
      pool
    });
    
    //pool.end();

    return res.json({success: true, data: listBillingConcepts, access});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createBillingConcept = async (req, res) => {   
  try {  
    const registerSchema = Joi.object({
      nombre: Joi.string().required(),
      id_cuenta_ingreso_erp: Joi.number().required(),
      id_cuenta_interes_erp: Joi.number().allow(null,''),
      id_cuenta_iva_erp: Joi.number().allow(null,''),
      id_cuenta_por_cobrar: Joi.number().required(),
      intereses: Joi.number().required(),
      valor: Joi.number().allow(null,''),
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    let { nombre, id_cuenta_ingreso_erp, id_cuenta_interes_erp, id_cuenta_iva_erp, id_cuenta_por_cobrar, intereses, valor } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    valor = await roundValues({
      val: valor,
      pool
    });

    //CREATE BILLING CONCEPT
    const [insertedNewConcept] = await pool.query(`INSERT INTO conceptos_facturacion 
      (nombre, id_cuenta_ingreso_erp, id_cuenta_interes_erp, id_cuenta_iva_erp, id_cuenta_por_cobrar, intereses, valor, created_by) 
        VALUES 
      (UPPER(?), ?, ?, ?, ?, ?, ?, ?)`,
      [nombre, id_cuenta_ingreso_erp, (id_cuenta_interes_erp ? id_cuenta_interes_erp : null), (id_cuenta_iva_erp ? id_cuenta_iva_erp : null), id_cuenta_por_cobrar, intereses, valor, req.user.id]
    );
    
    //GET NEW BILLING CONCEPT
    const [rows] = await pool.query(`SELECT 
      t1.*, 
      t1.id AS value,
      CONCAT(t1.id,' - ',t1.nombre) AS label,
      CONCAT(t2.codigo,' - ',t2.nombre)  AS cuentaIngresoLabel,
      CONCAT(IFNULL(t3.codigo,''),' - ',IFNULL(t3.nombre,''))  AS cuentaInteresLabel,
      CONCAT(IFNULL(t4.codigo,''),' - ',IFNULL(t4.nombre,''))  AS cuentaIvaLabel,
      CONCAT(t5.codigo,' - ',t5.nombre) AS cuentaXCobrarLabel
    FROM conceptos_facturacion t1
      INNER JOIN erp_maestras t2 ON t2.id = t1.id_cuenta_ingreso_erp
      LEFT OUTER JOIN erp_maestras t3 ON t3.id = t1.id_cuenta_interes_erp
      LEFT OUTER JOIN erp_maestras t4 ON t4.id = t1.id_cuenta_iva_erp
      INNER JOIN erp_maestras t5 ON t5.id = t1.id_cuenta_por_cobrar
    WHERE  
      t1.id = ?`, [ insertedNewConcept.insertId ]);
    
    let billingConcept = rows[0];
    
    await genLog({
        module: 'conceptos_facturacion', 
        idRegister: billingConcept.id, 
        recordBefore: billingConcept, 
        oper: 'CREATE', 
        detail: `CONCEPTO DE FACTURACIÓN CON NOMBRE ${billingConcept.nombre} CREADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {billingConcept}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putBillingConcept = async (req, res) => {  
  try {   
    const registerSchema = Joi.object({
      nombre: Joi.string().required(),
      id_cuenta_ingreso_erp: Joi.number().required(),
      id_cuenta_interes_erp: Joi.number().allow(null,''),
      id_cuenta_iva_erp: Joi.number().allow(null,''),
      id_cuenta_por_cobrar: Joi.number().required(),
      intereses: Joi.number().required(),
      valor: Joi.number().allow(null,''),
      cuentaIngresoLabel: Joi.required(),
      cuentaInteresLabel: Joi.allow(null,''),
      value: Joi.allow(null,''),
      label: Joi.allow(null,''),
      cuentaIvaLabel: Joi.allow(null,''),
      cuentaXCobrarLabel: Joi.required(),
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

    let { nombre, id_cuenta_ingreso_erp, id_cuenta_interes_erp, id_cuenta_iva_erp, id_cuenta_por_cobrar, intereses, valor, id } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    valor = await roundValues({
      val: valor,
      pool
    });

    //GET BEFORE EDITED BILLING CONCEPT
    const [rowsBefore] = await pool.query(`SELECT * FROM conceptos_facturacion WHERE id = ?`, [ id ]);

    let conceptoFacturacionBefore = rowsBefore[0];

    //UPDATE BILLING CONCEPT
    await pool.query(`UPDATE conceptos_facturacion SET
        nombre = UPPER(?), 
        id_cuenta_ingreso_erp = ?, 
        id_cuenta_interes_erp = ?, 
        id_cuenta_iva_erp = ?, 
        id_cuenta_por_cobrar = ?, 
        intereses = ?, 
        valor = ?,
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [nombre, id_cuenta_ingreso_erp, (id_cuenta_interes_erp ? id_cuenta_interes_erp : null), (id_cuenta_iva_erp ? id_cuenta_iva_erp : null), id_cuenta_por_cobrar, intereses, valor, req.user.id, id]
    );
    
    //GET EDITED BILLING CONCEPT
    const [rows] = await pool.query(`SELECT 
        t1.*, 
        t1.id AS value,
        CONCAT(t1.id,' - ',t1.nombre) AS label,
        CONCAT(t2.codigo,' - ',t2.nombre)  AS cuentaIngresoLabel,
        CONCAT(IFNULL(t3.codigo,''),' - ',IFNULL(t3.nombre,''))  AS cuentaInteresLabel,
        CONCAT(IFNULL(t4.codigo,''),' - ',IFNULL(t4.nombre,''))  AS cuentaIvaLabel,
        CONCAT(t5.codigo,' - ',t5.nombre) AS cuentaXCobrarLabel
      FROM conceptos_facturacion t1
        INNER JOIN erp_maestras t2 ON t2.id = t1.id_cuenta_ingreso_erp
        LEFT OUTER JOIN erp_maestras t3 ON t3.id = t1.id_cuenta_interes_erp
        LEFT OUTER JOIN erp_maestras t4 ON t4.id = t1.id_cuenta_iva_erp
        INNER JOIN erp_maestras t5 ON t5.id = t1.id_cuenta_por_cobrar
      WHERE  
        t1.id = ?`, [id ]);
    
    let billingConcept = rows[0];
    
    await genLog({
        module: 'conceptos_facturacion', 
        idRegister: id, 
        recordBefore: conceptoFacturacionBefore, 
        oper: 'UPDATE', 
        detail: `CONCEPTO DE FACTURACIÓN CON NOMBRE ${conceptoFacturacionBefore.nombre} ACTUALIZADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {billingConcept}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteBillingConcept = async (req, res) => { 
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

    //GET BILLING CONCEPT
    let [billingConcept] = await pool.query(`SELECT * FROM conceptos_facturacion WHERE id = ?`,[id]);
    billingConcept = billingConcept[0];
    
    await genLog({
        module: 'conceptos_facturacion', 
        idRegister: id, 
        recordBefore: {}, 
        oper: 'DELETE', 
        detail: `CONCEPTO DE FACTURACIÓN CON NOMBRE ${billingConcept.nombre} ELIMINADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //DELETE BILLING CONCEPT
    await pool.query(`UPDATE conceptos_facturacion SET eliminado = 1 WHERE id = ?`,
      [id]
    );
    
    //pool.end();

    return res.json({success: true, data: {billingConcept: { id }}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  getAllBillingConcepts,
  createBillingConcept,
  deleteBillingConcept,
  putBillingConcept
};
