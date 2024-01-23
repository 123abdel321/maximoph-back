import Joi  from "joi";
import axios from "axios";
import { poolSys } from "../../../db.js";
import { getSysEnv, updateSysEnv, roundValues, genRandomToken, padLeft, getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { sendEmailBillPDF } from "../../../helpers/sysEmailBillPDF.js";
import { genExtractCustomerNit } from "../../../helpers/sysExtractNit.js";
import { sendFBPushMessageUser } from "../../../helpers/firebasePushNotification.js";

import { createUpdatePropertyCyclicalBill } from "../../../helpers/sysPropertyCyclicalBill.js";

const getAllCyclicalBills = async (req, res) => {
  
  try {
    let pool = poolSys.getPool(req.user.token_db);
    
    let { date } = req.query;

    let validateDate = (date=='true' ? true : false);
      
    let admonConcept = await getSysEnv({
      name: 'id_concepto_administracion',
      pool: pool
    });

    let adminConceptParqueadero = await getSysEnv({
        name: 'id_concepto_administracion_parqueadero',
        pool: pool
    });

    let adminConceptCuartoUtil = await getSysEnv({
        name: 'id_concepto_administracion_cuarto_util',
        pool: pool
    });
    
    let interestsConcept = await getSysEnv({
      name: 'id_concepto_intereses',
      pool: pool
    });

    const [cyclicalBills] = await pool.query(`SELECT 
          t1.id_persona as id_persona,
          t1.id_inmueble as id_inmueble,
          t1.fecha_inicio as fecha_inicio,
          t1.fecha_fin as fecha_fin,
          t1.valor_total as valor_total,
          t1.observacion as observacion,
          DATE_FORMAT(t1.fecha_inicio,'%Y-%m-%d') AS fecha_inicio,
          DATE_FORMAT(t1.fecha_fin,'%Y-%m-%d') AS fecha_fin,
        CONCAT(t3.nombre,' - ',t2.numero_interno_unidad) AS inmuebleText,
        CONCAT(t2.area) AS areaText,
        (IFNULL(t2.coeficiente,0)*100) AS coeficiente,
        t3.nombre AS zonaText,
        (SELECT COUNT(t4.id) FROM factura_ciclica_detalles t4 WHERE t4.id_factura_ciclica = t1.id) AS conceptosText,
        FORMAT(t4.numero_documento,0) AS personaDocumento,
        TRIM(REPLACE(REPLACE(CONCAT(
          IFNULL(t4.primer_nombre,''),' ',
          IFNULL(t4.segundo_nombre,''),' ',
          IFNULL(t4.primer_apellido,''),' ',
          IFNULL(t4.segundo_apellido,''),' '
        ),'  ',' '),'  ',' ')) AS personaText,
        IF(t5.tipo='0','PROPIETARIO:','INQUILINO:') AS personaTipo,
        CONCAT(t5.porcentaje_administracion,' %') AS personaPorcentaje,
        DATE_FORMAT(t1.created_at,'%Y-%m-%d') AS created_format,
        IFNULL(t1.valor_total,0) AS valor_total_sum,
        t6.id_concepto_factura,
        CONCAT(t7.id,' - ',t7.nombre) AS conceptoText,
        IF(t6.id_concepto_factura='${admonConcept}',1,
          IF(t6.id_concepto_factura='${interestsConcept}',1,
            IF(t6.id_concepto_factura='${adminConceptParqueadero}',1,
              IF(t6.id_concepto_factura='${adminConceptCuartoUtil}',1,0
              )
            )
          )
        ) AS concepto_bloqueado
      FROM facturas_ciclica t1 
        INNER JOIN inmuebles t2 ON t2.id = t1.id_inmueble
        INNER JOIN zonas t3 ON t3.id = t2.id_inmueble_zona 
        LEFT OUTER JOIN personas t4 ON t4.id = t1.id_persona 
        LEFT OUTER JOIN inmueble_personas_admon t5 ON t5.id_persona = t1.id_persona AND t5.id_inmueble = t2.id
        LEFT OUTER JOIN factura_ciclica_detalles t6 ON t6.id_factura_ciclica = t1.id
        LEFT OUTER JOIN conceptos_facturacion t7 ON t7.id = t6.id_concepto_factura
      WHERE
        ${validateDate?`(DATE_FORMAT(NOW(),'%Y-%m-%d')>=t1.fecha_inicio OR DATE_FORMAT(NOW(),'%Y-%m-%d')<=t1.fecha_fin)`:'1=1'}
        ${validateDate?`GROUP BY id_persona, id_inmueble`:''}
      ORDER BY t1.id ASC
      `);

      let stricted = await getSysEnv({
        name: 'validacion_estricta_area',
        pool: pool
      });
      
      let periodoFacturacion = await getSysEnv({
        name: 'periodo_facturacion',
        pool: pool
      });
        
      let [totalsPersons] = await pool.query(
          `SELECT 
              t1.id,
              (SELECT IFNULL(t4.valor,0) FROM entorno t4 WHERE t4.campo='numero_total_unidades') AS unidades_entorno,
              (SELECT IFNULL(t3.valor,0) FROM entorno t3 WHERE t3.campo='valor_total_presupuesto_year_actual') AS ppto_entorno
          FROM facturas_ciclica t1
          WHERE
            ${validateDate?`(DATE_FORMAT(NOW(),'%Y-%m-%d')>=t1.fecha_inicio OR DATE_FORMAT(NOW(),'%Y-%m-%d')<=t1.fecha_fin)`:'1=1'}
          GROUP BY t1.id_persona`);
      
      let [totalsProperties] = await pool.query(
          `SELECT 
              t1.id
          FROM facturas_ciclica t1
            INNER JOIN inmuebles t2 ON t2.id = t1.id_inmueble AND t2.eliminado = 0
          WHERE
            ${validateDate?`(DATE_FORMAT(NOW(),'%Y-%m-%d')>=t1.fecha_inicio OR DATE_FORMAT(NOW(),'%Y-%m-%d')<=t1.fecha_fin)`:'1=1'}
          GROUP BY t1.id_inmueble`);
          
      let [totalsBIll] = await pool.query(
          `SELECT 
            SUM(t1.valor_total) AS valor_total_facturas 
          FROM facturas_ciclica t1
          INNER JOIN inmuebles t2 ON t2.id = t1.id_inmueble AND t2.eliminado = 0
          WHERE 
            ${validateDate?`(DATE_FORMAT(NOW(),'%Y-%m-%d')>=t1.fecha_inicio OR DATE_FORMAT(NOW(),'%Y-%m-%d')<=t1.fecha_fin)`:'1=1'}`);
          totalsBIll = totalsBIll[0].valor_total_facturas;

      let [totalsPropertiesPercentDiff] = await pool.query(
          `SELECT 
              GROUP_CONCAT(t1.numero_interno_unidad,'') As numbers
          FROM inmuebles t1
          WHERE
            (SELECT SUM(IFNULL(t2.porcentaje_administracion,0)) FROM inmueble_personas_admon t2 WHERE t2.id_inmueble = t1.id) <> 100`);

      let newTotals = {
        facturas_ingresadas: 0,
        unidades_ingresadas: totalsProperties.length,
        unidades_admon_diff: totalsPropertiesPercentDiff[0].numbers,
        unidades_entorno: 0,
        valor_total_facturas: totalsBIll,
        coeficiente_ingresado: 0,
        coeficiente_entorno: 100,
        valor_total_administracion: 0,
        ppto_entorno: 0
      };

      newTotals.facturas_ingresadas = totalsPersons.length;
      newTotals.ppto_entorno = totalsPersons[0]?.ppto_entorno;
      newTotals.unidades_entorno = totalsPersons[0]?.unidades_entorno;
      
      let totals = newTotals;
      const [totals_coeficiente] = await pool.query(
          `SELECT 
              SUM(DISTINCT IFNULL(t6.coeficiente,0)*100) As coe 
            FROM facturas_ciclica t4 
              INNER JOIN inmuebles t6 ON t6.id = t4.id_inmueble
            WHERE
              ${validateDate?`(DATE_FORMAT(NOW(),'%Y-%m-%d')>=t4.fecha_inicio OR DATE_FORMAT(NOW(),'%Y-%m-%d')<=t4.fecha_fin)`:'1=1'}
            GROUP BY t6.id;`);
      totals_coeficiente.map(coe=>{
        totals.coeficiente_ingresado += Number(coe.coe);
      });

      const [all_concepts] = await pool.query(
          `SELECT 
            t2.nombre AS nombre_concepto, 
            SUM(t1.total) AS total_concepto 
            FROM facturas_ciclica t3
              INNER JOIN factura_ciclica_detalles t1 ON t1.id_factura_ciclica = t3.id
              INNER JOIN conceptos_facturacion t2 ON t2.id = t1.id_concepto_factura
              INNER JOIN inmuebles t4 ON t4.id = t3.id_inmueble
            WHERE t1.id_concepto_factura NOT IN (?,?,?) AND
            t4.eliminado = 0 AND
            ${validateDate?`(DATE_FORMAT(NOW(),'%Y-%m-%d')>=t3.fecha_inicio OR DATE_FORMAT(NOW(),'%Y-%m-%d')<=t3.fecha_fin)`:'1=1'}
            GROUP BY t1.id_concepto_factura
          `,[admonConcept,adminConceptParqueadero,adminConceptCuartoUtil]);
      
      const [admonSumValue] = await pool.query(
          `SELECT 
            t2.nombre AS nombre_concepto, 
            SUM(t1.total) AS total_concepto 
            FROM facturas_ciclica t3
              INNER JOIN factura_ciclica_detalles t1 ON t1.id_factura_ciclica = t3.id
              INNER JOIN conceptos_facturacion t2 ON t2.id = t1.id_concepto_factura AND t1.id_concepto_factura IN (?,?,?)
              INNER JOIN inmuebles t4 ON t4.id = t3.id_inmueble
            WHERE 
            t4.eliminado = 0 AND
            ${validateDate?`(DATE_FORMAT(NOW(),'%Y-%m-%d')>=t3.fecha_inicio OR DATE_FORMAT(NOW(),'%Y-%m-%d')<=t3.fecha_fin)`:'1=1'}
          `,[admonConcept,adminConceptParqueadero,adminConceptCuartoUtil]);
      
      totals.concepts = all_concepts;
      
      totals.valor_total_administracion = admonSumValue[0].total_concepto;

    const currentDate = new Date();
    const currentYear = currentDate.getFullYear();
    const currentMonth = (currentDate.getMonth() + 1).toString().padStart(2, '0');
    const dateFormat = `${currentYear}-${currentMonth}`;

    const [doneExported] = await pool.query(`SELECT * FROM factura_ciclica_historial WHERE created_at LIKE ? AND estado = 1`,[dateFormat+'%']);
    
    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 6, 
      pool
    });
    
    //pool.end();

    return res.json({success: true, data: cyclicalBills, totals: totals, exported: doneExported, stricted, periodoFacturacion, access});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error });
  }
};

const createCyclicalBill = async (req, res) => {
  try {
    const registerSchema = Joi.object({
        id_inmueble: Joi.number().required(), 
        id_concepto: Joi.number().required(), 
        id_persona: Joi.number().required(), 
        fecha_inicio: Joi.date().required(), 
        fecha_fin: Joi.date().allow(null,''),
        valor_total: Joi.number().allow(null,''),
        observacion: Joi.string().allow(null,'')
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(401).json({ success: false, error: error.message });
    }

    let { id_inmueble, id_concepto, id_persona, fecha_inicio, fecha_fin, valor_total, observacion } = req.body;

    fecha_inicio = fecha_inicio.split("T")[0];
    fecha_fin = fecha_fin ? fecha_fin.split("T")[0] : fecha_fin;

    let pool = poolSys.getPool(req.user.token_db);

    valor_total = await roundValues({
      val: valor_total,
      pool
    });

    //CREATE CYCLICAL BILLING
    const [insertedNewCyclicalBill] = await pool.query(`INSERT INTO facturas_ciclica 
            (id_inmueble, id_persona, fecha_inicio, fecha_fin, valor_total, observacion, created_by) 
                VALUES 
            (?, ?, ?, ?, ?, UPPER(?), ?)`,
      [id_inmueble, id_persona, fecha_inicio, (fecha_fin||null), valor_total, observacion, req.user.id]
    );
    
    //CREATE CYCLICAL BILLING DETAIL
    await pool.query(`INSERT INTO factura_ciclica_detalles 
      (id_factura_ciclica, id_concepto_factura, cantidad, valor_unitario, total, descripcion, created_by) 
          VALUES 
      (?, ?, ?, ?, ?, UPPER(?), ?)`,
      [insertedNewCyclicalBill.insertId, id_concepto, 1, valor_total, valor_total, observacion, req.user.id]
    );
    
    //GET NEW CYCLICAL BILLING
    const [rows] = await pool.query(`SELECT 
      t1.*,
      DATE_FORMAT(t1.fecha_inicio,'%Y-%m-%d') AS fecha_inicio,
      DATE_FORMAT(t1.fecha_fin,'%Y-%m-%d') AS fecha_fin,
      CONCAT(t3.nombre,' - ',t2.numero_interno_unidad) AS inmuebleText,
      t3.nombre AS zonaText,
      (SELECT COUNT(t4.id) FROM factura_ciclica_detalles t4 WHERE t4.id_factura_ciclica = t1.id) AS conceptosText,
      CONCAT(
        t4.numero_documento,' - ',
        IFNULL(t4.primer_nombre,''),' ',
        IFNULL(t4.segundo_nombre,''),' ',
        IFNULL(t4.primer_apellido,''),' ',
        IFNULL(t4.segundo_apellido,''),' '
      ) AS personaText
    FROM facturas_ciclica t1 
      INNER JOIN inmuebles t2 ON t2.id = t1.id_inmueble
      INNER JOIN zonas t3 ON t3.id = t2.id_inmueble_zona 
      INNER JOIN personas t4 ON t4.id = t1.id_persona 
    WHERE
      t1.id = ?`, [ insertedNewCyclicalBill.insertId ]);
    
    let newCyclicalBill = rows[0];
    
    //pool.end();

    return res.json({success: true, data: { newCyclicalBill }});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const createCyclicalBillMassive = async (req, res) => {
  try {
    const registerSchema = Joi.object({
        tipo_concepto_masivo: Joi.number().required(), 
        tipo_inmueble_masivo: Joi.number().required(), 
        id_concepto_masivo: Joi.number().required(), 
        fecha_inicio: Joi.date().allow(null,''), 
        fecha_fin: Joi.date().allow(null,''),
        valor: Joi.number().required(),
        descripcion: Joi.string().allow(null,''),
        id_zona_masiva: Joi.number().allow(null,'')
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    let { id_zona_masiva, tipo_concepto_masivo, tipo_inmueble_masivo, id_concepto_masivo, fecha_inicio, fecha_fin, valor, descripcion } = req.body;

    fecha_inicio = fecha_inicio ? fecha_inicio.split("T")[0] : fecha_inicio;
    fecha_fin = fecha_fin ? fecha_fin.split("T")[0] : null;

    if(fecha_fin&&!fecha_inicio){
      return res.status(201).json({ success: false, error: 'Ingrese una fecha de inicio' });
    }

    let pool = poolSys.getPool(req.user.token_db);

    let conditionalsQuery = ['t1.eliminado = 0'];

    if(tipo_inmueble_masivo!='3'){
      conditionalsQuery.push(`t1.tipo = ${tipo_inmueble_masivo}`);
    }
    
    if(id_zona_masiva){
      conditionalsQuery.push(`t1.id_inmueble_zona = ${id_zona_masiva}`);
    }

    let customCoeficiente = conditionalsQuery.length>1 ? true : false;
    conditionalsQuery = conditionalsQuery.length>1 ? conditionalsQuery.join(' AND ') : '1';

    let [propertiesAreaSum] = await pool.query(`SELECT SUM(t1.area) AS total_area FROM inmuebles t1 WHERE ${conditionalsQuery}`);
    if(!propertiesAreaSum.length) {
      return res.status(201).json({ success: false, error: 'No se encontraron inmuebles asociados a los términos.' });
    }

    propertiesAreaSum = propertiesAreaSum[0].total_area;

    const [properties] = await pool.query(`SELECT t1.*, ROUND((t1.area/${propertiesAreaSum}),3) AS coeficiente_alterno FROM inmuebles t1 WHERE ${conditionalsQuery}`);
    if(!properties.length) {
      return res.status(201).json({ success: false, error: 'No se encontraron inmuebles asociados a los términos.' });
    }

    let adminConcept = await getSysEnv({
        name: 'id_concepto_administracion',
        pool: pool
    });
    
    let adminConceptParqueadero = await getSysEnv({
        name: 'id_concepto_administracion_parqueadero',
        pool: pool
    });

    let adminConceptCuartoUtil = await getSysEnv({
        name: 'id_concepto_administracion_cuarto_util',
        pool: pool
    });

    let conceptAdmonToUpdate = adminConcept;

    await Promise.all(properties.map(async property=>{

      switch(Number(property.tipo)){
          case 0: 
              conceptAdmonToUpdate = adminConcept;
          break;
          case 1:
              conceptAdmonToUpdate = adminConceptParqueadero ? adminConceptParqueadero : adminConcept;
          break;
          case 2: 
              conceptAdmonToUpdate = adminConceptCuartoUtil ? adminConceptCuartoUtil : adminConcept;   
          break;
      }

      await createUpdatePropertyCyclicalBill({
        idInmueble: property.id, 
        pool, 
        admonValidate: (tipo_concepto_masivo==0?Math.round(Number(valor)*Number(customCoeficiente?property.coeficiente_alterno:property.coeficiente)):Number(valor)), 
        adminConcept: conceptAdmonToUpdate,
        percent: (tipo_concepto_masivo==0?Number(customCoeficiente?property.coeficiente_alterno:property.coeficiente):'N/A'), 
        customConcept: {
          id: id_concepto_masivo,
          ini: fecha_inicio,
          end: fecha_fin,
          descripcion: descripcion
        },
        req
      });
    }));
    
    //pool.end();

    return res.json({success: true});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteCyclicalBillMassive = async (req, res) => {   
  try {
    const registerSchema = Joi.object({
        tipo_inmueble_eliminar_masivo: Joi.number().required(), 
        id_concepto_eliminar_masivo: Joi.number().required(), 
        id_zona_eliminar_masiva: Joi.number().allow(null,''),
        fecha: Joi.date().required(),
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    let { id_concepto_eliminar_masivo, id_zona_eliminar_masiva, tipo_inmueble_eliminar_masivo, fecha } = req.body;

    fecha = fecha.split("T")[0];

    let pool = poolSys.getPool(req.user.token_db);

    let conditionalsQuery = [`t3.id_concepto_factura = ${id_concepto_eliminar_masivo}`, `DATE_FORMAT(t2.created_at,'%Y-%m-%d') = '${fecha}'`];

    if(tipo_inmueble_eliminar_masivo!='3'){
      conditionalsQuery.push(`t1.tipo = ${tipo_inmueble_eliminar_masivo}`);
    }
    
    if(id_zona_eliminar_masiva){
      conditionalsQuery.push(`t1.id_inmueble_zona = ${id_zona_eliminar_masiva}`);
    }

    conditionalsQuery = conditionalsQuery.length ? conditionalsQuery.join(' AND ') : '1';

    const [cyclicalDeatils] = await pool.query(`SELECT  t3.*
    
    FROM inmuebles t1
    
    INNER JOIN facturas_ciclica t2 ON t2.id_inmueble = t1.id
    INNER JOIN factura_ciclica_detalles t3 ON t3.id_factura_ciclica = t2.id 
    
    WHERE ${conditionalsQuery}`);

    if(!cyclicalDeatils.length) {
      return res.status(201).json({ success: false, error: 'No se encontraron conceptos asociados a los términos.' });
    }

    //DELETE CYCLICAL CONCEPT MASSIVE
    await pool.query(`DELETE t3 FROM inmuebles t1
    INNER JOIN facturas_ciclica t2 ON t2.id_inmueble = t1.id
    INNER JOIN factura_ciclica_detalles t3 ON t3.id_factura_ciclica = t2.id
    WHERE ${conditionalsQuery}`);
    
    //DELETE BLANK CYCLICAL
    await pool.query(`DELETE t2 FROM inmuebles t1
    INNER JOIN facturas_ciclica t2 ON t2.id_inmueble = t1.id
    LEFT OUTER JOIN factura_ciclica_detalles t3 ON t3.id_factura_ciclica = t2.id
    WHERE t3.id IS NULL`);

    //pool.end();

    return res.json({success: true});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const putCyclicalBill = async (req, res) => {
  try {     
    const registerSchema = Joi.object({
        id_concepto: Joi.number().required(), 
        id_concepto_factura: Joi.number().allow(null,''),
        conceptoText: Joi.string().required(), 
        id_inmueble: Joi.number().required(), 
        id_persona: Joi.number().required(), 
        fecha_inicio: Joi.date().required(), 
        fecha_fin: Joi.date().allow(null,''), 
        observacion: Joi.string().allow(null,''), 
        inmuebleText: Joi.string().allow(null,''),
        zonaText: Joi.string().allow(null,''),
        conceptosText: Joi.number().allow(null,''),
        valor_total: Joi.number().allow(null,''),
        created_by: Joi.number(),
        created_at: Joi.date(),
        updated_at: Joi.string().allow(null,''), 
        coeficiente: Joi.allow(null,''), 
        concepto_bloqueado: Joi.allow(null,''), 
        updated_by: Joi.number().allow(null,''),
        personaDocumento: Joi.allow(null,''),
        personaTipo: Joi.allow(null,''),
        personaPorcentaje: Joi.allow(null,''),
        created_format: Joi.allow(null,''),
        valor_total_sum: Joi.allow(null,''),
        id: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    let { fecha_inicio, fecha_fin, observacion, valor_total, id_inmueble, id_concepto, id_persona, id } = req.body;

    fecha_inicio = fecha_inicio.split("T")[0];
    fecha_fin = fecha_fin ? fecha_fin.split("T")[0] : fecha_fin;

    let pool = poolSys.getPool(req.user.token_db);

    valor_total = await roundValues({
      val: valor_total,
      pool
    });

    //UPDATE CYCLICAL BILL
    await pool.query(`UPDATE facturas_ciclica SET
        id_inmueble = ?, 
        id_persona = ?, 
        fecha_inicio = ?, 
        fecha_fin = ?, 
        valor_total = ?,
        observacion = UPPER(?),
        updated_at = NOW(), 
        updated_by = ? 
      WHERE 
        id = ?`,
      [id_inmueble, id_persona, fecha_inicio, (fecha_fin||null), valor_total, observacion, req.user.id, id]
    );
    
    //UPDATE CYCLICAL BILL DETAIL
    await pool.query(`UPDATE facturas_ciclica t1 
        INNER JOIN factura_ciclica_detalles t2 ON t2.id_factura_ciclica = t1.id
        SET
          t2.id_concepto_factura = ?,
          t2.valor_unitario = ?, 
          t2.total = ?,
          t2.descripcion = UPPER(?),
          t2.updated_at = NOW(), 
          t2.updated_by = ? 
      WHERE 
        t1.id = ?`,
      [id_concepto, valor_total, valor_total, observacion, req.user.id, id]
    );
    
    //GET EDITED CYCLICAL BILL
    const [rows] = await pool.query(`SELECT 
      t1.*,
      DATE_FORMAT(t1.fecha_inicio,'%Y-%m-%d') AS fecha_inicio,
      DATE_FORMAT(t1.fecha_fin,'%Y-%m-%d') AS fecha_fin,
      CONCAT(t3.nombre,' - ',t2.numero_interno_unidad) AS inmuebleText,
      t3.nombre AS zonaText,
      (SELECT COUNT(t4.id) FROM factura_ciclica_detalles t4 WHERE t4.id_factura_ciclica = t1.id) AS conceptosText,
      CONCAT(
        t4.numero_documento,' - ',
        IFNULL(t4.primer_nombre,''),' ',
        IFNULL(t4.segundo_nombre,''),' ',
        IFNULL(t4.primer_apellido,''),' ',
        IFNULL(t4.segundo_apellido,''),' '
      ) AS personaText
    FROM facturas_ciclica t1 
      INNER JOIN inmuebles t2 ON t2.id = t1.id_inmueble
      INNER JOIN zonas t3 ON t3.id = t2.id_inmueble_zona 
      INNER JOIN personas t4 ON t4.id = t1.id_persona 
    WHERE
    t1.id = ?`, [ id ]);
    
    let newCyclicalBill = rows[0];
    
    //pool.end();

    return res.json({success: true, data: {newCyclicalBill}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const deleteCyclicalBill = async (req, res) => {   
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

    //DELETE CYCLICAL BILL
    await pool.query(`DELETE FROM factura_ciclica_detalles WHERE id_factura_ciclica = ?`,
      [id]
    );
    
    await pool.query(`DELETE FROM facturas_ciclica WHERE id = ?`,
      [id]
    );
    
    //pool.end();

    return res.json({success: true, data: {cyclicalBill: { id }}});
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

//GEN ACCOUNT BULK DOCUMENTS TO ERP
const genBulkMovAccountErp = async (pool, idHistory) => {
	
  try {
    let [bills] = await pool.query(`SELECT 
        
        t9.id_erp AS id_cuenta_por_cobrar,
        t10.id_erp AS id_cuenta_ingreso,
        t4.nombre AS nombre_concepto,
        CONCAT(IFNULL(t3.descripcion,''), IF(IPA.porcentaje_administracion < 100,CONCAT(' ', IPA.porcentaje_administracion, '%'),'')) AS descripcion,
        t3.total,
        t2.token_erp AS token_factura,
        t2.consecutivo AS consecutivo_factura,
        IFNULL(t2.total_anticipos,0) AS total_anticipos,
        DATE_FORMAT(t2.created_at,"%Y-%m-%d") AS fecha_factura,
        t5.id_tercero_erp,
        CONCAT(DATE_FORMAT(t2.created_at, "%m%y")) AS documento_referencia,
        IFNULL((SELECT t12.id_erp FROM entorno t8 INNER JOIN erp_maestras t12 ON t12.id = t8.valor WHERE t8.campo='id_comprobante_ventas_erp' LIMIT 1),0) AS id_comprobante,
        IFNULL(t11.id_erp,'') AS id_centro_costos
          
      FROM factura_ciclica_historial_detalle t1 
      
      INNER JOIN facturas t2 ON t2.id = t1.id_factura
      INNER JOIN factura_detalles t3 ON t3.id_factura = t2.id
      INNER JOIN conceptos_facturacion t4 ON t4.id = t3.id_concepto_factura
      INNER JOIN erp_maestras t9 ON t9.id = t4.id_cuenta_por_cobrar
      INNER JOIN erp_maestras t10 ON t10.id = t4.id_cuenta_ingreso_erp
      INNER JOIN personas t5 ON t5.id = t2.id_persona
      INNER JOIN inmuebles t6 ON t6.id = t3.id_inmueble
      INNER JOIN zonas t7 ON t7.id = t6.id_inmueble_zona
      INNER JOIN inmueble_personas_admon IPA ON t3.id_inmueble = IPA.id_inmueble AND t2.id_persona = IPA.id_persona
      LEFT OUTER JOIN erp_maestras t11 ON t11.id = t7.id_centro_costos_erp
    
    WHERE t1.id_factura_ciclica = ${idHistory}`);

		let bulkDocumentsToErp = [];

		bills.forEach(bill => {
			bulkDocumentsToErp.push(bill);
		});

    return bulkDocumentsToErp;

  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
}

const getDateBill = async (_date)=>{
  let _newDate = _date.split("-");
      _newDate = `${_newDate[0]}-${_newDate[1]}-02`;
  const fecha = new Date(_newDate);

  const year = fecha.getFullYear();
  const month = String((fecha.getMonth() + 1)>12 ? 12 : (fecha.getMonth() + 1)).padStart(2, '0');
  const day = String(fecha.getDate()).padStart(2, '0');
  const hours = String(fecha.getHours()).padStart(2, '0');
  const minutes = String(fecha.getMinutes()).padStart(2, '0');
  const seconds = String(fecha.getSeconds()).padStart(2, '0');
  
  const formattedDate = `${year}-${month}-01 ${hours}:${minutes}:${seconds}`;

  return formattedDate;
};

const addDateBill = async (_date)=>{
  let _newDate = _date.split("-");
      _newDate = `${_newDate[0]}-${_newDate[1]}-02`;

  const fecha = new Date(_newDate);
  fecha.setMonth(fecha.getMonth() + 1);

  const year = fecha.getFullYear();
  const month = String((fecha.getMonth() + 1)).padStart(2, '0');
  
  const formattedDate = `${year}-${month}-01`;
  
  return formattedDate;
};

const processCyclicalBill = async (req, res) => {

  try {
    let pool = poolSys.getPool(req.user.token_db);
    
    //PRE-PROCESS FACS
    let [preBills] = await pool.query(`SELECT 
        t1.id, t1.id_persona, IFNULL(t2.id_tercero_erp,'') AS id_tercero_erp, t1.id_inmueble, '' AS consecutivo, SUM(t1.valor_total) AS valor_total, t3.id AS id_usuario
      FROM facturas_ciclica t1
        INNER JOIN personas t2 ON t2.id = t1.id_persona
        LEFT OUTER JOIN cli_maximo_ph_admin.usuarios t3 ON t3.email = t2.email
      WHERE 
        (DATE_FORMAT(NOW(),'%Y-%m-%d')>=t1.fecha_inicio OR DATE_FORMAT(NOW(),'%Y-%m-%d')<=t1.fecha_fin) AND t1.valor_total>0
      GROUP BY t1.id_persona;`);
 
    let actualConsecutive = await getSysEnv({
      name: 'consecutivo_ventas',
      pool: pool
    });
    
    actualConsecutive = Number(actualConsecutive);
    
    let periodoFacturacion = await getSysEnv({
      name: 'periodo_facturacion',
      pool: pool
    });
    periodoFacturacion = (periodoFacturacion ? periodoFacturacion : '');
    periodoFacturacion = await getDateBill(periodoFacturacion);

    let apiKeyERP = await getSysEnv({
      name: 'api_key_erp',
      pool: pool
    });

    let searchConcepts = [];

    let idConceptoAdministracion = await getSysEnv({
      name: 'id_concepto_administracion',
      pool: pool
    });
    
    let idConceptoIntereses = await getSysEnv({
      name: 'id_concepto_intereses',
      pool: pool
    });
    
    let porcentajeInteresesMora = await getSysEnv({
      name: 'porcentaje_intereses_mora',
      pool: pool
    });
    porcentajeInteresesMora = Number(porcentajeInteresesMora);

    searchConcepts = searchConcepts.join(",");

    let [erpConceptAdmon] = await pool.query(`SELECT 
        t1.id AS id_concepto, t2.id_erp 
      FROM conceptos_facturacion t1
        INNER JOIN erp_maestras t2 ON t2.id = t1.id_cuenta_por_cobrar 
      WHERE 
        t1.id = ${idConceptoAdministracion}`);
        erpConceptAdmon = erpConceptAdmon[0];

    let [erpConceptIntereses] = await pool.query(`SELECT 
        t1.id AS id_concepto, t2.id_erp 
      FROM conceptos_facturacion t1
        INNER JOIN erp_maestras t2 ON t2.id = t1.id_cuenta_por_cobrar 
      WHERE 
        t1.id = ${idConceptoIntereses}`);
        erpConceptIntereses = erpConceptIntereses[0];
    
    //DELETE EXIST PERIOD - BULK ERP DOCUMENTS
    let [tokensToDelete] = await pool.query(`SELECT
        IFNULL(t3.token_erp,'') AS token_erp
      FROM factura_ciclica_historial t1
        INNER JOIN factura_ciclica_historial_detalle t2 ON t2.id_factura_ciclica = t1.id
        INNER JOIN facturas t3 ON t3.id = t2.id_factura
      WHERE t1.created_at LIKE '${periodoFacturacion.split(' ')[0]}%'`);

		const instance = axios.create({
			baseURL: `${process.env.URL_API_ERP}`,
			headers: {
				'Authorization': apiKeyERP,
				'Content-Type': 'application/json'
			}
		});
    
    if(tokensToDelete.length && apiKeyERP){
      let tokensToSendDelete = [];

      tokensToDelete.map(rec=>{
        tokensToSendDelete.push({"token" : rec.token_erp});
      });
      
      await instance.post(`bulk-documentos-delete`, JSON.stringify({
        "documento": tokensToSendDelete
      }));
    }

    //DELETE EXIST PERIOD - BILL DETAILS
    await pool.query(`DELETE 
      t4
    FROM factura_ciclica_historial t1
      INNER JOIN factura_ciclica_historial_detalle t2 ON t2.id_factura_ciclica = t1.id
      INNER JOIN facturas t3 ON t3.id = t2.id_factura
      INNER JOIN factura_detalles t4 ON t4.id_factura = t3.id
    WHERE t1.created_at LIKE '${periodoFacturacion.split(' ')[0]}%'`);
    
    //DELETE EXIST PERIOD - BILL HEAD
    await pool.query(`DELETE 
      t3
    FROM factura_ciclica_historial t1
      INNER JOIN factura_ciclica_historial_detalle t2 ON t2.id_factura_ciclica = t1.id
      INNER JOIN facturas t3 ON t3.id = t2.id_factura
    WHERE t1.created_at LIKE '${periodoFacturacion.split(' ')[0]}%'`);
    
    //DELETE EXIST PERIOD - DETAIL
    await pool.query(`DELETE 
      t2
    FROM factura_ciclica_historial t1
      INNER JOIN factura_ciclica_historial_detalle t2 ON t2.id_factura_ciclica = t1.id
    WHERE t1.created_at LIKE '${periodoFacturacion.split(' ')[0]}%'`);
    
    //DELETE EXIST PERIOD
    await pool.query(`DELETE  t1 FROM factura_ciclica_historial t1 WHERE t1.created_at LIKE '${periodoFacturacion.split(' ')[0]}%'`);

    let consecutiveToReserved = preBills.length;

    let newConsecutive = actualConsecutive+consecutiveToReserved;
    
    await updateSysEnv({
        name: 'consecutivo_ventas',
        val: newConsecutive,
        pool: pool
    });

    let billsDetailsToInsert = [];
    let billsHisDetailsToInsert = [];
    let valorTotal = 0;

    let [headCyclicalHis] = await pool.query(`INSERT INTO factura_ciclica_historial (valor_total, created_by, created_at) VALUES (?, ?, ?)`, [0, req.user.id, periodoFacturacion]);
    let token = '';
    
    await Promise.all(preBills.map(async (preBill, index)=>{
			
      const [preBillDetails] = await pool.query(`SELECT 
          t1.id_inmueble, t2.id_concepto_factura, t2.cantidad, t2.valor_unitario, t2.total, t2.descripcion, t3.numero_interno_unidad,
          CASE
              WHEN t3.tipo = 0 THEN "INMUEBLE"
              WHEN t3.tipo = 1 THEN "PARQUEADERO"
              WHEN t3.tipo = 2 THEN "CUARTO UTIL"
          END AS tipo_unidad,
          t5.id_erp AS id_cuenta_por_cobrar_erp
        FROM facturas_ciclica t1
          INNER JOIN factura_ciclica_detalles t2 ON t2.id_factura_ciclica = t1.id
          INNER JOIN conceptos_facturacion t4 ON t4.id = t2.id_concepto_factura
          INNER JOIN erp_maestras t5 ON t5.id = t4.id_cuenta_por_cobrar
          INNER JOIN inmuebles t3 ON t3.id = t1.id_inmueble
        WHERE 
          t1.id_persona = ? AND (DATE_FORMAT(NOW(),'%Y-%m-%d')>=t1.fecha_inicio OR DATE_FORMAT(NOW(),'%Y-%m-%d')<=t1.fecha_fin) AND t1.valor_total>0`,[preBill.id_persona]
			);
      let getExtractNitERP = null;
      if(apiKeyERP){
        var url = `${process.env.URL_API_ERP}extracto?id_nit=${preBill.id_tercero_erp}&id_tipo_cuenta=3`;
        getExtractNitERP = await instance.get(url);
        getExtractNitERP = getExtractNitERP.data.data;
      }

      let totalPendiente = 0;
      let totalPendienteSinIntereses = 0;
      const billsA = getExtractNitERP;
      const totalPendienteXCuenta = [];
      billsA.forEach(bill=>{
        
        if(Number(bill.saldo)>0&&(Number(bill.id_cuenta)==erpConceptAdmon.id_erp||Number(bill.id_cuenta)==erpConceptIntereses.id_erp)){
          totalPendiente += Number(bill.saldo);
        }

        if(Number(bill.saldo)>0&&Number(bill.id_cuenta)==erpConceptAdmon.id_erp){
          totalPendienteSinIntereses += Number(bill.saldo);
        }
      });
      
      let extractCustomerNit = await genExtractCustomerNit(preBill.id_tercero_erp, pool, preBill.id_persona);
      
      if(preBillDetails.length){
        let valorIntereses = 0;
  
        if(totalPendienteSinIntereses>0&&porcentajeInteresesMora>0){
          valorIntereses = Math.round(totalPendienteSinIntereses*(porcentajeInteresesMora/100));
          valorIntereses = await roundValues({
            val: valorIntereses,
            pool
          });  
  
          preBillDetails.push({
            id_inmueble: preBillDetails[0].id_inmueble,
            id_concepto_factura: idConceptoIntereses,
            cantidad: preBillDetails[0].cantidad,
            valor_unitario: valorIntereses,
            total: valorIntereses,
            tipo_unidad: preBillDetails[0].tipo_unidad,
            numero_interno_unidad: preBillDetails[0].numero_interno_unidad,
            descripcion: `INTERESES % ${porcentajeInteresesMora} - BASE: ${Number(totalPendienteSinIntereses).toLocaleString('es-ES')}`,
            id_cuenta_por_cobrar_erp: erpConceptIntereses.id_erp
          });
        }else if(totalPendienteSinIntereses==0){
          if(Number(extractCustomerNit.totalGlobalIntereses)){
            //INTERESES PAGO EXTEMPORÁNEO
            preBillDetails.push({
              id_inmueble: preBillDetails[0].id_inmueble,
              id_concepto_factura: idConceptoIntereses,
              cantidad: preBillDetails[0].cantidad,
              valor_unitario: Number(extractCustomerNit.totalGlobalIntereses),
              total: Number(extractCustomerNit.totalGlobalIntereses),
              tipo_unidad: preBillDetails[0].tipo_unidad,
              numero_interno_unidad: preBillDetails[0].numero_interno_unidad,
              descripcion: `INTERESES PAGO EXTEMPORANEO - % ${porcentajeInteresesMora} - BASE: ${Number(extractCustomerNit.totalPendiente).toLocaleString('es-ES')}`,
              id_cuenta_por_cobrar_erp: erpConceptIntereses.id_erp
            });
          }
        }

        token = await genRandomToken();

        let totalAnticipos = 0;

        if(Number(extractCustomerNit.anticipos)>0&&(Number(preBill.valor_total)+valorIntereses)>Number(extractCustomerNit.anticipos)){
          totalAnticipos = Number(extractCustomerNit.anticipos);
        }else if(Number(extractCustomerNit.anticipos)>0&&Number(extractCustomerNit.anticipos)>(Number(preBill.valor_total)+valorIntereses)){
          totalAnticipos = (Number(preBill.valor_total)+valorIntereses);
        }

        const [insertBill] = await pool.query(`INSERT INTO facturas (id_persona, id_inmueble, consecutivo, saldo_anterior, total_anticipos, valor_total, token_erp, created_at)
        VALUES
        (?, ?, ?, ?, ?, ?, ?, ?)`,
        [preBill.id_persona, preBill.id_inmueble, (actualConsecutive+(index)), totalPendiente, totalAnticipos, (Number(preBill.valor_total)+valorIntereses), token, periodoFacturacion]);
        
        valorTotal += (Number(preBill.valor_total)+valorIntereses);

        let saldoAnteriorCuenta = 0;

        preBillDetails.map(billDetail=>{
          if(totalPendienteXCuenta[billDetail.id_cuenta_por_cobrar_erp]){ 
            saldoAnteriorCuenta = totalPendienteXCuenta[billDetail.id_cuenta_por_cobrar_erp];
          }else{
            saldoAnteriorCuenta = 0;
          }
          
          billsDetailsToInsert.push(`
              INSERT INTO factura_detalles (id_factura, id_inmueble, id_concepto_factura, cantidad, valor_unitario, saldo_anterior, total, descripcion)
              VALUES
              ('${insertBill.insertId}', '${billDetail.id_inmueble}', '${billDetail.id_concepto_factura}', '${billDetail.cantidad}', '${billDetail.valor_unitario}', '${saldoAnteriorCuenta}', '${billDetail.total}', '${billDetail.tipo_unidad}:  ${billDetail.numero_interno_unidad} ${billDetail.descripcion==null ? '' : billDetail.descripcion}')`);
        });
        
        billsHisDetailsToInsert.push(`
            INSERT INTO factura_ciclica_historial_detalle (id_factura_ciclica, id_factura, total, created_by)
            VALUES
            ('${headCyclicalHis.insertId}', '${insertBill.insertId}', '${(Number(preBill.valor_total)+valorIntereses)}', '${req.user.id}')`);
      }
    }));

    billsDetailsToInsert = billsDetailsToInsert.join("; ");
    await pool.query(billsDetailsToInsert);

    billsHisDetailsToInsert = billsHisDetailsToInsert.join("; ");
    await pool.query(billsHisDetailsToInsert);
    
    await pool.query(`UPDATE factura_ciclica_historial SET valor_total = ? WHERE id = ?`, [valorTotal, headCyclicalHis.insertId]);
    
    //await processEmailsBill(headCyclicalHis.insertId, pool);
    
    //UPDATE TOTAL CYCLICAL HIS
    await pool.query(`UPDATE factura_ciclica_historial t1 SET t1.valor_total = (SELECT SUM(t2.total) FROM factura_ciclica_historial_detalle t2 WHERE t2.id_factura_ciclica = t1.id) WHERE 1=1`);

    //UPDATE TOTAL CYCLICAL BILL
    await pool.query(`UPDATE facturas t1 SET t1.valor_total = (SELECT SUM(t2.total) FROM factura_detalles t2 WHERE t2.id_factura = t1.id) WHERE 1=1`);
    
    let bulkMovAccountErp = await genBulkMovAccountErp(pool, headCyclicalHis.insertId);
    
    await instance.post(`bulk-documentos`,JSON.stringify({
      "documento": bulkMovAccountErp
		}));

    periodoFacturacion = await addDateBill(periodoFacturacion);
    
    await updateSysEnv({
        name: 'periodo_facturacion',
        val: periodoFacturacion,
        pool: pool
    });

    //pool.end();

    return res.json({success: true, data: {id: headCyclicalHis.insertId}});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const processEmailsBill = async (idHistory, pool)=>{
  try {
    const [bills] = await pool.query(`SELECT id_factura FROM factura_ciclica_historial_detalle WHERE id_factura_ciclica = ?`,[idHistory]);

    await Promise.all(bills.map(async bill=>{
      await sendEmailBillPDF(bill.id_factura, pool);
    }));

  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  processCyclicalBill,
  getAllCyclicalBills,
  createCyclicalBill,
  createCyclicalBillMassive,
  deleteCyclicalBill,
  deleteCyclicalBillMassive,
  putCyclicalBill
};
