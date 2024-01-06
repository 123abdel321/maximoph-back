import Joi  from "joi";
import axios from "axios";
import { poolSys } from "../../../db.js";
import { genExtractProvaiderNit } from "../../../helpers/sysExtractNit.js";
import { getSysEnv, updateSysEnv, genRandomToken, padLeft, getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { genLog } from "../../../helpers/sysLogs.js";

import { genPaymentPDF } from "../../../helpers/sysGenSystemPDF.js";

const getAllAcumulate = async (req, res) => {
  try {
    let pool = poolSys.getPool(req.user.token_db);

    const [billCashReceipts] = await pool.query(`SELECT 

        t5.id,
        t5.consecutivo,
        DATE_FORMAT(t5.fecha_recibo,'%Y-%m-%d') AS fecha,
        FORMAT(t4.numero_documento,0) AS personaDocumento,
        TRIM(REPLACE(REPLACE(CONCAT(
          IFNULL(t4.primer_nombre,''),' ',
          IFNULL(t4.segundo_nombre,''),' ',
          IFNULL(t4.primer_apellido,''),' ',
          IFNULL(t4.segundo_apellido,''),' '
        ),'  ',' '),'  ',' ')) AS personaText,
        t4.id AS id_persona,
        IF(t5.estado=0,'ANULADO','REGISTRADO') AS estadoText,
        FORMAT(t5.valor_recibo,0) AS valor,
        IFNULL(t5.observacion,'') AS observacion,
        'RECIBO DE CAJA' AS tipo

      FROM factura_recibos_caja t5
        LEFT OUTER JOIN personas t4 ON t4.id = t5.id_persona
    `);

    let [spents] = await pool.query(`SELECT 

      t1.id,
      t1.consecutivo,
      DATE_FORMAT(t1.fecha_documento,"%Y-%m-%d") AS fecha,
      FORMAT(t2.numero_documento,0) AS personaDocumento,
      TRIM(REPLACE(REPLACE(CONCAT(
        IFNULL(t2.primer_nombre,''),' ',
        IFNULL(t2.segundo_nombre,''),' ',
        IFNULL(t2.primer_apellido,''),' ',
        IFNULL(t2.segundo_apellido,''),' '
      ),'  ',' '),'  ',' ')) AS personaText,
      t2.id AS id_persona,
      IF(t1.anulado=1,'ANULADO','REGISTRADO') AS estadoText,
      t1.valor_total AS valor,
      IFNULL(t1.observacion,'') AS observacion,
      'GASTO' AS tipo

    FROM gastos t1

    INNER JOIN personas t2 ON t2.id = t1.id_persona_proveedor
    `);

    const [spentPayments] = await pool.query(`SELECT 

        t5.id,
        t5.consecutivo,
        DATE_FORMAT(t5.fecha_pago,'%Y-%m-%d') AS fecha,
        FORMAT(t4.numero_documento,0) AS personaDocumento,
        TRIM(REPLACE(REPLACE(CONCAT(
          IFNULL(t4.primer_nombre,''),' ',
          IFNULL(t4.segundo_nombre,''),' ',
          IFNULL(t4.primer_apellido,''),' ',
          IFNULL(t4.segundo_apellido,''),' '
        ),'  ',' '),'  ',' ')) AS personaText,
        t4.id AS id_persona,
        IF(t5.estado=0,'ANULADO','REGISTRADO') AS estadoText,
        FORMAT(t5.valor_pago,0) AS valor,
        IFNULL(t5.observacion,'') AS observacion,
        'PAGO' AS tipo
        
      FROM gasto_pagos t5
        LEFT OUTER JOIN personas t4 ON t4.id = t5.id_persona
    `);
        
    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 10, 
      pool
    });
    
    //pool.end();
    
    return res.json({success: true, data: [...billCashReceipts, ...spents, ...spentPayments], access });
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const getAllPayments = async (req, res) => {
  try {
    let pool = poolSys.getPool(req.user.token_db);

    const [spentPayments] = await pool.query(`SELECT 
        t5.id,
        t5.consecutivo,
        DATE_FORMAT(t5.fecha_pago,'%Y-%m-%d') AS fecha_pago,
        FORMAT(t4.numero_documento,0) AS personaDocumento,
        TRIM(REPLACE(REPLACE(CONCAT(
          IFNULL(t4.primer_nombre,''),' ',
          IFNULL(t4.segundo_nombre,''),' ',
          IFNULL(t4.primer_apellido,''),' ',
          IFNULL(t4.segundo_apellido,''),' '
        ),'  ',' '),'  ',' ')) AS personaText,
        t4.id AS personaId,
        t5.estado,
        IF(t5.estado=0,'ANULADO','REGISTRADO') AS estadoText,
        FORMAT(t5.valor_pago,0) AS valor_pago,
        IFNULL(t5.observacion,'') AS observacion
      FROM gasto_pagos t5
        LEFT OUTER JOIN personas t4 ON t4.id = t5.id_persona
    `);
    

    let paymentsNextNumber = await getSysEnv({name: "consecutivo_pagos", pool});
    
    let controlFechaDigitacion = await getSysEnv({name: "control_fecha_digitacion", pool});
    
    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 10, 
      pool
    });
    
    //pool.end();
    
    return res.json({success: true, data: spentPayments, paymentsNextNumber, controlFechaDigitacion, access });
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const getCurrentDateTime = ()=>{
  try {
    const now = new Date();
    const year = now.getFullYear();
    const month = String(now.getMonth() + 1).padStart(2, '0');
    const day = String(now.getDate()).padStart(2, '0');
    const hours = String(now.getHours()).padStart(2, '0');
    const minutes = String(now.getMinutes()).padStart(2, '0');
    const seconds = String(now.getSeconds()).padStart(2, '0');

    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
  } catch (error) {
    console.log("error getCurrentDateTime");
    console.log(error.message);
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createPayment = async (req, res) => {   
  console.log('createPayment');
  try {  
    const registerSchema = Joi.object({
        id_persona: Joi.number().required(),
        id_tercero_erp: Joi.number().required(),
        fecha_pago: Joi.date().required(), 
        valor_pago: Joi.number().allow(null,''),
        observacion: Joi.string().allow(null,''),
        id_cuenta_egreso_recibos_caja_erp: Joi.number().allow(null,'')
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    let { id_persona, id_tercero_erp, fecha_pago, valor_pago, observacion, id_cuenta_egreso_recibos_caja_erp } = req.body;

    let getExtractNitERP = [];

    let pool = poolSys.getPool(req.user.token_db);
    
    let apiKeyERP = await getSysEnv({
      name: 'api_key_erp',
      pool: pool
    });

    const instance = axios.create({
      baseURL: `${process.env.URL_API_ERP}`,
      headers: {
        'Authorization': apiKeyERP,
        'Content-Type': 'application/json'
      }
    });
    
    let tokenErp = await genRandomToken();

    let responseExtract = await genExtractProvaiderNit(id_tercero_erp, pool);

    if(Number(valor_pago)>Number(responseExtract.totalPendiente)){
      return res.status(201).json({ success: false, error: 'El valor del abono es superior al saldo pendiente.' });
    }

    fecha_pago = fecha_pago.split("T")[0];
    
    let actualConsecutive = await getSysEnv({
      name: 'consecutivo_pagos',
      pool: pool
    });
    actualConsecutive = Number(actualConsecutive);

    let newConsecutive = actualConsecutive+1;
      
    await updateSysEnv({
        name: 'consecutivo_pagos',
        val: newConsecutive,
        pool: pool
    });
    
    let bulkDocumentsToErp = [];
    
    let valorPagoMap = 0;
    let valorPagoDisponible = Number(valor_pago);
    
    let descriptionAbono = [];

    let [pagoComprobanteErp] = await pool.query(`SELECT t2.id_erp FROM entorno t1 INNER JOIN erp_maestras t2 ON t2.id = t1.valor WHERE t1.campo='id_comprobante_pagos_erp'`);
    pagoComprobanteErp = pagoComprobanteErp[0].id_erp;
    
    let pagoCuentaEgresoErp = false;

    if(id_cuenta_egreso_recibos_caja_erp){
      [pagoCuentaEgresoErp] = await pool.query(`SELECT t2.id_erp FROM erp_maestras t2 WHERE t2.id = ${id_cuenta_egreso_recibos_caja_erp}`);
      pagoCuentaEgresoErp = pagoCuentaEgresoErp[0].id_erp;
    }else{
      [pagoCuentaEgresoErp] = await pool.query(`SELECT t2.id_erp FROM entorno t1 INNER JOIN erp_maestras t2 ON t2.id = t1.valor WHERE t1.campo='id_cuenta_egreso_recibos_caja_erp'`);
      pagoCuentaEgresoErp = pagoCuentaEgresoErp[0].id_erp;
    }

    responseExtract.data.map(bill=>{
      if(valorPagoDisponible>0){
        if(Number(bill.totalPendiente.replaceAll(".","").replaceAll(",",""))>=valorPagoDisponible){
          valorPagoMap = valorPagoDisponible;
          valorPagoDisponible = 0;
        }else{
          valorPagoMap = Number(bill.totalPendiente.replaceAll(".","").replaceAll(",",""));
          valorPagoDisponible = valorPagoDisponible-Number(bill.totalPendiente.replaceAll(".","").replaceAll(",",""));
        }

        descriptionAbono.push(`DOC. REF: ${padLeft(bill.docRef, 8)} ABONO: ${Number(valorPagoMap).toLocaleString('es-ES')}`)

        //CXP
        bulkDocumentsToErp.push({
          id_nit: id_tercero_erp,
          id_centro_costo: null,
          id_cuenta: bill.cuenta_id,
          debito: valorPagoMap,
          credito: 0,
          concepto: `PAGO MAXIMO PH - ${observacion}`,
          documento_referencia: bill.docRef
        });
      }
    });
    
    //EGRESO
    bulkDocumentsToErp.push({
      id_nit: id_tercero_erp,
      id_centro_costo: null,
      id_cuenta: pagoCuentaEgresoErp,
      debito: 0,
      credito: valor_pago,
      concepto: `PAGO MAXIMO MAXIMO PH - ${observacion}`,
      documento_referencia: ''
    });

    let response = await instance.post(`${process.env.URL_API_ERP}documentos`, JSON.stringify({
      documento: bulkDocumentsToErp,
      id_comprobante: pagoComprobanteErp,
      consecutivo: actualConsecutive,
      fecha_manual: fecha_pago,
    }));

    // let response = await axios.post(`${process.env.URL_API_ERP}bulk-document?key=${apiKeyERP}`,
    // {
    //   items: JSON.stringify(bulkDocumentsToErp)
    // });

    descriptionAbono = descriptionAbono.join(" | ");

    //CREATE PAYMENT
    const [insertedNewPayment] = await pool.query(`INSERT INTO gasto_pagos 
            (consecutivo, id_persona, fecha_pago, valor_pago, observacion, token_erp, created_by) 
                VALUES 
            (?, ?, ?, ?, UPPER(?), ?, ?)`,
      [actualConsecutive, id_persona, fecha_pago, valor_pago, ((observacion||'')+" DETALLE: "+descriptionAbono), tokenErp, req.user.id]
    );
    
    //GET NEW PAYMENT
    const [rows] = await pool.query(`SELECT 
        t5.id,
        t5.consecutivo,
        DATE_FORMAT(t5.fecha_pago,'%Y-%m-%d') AS fecha_pago,
        FORMAT(t4.numero_documento,0) AS personaDocumento,
        CONCAT(
            IFNULL(t4.primer_nombre,''),' ',
            IFNULL(t4.segundo_nombre,''),' ',
            IFNULL(t4.primer_apellido,''),' ',
            IFNULL(t4.segundo_apellido,''),' '
        ) AS personaText,
        t4.id AS personaId,
        t5.estado,
        IF(t5.estado=0,'ANULADO','REGISTRADO') AS estadoText,
        FORMAT(t5.valor_pago,0) AS valor_pago,
        IFNULL(t5.observacion,'') AS observacion
      FROM gasto_pagos t5
        LEFT OUTER JOIN personas t4 ON t4.id = t5.id_persona

      WHERE
        t5.id = ?`, [ insertedNewPayment.insertId ]);

    let newPayment = rows[0];
    
    await genLog({
        module: 'pagos', 
        idRegister: newPayment.id, 
        recordBefore: newPayment, 
        oper: 'CREATE', 
        detail: `PAGO ${newPayment.consecutivo} CREADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });

    //pool.end();

    return res.json({success: true, data: { newPayment }});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deletePayment = async (req, res) => {
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
    
    const { oper } = req.query;
    let pool = poolSys.getPool(req.user.token_db);

    let apiKeyERP = await getSysEnv({
      name: 'api_key_erp',
      pool: pool
    });
    
    //GET NEW BILL CASH RECEIPT
    const [rows] = await pool.query(`SELECT * FROM gasto_pagos WHERE id = ?`, [ id ]);
    let payment = rows[0];

    //DELETE PAYMENT
    let [token_erp] = await pool.query(`SELECT token_erp FROM gasto_pagos WHERE id = ?`,[id]);
    token_erp = token_erp[0].token_erp;

    if(oper=='cancel'){
      await pool.query(`UPDATE gasto_pagos SET estado = 0 WHERE id = ?`,[id]);
      await axios.post(`${process.env.URL_API_ERP}cancel-document?key=${apiKeyERP}`,
      {
        token: token_erp
      });
    
      await genLog({
          module: 'pagos', 
          idRegister: payment.id, 
          recordBefore: payment, 
          oper: 'UPDATE', 
          detail: `PAGO ${payment.consecutivo} ANULADO POR ${req.user.email}`, 
          user: req.user.id,
          pool
      });
    }else{
    
      await genLog({
          module: 'pagos', 
          idRegister: payment.id, 
          recordBefore: payment, 
          oper: 'DELETE', 
          detail: `PAGO ${payment.consecutivo} ELIMINADO POR ${req.user.email}`, 
          user: req.user.id,
          pool
      });

      await pool.query(`DELETE t1 FROM gasto_pagos t1 WHERE t1.id = ?`,[id]);
      await axios.post(`${process.env.URL_API_ERP}delete-bulk-document?key=${apiKeyERP}`,
      {
        token: token_erp
      });
    }

    //pool.end();

    return res.json({success: true, data: {payment: { id }}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error });
  } 
};

const getExtractNit = async (req, res) => {
  console.log('getExtractNit 444');
  try {
    const registerSchema = Joi.object({
        tercero: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.params);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    let { tercero } = req.params;
    
    let pool = poolSys.getPool(req.user.token_db);

    let response = await genExtractProvaiderNit(tercero, pool);
        response.success = true;

    console.log('response: ',response);

    //pool.end();

    return res.json(response);
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const getPaymentPDF = async (req, res) => {
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

    let pdfBuffer = await genPaymentPDF(id, pool, req);
    
    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Disposition', 'attachment; filename=pago.pdf');
    res.send(pdfBuffer);

  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  getExtractNit,
  getPaymentPDF,
  createPayment,
  deletePayment,
  getAllPayments,
  getAllAcumulate
};
