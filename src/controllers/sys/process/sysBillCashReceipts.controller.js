import Joi  from "joi";
import axios from "axios";
import { poolSys } from "../../../db.js";
import { genExtractCustomerNit } from "../../../helpers/sysExtractNit.js";
import { getSysEnv, updateSysEnv, genRandomToken, padLeft, getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { genLog } from "../../../helpers/sysLogs.js";

import { genBillCashReceiptPDF, genPeaceAndSafetyPDF } from "../../../helpers/sysGenSystemPDF.js";

import path from "path";
import multer from "multer";
import CryptoJS from "crypto-js";
import { fileURLToPath } from "url";

const __dirname = path.dirname(fileURLToPath(import.meta.url));

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(__dirname, "../../../../public/uploads/vouchersBillCashReceipts"));
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

//BILL CASH RECEIPTS

const getAllBillCashReceipts = async (req, res) => {
  try {
    let pool = poolSys.getPool(req.user.token_db);

    const [billCashReceipts] = await pool.query(`SELECT 
        t5.id,
        t5.consecutivo,
        DATE_FORMAT(t5.fecha_recibo,'%Y-%m-%d') AS fecha_recibo,
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
        FORMAT(t5.valor_recibo,0) AS valor_recibo,
        IFNULL(t5.observacion,'') AS observacion
      FROM factura_recibos_caja t5
        LEFT OUTER JOIN personas t4 ON t4.id = t5.id_persona
    `);
    

    let billCashReceiptNextNumber = await getSysEnv({name: "consecutivo_recibos_caja", pool});
    
    let controlFechaDigitacion = await getSysEnv({name: "control_fecha_digitacion", pool});
    
    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 8, 
      pool
    });

    //pool.end();
    
    return res.json({success: true, data: billCashReceipts, billCashReceiptNextNumber, controlFechaDigitacion, access });
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

const createBillCashReceiptProcess = async (data, pool, req) => {
  console.log('createBillCashReceiptProcess');
  try {
    let { id_persona, id_tercero_erp, fecha_recibo, valor_recibo, id_cuenta_ingreso_recibos_caja_erp, intereses, descuento_pronto_pago, observacion } = data;
    
    let apiKeyERP = await getSysEnv({
      name: 'api_key_erp',
      pool: pool
    });
    
    let cuentaAnticipos = await getSysEnv({
      name: 'id_cuenta_anticipos_erp',
      pool: pool
    });
    
    let tokenErp = await genRandomToken();

    let responseExtract = await genExtractCustomerNit(id_tercero_erp, pool, false);

    if(Number(valor_recibo)>Number(responseExtract.totalPendiente)&&!cuentaAnticipos){
      return res.status(201).json({ success: false, error: 'El valor del abono es superior al saldo pendiente.' });
    }

    fecha_recibo = fecha_recibo.indexOf("T")>=0 ? fecha_recibo.split("T")[0] : fecha_recibo;

    let [cxcIdErpIntereses] = await pool.query(`SELECT GROUP_CONCAT(t2.id_erp) AS id_cxc_intereses FROM conceptos_facturacion t1 INNER JOIN erp_maestras t2 ON t2.id = t1.id_cuenta_por_cobrar INNER JOIN entorno t3 ON t3.valor = t1.id AND t3.campo='id_concepto_intereses' WHERE t1.eliminado=0`);
         cxcIdErpIntereses = cxcIdErpIntereses[0].id_cxc_intereses;
    
    let [cxcIdErpDescuento] = await pool.query(`SELECT t2.id_erp AS id_cuenta_descuento_erp FROM entorno t1 INNER JOIN erp_maestras t2 ON t2.id = t1.valor WHERE t1.campo='id_cuenta_descuento_erp'`);
         cxcIdErpDescuento = cxcIdErpDescuento[0].id_cuenta_descuento_erp;

    let [reciboComprobanteErp] = await pool.query(`SELECT t2.id_erp FROM entorno t1 INNER JOIN erp_maestras t2 ON t2.id = t1.valor WHERE t1.campo='id_comprobante_recibos_caja_erp'`);
    reciboComprobanteErp = reciboComprobanteErp[0].id_erp;

    if(cuentaAnticipos){
      [cuentaAnticipos] = await pool.query(`SELECT t2.id_erp FROM entorno t1 INNER JOIN erp_maestras t2 ON t2.id = t1.valor WHERE t1.campo='id_cuenta_anticipos_erp'`);
      cuentaAnticipos = cuentaAnticipos[0].id_erp;
    }
    
    let reciboCuentaIngresoErp = false;

    if(id_cuenta_ingreso_recibos_caja_erp){
      [reciboCuentaIngresoErp] = await pool.query(`SELECT t2.id_erp FROM erp_maestras t2 WHERE t2.id = ${id_cuenta_ingreso_recibos_caja_erp}`);
      reciboCuentaIngresoErp = reciboCuentaIngresoErp[0].id_erp;
    }else{
      [reciboCuentaIngresoErp] = await pool.query(`SELECT t2.id_erp FROM entorno t1 INNER JOIN erp_maestras t2 ON t2.id = t1.valor WHERE t1.campo='id_cuenta_ingreso_pasarela_erp'`);
      reciboCuentaIngresoErp = reciboCuentaIngresoErp[0].id_erp;
    }
        
    let actualConsecutive = await getSysEnv({
      name: 'consecutivo_recibos_caja',
      pool: pool
    });
    actualConsecutive = Number(actualConsecutive);

    let newConsecutive = actualConsecutive+1;
      
    await updateSysEnv({
        name: 'consecutivo_recibos_caja',
        val: newConsecutive,
        pool: pool
    });
    
    let bulkDocumentsToErp = [];
    
    let valorReciboMap = 0;
    let valorReciboDisponible = Number(valor_recibo);
    
    let descriptionAbono = [];

    responseExtract.data.map(bill=>{
      if(valorReciboDisponible>0){
        if(Number(bill.totalPendiente.replaceAll(".","").replaceAll(",",""))>=valorReciboDisponible){
          valorReciboMap = valorReciboDisponible;
          valorReciboDisponible = 0;
        }else{
          valorReciboMap = Number(bill.totalPendiente.replaceAll(".","").replaceAll(",",""));
          valorReciboDisponible = valorReciboDisponible-Number(bill.totalPendiente.replaceAll(".","").replaceAll(",",""));
        }

        descriptionAbono.push(`DOC. REF: ${padLeft(bill.docRef, 8)} ABONO: ${Number(valorReciboMap).toLocaleString('es-ES')}`)

        /*if(Number(valorReciboMap)==Number(bill.totalPendiente.replaceAll(".","").replaceAll(",",""))&&Number(bill.totalIntereses.replaceAll(".","").replaceAll(",",""))>0){
          //INTERESES
          bulkDocumentsToErp.push({
            id_comprobante: (reciboComprobanteErp||1),
            id_nit: id_tercero_erp,
            id_centro_costo: null,
            id_documento: padLeft(actualConsecutive, 8),
            fecha: getCurrentDateTime(),
            fecha_manual: fecha_recibo,
            id_cuenta: cxcIdErpIntereses,
            valor: Number(bill.totalIntereses.replaceAll(".","").replaceAll(",","")),
            tipo:  1,//crédito
            token: tokenErp,
            concepto: `INTERESES PAGO EXTEMPORANEO - RECIBO DE CAJA MAXIMO PH - ${observacion}`,
            documento_referencia: padLeft(bill.docRef, 8)
          });
          
          //CXC
          bulkDocumentsToErp.push({
            id_comprobante: (reciboComprobanteErp||1),
            id_nit: id_tercero_erp,
            id_centro_costo: null,
            id_documento: padLeft(actualConsecutive, 8),
            fecha: getCurrentDateTime(),
            fecha_manual: fecha_recibo,
            id_cuenta: bill.cuenta_id,
            valor: (Number(valorReciboMap)-Number(bill.totalIntereses.replaceAll(".","").replaceAll(",",""))),
            tipo:  1,//crédito
            token: tokenErp,
            concepto: `RECIBO DE CAJA MAXIMO PH - ${observacion}`,
            documento_referencia: padLeft(bill.docRef, 8)
          });
        }else */if(Number(valorReciboMap)==Number(bill.totalPendiente.replaceAll(".","").replaceAll(",",""))&&Number(bill.totalDescuento.replaceAll(".","").replaceAll(",",""))>0&&cxcIdErpDescuento){
          //CXC
          bulkDocumentsToErp.push({
            id_nit: id_tercero_erp,
            id_centro_costo: null,
            id_documento: actualConsecutive,
            id_cuenta: bill.cuenta_id,
            debito: 0,
            credito: (valorReciboMap+Number(bill.totalDescuento.replaceAll(".","").replaceAll(",",""))),
            concepto: `RECIBO DE CAJA MAXIMO PH - ${observacion}`,
            documento_referencia: bill.docRef
          });

          //DESCUENTO
          bulkDocumentsToErp.push({
            id_nit: id_tercero_erp,
            id_centro_costo: null,
            id_documento: actualConsecutive,
            id_cuenta: cxcIdErpDescuento,
            debito: Number(bill.totalDescuento.replaceAll(".","").replaceAll(",","")),
            credito: 0,
            concepto: `DESCUENTO PRONTO PAGO - RECIBO DE CAJA MAXIMO PH - ${observacion}`,
            documento_referencia: padLeft(bill.docRef, 8)
          });
        }else{
          //CXC
          bulkDocumentsToErp.push({
            id_nit: id_tercero_erp,
            id_centro_costo: null,
            id_documento: actualConsecutive,
            id_cuenta: bill.cuenta_id,
            debito: 0,
            credito: valorReciboMap,
            concepto: `RECIBO DE CAJA MAXIMO PH - ${observacion}`,
            documento_referencia: bill.docRef
          });
        }
      }
    });

    //ANTICIPOS
    if(valorReciboDisponible>0){
      descriptionAbono.push(`ANTICIPO: ${Number(valorReciboDisponible).toLocaleString('es-ES')}`);

      bulkDocumentsToErp.push({
        id_nit: id_tercero_erp,
        id_centro_costo: null,
        id_documento: actualConsecutive,
        id_cuenta: cuentaAnticipos,
        debito: 0,
        credito: valorReciboDisponible,
        concepto: `ANTICIPO - RECIBO DE CAJA MAXIMO PH - ${observacion}`,
        documento_referencia: ""
      });
    }
    
    //INGRESO
    bulkDocumentsToErp.push({
      id_nit: id_tercero_erp,
      id_centro_costo: null,
      id_documento: actualConsecutive,
      id_cuenta: reciboCuentaIngresoErp,
      debito: valor_recibo,
      credito: 0,
      concepto: `RECIBO DE CAJA MAXIMO PH - ${observacion}`,
      documento_referencia: ''
    });

    const instance = axios.create({
      baseURL: `${process.env.URL_API_ERP}`,
      headers: {
        'Authorization': apiKeyERP,
        'Content-Type': 'application/json'
      }
    });

    await instance.post(`${process.env.URL_API_ERP}documentos`, JSON.stringify({
      documento: bulkDocumentsToErp,
      id_comprobante: (reciboComprobanteErp||1),
      consecutivo: actualConsecutive,
      fecha_manual: fecha_recibo,
      token_factura: tokenErp
    }));
    
    descriptionAbono = descriptionAbono.join(" | ");

    //CREATE BILL CASH RECEIPT
    const [insertedNewBillCashReceipt] = await pool.query(`INSERT INTO factura_recibos_caja 
            (consecutivo, id_persona, fecha_recibo, valor_recibo, observacion, token_erp, created_by) 
                VALUES 
            (?, ?, ?, ?, UPPER(?), ?, ?)`,
      [actualConsecutive, id_persona, fecha_recibo, valor_recibo, ((observacion||'')+" DETALLE: "+descriptionAbono), tokenErp, req.user.id]
    );
    
    //GET NEW BILL CASH RECEIPT
    const [rows] = await pool.query(`SELECT 
        t5.id,
        t5.consecutivo,
        DATE_FORMAT(t5.fecha_recibo,'%Y-%m-%d') AS fecha_recibo,
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
        FORMAT(t5.valor_recibo,0) AS valor_recibo,
        IFNULL(t5.observacion,'') AS observacion
      FROM factura_recibos_caja t5
        LEFT OUTER JOIN personas t4 ON t4.id = t5.id_persona

      WHERE
        t5.id = ?`, [ insertedNewBillCashReceipt.insertId ]);

    let newBillCashReceipt = rows[0];
    
    await genLog({
        module: 'recibos_de_caja', 
        idRegister: newBillCashReceipt.id, 
        recordBefore: newBillCashReceipt, 
        oper: 'CREATE', 
        detail: `RECIBO DE CAJA ${newBillCashReceipt.consecutivo} CREADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });

    //pool.end();

    return {success: true, data: { newBillCashReceipt }};
  } catch (error) {
    return { success: false, error: 'Internal Server Error', error: error.message };
  }
};

const createBillCashReceipt = async (req, res) => { 
  console.log('createBillCashReceipt');

  try {  
    const registerSchema = Joi.object({
        id_persona: Joi.number().required(),
        id_tercero_erp: Joi.number().required(),
        fecha_recibo: Joi.date().required(), 
        valor_recibo: Joi.number().allow(null,''),
        intereses: Joi.number().allow(null,''),
        descuento_pronto_pago: Joi.number().allow(null,''),
        observacion: Joi.string().allow(null,''),
        id_cuenta_ingreso_recibos_caja_erp: Joi.number().allow(null,'')
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    let pool = poolSys.getPool(req.user.token_db);

    let response = await createBillCashReceiptProcess(req.body, pool, req);

    //pool.end();
    
    if(response.success){
      return res.json(response);
    }else{
      return res.status(500).json(response);
    }

  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createBillCashReceiptAnticipos = async (req, res) => {
  console.log('createBillCashReceiptAnticipos');

  try {  
    const registerSchema = Joi.object({
        id_history: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }
    let { id_history } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    let cuentaAnticipos = await getSysEnv({
      name: 'id_cuenta_anticipos_erp',
      pool: pool
    });

    if(cuentaAnticipos){
      let [bills] = await pool.query(`SELECT 
          t2.id_persona,
          t5.id_tercero_erp,
          DATE_FORMAT(NOW(),"%Y-%m-%d") AS fecha_recibo,
          IFNULL(t2.total_anticipos,0) AS valor_recibo,
          0 AS intereses,
          0 AS descuento_pronto_pago,
          'CRUCE ANTICIPO' AS observacion,
          '${cuentaAnticipos}' AS id_cuenta_ingreso_recibos_caja_erp
        FROM factura_ciclica_historial_detalle t1 
          INNER JOIN facturas t2 ON t2.id = t1.id_factura
          INNER JOIN personas t5 ON t5.id = t2.id_persona
      WHERE t1.id_factura_ciclica = ${id_history} AND IFNULL(t2.total_anticipos,0)>0`);

      await Promise.all(bills.map(async (bill)=>{
        await createBillCashReceiptProcess(bill, pool, req);
      }));

      //pool.end();
      
      return res.json({success: true});
    }else{
      return res.json({success: false, error: 'Cuenta de anticipos sin configurar'});
    }
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteBillCashReceipt = async (req, res) => {
  console.log('deleteBillCashReceipt: ',deleteBillCashReceipt);
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

    const instance = axios.create({
			baseURL: `${process.env.URL_API_ERP}`,
			headers: {
				'Authorization': apiKeyERP,
				'Content-Type': 'application/json'
			}
		});

    //GET NEW BILL CASH RECEIPT
    const [rows] = await pool.query(`SELECT * FROM factura_recibos_caja WHERE id = ?`, [ id ]);

    let billCashReceipt = rows[0];
    
    //DELETE BILL CASH RECEIPT
    let [token_erp] = await pool.query(`SELECT token_erp FROM factura_recibos_caja WHERE id = ?`,[id]);
    token_erp = [{"token" : token_erp[0].token_erp}];

    await instance.post(`bulk-documentos-delete`, JSON.stringify({
      "documento": token_erp
    }));

    if(oper=='cancel'){
      await pool.query(`UPDATE factura_recibos_caja SET estado = 0 WHERE id = ?`,[id]);
    
      await genLog({
          module: 'recibos_de_caja', 
          idRegister: billCashReceipt.id, 
          recordBefore: billCashReceipt, 
          oper: 'UPDATE', 
          detail: `RECIBO DE CAJA ${billCashReceipt.consecutivo} ANULADO POR ${req.user.email}`, 
          user: req.user.id,
          pool
      });
    }else{
    
      await genLog({
          module: 'recibos_de_caja', 
          idRegister: billCashReceipt.id, 
          recordBefore: billCashReceipt, 
          oper: 'DELETE', 
          detail: `RECIBO DE CAJA ${billCashReceipt.consecutivo} ELIMINADO POR ${req.user.email}`, 
          user: req.user.id,
          pool
      });

      await pool.query(`DELETE t1 FROM factura_recibos_caja t1 WHERE t1.id = ?`,[id]);
    }

    await pool.query(`UPDATE factura_recibo_caja_comprobante SET
        estado = 0,
        id_recibo_caja = NULL,
        observacion_administrador = NULL,
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id_recibo_caja = ?`,
      [req.user.id, id]
    );

    //pool.end();

    return res.json({success: true, data: {billCashReceipt: { id }}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error });
  } 
};

const getExtractNit = async (req, res) => {
  console.log('getExtractNit');
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

    let response = await genExtractCustomerNit(tercero, pool, false);
        response.success = true;

    //pool.end();

    return res.json(response);
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const getBillCashReceiptPDF = async (req, res) => {
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

    let pdfBuffer = await genBillCashReceiptPDF(id, pool, req);
    
    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Disposition', 'attachment; filename=gasto.pdf');
    res.send(pdfBuffer);

  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const getPeaceAndSafetyPDF = async (req, res) => {
  try {
    const registerSchema = Joi.object({
      persona: Joi.string().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.params);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }
    
    const { persona } = req.params;
    
    let pool = poolSys.getPool(req.user.token_db);

    let pdfBuffer = await genPeaceAndSafetyPDF(persona, pool, req);
    
    if(pdfBuffer){
      res.setHeader('Content-Type', 'application/pdf');
      res.setHeader('Content-Disposition', 'attachment; filename=gasto.pdf');
      res.send(pdfBuffer);
    }else{
      return res.status(401).json({});
    }

  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};


//VOUCHERS
const getOwnVouchers = async (req, res) => {
  try {
      let pool = poolSys.getPool(req.user.token_db);

      let queryOwnVouchers = `SELECT 
          t1.*,
          
          DATE_FORMAT(t1.created_at,"%Y-%m-%d %H:%i") AS created_at,

          IFNULL(t4.nombre,'') AS imagen,

          FORMAT(t5.numero_documento,0) AS personaDocumento,

          CONCAT(IFNULL(t5.primer_nombre,''),' ',IFNULL(t5.segundo_nombre,''),' ',IFNULL(t5.primer_apellido,''),' ',IFNULL(t5.segundo_apellido,'')) AS personaText
          
      FROM factura_recibo_caja_comprobante t1 
          LEFT OUTER JOIN multimedia t4 ON t4.id_registro = t1.id AND t4.tipo = 5
          INNER JOIN personas t5 ON t5.id = t1.id_persona

      WHERE 
          t1.created_by='${req.user.id}' 
      ORDER BY t1.created_at DESC`;
      
      const [ownVouchers] = await pool.query(queryOwnVouchers);
      
      //pool.end();

      return res.json({success: true, data: ownVouchers});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const getAllVouchers = async (req, res) => {
  try {
      let pool = poolSys.getPool(req.user.token_db);

      const [vouchers] = await pool.query(`SELECT 
          t1.*,
          
          DATE_FORMAT(t1.created_at,"%Y-%m-%d %H:%i") AS created_at,

          IFNULL(t4.nombre,'') AS imagen,

          FORMAT(t5.numero_documento,0) AS personaDocumento,
          
          t5.id_tercero_erp,

          CONCAT(IFNULL(t5.primer_nombre,''),' ',IFNULL(t5.segundo_nombre,''),' ',IFNULL(t5.primer_apellido,''),' ',IFNULL(t5.segundo_apellido,'')) AS personaText
          
      FROM factura_recibo_caja_comprobante t1 
          LEFT OUTER JOIN multimedia t4 ON t4.id_registro = t1.id AND t4.tipo = 5
          INNER JOIN personas t5 ON t5.id = t1.id_persona

      WHERE 1 = 1
      ORDER BY t1.created_at DESC`);
  
      let access = await getModuleAccess({
        user: req.user.id, 
        client: req.user.id_cliente, 
        module: 8, 
        pool
      });
      
      //pool.end();

      return res.json({success: true, data: vouchers, access});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createVoucher = async (req, res) => {     
  try {
      multer({ storage }).single('image')(req, res, async(err) => {
          if (err) {
            console.log(err.message);
            return res.status(400).json({ message: "Failed image processing" });
          }
    
          const image = req.file ? path.basename(req.file.path) : null;

          const registerSchema = Joi.object({
              id_persona: Joi.number().required(),
              fecha: Joi.string().required(),
              valor: Joi.number().required(),
              image: Joi.allow(null,''),
              tipo_image: Joi.string().required().allow(null,'')
          });

          //VALIDATE FORMAT FIELDS
          const { error } = registerSchema.validate(req.body);
          if (error) {
          return res.status(201).json({ success: false, error: error.message });
          }

          const { id_persona, fecha, valor, tipo_image } = req.body;

          let pool = poolSys.getPool(req.user.token_db);

          //CREATE VOUCHER
          const [insertedNewVoucher] = await pool.query(`INSERT INTO factura_recibo_caja_comprobante 
          (id_persona, fecha, valor, created_by) 
              VALUES 
          (?, ?, ?, ?)`,
          [id_persona, fecha, valor, req.user.id]
          );
          
          //GET VOUCHER
          const [rows] = await pool.query(`SELECT 
              t1.*,
              
              DATE_FORMAT(t1.created_at,"%Y-%m-%d %H:%i") AS created_at,

              IFNULL(t4.nombre,'') AS imagen,

          FORMAT(t5.numero_documento,0) AS personaDocumento,

              CONCAT(IFNULL(t5.primer_nombre,''),' ',IFNULL(t5.segundo_nombre,''),' ',IFNULL(t5.primer_apellido,''),' ',IFNULL(t5.segundo_apellido,'')) AS personaText

          FROM factura_recibo_caja_comprobante t1 
              LEFT OUTER JOIN multimedia t4 ON t4.id_registro = t1.id AND t4.tipo = 5
              INNER JOIN personas t5 ON t5.id = t1.id_persona

          WHERE t1.id = ?`, [ insertedNewVoucher.insertId ]);
          
          let voucher = rows[0];
          
          //ADD IMAGE
          if(image){
              await pool.query(`INSERT INTO multimedia 
              (tipo, id_registro, nombre, peso, tipo_multimedia, created_by)
                  VALUES
              (?, ?, ?, ?, ?, ?)
              `, [5, voucher.id, image, 0, tipo_image, req.user.id]);
          }

          //pool.end();

          return res.json({success: true, data: {voucher}});
      });
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const changeStatusVoucher = async (req, res) => {
  try {  
    const registerSchema = Joi.object({
      id_persona: Joi.number().required(),
      id_tercero_erp: Joi.number().required(),
      fecha_recibo: Joi.date().required(), 
      valor_recibo: Joi.number().allow(null,''),
      intereses: Joi.number().allow(null,''),
      descuento_pronto_pago: Joi.number().allow(null,''),
      observacion: Joi.string().allow(null,''),
      id_cuenta_ingreso_recibos_caja_erp: Joi.number().allow(null,''),
      estado: Joi.number().required(),
      observacion_administrador: Joi.string().allow(null,''),
      saldo: Joi.allow(null,''),
      persona_documento: Joi.allow(null,''),
      persona_nombres: Joi.allow(null,''),
      id: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { estado, observacion_administrador, id } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    let responseBCR = false;
    
    if(estado==1){
      responseBCR = await createBillCashReceiptProcess(req.body, pool, req);
    }

    //UPDATE VOUCHER
    await pool.query(`UPDATE factura_recibo_caja_comprobante SET
        estado = ?,
        id_recibo_caja = ?,
        observacion_administrador = UPPER(?),
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [estado, (responseBCR ? responseBCR.data.newBillCashReceipt.id : null), observacion_administrador, req.user.id, id]
    );
    
    //GET EDITED VOUCHER
    const [rows] = await pool.query(`SELECT 
          t1.*,
          
          DATE_FORMAT(t1.created_at,"%Y-%m-%d %H:%i") AS created_at,

          IFNULL(t4.nombre,'') AS imagen,

          FORMAT(t5.numero_documento,0) AS personaDocumento,

          CONCAT(IFNULL(t5.primer_nombre,''),' ',IFNULL(t5.segundo_nombre,''),' ',IFNULL(t5.primer_apellido,''),' ',IFNULL(t5.segundo_apellido,'')) AS personaText

      FROM factura_recibo_caja_comprobante t1 
          LEFT OUTER JOIN multimedia t4 ON t4.id_registro = t1.id AND t4.tipo = 5
          INNER JOIN personas t5 ON t5.id = t1.id_persona

      WHERE t1.id = ?`, [ id ]);
    
    let voucher = rows[0];

    //pool.end();

    return res.json({success: true, data: {voucher}});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  getExtractNit,
  getBillCashReceiptPDF,
  getPeaceAndSafetyPDF,
  createBillCashReceipt,
  createBillCashReceiptAnticipos,
  deleteBillCashReceipt,
  getAllBillCashReceipts,
  
  changeStatusVoucher,
  getOwnVouchers,
  getAllVouchers,
  createVoucher
};
