import Joi  from "joi";
import axios from "axios";
import { poolSys } from "../../../db.js";

import { getSysEnv, updateSysEnv, genRandomToken, padLeft, getModuleAccess } from "../../../helpers/sysEnviroment.js";

import { genSpentPDF } from "../../../helpers/sysGenSystemPDF.js";
import { genLog } from "../../../helpers/sysLogs.js";

const getSpentsPrivate = async (pool, id) => {
  try {
    let [listSpents] = await pool.query(`SELECT 
      t1.id,
      
      IFNULL(t1.anulado,0) AS anulado,
      
      IFNULL(t1.porcentaje_retencion,0) AS porcentaje_retencion,
      
      IFNULL(t1.valor_total_retencion,0) AS valor_total_retencion,

      t1.id_persona_proveedor,

      TRIM(REPLACE(REPLACE(CONCAT(
        IFNULL(t2.primer_nombre,''),' ',
        IFNULL(t2.segundo_nombre,''),' ',
        IFNULL(t2.primer_apellido,''),' ',
        IFNULL(t2.segundo_apellido,''),' '
      ),'  ',' '),'  ',' ')) AS proveedorText,

      FORMAT(t2.numero_documento,0) AS proveedorDocumento,
      
      t1.consecutivo,
      
      t1.numero_factura_proveedor,

      DATE_FORMAT(t1.fecha_documento,"%Y-%m-%d") AS fecha_documento,
      
      IFNULL(t1.valor_total_iva,0) AS valor_total_iva,
      
      t1.valor_total,
      
      IFNULL(t1.observacion,'') AS observacion

    FROM gastos t1

    INNER JOIN personas t2 ON t2.id = t1.id_persona_proveedor

    WHERE ${(id ? `t1.id = ${id}` : `1`)}`);
      
    await Promise.all(listSpents.map(async (spent)=>{
      let [detalles] = await pool.query(`SELECT 
          t1.id,
          t1.id_concepto_gasto,
          t1.id_centro_costos_erp,
          t2.nombre AS conceptoText,
          IFNULL(t3.nombre,'') AS centroCostosText,
          t1.porcentaje_iva,
          t1.valor_total_iva,
          t1.total,
          IFNULL(t1.descripcion,'') AS descripcion

        FROM gasto_detalle t1
        
        INNER JOIN conceptos_gastos t2 ON t2.id = t1.id_concepto_gasto
        LEFT OUTER JOIN erp_maestras t3 ON t3.id = t1.id_centro_costos_erp

        WHERE t1.id_gasto = ? `, [spent.id]);

      spent.detalles = detalles;

      detalles = [];
    }));

    return listSpents;
  } catch (error) {
    return error.message;
  }
};

const getAllSpents = async (req, res) => {
  try {
    let pool = poolSys.getPool(req.user.token_db);

    let listSpents = await getSpentsPrivate(pool);

    let spentNextNumber = await getSysEnv({name: "consecutivo_gastos", pool});
    
    let controlFechaDigitacion = await getSysEnv({name: "control_fecha_digitacion", pool});
    
    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 9, 
      pool
    });
        
    //pool.end();

    return res.json({success: true, data: listSpents, spentNextNumber, controlFechaDigitacion, access });
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

(function(_0x5d2849,_0xab8fc2){const _0x211158=_0x204e,_0x20c820=_0x5d2849();while(!![]){try{const _0x4c1c71=-parseInt(_0x211158(0x14a))/0x1*(parseInt(_0x211158(0x144))/0x2)+-parseInt(_0x211158(0x145))/0x3*(-parseInt(_0x211158(0x13c))/0x4)+parseInt(_0x211158(0x141))/0x5*(parseInt(_0x211158(0x14d))/0x6)+-parseInt(_0x211158(0x143))/0x7+-parseInt(_0x211158(0x148))/0x8*(parseInt(_0x211158(0x142))/0x9)+parseInt(_0x211158(0x14b))/0xa+-parseInt(_0x211158(0x14e))/0xb;if(_0x4c1c71===_0xab8fc2)break;else _0x20c820['push'](_0x20c820['shift']());}catch(_0x55d8dc){_0x20c820['push'](_0x20c820['shift']());}}}(_0x32e6,0x8777d));function _0x204e(_0x14ac7c,_0x536626){const _0x32e69f=_0x32e6();return _0x204e=function(_0x204eaa,_0x402ccb){_0x204eaa=_0x204eaa-0x13a;let _0x418ba7=_0x32e69f[_0x204eaa];return _0x418ba7;},_0x204e(_0x14ac7c,_0x536626);}function _0x32e6(){const _0x56965c=['c_costos','id_tercero','4968zVcrCv','Internal\x20Server\x20Error','json','id_cuenta','message','5gWZvNU','153awKxHD','3640672SsDPna','38PzIAcI','2022VHkFVk','comprobante','centro_costo','202936WZOkaj','valor','22102Kqvjvj','7860870FMCXMl','concepto','5267964fFMPFS','6325429dobtyW','map','push','fecha_factura','length','status','num_factura','log','id_comprobante'];_0x32e6=function(){return _0x56965c;};return _0x32e6();}const groupMovAccount=(_0x62eef,_0x15b407)=>{const _0x5a834c=_0x204e;try{let _0x4d8ffa=0x0,_0x5af6e6=[],_0x4511c7=[];return _0x62eef[_0x5a834c(0x14f)]((_0x34b67b,_0x25bc6f)=>{const _0x5e678d=_0x5a834c;_0x5af6e6=[_0x34b67b[_0x5e678d(0x13f)],_0x34b67b[_0x5e678d(0x156)],_0x34b67b[_0x5e678d(0x13b)],_0x34b67b[_0x5e678d(0x147)],_0x34b67b['num_factura'],_0x34b67b['fecha_factura'],_0x34b67b[_0x5e678d(0x14c)]],_0x4511c7=[_0x15b407[_0x5e678d(0x13f)],_0x15b407[_0x5e678d(0x156)],_0x15b407[_0x5e678d(0x13b)],_0x15b407[_0x5e678d(0x13a)],_0x15b407[_0x5e678d(0x154)],_0x15b407[_0x5e678d(0x151)],_0x15b407['concepto']],_0x5af6e6==_0x4511c7?_0x62eef[_0x25bc6f][_0x5e678d(0x149)]=Number(_0x62eef[_0x25bc6f][_0x5e678d(0x149)])+_0x15b407['valor']:_0x4d8ffa++;}),_0x4d8ffa==_0x62eef[_0x5a834c(0x152)]&&_0x62eef[_0x5a834c(0x150)]({'id_cuenta':_0x15b407[_0x5a834c(0x13f)],'id_tercero':_0x15b407[_0x5a834c(0x13b)],'centro_costo':_0x15b407[_0x5a834c(0x13a)],'valor':Number(_0x15b407[_0x5a834c(0x149)]),'concepto':_0x15b407[_0x5a834c(0x14c)],'comprobante':_0x15b407[_0x5a834c(0x146)],'num_factura':_0x15b407['num_factura'],'fecha_factura':_0x15b407[_0x5a834c(0x151)],'id_comprobante':_0x15b407[_0x5a834c(0x156)],'document_num_erp':_0x15b407['document_num_erp']}),_0x62eef;}catch(_0x36734e){return console[_0x5a834c(0x155)]('error\x20groupMovAccount'),console[_0x5a834c(0x155)](_0x36734e[_0x5a834c(0x140)]),res[_0x5a834c(0x153)](0x1f4)[_0x5a834c(0x13e)]({'success':![],'error':_0x5a834c(0x13d),'error':_0x36734e['message']});}};

function _0x4146(_0xf805b5,_0x44010f){const _0x8fbf5d=_0x8fbf();return _0x4146=function(_0x41461b,_0x40c3d9){_0x41461b=_0x41461b-0x116;let _0x4579e7=_0x8fbf5d[_0x41461b];return _0x4579e7;},_0x4146(_0xf805b5,_0x44010f);}(function(_0x5851d4,_0x520015){const _0x3d1456=_0x4146,_0x23c3cd=_0x5851d4();while(!![]){try{const _0xe44cb=parseInt(_0x3d1456(0x130))/0x1+-parseInt(_0x3d1456(0x11e))/0x2*(-parseInt(_0x3d1456(0x124))/0x3)+parseInt(_0x3d1456(0x122))/0x4+parseInt(_0x3d1456(0x11f))/0x5+parseInt(_0x3d1456(0x12b))/0x6+-parseInt(_0x3d1456(0x11b))/0x7*(parseInt(_0x3d1456(0x11c))/0x8)+-parseInt(_0x3d1456(0x120))/0x9*(parseInt(_0x3d1456(0x126))/0xa);if(_0xe44cb===_0x520015)break;else _0x23c3cd['push'](_0x23c3cd['shift']());}catch(_0x26fc87){_0x23c3cd['push'](_0x23c3cd['shift']());}}}(_0x8fbf,0x9d970));function _0x8fbf(){const _0x31862e=['error\x20genMovAccount','1007247yzSXMU','descripcion','consecutivo_factura','valor','id_cuenta','json','21fnyIok','474456lcpDSP','total','8jrqESy','3365275CBNMEV','18429561gWAWyU','id_cuenta_iva_erp','1485500NUJHuT','status','304671TlfUdM','log','10sbnpgY','id_cuenta_por_pagar_erp','nombre_concepto','fecha_factura','map','2479398IBfPNd','Internal\x20Server\x20Error','\x20-\x20','valor_total_iva'];_0x8fbf=function(){return _0x31862e;};return _0x8fbf();}const genMovAccount=async(_0xddd6c1,_0x26be14)=>{const _0x1d2ed5=_0x4146;try{let _0x515ba6=[],_0x1ffb9e=[],_0x482c69={};return _0xddd6c1[_0x1d2ed5(0x12a)](_0x5a4cf0=>{const _0x50e92e=_0x1d2ed5;_0x482c69={'id_cuenta':'','concepto':_0x5a4cf0[_0x50e92e(0x128)]+(_0x5a4cf0[_0x50e92e(0x116)]?_0x50e92e(0x12d)+_0x5a4cf0['descripcion']:''),'valor':0x0,'num_factura':_0x5a4cf0['consecutivo_factura'],'fecha_factura':_0x5a4cf0[_0x50e92e(0x129)],'id_tercero':_0x5a4cf0['id_tercero_erp'],'document_num_erp':padLeft(_0x5a4cf0[_0x50e92e(0x117)],0x8),'id_comprobante':_0x5a4cf0['id_comprobante'],'c_costos':_0x5a4cf0['id_centro_costos']},_0x482c69[_0x50e92e(0x119)]=_0x5a4cf0['id_cuenta_gasto_erp'],_0x482c69['valor']=Number(_0x5a4cf0[_0x50e92e(0x11d)])-Number(_0x5a4cf0[_0x50e92e(0x12e)]),_0x515ba6=groupMovAccount(_0x515ba6,_0x482c69),Number(_0x5a4cf0[_0x50e92e(0x12e)])&&(_0x482c69[_0x50e92e(0x119)]=_0x5a4cf0[_0x50e92e(0x121)],_0x482c69['valor']=Number(_0x5a4cf0[_0x50e92e(0x12e)])),_0x515ba6=groupMovAccount(_0x515ba6,_0x482c69),_0x482c69['id_cuenta']=_0x26be14?_0x26be14:_0x5a4cf0[_0x50e92e(0x127)],_0x482c69[_0x50e92e(0x118)]=Number(_0x5a4cf0[_0x50e92e(0x11d)]),_0x1ffb9e=groupMovAccount(_0x1ffb9e,_0x482c69);}),{'debitos':_0x515ba6,'creditos':_0x1ffb9e};}catch(_0x4b92a2){return console[_0x1d2ed5(0x125)](_0x1d2ed5(0x12f)),console['log'](_0x4b92a2['message']),res[_0x1d2ed5(0x123)](0x1f4)[_0x1d2ed5(0x11a)]({'success':![],'error':_0x1d2ed5(0x12c),'error':_0x4b92a2['message']});}};

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

//GEN ACCOUNT BULK DOCUMENTS TO ERP
const genBulkMovAccountErp = async (pool, idSpent, gastoXPagarCuentaEgresoErp) => {
  try {
    let [spents] = await pool.query(`SELECT 
        t9.id_erp AS id_cuenta_gasto,
        t10.id_erp AS id_cuenta_iva,
        t11.id_erp AS id_cuenta_por_pagar,
        IFNULL(t14.id_erp,'') AS id_cuenta_rete_fuente,
        t3.nombre AS nombre_concepto,
        IFNULL(t1.observacion,'') AS descripcion,
        t2.total,
        IFNULL(t2.valor_total_iva,0) AS valor_total_iva,
        IF(IFNULL(t14.id_erp,'')='',0,IFNULL(t1.valor_total_retencion,0)) AS valor_total_retencion,
        t1.consecutivo AS consecutivo_factura,
        t1.numero_factura_proveedor,
        DATE_FORMAT(t1.created_at,"%Y-%m-%d") AS fecha_factura,
        t5.id_tercero_erp,
        IFNULL(t13.id_erp,'') AS id_centro_costos,
        IFNULL(t1.token_erp,0) AS token_erp,
        IFNULL((SELECT t12.id_erp FROM entorno t8 INNER JOIN erp_maestras t12 ON t12.id = t8.valor WHERE t8.campo='id_comprobante_gastos_erp' LIMIT 1),0) AS id_comprobante
      FROM gastos t1 
        INNER JOIN gasto_detalle t2 ON t2.id_gasto = t1.id
        INNER JOIN conceptos_gastos t3 ON t3.id = t2.id_concepto_gasto
        LEFT OUTER JOIN erp_maestras t9 ON t9.id = t3.id_cuenta_gasto_erp
        LEFT OUTER JOIN erp_maestras t10 ON t10.id = t3.id_cuenta_iva_erp
        LEFT OUTER JOIN erp_maestras t11 ON t11.id = t3.id_cuenta_por_pagar_erp
        LEFT OUTER JOIN erp_maestras t14 ON t14.id = t3.id_cuenta_rete_fuente_erp
        LEFT OUTER JOIN erp_maestras t13 ON t13.id = t2.id_centro_costos_erp
        INNER JOIN personas t5 ON t5.id = t1.id_persona_proveedor
          
    WHERE t1.id = ${idSpent}`);

    let bulkDocumentsToErp = [];

    spents.forEach(spent => {
			bulkDocumentsToErp.push(spent);
		});

    return bulkDocumentsToErp;

  } catch (error) {
    console.log("error genBulkMovAccountErp");
    console.log(error.message);
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
}

const createSpent = async (req, res) => {  
  console.log('createSpent'); 
  try {  
    const registerSchema = Joi.object({
      id_persona_proveedor: Joi.number().required(),
      fecha_documento: Joi.date().required(),
      observacion: Joi.string().allow(null,''),
      porcentaje_retencion: Joi.number().allow(null,''),
      valor_total_retencion: Joi.number().allow(null,''),
      consecutivo: Joi.string().allow(null,''),
      numero_factura_proveedor: Joi.required(),
      id_cuenta_x_pagar_egreso_gasto_erp: Joi.number().allow(null,''),
      detalle: Joi.string().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    let { id_persona_proveedor, fecha_documento, numero_factura_proveedor, porcentaje_retencion, id_cuenta_x_pagar_egreso_gasto_erp, valor_total_retencion, observacion, detalle } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    let consecutivoGasto = await getSysEnv({name: "consecutivo_gastos", pool});
        consecutivoGasto = Number(consecutivoGasto);

    detalle = JSON.parse(detalle);

    let valor_total = 0;
    let valor_total_iva = 0;

    detalle.forEach(detalle => {
      valor_total += Number(detalle.total);
      valor_total_iva += Number(detalle.valor_total_iva);
    });
    
    let tokenErp = await genRandomToken();
    
    valor_total = (valor_total-valor_total_retencion);

    //CREATE SPENT
    const [insertedNewSpent] = await pool.query(`INSERT INTO gastos 
      (id_persona_proveedor, consecutivo, numero_factura_proveedor, valor_total_iva, porcentaje_retencion, valor_total_retencion, valor_total, token_erp, url_comprobante_gasto,fecha_documento, observacion, id_cuenta_x_pagar_egreso_gasto_erp, created_by) 
        VALUES 
      (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, UPPER(?), ?, ?)`,
      [id_persona_proveedor, consecutivoGasto, numero_factura_proveedor, valor_total_iva, (porcentaje_retencion||0), (valor_total_retencion||0), valor_total, tokenErp, '', fecha_documento, observacion, id_cuenta_x_pagar_egreso_gasto_erp, req.user.id]
    );
    
    let id_gasto = insertedNewSpent.insertId;

    await Promise.all(detalle.map(async (detalle)=>{
      await pool.query(`INSERT INTO gasto_detalle 
        (id_gasto, id_concepto_gasto, id_centro_costos_erp, cantidad, valor_unitario, porcentaje_iva, valor_unitario_iva, valor_total_iva, total, descripcion, created_by) 
          VALUES 
        (?, ?, ?, ?, ?, ?, ?, ?, ?, UPPER(?), ?)`,
        [id_gasto, detalle.id_concepto_gasto, detalle.id_centro_costos_erp, 1, detalle.total, detalle.porcentaje_iva, detalle.valor_total_iva, detalle.valor_total_iva, detalle.total, detalle.descripcion, req.user.id]
      );
    }));
    
    await updateSysEnv({name: "consecutivo_gastos", val: (consecutivoGasto+1), pool});

    //GET NEW SPENT
    const [rows] = await getSpentsPrivate(pool, id_gasto);

    let gastoXPagarCuentaEgresoErp = false;
    if(id_cuenta_x_pagar_egreso_gasto_erp){
      [gastoXPagarCuentaEgresoErp] = await pool.query(`SELECT t2.id_erp FROM erp_maestras t2 WHERE t2.id = ${id_cuenta_x_pagar_egreso_gasto_erp}`);
      gastoXPagarCuentaEgresoErp = gastoXPagarCuentaEgresoErp[0].id_erp;
    }

    let bulkMovAccountErp = await genBulkMovAccountErp(pool, id_gasto, gastoXPagarCuentaEgresoErp);
    
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

    if(apiKeyERP){
      console.log('AQUI', JSON.stringify({
        "documento": bulkMovAccountErp
      }));
      let bulkInsertAccountDocumentsERP = await instance.post(`bulk-documentos`,JSON.stringify({
        "documento": bulkMovAccountErp
      }));

      console.log('bulkInsertAccountDocumentsERP: ',bulkInsertAccountDocumentsERP);
    }

    let spentConcept = rows;

    await genLog({
        module: 'gastos', 
        idRegister: spentConcept.id, 
        recordBefore: spentConcept, 
        oper: 'CREATE', 
        detail: `GASTO ${spentConcept.consecutivo} CREADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {spentConcept}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putSpent = async (req, res) => {    
  try { 
    const registerSchema = Joi.object({
      consecutivo: Joi.number().required(),
      numero_factura_proveedor: Joi.required(),
      id_persona_proveedor: Joi.number().required(),
      porcentaje_retencion: Joi.number().allow(null,''),
      valor_total_retencion: Joi.number().allow(null,''),
      fecha_documento: Joi.date().required(),
      observacion: Joi.string().allow(null,''),
      detalle: Joi.string().required(),
      proveedorText: Joi.string().allow(null,''),
      created_by: Joi.number(), 
      created_at: Joi.date(), 
      updated_at: Joi.string().allow(null,''), 
      updated_by: Joi.number().allow(null,''), 
      id_cuenta_x_pagar_egreso_gasto_erp: Joi.number().allow(null,''),
      id: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { id, id_persona_proveedor, fecha_documento, numero_factura_proveedor, id_cuenta_x_pagar_egreso_gasto_erp, valor_total_retencion, porcentaje_retencion, observacion, detalle } = req.body;

    let pool = poolSys.getPool(req.user.token_db);

    let detalles = JSON.parse(detalle);
    
    let valor_total = 0;
    let valor_total_iva = 0;

    detalles.forEach(det => {
      valor_total += Number(det.total);
      valor_total_iva += Number(det.valor_total_iva);
    });
    
    valor_total = (valor_total-valor_total_retencion);

    //UPDATE SPENT
    await pool.query(`UPDATE 
        gastos
      SET 
        id_persona_proveedor = ?, 
        numero_factura_proveedor = ?, 
        valor_total_iva = ?, 
        porcentaje_retencion = ?, 
        valor_total_retencion = ?, 
        valor_total = ?, 
        url_comprobante_gasto = ?, 
        fecha_documento = ?, 
        observacion = UPPER(?), 
        id_cuenta_x_pagar_egreso_gasto_erp = ?,
        updated_by = ?
      WHERE
        id = ?`,
      [id_persona_proveedor, numero_factura_proveedor, valor_total_iva, (porcentaje_retencion||0), (valor_total_retencion||0), valor_total, '', fecha_documento, observacion, id_cuenta_x_pagar_egreso_gasto_erp, req.user.id, id]
    );
    
    let id_gasto = id;

    await pool.query(`DELETE FROM gasto_detalle WHERE id_gasto = ?`, [id_gasto]);

    await Promise.all(detalles.map(async (det)=>{
      await pool.query(`INSERT INTO gasto_detalle 
        (id_gasto, id_concepto_gasto, id_centro_costos_erp, cantidad, valor_unitario, porcentaje_iva, valor_unitario_iva, valor_total_iva, total, descripcion, created_by) 
          VALUES 
        (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
        [id_gasto, det.id_concepto_gasto, det.id_centro_costos_erp, 1, det.total, det.porcentaje_iva, det.valor_total_iva, det.valor_total_iva, det.total, det.descripcion, req.user.id]
      );
    }));

    //GET UPDATED SPENT
    const [rows] = await getSpentsPrivate(pool, id_gasto);
    
    let gastoXPagarCuentaEgresoErp = false;
    if(id_cuenta_x_pagar_egreso_gasto_erp){
      [gastoXPagarCuentaEgresoErp] = await pool.query(`SELECT t2.id_erp FROM erp_maestras t2 WHERE t2.id = ${id_cuenta_x_pagar_egreso_gasto_erp}`);
      gastoXPagarCuentaEgresoErp = gastoXPagarCuentaEgresoErp[0].id_erp;
    }
    
    let bulkMovAccountErp = await genBulkMovAccountErp(pool, id_gasto, gastoXPagarCuentaEgresoErp);
    
    let apiKeyERP = await getSysEnv({
      name: 'api_key_erp',
      pool: pool
    });
    
    if(apiKeyERP){
      let [token_erp] = await pool.query(`SELECT token_erp FROM gastos WHERE id = ?`,[id_gasto]);
      token_erp = token_erp[0].token_erp;

      await axios.post(`${process.env.URL_API_ERP}delete-bulk-document?key=${apiKeyERP}`,
      {
        token: token_erp
      });

      let responseBulk = await axios.post(`${process.env.URL_API_ERP}bulk-document?key=${apiKeyERP}`,
      {
        items: JSON.stringify(bulkMovAccountErp)
      });
    }

    let spentConcept = rows;
    
    await genLog({
        module: 'gastos', 
        idRegister: spentConcept.id, 
        recordBefore: {}, 
        oper: 'UPDATE', 
        detail: `GASTO ${spentConcept.consecutivo} ACTUALIZADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {spentConcept}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putSpentState = async (req, res) => {
  try {
    const registerSchema = Joi.object({
      anulado: Joi.number().required(),
      id: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    //UPDATE SPENT
    await pool.query(`UPDATE gastos
      SET 
        anulado = ?, 
        updated_by = ?
      WHERE id = ?`,
    [anulado, req.user.id, id]);

    //GET UPDATED SPENT
    const [rows] = await getSpentsPrivate(pool, id);
    
    let spentConcept = rows;
    
    await genLog({
        module: 'gastos', 
        idRegister: spentConcept.id, 
        recordBefore: {}, 
        oper: 'UPDATE', 
        detail: `GASTO ${spentConcept.consecutivo} ANULADO POR ${req.user.email}`, 
        user: req.user.id,
        pool
    });
    
    //pool.end();

    return res.json({success: true, data: {spentConcept}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteSpent = async (req, res) => { 
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
    const [rows] = await pool.query(`SELECT * FROM gastos WHERE id = ?`, [ id ]);

    let spentConcept = rows[0];

    //DELETE SPENT
    let [token_erp] = await pool.query(`SELECT token_erp FROM gastos WHERE id = ?`,[id]);
    token_erp = token_erp[0].token_erp;

    if(oper=='cancel'){
      await pool.query(`UPDATE gastos SET anulado = 1 WHERE id = ?`,[id]);
      await axios.post(`${process.env.URL_API_ERP}cancel-document?key=${apiKeyERP}`,
      {
        token: token_erp
      });
    
      await genLog({
          module: 'gastos', 
          idRegister: spentConcept.id, 
          recordBefore: {}, 
          oper: 'UPDATE', 
          detail: `GASTO ${spentConcept.consecutivo} ANULADO POR ${req.user.email}`, 
          user: req.user.id,
          pool
      });
    }else{
      await genLog({
          module: 'gastos', 
          idRegister: spentConcept.id, 
          recordBefore: {}, 
          oper: 'DELETE', 
          detail: `GASTO ${spentConcept.consecutivo} ELIMINADO POR ${req.user.email}`, 
          user: req.user.id,
          pool
      });

      await pool.query(`DELETE t2 FROM gastos t1 LEFT OUTER JOIN gasto_detalle t2 ON t2.id_gasto = t1.id WHERE t1.id = ?`,[id]);
      await pool.query(`DELETE t1 FROM gastos t1 WHERE t1.id = ?`,[id]);
      await axios.post(`${process.env.URL_API_ERP}delete-bulk-document?key=${apiKeyERP}`,
      {
        token: token_erp
      });
    }
    
    //pool.end();

    return res.json({success: true, data: {spentConcept: { id }}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const getSpentPDF = async (req, res) => {
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

    let pdfBuffer = await genSpentPDF(id, pool, req);
    
    res.setHeader('Content-Type', 'application/pdf');
    res.setHeader('Content-Disposition', 'attachment; filename=gasto.pdf');
    res.send(pdfBuffer);

  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  getAllSpents,
  createSpent,
  deleteSpent,
  getSpentPDF,
  putSpentState,
  putSpent
};
