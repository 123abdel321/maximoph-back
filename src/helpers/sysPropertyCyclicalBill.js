
import { getSysEnv, roundValues } from "./sysEnviroment.js";

const createUpdatePropertyCyclicalBill = async ({idInmueble, pool, adminConcept, admonValidate, customConcept, percent, req})=>{
  if(adminConcept||customConcept){//CREATE OR UPDATE CYCLICAL BILL

      //GET ACTUAL OWNERS AND RENTERS
      const [ownersRenters] = await pool.query(`SELECT
            t1.id,
            t1.id_inmueble,
            IFNULL(t2.id,'') AS id_factura_ciclica,
            IFNULL(t3.id,'') AS id_detalle_ciclica,
            t1.porcentaje_administracion,
            t1.id_persona,
            IFNULL(t4.valor_total_administracion,0) AS valor_total_administracion,
            t4.tipo
        FROM inmueble_personas_admon t1 
          LEFT OUTER JOIN facturas_ciclica t2 ON t2.id_persona = t1.id_persona AND t2.id_inmueble = t1.id_inmueble
          LEFT OUTER JOIN factura_ciclica_detalles t3 ON t3.id_factura_ciclica = t2.id AND t3.id_concepto_factura = ${adminConcept}
          INNER JOIN inmuebles t4 ON t4.id = t1.id_inmueble
        WHERE
            t1.id_inmueble = ${idInmueble}
        `);

      let porcentajeAdmin = 0;
      await Promise.all(ownersRenters.map(async ownerRenter=>{
        
        admonValidate = admonValidate ? admonValidate : Number(ownerRenter.valor_total_administracion);
          porcentajeAdmin = Number((ownerRenter.porcentaje_administracion/100).toFixed(2));
          porcentajeAdmin = Math.round(admonValidate*porcentajeAdmin);
          porcentajeAdmin = (porcentajeAdmin!=null && porcentajeAdmin!='' ? porcentajeAdmin : 0);
  
          porcentajeAdmin = await roundValues({
            val: porcentajeAdmin,
            pool
          });

          if(customConcept&&porcentajeAdmin>0){
            const [insertedBillHead] = await pool.query(`INSERT INTO facturas_ciclica 
            (id_inmueble, id_persona, fecha_inicio, fecha_fin, valor_total, created_by, created_at)
            VALUES
            (?, ?, ?, ?, ?, ?, NOW())`,
            [idInmueble, ownerRenter.id_persona, customConcept.ini, customConcept.end, porcentajeAdmin, req.user.id]);
  
            customConcept.descripcion = `${customConcept.descripcion} ${percent!=0?`- COEFICIENTE: ${percent}`:''}`;
  
            await pool.query(`INSERT INTO factura_ciclica_detalles 
            (id_factura_ciclica, id_concepto_factura, cantidad, valor_unitario, total, descripcion, created_by, created_at)
            VALUES
            (?, ?, ?, ?, ?, ?, ?, NOW())`,
            [insertedBillHead.insertId, customConcept.id, 1, porcentajeAdmin, porcentajeAdmin, customConcept.descripcion, porcentajeAdmin, req.user.id]);
          }else if(ownerRenter.id_detalle_ciclica&&porcentajeAdmin>0){ //IF EXIST DETAIL: UPDATE EXISTING DETAIL CYCLICAL CONCEPT
              await pool.query(`UPDATE factura_ciclica_detalles SET
                  valor_unitario = ?,
                  total = ?,
                  updated_at = NOW(), 
                  updated_by = ? 
              WHERE 
                  id = ?`,
              [porcentajeAdmin, porcentajeAdmin, req.user.id, ownerRenter.id_detalle_ciclica]);
      
              //UPDATE TOTAL HEAD CYCLICAL BILL
              await pool.query(`UPDATE 
                facturas_ciclica t1 
              SET 
                t1.valor_total = IFNULL((SELECT SUM(t2.total) FROM factura_ciclica_detalles t2 WHERE t2.id_factura_ciclica = t1.id),0)
              WHERE t1.id = ?
              `,[ownerRenter.id_factura_ciclica]);
          }else if(porcentajeAdmin>0){ //IF NOT EXIST HEAD: INSERT NEW CYCLICAL BILL

              const [existeFactura] = await pool.query(`SELECT * FROM facturas_ciclica WHERE id_inmueble = ${idInmueble} AND id_persona = ${ownerRenter.id_persona}`);
              
              if (!existeFactura.length) {
                const [insertedBillHead] = await pool.query(`INSERT INTO facturas_ciclica 
                (id_inmueble, id_persona, fecha_inicio, valor_total, created_by, created_at)
                VALUES
                (?, ?, NOW(), ?, ?, NOW())`,
                [idInmueble, ownerRenter.id_persona, porcentajeAdmin, req.user.id]);
    
                await pool.query(`INSERT INTO factura_ciclica_detalles 
                (id_factura_ciclica, id_concepto_factura, cantidad, valor_unitario, total, created_by, created_at)
                VALUES
                (?, ?, ?, ?, ?, ?, NOW())`,
                [insertedBillHead.insertId, adminConcept, 1, porcentajeAdmin, porcentajeAdmin, req.user.id]);
              }
          }
      }));

      //UPDATE TOTAL CYCLICAL
      await pool.query(`UPDATE facturas_ciclica t1 
        SET 
          t1.valor_total = IFNULL((SELECT SUM(t2.total) FROM factura_ciclica_detalles t2 WHERE t2.id_factura_ciclica = t1.id),0) 
        WHERE 
          1=1`);
  }
};

const roundAllValuesPropertyCyclicalBill = async ({pool})=>{
  let [roundType] = await pool.query(`SELECT IFNULL(valor,'') AS valor FROM entorno WHERE campo = 'redondeo_conceptos'`);
  roundType = roundType.length ? (roundType[0].valor||1) : 0;
  roundType = roundType == 0 ? 1 : roundType;
  
  //ROUND DETAIL VALUES
  await pool.query(`UPDATE 
      factura_ciclica_detalles 
  SET 
    valor_unitario = ROUND((valor_unitario/${roundType}))*${roundType},
    total =  ROUND((total/${roundType}))*${roundType}
  `);

  //UPDATE TOTAL CYCLICAL
  await pool.query(`UPDATE facturas_ciclica t1 
    SET 
      t1.valor_total = IFNULL((SELECT SUM(t2.total) FROM factura_ciclica_detalles t2 WHERE t2.id_factura_ciclica = t1.id),0) 
    WHERE 
      1=1`);
};

export {
  createUpdatePropertyCyclicalBill,
  roundAllValuesPropertyCyclicalBill
};