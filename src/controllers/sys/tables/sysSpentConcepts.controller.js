import Joi  from "joi";
import { poolSys } from "../../../db.js";
import { getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { genLog } from "../../../helpers/sysLogs.js";

const getAllSpentConcepts = async (req, res) => {
  try {
    let pool = poolSys.getPool(req.user.token_db);

    const [listSpentConcepts] = await pool.query(`SELECT 
      t1.*,
      t1.id AS value,
      t1.porcentaje_iva AS iva,
      CONCAT(t1.id,' - ',t1.nombre,' - ',t1.porcentaje_iva,' %') AS label,
      CONCAT(t2.codigo,' - ',t2.nombre)  AS cuentaGastoLabel,
      CONCAT(IFNULL(t3.codigo,''),' - ',IFNULL(t3.nombre,'')) AS cuentaIvaLabel,
      CONCAT(IFNULL(t4.codigo,''),' - ',IFNULL(t4.nombre,''))  AS cuentaRetencionLabel,
      CONCAT(IFNULL(t5.codigo,''),' - ',IFNULL(t5.nombre,'')) AS cuentaXPagarLabel
    FROM conceptos_gastos  t1
      INNER JOIN erp_maestras t2 ON t2.id = t1.id_cuenta_gasto_erp
      LEFT OUTER JOIN erp_maestras t3 ON t3.id = t1.id_cuenta_iva_erp
      LEFT OUTER JOIN erp_maestras t4 ON t4.id = t1.id_cuenta_rete_fuente_erp
      LEFT OUTER JOIN erp_maestras t5 ON t5.id = t1.id_cuenta_por_pagar_erp
    WHERE t1.eliminado = 0`);

    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 32, 
      pool
    });

    //pool.end();

    return res.json({success: true, data: listSpentConcepts, access});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createSpentConcept = async (req, res) => {    
  try { 
    const registerSchema = Joi.object({
      nombre: Joi.string().required(),
      id_cuenta_gasto_erp: Joi.number().required(),
      id_cuenta_iva_erp: Joi.number().allow(null,''),
      porcentaje_iva: Joi.number().allow(null,''),
      id_cuenta_rete_fuente_erp: Joi.number().allow(null,''),
      base_rete_fuente: Joi.number().allow(null,''),
      porcentaje_rete_fuente: Joi.number().allow(null,''),
      id_cuenta_por_pagar_erp: Joi.number().required().allow(null,''),
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { nombre, id_cuenta_gasto_erp, id_cuenta_iva_erp, porcentaje_iva, id_cuenta_rete_fuente_erp, base_rete_fuente, porcentaje_rete_fuente, id_cuenta_por_pagar_erp } = req.body;

    let pool = poolSys.getPool(req.user.token_db);
    //CREATE BILLING CONCEPT
    const [insertedNewConcept] = await pool.query(`INSERT INTO conceptos_gastos 
      (nombre, id_cuenta_gasto_erp, id_cuenta_iva_erp, porcentaje_iva, id_cuenta_rete_fuente_erp, base_rete_fuente, porcentaje_rete_fuente, id_cuenta_por_pagar_erp, created_by) 
        VALUES 
      (UPPER(?), ?, ?, ?, ?, ?, ?, ?, ?)`,
      [nombre, id_cuenta_gasto_erp, (id_cuenta_iva_erp ? id_cuenta_iva_erp : null), porcentaje_iva, (id_cuenta_rete_fuente_erp ? id_cuenta_rete_fuente_erp : null), (base_rete_fuente ? base_rete_fuente : null), (porcentaje_rete_fuente ? porcentaje_rete_fuente : null), (id_cuenta_por_pagar_erp||null), req.user.id]
    );

    
    //GET NEW BILLING CONCEPT
    const [rows] = await pool.query(`SELECT 
      t1.*,
      t1.id AS value,
      t1.porcentaje_iva AS iva,
      CONCAT(t1.id,' - ',t1.nombre,' - ',t1.porcentaje_iva,' %') AS label,
      CONCAT(t2.codigo,' - ',t2.nombre)  AS cuentaGastoLabel,
      CONCAT(IFNULL(t3.codigo,''),' - ',IFNULL(t3.nombre,'')) AS cuentaIvaLabel,
      CONCAT(IFNULL(t4.codigo,''),' - ',IFNULL(t4.nombre,''))  AS cuentaRetencionLabel,
      CONCAT(IFNULL(t5.codigo,''),' - ',IFNULL(t5.nombre,'')) AS cuentaXPagarLabel
    FROM conceptos_gastos t1
      INNER JOIN erp_maestras t2 ON t2.id = t1.id_cuenta_gasto_erp
      LEFT OUTER JOIN erp_maestras t3 ON t3.id = t1.id_cuenta_iva_erp
      LEFT OUTER JOIN erp_maestras t4 ON t4.id = t1.id_cuenta_rete_fuente_erp
      LEFT OUTER JOIN erp_maestras t5 ON t5.id = t1.id_cuenta_por_pagar_erp
    WHERE 
      t1.id = ?`, [ insertedNewConcept.insertId ]);
    
    let spentConcept = rows[0];
    
    await genLog({
        module: 'conceptos_gastos', 
        idRegister: spentConcept.id, 
        recordBefore: spentConcept, 
        oper: 'CREATE', 
        detail: `CONCEPTO DE GASTO CON NOMBRE ${spentConcept.nombre} CREADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {spentConcept}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putSpentConcept = async (req, res) => {  
  try { 
    const registerSchema = Joi.object({
      nombre: Joi.string().required(),
      id_cuenta_gasto_erp: Joi.number().required(),
      id_cuenta_iva_erp: Joi.number().allow(null,''),
      porcentaje_iva: Joi.number().allow(null,''),
      id_cuenta_rete_fuente_erp: Joi.number().allow(null,''),
      base_rete_fuente: Joi.number().allow(null,''),
      porcentaje_rete_fuente: Joi.number().allow(null,''),
      id_cuenta_por_pagar_erp: Joi.number().required().allow(null,''),
      cuentaGastoLabel: Joi.required(),
      cuentaRetencionLabel: Joi.allow(null,''),
      cuentaIvaLabel: Joi.allow(null,''),
      cuentaXPagarLabel: Joi.required(),
      value: Joi.allow(null,''),
      label: Joi.allow(null,''),
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

    const { nombre, id_cuenta_gasto_erp, id_cuenta_iva_erp, porcentaje_iva, id_cuenta_rete_fuente_erp, base_rete_fuente, porcentaje_rete_fuente, id_cuenta_por_pagar_erp, id } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    //GET BEFORE EDITED SPENT CONCEPT
    const [rowsBefore] = await pool.query(`SELECT * FROM conceptos_gastos WHERE id = ?`, [ id ]);

    let conceptSpentBefore = rowsBefore[0];

    //UPDATE BILLING CONCEPT
    await pool.query(`UPDATE conceptos_gastos SET
        nombre = UPPER(?), 
        id_cuenta_gasto_erp = ?, 
        id_cuenta_iva_erp = ?, 
        porcentaje_iva = ?, 
        id_cuenta_rete_fuente_erp = ?, 
        base_rete_fuente = ?, 
        porcentaje_rete_fuente = ?, 
        id_cuenta_por_pagar_erp = ?, 
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [nombre, id_cuenta_gasto_erp, (id_cuenta_iva_erp ? id_cuenta_iva_erp : null), porcentaje_iva, (id_cuenta_rete_fuente_erp ? id_cuenta_rete_fuente_erp : null), (base_rete_fuente ? base_rete_fuente : null), (porcentaje_rete_fuente ? porcentaje_rete_fuente : null), (id_cuenta_por_pagar_erp||null), req.user.id, id]
    );
    
    //GET EDITED BILLING CONCEPT
    const [rows] = await pool.query(`SELECT 
      t1.*,
      t1.id AS value,
      t1.porcentaje_iva AS iva,
      CONCAT(t1.id,' - ',t1.nombre,' - ',t1.porcentaje_iva,' %') AS label,
      CONCAT(t2.codigo,' - ',t2.nombre)  AS cuentaGastoLabel,
      CONCAT(IFNULL(t3.codigo,''),' - ',IFNULL(t3.nombre,'')) AS cuentaIvaLabel,
      CONCAT(IFNULL(t4.codigo,''),' - ',IFNULL(t4.nombre,''))  AS cuentaRetencionLabel,
      CONCAT(IFNULL(t5.codigo,''),' - ',IFNULL(t5.nombre,'')) AS cuentaXPagarLabel
    FROM conceptos_gastos  t1
      INNER JOIN erp_maestras t2 ON t2.id = t1.id_cuenta_gasto_erp
      LEFT OUTER JOIN erp_maestras t3 ON t3.id = t1.id_cuenta_iva_erp
      LEFT OUTER JOIN erp_maestras t4 ON t4.id = t1.id_cuenta_rete_fuente_erp
      LEFT OUTER JOIN erp_maestras t5 ON t5.id = t1.id_cuenta_por_pagar_erp
    WHERE
      t1.id = ?`, [ id ]);
    
    let spentConcept = rows[0];
    
    await genLog({
        module: 'conceptos_gastos', 
        idRegister: id, 
        recordBefore: conceptSpentBefore, 
        oper: 'UPDATE', 
        detail: `CONCEPTO DE GASTO CON NOMBRE ${conceptSpentBefore.nombre} EDITADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {spentConcept}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteSpentConcept = async (req, res) => {     
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
    
    //GET SPENT CONCEPT
    let [spentConcept] = await pool.query(`SELECT * FROM conceptos_gastos WHERE id = ?`,[id]);
    spentConcept = spentConcept[0];

    await genLog({
        module: 'conceptos_gastos', 
        idRegister: id, 
        recordBefore: {}, 
        oper: 'DELETE', 
        detail: `CONCEPTO DE GASTO CON NOMBRE ${spentConcept.nombre} ELIMINADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });

    //DELETE BILLING CONCEPT
    await pool.query(`UPDATE conceptos_gastos SET eliminado = 1 WHERE id = ?`,
      [id]
    );
    
    //pool.end();

    return res.json({success: true, data: {spentConcept: { id }}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  getAllSpentConcepts,
  createSpentConcept,
  deleteSpentConcept,
  putSpentConcept
};
