import { poolSys } from "../../../db.js";
import { getSysEnv } from "../../../helpers/sysEnviroment.js";

const getAllHistoryBills = async (req, res) => {
  try {
    let pool = poolSys.getPool(req.user.token_db);
    
    const { idHistory } = req.params;
    
    const { id_person } = req.query;

    const [exportedPeriods] = await pool.query(`SELECT 
      id, DATE_FORMAT(created_at, "%Y-%m") AS periodo, IF(estado=0,"ANULADO","GENERADO") AS estado, 
      FORMAT(valor_total,0) AS valor_total, created_at, updated_at 
    FROM factura_ciclica_historial
    WHERE 1 ORDER BY id DESC`);
    
    let bills = [];
    if(exportedPeriods.length){
      let filter = '';

      if(id_person){
        filter = `t1.id_persona = ${id_person} AND t1.estado = 1 AND IFNULL(t1.total_abonos,0)<t1.valor_total`;
      }else{
        filter = `t5.id_factura_ciclica = ${(idHistory ? idHistory : exportedPeriods[0].id)}`;
      }

      [bills] = await pool.query(`SELECT 
          t1.*,
          FORMAT(t1.valor_total,0) AS valortotal,
          DATE_FORMAT(t1.created_at,"%Y-%m-%d") AS fecha,
          CONCAT(t3.nombre,' - ',t2.numero_interno_unidad) AS inmuebleText,
          t3.nombre AS zonaText,
          CONCAT(t2.area,' M2') AS areaText,
          FORMAT(t4.numero_documento,0) AS personaDocumento,
          TRIM(REPLACE(REPLACE(CONCAT(
            IFNULL(t4.primer_nombre,''),' ',
            IFNULL(t4.segundo_nombre,''),' ',
            IFNULL(t4.primer_apellido,''),' ',
            IFNULL(t4.segundo_apellido,''),' '
          ),'  ',' '),'  ',' ')) AS propietarioText,
          t4.id AS propietarioId,
          t4.email AS emailPropietario
        FROM factura_ciclica_historial_detalle t5
          INNER JOIN facturas t1 ON t1.id = t5.id_factura
          INNER JOIN factura_detalles t6 ON t6.id_factura = t1.id
          INNER JOIN inmuebles t2 ON t2.id = t6.id_inmueble
          INNER JOIN zonas t3 ON t3.id = t2.id_inmueble_zona 
          INNER JOIN personas t4 ON t4.id = t1.id_persona
        WHERE 
          ${filter} GROUP BY t1.id`);
    }
    
    //pool.end();

    return res.json({success: true, data: bills, exportedPeriods: exportedPeriods});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

const getAllHistoryBillsDetails = async (req, res) => {
  try {
    let pool = poolSys.getPool(req.user.token_db);
    
    const { idHistory } = req.params;
    
    const { id_person } = req.query;

    const [exportedPeriods] = await pool.query(`SELECT 
      id, DATE_FORMAT(created_at, "%Y-%m") AS periodo, IF(estado=0,"ANULADO","GENERADO") AS estado, 
      FORMAT(valor_total,0) AS valor_total, created_at, updated_at 
    FROM factura_ciclica_historial
    WHERE 1 ORDER BY id DESC`);
    
    let bills = [];
    if(exportedPeriods.length){
      let filter = '';

      if(id_person){
        filter = `t1.id_persona = ${id_person} AND t1.estado = 1 AND IFNULL(t1.total_abonos,0)<t1.valor_total`;
      }else{
        filter = `t5.id_factura_ciclica = ${(idHistory ? idHistory : exportedPeriods[0].id)}`;
      }

      [bills] = await pool.query(`SELECT 
          t1.*,
          FORMAT(t1.valor_total,0) AS valortotal,
          FORMAT(t1.saldo_anterior,0) AS saldoAnterior,
          DATE_FORMAT(t1.created_at,"%Y-%m-%d") AS fecha,
          CONCAT(t3.nombre,' - ',t2.numero_interno_unidad) AS inmuebleText,
          t3.nombre AS zonaText,
          CONCAT(t2.area,' M2') AS areaText,
          FORMAT(t4.numero_documento,0) AS personaDocumento,
          CONCAT(
              IFNULL(t4.primer_nombre,''),' ',
              IFNULL(t4.segundo_nombre,''),' ',
              IFNULL(t4.primer_apellido,''),' ',
              IFNULL(t4.segundo_apellido,''),' '
          ) AS propietarioText,
          t4.id AS propietarioId,
          t4.email AS emailPropietario,
          IFNULL(t4.id_tercero_erp,'') AS id_tercero_erp,
          CONCAT(t6.descripcion,'-',t7.nombre) AS descripcion, 
          FORMAT(IFNULL(t6.saldo_anterior,0),0) As saldo_anterior,
          FORMAT(t6.total,0) As total,
          CONCAT(t2.numero_interno_unidad,DATE_FORMAT(t6.created_at,"%m"),SUBSTRING(YEAR(CURRENT_DATE()), 3, 2)) AS referencia,
          ROUND(IFNULL(t2.area,0),2) As area,
          ROUND((IFNULL(t2.coeficiente,0)*100),2) AS coeficiente
        FROM factura_ciclica_historial_detalle t5
          INNER JOIN facturas t1 ON t1.id = t5.id_factura
          INNER JOIN factura_detalles t6 ON t6.id_factura = t1.id
          INNER JOIN conceptos_facturacion t7 ON t7.id = t6.id_concepto_factura
          INNER JOIN inmuebles t2 ON t2.id = t6.id_inmueble
          INNER JOIN zonas t3 ON t3.id = t2.id_inmueble_zona 
          INNER JOIN personas t4 ON t4.id = t1.id_persona
        WHERE 
          ${filter}`);
    }
    
    //pool.end();

    return res.json({success: true, data: bills, exportedPeriods: exportedPeriods});
  } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
    getAllHistoryBills,
    getAllHistoryBillsDetails
};
