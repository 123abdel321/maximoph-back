import html_to_pdf  from "html-pdf-node";
import { getSysEnv, getLogoCompany } from "./sysEnviroment.js";

const genSpentPDF = async (id, pool, req) => {

  let logoCompany = await getLogoCompany({
    pool,
    id: req.user.id_cliente
  });

  if(logoCompany){
    logoCompany = (process.env.REACT_API_URL||'https://api.maximoph.com')+"/uploads/company-logo/"+logoCompany;
  }

  let [headSpent] = await pool.query(`SELECT 
    t1.id,
    
    IFNULL(t1.anulado,0) AS anulado,
    
    IFNULL(t1.porcentaje_retencion,0) AS porcentaje_retencion,
    
    IFNULL(t1.valor_total_retencion,0) AS valor_total_retencion,

    t1.id_persona_proveedor,

    CONCAT(
      FORMAT(t2.numero_documento,0),' ',
      IFNULL(t2.primer_nombre,''),' ',
      IFNULL(t2.segundo_nombre,''),' ',
      IFNULL(t2.primer_apellido,''),' ',
      IFNULL(t2.segundo_apellido,''),' '
    ) AS proveedorText,
    
    t1.consecutivo,

    DATE_FORMAT(t1.fecha_documento,"%Y-%m-%d") AS fecha_documento,
    
    FORMAT(IFNULL(t1.valor_total_iva,0),0) AS valor_total_iva,
    
    FORMAT(t1.valor_total,0) AS valor_total,
    
    IFNULL(t1.observacion,'') AS observacion, 
    
    DATE_FORMAT(NOW(),"%Y-%m-%d %H:%i:%s") AS fecha_impresion

  FROM gastos t1

  INNER JOIN personas t2 ON t2.id = t1.id_persona_proveedor

  WHERE t1.id = ?`,[id]);

  headSpent = headSpent[0];
  
  let [bodySpent] = await pool.query(`SELECT 
    t1.id,
    t1.id_concepto_gasto,
    t1.id_centro_costos_erp,
    t2.nombre AS conceptoText,
    IFNULL(t3.nombre,'') AS centroCostosText,
    t1.porcentaje_iva,
    FORMAT(t1.valor_total_iva,0) AS valor_total_iva,
    FORMAT(t1.total,0) AS total,
    IFNULL(t1.descripcion,'') AS descripcion

  FROM gasto_detalle t1

  INNER JOIN conceptos_gastos t2 ON t2.id = t1.id_concepto_gasto
  LEFT OUTER JOIN erp_maestras t3 ON t3.id = t1.id_centro_costos_erp

  WHERE t1.id_gasto = ?`,[id]);
  
  let bodySpentHTML = [];

  bodySpent.map(spentB=>{
      bodySpentHTML.push(`<tr>
          <td>${spentB.conceptoText}</td>
          <td>${spentB.centroCostosText}</td>
          <td>${spentB.porcentaje_iva}</td>
          <td style="text-align: right;">$ ${spentB.valor_total_iva}</td>
          <td style="text-align: right;">$ ${spentB.total}</td>
      </tr>`);
  });

  bodySpentHTML = bodySpentHTML.join(" ");

  let razonSocial = await getSysEnv({
      name: 'razon_social',
      pool: pool
  });
  
  let nit = await getSysEnv({
      name: 'nit',
      pool: pool
  });
  
  let direccion = await getSysEnv({
      name: 'direccion',
      pool: pool
  });

  let telefono = await getSysEnv({
      name: 'telefono',
      pool: pool
  });
  
  let email = await getSysEnv({
      name: 'email',
      pool: pool
  });
  
  let options = { width: '21.59 cm', height: '13.97 cm',  printBackground: true};
  
  let htmlContent = `<!DOCTYPE html>
  <html>
  <head>
    <title>Gasto</title>
    <style>
      body {
        font-family: Arial, sans-serif;
      }
      .header {
        display: flex;
        text-align: center;
        margin-bottom: 20px;
        border: 1px solid #dddddd;
        border-radius: 15px;
        padding: 10px;
        background-color: #171f42;
      }
      .header div {
        width: 75%;
        text-align: center;
      }
      .header img {
        width: 100px;
        height: 100px;
        border-radius: 15px;
        margin-left: 10px;
      }
      .header p {
        margin: 0;
        color: #FFFFFF!important;
      }
      .sub-header{
        width: 100%;
      }
      .sub-header table tbody tr td{
        padding: 5px;
        font-size: 13px;
      }
      .sub-header table tbody tr td b{
        color: #171F42;
      }
      .contact-info {
        text-align: right;
        margin-bottom: 20px;
      }
      .table {
        width: 100%;
        border-collapse: collapse;
      }
      .table th, .table td {
        border: 1px solid #ccc;
        padding: 8px;
        font-size: 13px;
      }
      .table th {
        background-color: #171f42;
      }
      .table thead tr th {
        color: #FFFFFF!important;
      }
      .totals {
        text-align: right;
        margin-top: 20px;
      }
      .watermark {
        position: absolute;
        bottom: 40%;
        right: 12%;
        z-index: 1;
        opacity: 0.3;
        transform: rotate(-45deg);
        font-size: 130px;
        color: #ff5959;
      }
    </style>
  </head>
  <body>
    <div class="header">
      ${logoCompany?`<img src='${logoCompany}' />`:``}
      <div ${!logoCompany?`style='width: 100%;'`:``}>
        <p><b>${razonSocial}</b></p>
        <p><b>NIT:</b> ${nit}</p>
        <p><b>Dirección:</b> ${direccion}</p>
        <p><b>Teléfono:</b> ${telefono}</p>
        <p><b>Email:</b> ${email}</p>
      </div>
    </div>
    <div class="sub-header">
      <table>
        <tbody>
          <tr>
              <td><b>Fecha:</b> ${headSpent.fecha_documento}</td>
              <td><b>Gasto Nº:</b> ${headSpent.consecutivo}</td>
          </tr>
          <tr>
              <td><b>Proveedor:</b> ${headSpent.proveedorText}</td>
              <td><b>Observación:</b> ${headSpent.observacion}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <br />
    <table class="table">
      <thead>
        <tr>
          <th>Concepto</th>
          <th>Centro Costos</th>
          <th>% IVA</th>
          <th>Valor IVA</th>
          <th>Total</th>
        </tr>
      </thead>
      <tbody>
        ${bodySpentHTML}
      </tbody>
    </table>
    <div class="totals">
      <p><b>Total IVA:</b> $ ${headSpent.valor_total_iva}</p>
      ${Number(headSpent.porcentaje_retencion)>0?(`<p><b>Total Rete.Fuente:</b> (% ${headSpent.porcentaje_retencion}) $ ${headSpent.valor_total_retencion}</p>`):(``)}
      <p><b>Total Gasto:</b> $ ${headSpent.valor_total}</p>
    </div>

    ${headSpent.anulado?'<div class="watermark">ANULADA</div>':''}
    
    <br />
    <br />
   
    <div style='display: flex;'>
      <p style="font-size: 12px;width: 50%;">Generado en http://www.maximoph.com/</p>
      <p style="font-size: 12px;width: 50%;text-align: right;">Fecha Impresión: ${headSpent.fecha_impresion}</p>
    <div>
    </body>
  </html>`

  let file = { content: htmlContent };
  
  let pdf = await html_to_pdf.generatePdf(file, options);

  return pdf;
};

const genBillCashReceiptPDF = async (id, pool, req) => {
  
  let logoCompany = await getLogoCompany({
    pool,
    id: req.user.id_cliente
  });

  if(logoCompany){
    logoCompany = (process.env.REACT_API_URL||'https://api.maximoph.com')+"/uploads/company-logo/"+logoCompany;
  }

  let [headBillCashReceipt] = await pool.query(`SELECT 
    t1.id,
    
    IFNULL(t1.estado,1) AS estado,

    CONCAT(
      FORMAT(t2.numero_documento,0),' ',
      IFNULL(t2.primer_nombre,''),' ',
      IFNULL(t2.segundo_nombre,''),' ',
      IFNULL(t2.primer_apellido,''),' ',
      IFNULL(t2.segundo_apellido,''),' '
    ) AS responsableText,
    
    t1.consecutivo,

    DATE_FORMAT(t1.fecha_recibo,"%Y-%m-%d") AS fecha_documento,
    
    FORMAT(t1.valor_recibo,0) AS valor_recibo,
    
    IFNULL(t1.observacion,'') AS observacion, 
    
    DATE_FORMAT(NOW(),"%Y-%m-%d %H:%i:%s") AS fecha_impresion

  FROM factura_recibos_caja t1

  INNER JOIN personas t2 ON t2.id = t1.id_persona

  WHERE t1.id = ?`,[id]);

  headBillCashReceipt = headBillCashReceipt[0];

  let bodyBillCashReceiptHTML = [];
      
  bodyBillCashReceiptHTML.push(`<tr>
      <td>${headBillCashReceipt.observacion}</td>
  </tr>`);

  bodyBillCashReceiptHTML = bodyBillCashReceiptHTML.join(" ");

  let razonSocial = await getSysEnv({
      name: 'razon_social',
      pool: pool
  });
  
  let nit = await getSysEnv({
      name: 'nit',
      pool: pool
  });
  
  let direccion = await getSysEnv({
      name: 'direccion',
      pool: pool
  });

  let telefono = await getSysEnv({
      name: 'telefono',
      pool: pool
  });
  
  let email = await getSysEnv({
      name: 'email',
      pool: pool
  });
  
  let options = { width: '21.59 cm', height: '13.97 cm',  printBackground: true};
  
  let htmlContent = `<!DOCTYPE html>
  <html>
  <head>
    <title>Recibo de Caja</title>
    <style>
      body {
        font-family: Arial, sans-serif;
      }
      .header {
        display: flex;
        text-align: center;
        margin-bottom: 20px;
        border: 1px solid #dddddd;
        border-radius: 15px;
        padding: 10px;
        background-color: #171f42;
      }
      .header div {
        width: 75%;
        text-align: center;
      }
      .header img {
        width: 100px;
        height: 100px;
        border-radius: 15px;
        margin-left: 10px;
      }
      .header p {
        margin: 0;
        color: #FFFFFF!important;
      }
      .sub-header{
        width: 100%;
      }
      .sub-header table tbody tr td{
        padding: 5px;
        font-size: 13px;
      }
      .sub-header table tbody tr td b{
        color: #171F42;
      }
      .contact-info {
        text-align: right;
        margin-bottom: 20px;
      }
      .table {
        width: 100%;
        border-collapse: collapse;
      }
      .table th, .table td {
        border: 1px solid #ccc;
        padding: 8px;
        font-size: 13px;
      }
      .table th {
        background-color: #171f42;
      }
      .table thead tr th {
        color: #FFFFFF!important;
      }
      .totals {
        text-align: right;
        margin-top: 20px;
      }
      .watermark {
        position: absolute;
        bottom: 40%;
        right: 12%;
        z-index: 1;
        opacity: 0.3;
        transform: rotate(-45deg);
        font-size: 130px;
        color: #ff5959;
      }
    </style>
  </head>
  <body>
    <div class="header">
      ${logoCompany?`<img src='${logoCompany}' />`:``}
      <div ${!logoCompany?`style='width: 100%;'`:``}>
        <p><b>${razonSocial}</b></p>
        <p><b>NIT:</b> ${nit}</p>
        <p><b>Dirección:</b> ${direccion}</p>
        <p><b>Teléfono:</b> ${telefono}</p>
        <p><b>Email:</b> ${email}</p>
      </div>
    </div>
    <div class="sub-header">
      <table>
        <tbody>
          <tr>
              <td><b>Fecha:</b> ${headBillCashReceipt.fecha_documento}</td>
              <td><b>Recibo de Caja Nº:</b> ${headBillCashReceipt.consecutivo}</td>
          </tr>
          <tr>
              <td><b>Persona:</b> ${headBillCashReceipt.responsableText}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <br />
    <table class="table">
      <thead>
        <tr>
          <th>Detalle</th>
        </tr>
      </thead>
      <tbody>
        ${bodyBillCashReceiptHTML}
      </tbody>
    </table>
    <div class="totals">
      <p><b>Total Recibo:</b> $ ${headBillCashReceipt.valor_recibo}</p>
    </div>

    ${headBillCashReceipt.estado==0?'<div class="watermark">ANULADO</div>':''}
    
    <br />
    <br />
   
    <div style='display: flex;'>
      <p style="font-size: 12px;width: 50%;">Generado en http://www.maximoph.com/</p>
      <p style="font-size: 12px;width: 50%;text-align: right;">Fecha Impresión: ${headBillCashReceipt.fecha_impresion}</p>
    <div>
    </body>
  </html>`

  let file = { content: htmlContent };
  
  let pdf = await html_to_pdf.generatePdf(file, options);

  return pdf;
};

const genPeaceAndSafetyPDF = async (persona, pool, req) => {
  
  let logoCompany = await getLogoCompany({
    pool,
    id: req.user.id_cliente
  });

  if(logoCompany){
    logoCompany = (process.env.REACT_API_URL||'https://api.maximoph.com')+"/uploads/company-logo/"+logoCompany;
  }

  let [headPeaceAndSafety] = await pool.query(`SELECT 
    t1.id,

    CONCAT(
      FORMAT(t1.numero_documento,0),' ',
      IFNULL(t1.primer_nombre,''),' ',
      IFNULL(t1.segundo_nombre,''),' ',
      IFNULL(t1.primer_apellido,''),' ',
      IFNULL(t1.segundo_apellido,''),' '
    ) AS responsableText,
        
    DATE_FORMAT(NOW(),"%Y-%m-%d %H:%i:%s") AS fecha_impresion

  FROM personas t1

  WHERE t1.email = ?`,[persona]);
  
  headPeaceAndSafety = headPeaceAndSafety[0];

  let pdf = null;
  if(headPeaceAndSafety){
    let bodyPeaceAndSafetyHTML = [];
        
    let razonSocial = await getSysEnv({
        name: 'razon_social',
        pool: pool
    });

    bodyPeaceAndSafetyHTML.push(`<tr>
        <td style='font-size: 15px;'>Por medio del presente comprobante de Paz y Salvo, se confirma que ${headPeaceAndSafety.responsableText} ha pagado el saldo correspondiente a todos los conceptos de administración de ${razonSocial}.</td>
    </tr>`);

    bodyPeaceAndSafetyHTML = bodyPeaceAndSafetyHTML.join(" ");
    
    let nit = await getSysEnv({
        name: 'nit',
        pool: pool
    });
    
    let direccion = await getSysEnv({
        name: 'direccion',
        pool: pool
    });

    let telefono = await getSysEnv({
        name: 'telefono',
        pool: pool
    });
    
    let email = await getSysEnv({
        name: 'email',
        pool: pool
    });
    
    let options = { width: '21.59 cm', height: '13.97 cm',  printBackground: true};
    
    let htmlContent = `<!DOCTYPE html>
    <html>
    <head>
      <title>Recibo de Caja</title>
      <style>
        body {
          font-family: Arial, sans-serif;
        }
        .header {
          display: flex;
          text-align: center;
          margin-bottom: 20px;
          border: 1px solid #dddddd;
          border-radius: 15px;
          padding: 10px;
          background-color: #171f42;
        }
        .header div {
          width: 75%;
          text-align: center;
        }
        .header img {
          width: 100px;
          height: 100px;
          border-radius: 15px;
          margin-left: 10px;
        }
        .header p {
          margin: 0;
          color: #FFFFFF!important;
        }
        .sub-header{
          width: 100%;
        }
        .sub-header table tbody tr td{
          padding: 5px;
          font-size: 13px;
        }
        .sub-header table tbody tr td b{
          color: #171F42;
        }
        .contact-info {
          text-align: right;
          margin-bottom: 20px;
        }
        .table {
          width: 100%;
          border-collapse: collapse;
        }
        .table th, .table td {
          border: 1px solid #ccc;
          padding: 8px;
          font-size: 13px;
        }
        .table th {
          background-color: #171f42;
        }
        .table thead tr th {
          color: #FFFFFF!important;
        }
        .totals {
          text-align: right;
          margin-top: 20px;
        }
        .watermark {
          position: absolute;
          bottom: 40%;
          right: 12%;
          z-index: 1;
          opacity: 0.3;
          transform: rotate(-45deg);
          font-size: 130px;
          color: #ff5959;
        }
      </style>
    </head>
    <body>
      <div class="header">
        ${logoCompany?`<img src='${logoCompany}' />`:``}
        <div ${!logoCompany?`style='width: 100%;'`:``}>
          <p><b>${razonSocial}</b></p>
          <p><b>NIT:</b> ${nit}</p>
          <p><b>Dirección:</b> ${direccion}</p>
          <p><b>Teléfono:</b> ${telefono}</p>
          <p><b>Email:</b> ${email}</p>
        </div>
      </div>
      <div class="sub-header">
        <table>
          <tbody>
            <tr>
                <td><b>Persona:</b> ${headPeaceAndSafety.responsableText}</td>
                <td><b>FECHA PAZ Y SALVO:</b> ${headPeaceAndSafety.fecha_impresion}</td>
            </tr>
          </tbody>
        </table>
      </div>
      <br />
      <table class="table">
        <thead>
          <tr>
            <th>Detalle</th>
          </tr>
        </thead>
        <tbody>
          ${bodyPeaceAndSafetyHTML}
        </tbody>
      </table>
      
      <br />
      <br />
    
      <div style='display: flex;'>
        <p style="font-size: 12px;width: 50%;">Generado en http://www.maximoph.com/</p>
        <p style="font-size: 12px;width: 50%;text-align: right;">Fecha Impresión: ${headPeaceAndSafety.fecha_impresion}</p>
      <div>
      </body>
    </html>`

    console.log(htmlContent);

    let file = { content: htmlContent };
    
    pdf = await html_to_pdf.generatePdf(file, options);
  }

  return pdf;
};

const genPaymentPDF = async (id, pool, req) => {
  
  let logoCompany = await getLogoCompany({
    pool,
    id: req.user.id_cliente
  });

  if(logoCompany){
    logoCompany = (process.env.REACT_API_URL||'https://api.maximoph.com')+"/uploads/company-logo/"+logoCompany;
  }

  let [headPayment] = await pool.query(`SELECT 
    t1.id,
    
    IFNULL(t1.estado,1) AS estado,

    CONCAT(
      FORMAT(t2.numero_documento,0),' ',
      IFNULL(t2.primer_nombre,''),' ',
      IFNULL(t2.segundo_nombre,''),' ',
      IFNULL(t2.primer_apellido,''),' ',
      IFNULL(t2.segundo_apellido,''),' '
    ) AS responsableText,
    
    t1.consecutivo,

    DATE_FORMAT(t1.fecha_pago,"%Y-%m-%d") AS fecha_documento,
    
    FORMAT(t1.valor_pago,0) AS valor_pago,
    
    IFNULL(t1.observacion,'') AS observacion, 
    
    DATE_FORMAT(NOW(),"%Y-%m-%d %H:%i:%s") AS fecha_impresion

  FROM gasto_pagos t1

  INNER JOIN personas t2 ON t2.id = t1.id_persona

  WHERE t1.id = ?`,[id]);

  headPayment = headPayment[0];

  let bodyPaymentHTML = [];
      
  bodyPaymentHTML.push(`<tr>
      <td>${headPayment.observacion}</td>
  </tr>`);

  bodyPaymentHTML = bodyPaymentHTML.join(" ");

  let razonSocial = await getSysEnv({
      name: 'razon_social',
      pool: pool
  });
  
  let nit = await getSysEnv({
      name: 'nit',
      pool: pool
  });
  
  let direccion = await getSysEnv({
      name: 'direccion',
      pool: pool
  });

  let telefono = await getSysEnv({
      name: 'telefono',
      pool: pool
  });
  
  let email = await getSysEnv({
      name: 'email',
      pool: pool
  });
  
  let options = { width: '21.59 cm', height: '13.97 cm',  printBackground: true};
  
  let htmlContent = `<!DOCTYPE html>
  <html>
  <head>
    <title>Recibo de Caja</title>
    <style>
      body {
        font-family: Arial, sans-serif;
      }
      .header {
        display: flex;
        text-align: center;
        margin-bottom: 20px;
        border: 1px solid #dddddd;
        border-radius: 15px;
        padding: 10px;
        background-color: #171f42;
      }
      .header div {
        width: 75%;
        text-align: center;
      }
      .header img {
        width: 100px;
        height: 100px;
        border-radius: 15px;
        margin-left: 10px;
      }
      .header p {
        margin: 0;
        color: #FFFFFF!important;
      }
      .sub-header{
        width: 100%;
      }
      .sub-header table tbody tr td{
        padding: 5px;
        font-size: 13px;
      }
      .sub-header table tbody tr td b{
        color: #171F42;
      }
      .contact-info {
        text-align: right;
        margin-bottom: 20px;
      }
      .table {
        width: 100%;
        border-collapse: collapse;
      }
      .table th, .table td {
        border: 1px solid #ccc;
        padding: 8px;
        font-size: 13px;
      }
      .table th {
        background-color: #171f42;
      }
      .table thead tr th {
        color: #FFFFFF!important;
      }
      .totals {
        text-align: right;
        margin-top: 20px;
      }
      .watermark {
        position: absolute;
        bottom: 40%;
        right: 12%;
        z-index: 1;
        opacity: 0.3;
        transform: rotate(-45deg);
        font-size: 130px;
        color: #ff5959;
      }
    </style>
  </head>
  <body>
    <div class="header">
      ${logoCompany?`<img src='${logoCompany}' />`:``}
      <div ${!logoCompany?`style='width: 100%;'`:``}>
        <p><b>${razonSocial}</b></p>
        <p><b>NIT:</b> ${nit}</p>
        <p><b>Dirección:</b> ${direccion}</p>
        <p><b>Teléfono:</b> ${telefono}</p>
        <p><b>Email:</b> ${email}</p>
      </div>
    </div>
    <div class="sub-header">
      <table>
        <tbody>
          <tr>
              <td><b>Fecha:</b> ${headPayment.fecha_documento}</td>
              <td><b>Pago Nº:</b> ${headPayment.consecutivo}</td>
          </tr>
          <tr>
              <td><b>Proveedor:</b> ${headPayment.responsableText}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <br />
    <table class="table">
      <thead>
        <tr>
          <th>Detalle</th>
        </tr>
      </thead>
      <tbody>
        ${bodyPaymentHTML}
      </tbody>
    </table>
    <div class="totals">
      <p><b>Total Pago:</b> $ ${headPayment.valor_pago}</p>
    </div>

    ${headPayment.estado==0?'<div class="watermark">ANULADO</div>':''}
    
    <br />
    <br />
   
    <div style='display: flex;'>
      <p style="font-size: 12px;width: 50%;">Generado en http://www.maximoph.com/</p>
      <p style="font-size: 12px;width: 50%;text-align: right;">Fecha Impresión: ${headPayment.fecha_impresion}</p>
    <div>
    </body>
  </html>`

  let file = { content: htmlContent };
  
  let pdf = await html_to_pdf.generatePdf(file, options);

  return pdf;
};

const genBillPDF = async (id, pool, req) => {
  
  let logoCompany = await getLogoCompany({
    pool,
    id: req.user.id_cliente
  });

  if(logoCompany){
    logoCompany = (process.env.REACT_API_URL||'https://api.maximoph.com')+"/uploads/company-logo/"+logoCompany;
  }

  let [headBill] = await pool.query(`SELECT 
      DATE_FORMAT(t1.created_at, '%m %Y') AS periodo, t1.estado, DATE_FORMAT(t1.created_at, '%Y-%m-%d') AS fecha, t1.id_inmueble AS codigo_inmueble, t1.consecutivo As cuenta_cobro_num, CONCAT(FORMAT(t3.numero_documento,0),' ',t3.primer_nombre,' ',t3.segundo_nombre,' ',t3.primer_apellido,' ',t3.segundo_apellido) AS persona_nombre, t3.email As persona_email, FORMAT(IFNULL(t1.saldo_anterior,0),0) AS saldo_anterior_factura, FORMAT(((IFNULL(t1.saldo_anterior,0)+t1.valor_total)-IFNULL(t1.total_anticipos,0)),0) AS total_factura,  FORMAT(IFNULL(t1.total_anticipos,0),0) AS total_anticipos, DATE_FORMAT(NOW(),"%Y-%m-%d %H:%i:%s") AS fecha_impresion
  FROM facturas t1 
      INNER JOIN personas t3 ON t3.id = t1.id_persona 
  WHERE t1.id = ?`,[id]);

  headBill = headBill[0];
  
  let [bodyBill] = await pool.query(`SELECT 
    CONCAT(t1.descripcion,'-',t2.nombre) AS descripcion, 
    FORMAT(t1.total,0) As causado,
    CONCAT(t3.numero_interno_unidad,DATE_FORMAT(t1.created_at,"%m"),SUBSTRING(YEAR(CURRENT_DATE()), 3, 2)) AS referencia,
    ROUND(IFNULL(t3.area,0),2) As area,
    ROUND((IFNULL(t3.coeficiente,0)*100),2) AS coeficiente,
    FORMAT(IFNULL(t1.saldo_anterior,0),0) AS saldo_anterior,
    FORMAT((IFNULL(t1.saldo_anterior,0)+t1.total),0) AS total
  FROM factura_detalles t1 
    INNER JOIN conceptos_facturacion t2 ON t2.id = t1.id_concepto_factura
    INNER JOIN inmuebles t3 ON t3.id = t1.id_inmueble
  WHERE t1.id_factura = ?`,[id]);
  
  let bodyBillHTML = [];

  bodyBill.map(billB=>{
      bodyBillHTML.push(`<tr>
          <td>${billB.referencia}</td>
          <td>${billB.descripcion}</td>
          <td>${billB.area}</td>
          <td>${billB.coeficiente}</td>
          <td style="text-align: right;">$ ${billB.saldo_anterior}</td>
          <td style="text-align: right;">$ ${billB.causado}</td>
          <td style="text-align: right;">$ ${billB.total}</td>
      </tr>`);
  });

  bodyBillHTML = bodyBillHTML.join(" ");

  let razonSocial = await getSysEnv({
      name: 'razon_social',
      pool: pool
  });
  
  let nit = await getSysEnv({
      name: 'nit',
      pool: pool
  });
  
  let direccion = await getSysEnv({
      name: 'direccion',
      pool: pool
  });

  let telefono = await getSysEnv({
      name: 'telefono',
      pool: pool
  });
  
  let email = await getSysEnv({
      name: 'email',
      pool: pool
  });

  let textoCuentaCobro = await getSysEnv({
      name: 'texto_cuenta_cobro',
      pool: pool
  });
  
  let options = { width: '21.59 cm', height: '13.97 cm',  printBackground: true};
  
  let htmlContent = `<!DOCTYPE html>
  <html>
  <head>
    <title>Cuenta de Cobro</title>
    <style>
      body {
        font-family: Arial, sans-serif;
      }
      .header {
        display: flex;
        text-align: center;
        margin-bottom: 20px;
        border: 1px solid #dddddd;
        border-radius: 15px;
        padding: 10px;
        background-color: #171f42;
      }
      .header div {
        width: 75%;
        text-align: center;
      }
      .header img {
        width: 100px;
        height: 100px;
        border-radius: 15px;
        margin-left: 10px;
      }
      .header p {
        margin: 0;
        color: #FFFFFF!important;
      }
      .sub-header{
        width: 100%;
      }
      .sub-header table tbody tr td{
        padding: 5px;
        font-size: 12px;
      }
      .sub-header table tbody tr td b{
        color: #171F42;
      }
      .contact-info {
        text-align: right;
        margin-bottom: 20px;
      }
      .table {
        width: 100%;
        border-collapse: collapse;
      }
      .table th, .table td {
        border: 1px solid #ccc;
        padding: 8px;
        font-size: 11px;
      }
      .table th {
        background-color: #171f42;
      }
      .table thead tr th {
        color: #FFFFFF!important;
      }
      .totals {
        text-align: right;
        margin-top: 20px;
      }
      .watermark {
        position: absolute;
        bottom: 40%;
        right: 12%;
        z-index: 1;
        opacity: 0.3;
        transform: rotate(-45deg);
        font-size: 130px;
        color: #ff5959;
      }
    </style>
  </head>
  <body>
    <div class="header">
      ${logoCompany?`<img src='${logoCompany}' />`:``}
      <div ${!logoCompany?`style='width: 100%;'`:``}>
        <p><b>${razonSocial}</b></p>
        <p><b>NIT:</b> ${nit}</p>
        <p><b>Dirección:</b> ${direccion}</p>
        <p><b>Teléfono:</b> ${telefono}</p>
        <p><b>Email:</b> ${email}</p>
      </div>
    </div>
    <div class="sub-header">
      <table>
        <tbody>
          <tr>
              <td><b>Período:</b> ${headBill.periodo}</td>
              <td><b>Fecha:</b> ${headBill.fecha}</td>
              <td><b>Cuenta Cobro Nº:</b> ${headBill.cuenta_cobro_num}</td>
          </tr>
          <tr>
              <td colspan="2"><b>Responsable:</b> ${headBill.persona_nombre}</td>
              <td colspan="2"><b>E-mail:</b> ${headBill.persona_email}</td>
          </tr>
        </tbody>
      </table>
    </div>
    <br />
    <table class="table">
      <thead>
        <tr>
          <th>Referencia</th>
          <th>Descripción</th>
          <th>Área</th>
          <th>Coeficiente</th>
          <th>Saldo</th>
          <th>Causado</th>
          <th>Total</th>
        </tr>
      </thead>
      <tbody>
        ${bodyBillHTML}
      </tbody>
    </table>
    <div class="totals">
      <p><b>Saldo Anterior:</b> $ ${headBill.saldo_anterior_factura}</p>
      <p ${headBill.total_anticipos=="0"?"style='display: none;'":""}><b>Total Anticipos:</b> $ ${headBill.total_anticipos}</p>
      <p><b>Total Adeudado:</b> $ ${headBill.total_factura}</p>
    </div>

    ${headBill.estado==0?'<div class="watermark">ANULADA</div>':''}
      
    <b style="color:#000;">${textoCuentaCobro}</b>
    <br />
    <br />
   
    <div style='display: flex;'>
      <p style="font-size: 12px;width: 50%;">Consulte su cuenta de cobro en http://www.maximoph.com/</p>
      <p style="font-size: 12px;width: 50%;text-align: right;">Fecha Impresión: ${headBill.fecha_impresion}</p>
    <div>
    </body>
  </html>`

  let file = { content: htmlContent };
  
  let pdf = await html_to_pdf.generatePdf(file, options);

  return pdf;
};

const genBillsPDF = async (id, fisico, pool, req) => {
  
  let logoCompany = await getLogoCompany({
    pool,
    id: req.user.id_cliente
  });

  if(logoCompany){
    logoCompany = (process.env.REACT_API_URL||'https://api.maximoph.com')+"/uploads/company-logo/"+logoCompany;
  }

  let razonSocial = await getSysEnv({
      name: 'razon_social',
      pool: pool
  });
  
  let nit = await getSysEnv({
      name: 'nit',
      pool: pool
  });
  
  let direccion = await getSysEnv({
      name: 'direccion',
      pool: pool
  });

  let telefono = await getSysEnv({
      name: 'telefono',
      pool: pool
  });
  
  let email = await getSysEnv({
      name: 'email',
      pool: pool
  });

  let textoCuentaCobro = await getSysEnv({
      name: 'texto_cuenta_cobro',
      pool: pool
  });
  
  let options = { width: '21.59 cm', height: '13.97 cm',  printBackground: true};

  let [historyBills] = await pool.query(`SELECT * FROM factura_ciclica_historial_detalle WHERE id_factura_ciclica = ?`,[id]);
  let billsPDF = [];

  await Promise.all(historyBills.map(async bill=>{
    let [headBill] = await pool.query(`SELECT 
      DATE_FORMAT(t1.created_at, '%m %Y') AS periodo, t1.estado, DATE_FORMAT(t1.created_at, '%Y-%m-%d') AS fecha, t1.id_inmueble AS codigo_inmueble, t1.consecutivo As cuenta_cobro_num, CONCAT(FORMAT(t3.numero_documento,0),' ',t3.primer_nombre,' ',t3.segundo_nombre,' ',t3.primer_apellido,' ',t3.segundo_apellido) AS persona_nombre, t3.email As persona_email, FORMAT(IFNULL(t1.saldo_anterior,0),0) AS saldo_anterior_factura, FORMAT(((IFNULL(t1.saldo_anterior,0)+t1.valor_total)-IFNULL(t1.total_anticipos,0)),0) AS total_factura,  FORMAT(IFNULL(t1.total_anticipos,0),0) AS total_anticipos, DATE_FORMAT(NOW(),"%Y-%m-%d %H:%i:%s") AS fecha_impresion
    FROM facturas t1 
        INNER JOIN personas t3 ON t3.id = t1.id_persona 
    WHERE t1.id = ? ${fisico==1 ? 'AND 1 = 1' : ''}`,[bill.id_factura]);

    if(headBill.length){
      headBill = headBill[0];

      let [bodyBill] = await pool.query(`SELECT 
          CONCAT(t1.descripcion,'-',t2.nombre) AS descripcion, 
          FORMAT(t1.total,0) As causado,
          CONCAT(t3.numero_interno_unidad,DATE_FORMAT(t1.created_at,"%m"),SUBSTRING(YEAR(CURRENT_DATE()), 3, 2)) AS referencia,
          ROUND(IFNULL(t3.area,0),2) As area,
          ROUND((IFNULL(t3.coeficiente,0)*100),2) AS coeficiente,
          FORMAT(IFNULL(t1.saldo_anterior,0),0) AS saldo_anterior,
          FORMAT((IFNULL(t1.saldo_anterior,0)+t1.total),0) AS total
      FROM factura_detalles t1 
          INNER JOIN conceptos_facturacion t2 ON t2.id = t1.id_concepto_factura
          INNER JOIN inmuebles t3 ON t3.id = t1.id_inmueble
      WHERE t1.id_factura = ?`,[bill.id_factura]);

      let bodyBillHTML = [];

      bodyBill.map(billB=>{
        bodyBillHTML.push(`<tr>
                <td>${billB.referencia}</td>
                <td>${billB.descripcion}</td>
                <td>${billB.area}</td>
                <td>${billB.coeficiente}</td>
                <td style="text-align: right;">$ ${billB.saldo_anterior}</td>
                <td style="text-align: right;">$ ${billB.causado}</td>
                <td style="text-align: right;">$ ${billB.total}</td>
            </tr>`);
      });

      bodyBillHTML = bodyBillHTML.join(" ");

      billsPDF.push(`<!DOCTYPE html>
      <html>
      <head>
        <title>Cuenta de Cobro</title>
        <style>
          body {
            font-family: Arial, sans-serif;
          }
          .header {
            display: flex;
            text-align: center;
            margin-bottom: 20px;
            border: 1px solid #dddddd;
            border-radius: 15px;
            padding: 10px;
            background-color: #171f42;
          }
          .header div {
            width: 75%;
            text-align: center;
          }
          .header img {
            width: 100px;
            height: 100px;
            border-radius: 15px;
            margin-left: 10px;
          }
          .header p {
            margin: 0;
            color: #FFFFFF;
          }
          .sub-header{
            width: 100%;
          }
          .sub-header table tbody tr td{
            padding: 5px;
            font-size: 11px;
          }
          .sub-header table tbody tr td b{
            color: #171F42;
          }
          .contact-info {
            text-align: right;
            margin-bottom: 20px;
          }
          .table {
            width: 100%;
            border-collapse: collapse;
          }
          .table th, .table td {
            border: 1px solid #ccc;
            font-size: 11px;
            padding: 4px;
          }
          .table th {
            background-color: #171f42;
          }
          .table thead tr th {
            color: #FFFFFF!important;
          }
          .totals {
            text-align: right;
            margin-top: 20px;
            font-size: 14px;
          }
          .watermark {
            position: absolute;
            bottom: 40%;
            right: 12%;
            z-index: 1;
            opacity: 0.3;
            transform: rotate(-45deg);
            font-size: 130px;
            color: #ff5959;
          }
        </style>
      </head>
      <body>
        <div class="header">
          ${logoCompany?`<img src='${logoCompany}' />`:``}
          <div ${!logoCompany?`style='width: 100%;'`:``}>
            <p><b>${razonSocial}</b></p>
            <p><b>NIT:</b> ${nit}</p>
            <p><b>Dirección:</b> ${direccion}</p>
            <p><b>Teléfono:</b> ${telefono}</p>
            <p><b>Email:</b> ${email}</p>
          </div>
        </div>
        <div class="sub-header">
          <table>
            <tbody>
              <tr>
                  <td><b>Período:</b> ${headBill.periodo}</td>
                  <td><b>Fecha:</b> ${headBill.fecha}</td>
                  <td><b>Cuenta Cobro Nº:</b> ${headBill.cuenta_cobro_num}</td>
              </tr>
              <tr>
                  <td colspan="2"><b>Responsable:</b> ${headBill.persona_nombre}</td>
                  <td colspan="2"><b>E-mail:</b> ${headBill.persona_email}</td>
              </tr>
            </tbody>
          </table>
        </div>
        <br />
        <table class="table">
          <thead>
            <tr>
              <th>Referencia</th>
              <th>Descripción</th>
              <th>Área</th>
              <th>Coeficiente</th>
              <th>Saldo</th>
              <th>Causado</th>
              <th>Total</th>
            </tr>
          </thead>
          <tbody>
            ${bodyBillHTML}
          </tbody>
        </table>
        <div class="totals">
          <p><b>Saldo Anterior:</b> $ ${headBill.saldo_anterior_factura}</p>
          <p ${headBill.total_anticipos=="0"?"style='display: none;'":""}><b>Total Anticipos:</b> $ ${headBill.total_anticipos}</p>
          <p><b>Total Adeudado:</b> $ ${headBill.total_factura}</p>
        </div>

        ${headBill.estado==0?'<div class="watermark">ANULADA</div>':''}
          
        <b style="color:#000;">${textoCuentaCobro}</b>
        <br />
        <br />
      
        <div style='display: flex;'>
          <p style="font-size: 12px;width: 50%;">Consulte su cuenta de cobro en http://www.maximoph.com/</p>
          <p style="font-size: 12px;width: 50%;text-align: right;">Fecha Impresión: ${headBill.fecha_impresion}</p>
        <div>
        </body>
      </html>`);
    }
  }));
  
  
  let htmlContent = billsPDF.join(' <div style="page-break-after:always;"><br /><br /></div> ');
  
  if(!billsPDF.length) htmlContent = '<div style="text-align: center; font-weight: bold;">NO HAY PERSONAS MARCADAS EN ESTE LOTE POR NOTIFICAR FÍSICAMENTE.</b>'
  
  let file = { content: htmlContent };
  
  let pdf = await html_to_pdf.generatePdf(file, options);

  return pdf;
};

export {
  genBillPDF,
  genSpentPDF,
  genPaymentPDF,
  genBillCashReceiptPDF,
  genPeaceAndSafetyPDF,
  genBillsPDF
};