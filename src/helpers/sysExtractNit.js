import axios from "axios";
import { getSysEnv } from "./sysEnviroment.js";

const genExtractCustomerNit = async (tercero, pool, personDateValidate) => {
  console.log('genExtractCustomerNit');
  try {
    let apiKeyERP = await getSysEnv({
      name: 'api_key_erp',
      pool: pool
    });

    let totalPendiente = 0;
    let totalGlobalDescuento = 0;
    let totalGlobalIntereses = 0;

    let anticiposCredito = 0;//credito-1
    let anticiposDebito = 0;//debito-0

    let billsFiltered = [];

    //GET CXC ERP
    let [cxcIdsErp] = await pool.query(`SELECT GROUP_CONCAT(t2.id_erp) AS ids_cxc FROM conceptos_facturacion t1 INNER JOIN erp_maestras t2 ON t2.id = t1.id_cuenta_por_cobrar WHERE t1.eliminado=0`);
         cxcIdsErp = cxcIdsErp[0].ids_cxc.split(",");
    
    let [cuentaAnticipos] = await pool.query(`SELECT t2.id_erp FROM entorno t1 INNER JOIN erp_maestras t2 ON t2.id = t1.valor WHERE t1.campo='id_cuenta_anticipos_erp'`);
         cuentaAnticipos = cuentaAnticipos[0]?.id_erp;

    let [cxcIdErpIntereses] = await pool.query(`SELECT GROUP_CONCAT(t2.id_erp) AS id_cxc_intereses FROM conceptos_facturacion t1 INNER JOIN erp_maestras t2 ON t2.id = t1.id_cuenta_por_cobrar INNER JOIN entorno t3 ON t3.valor = t1.id AND t3.campo='id_concepto_intereses' WHERE t1.eliminado=0`);
         cxcIdErpIntereses = cxcIdErpIntereses[0].id_cxc_intereses;
    
    let porcentajeDescuentoProntoPago = await getSysEnv({name: "porcentaje_descuento_pronto_pago", pool});
        porcentajeDescuentoProntoPago = Number(porcentajeDescuentoProntoPago);

    let porcentajeInteresesMora = await getSysEnv({name: "porcentaje_intereses_mora", pool});
        porcentajeInteresesMora = Number(porcentajeInteresesMora);

    let diaLimiteDescuentoProntoPago = await getSysEnv({name: "dia_limite_descuento_pronto_pago", pool});
        diaLimiteDescuentoProntoPago = Number(diaLimiteDescuentoProntoPago);

    let diaLimitePagoSinInteres = await getSysEnv({name: "dia_limite_pago_sin_interes", pool});
        diaLimitePagoSinInteres = Number(diaLimitePagoSinInteres);

    let fechaActual = new Date();
    let billCashReceipt = false;
    
    if(personDateValidate){
      let [billCashReceipt] = await pool.query(`SELECT * FROM factura_recibos_caja WHERE id_persona=${personDateValidate} ORDER BY fecha_recibo DESC LIMIT 1`);
         billCashReceipt = billCashReceipt.length ? billCashReceipt[0] : false;
        
      if(billCashReceipt.length){
        return {
          data: [], 
          porcentajeDescuentoProntoPago: 0,
          descuentoProntoPago: 0,
          porcentajeInteresesMora: 0,
          calculaIntereses: 0,
          mesActual: 0,
          diaActual: 0,
          totalPendiente: 0,
          totalGlobalDescuento: 0, 
          totalGlobalIntereses: 0
        };
      }else{
        fechaActual = new Date(billCashReceipt.fecha_recibo);
      }
    }
    
    let mesActual = Number(fechaActual.getMonth());
    
    let diaActual = Number(fechaActual.getDate());
    
    let descuentoProntoPago = diaActual<=diaLimiteDescuentoProntoPago ? true : false;
    
    let calculaIntereses = diaActual>diaLimitePagoSinInteres ? true : false;

    let getExtractNitERP = [];

    const instance = axios.create({
      baseURL: `${process.env.URL_API_ERP}`,
      headers: {
        'Authorization': apiKeyERP,
        'Content-Type': 'application/json'
      }
    });

    if(apiKeyERP){
      var url = `${process.env.URL_API_ERP}extracto?id_nit=${tercero}&id_tipo_cuenta=3`;
      getExtractNitERP = await instance.get(url);
      getExtractNitERP = getExtractNitERP.data.data;
    }

    const billsA = Object.values(getExtractNitERP);
    
    // if(cuentaAnticipos){
    //   let getExtractNitERPAnticipo = await axios.get(`${process.env.URL_API_ERP}document?id_nit=${tercero}&id_cuenta=${cuentaAnticipos}&key=${apiKeyERP}`);

    //   getExtractNitERPAnticipo = getExtractNitERPAnticipo.data.data;
  
    //   const anticiposTercero = Object.values(getExtractNitERPAnticipo);

    //   anticiposTercero.forEach(bill=>{
    //     if(bill.id_cuenta==cuentaAnticipos){
    //       if(Number(bill.tipo)==1){
    //         anticiposCredito += Number(bill.valor);
    //       }else{
    //         anticiposDebito += Number(bill.valor);
    //       }
    //     }
    //   });
    // }

    if(!personDateValidate){
      billsA.forEach(bill=>{
        if(Number(bill.saldo)>0&&cxcIdsErp.indexOf(bill.id_cuenta.toString())>=0){
          let fechaCausacion = new Date(bill.fecha_manual);
          var mesCausacion = Number(fechaCausacion.getMonth())+1;

          let totalDescuento = 0;
          let totalIntereses = 0;

          if(mesCausacion==mesActual && (bill.id_cuenta!=cxcIdErpIntereses)){
            if(descuentoProntoPago){
              totalDescuento = Number(bill.saldo);
              totalDescuento = totalDescuento*(porcentajeDescuentoProntoPago/100);
              totalDescuento = Math.round(totalDescuento);
            }else if(calculaIntereses){
              /*totalIntereses = (Number(bill.causacion)-Number(bill.total_abono||0));
              totalIntereses = ((totalIntereses*(porcentajeInteresesMora/100))/30);
              totalIntereses = totalIntereses*diaActual;
              totalIntereses = Math.round(totalIntereses);*/
            }
          }

          totalGlobalDescuento += totalDescuento;
          totalGlobalIntereses += totalIntereses;
          
          totalPendiente += Number(bill.saldo);

          totalPendiente -= Number(totalDescuento);
          totalPendiente += Number(totalIntereses);

          billsFiltered.push({
            cuenta_id: bill.id_cuenta,
            factura: Number(bill.consecutivo),
            docRef: bill.documento_referencia ? bill.documento_referencia : '',
            fecha: bill.fecha_manual,
            concepto: bill.concepto,
            intereses: (Number(bill.id_cuenta)==Number(cxcIdErpIntereses) ? true : false),
            cuenta_numero: Number(bill.cuenta),
            cuenta_nombre: bill.nombre_cuenta,
            totalFactura: Number(bill.total_facturas).toLocaleString('es-ES'),
            totalAbonos: Number(bill.total_abono||0).toLocaleString('es-ES'),
            totalDescuento: Number(totalDescuento).toLocaleString('es-ES'),
            totalIntereses: Number(totalIntereses).toLocaleString('es-ES'),
            totalPendiente: ( ( Number(bill.total_facturas) + Number(totalIntereses)) - ( Number(bill.total_abono||0)+Number(totalDescuento) ) ).toLocaleString('es-ES')
          });
        }
      });

      billsFiltered.sort((a, b) => {
        if (a.cuenta_numero !== b.cuenta_numero) {
          return a.cuenta_numero.toString().localeCompare(b.cuenta_numero.toString());
        } else {
          return a.fecha.localeCompare(b.fecha);
        }
      });
    }else if(billCashReceipt){
      totalPendiente = Number(billCashReceipt.valor_recibo);

      if(descuentoProntoPago){
        totalDescuento = Number(billCashReceipt.valor_recibo);
        totalDescuento = totalDescuento*(porcentajeDescuentoProntoPago/100);
        totalDescuento = Math.round(totalDescuento);
      }else if(calculaIntereses){
        totalIntereses = Number(billCashReceipt.valor_recibo);
        totalIntereses = ((totalIntereses*(porcentajeInteresesMora/100))/30);
        totalIntereses = totalIntereses*diaActual;
        totalIntereses = Math.round(totalIntereses);
      }

      totalGlobalDescuento += totalDescuento;
      totalGlobalIntereses += totalIntereses;
    }

    return {
      data: billsFiltered, 
      anticipos: Math.abs(anticiposCredito-anticiposDebito),
      porcentajeDescuentoProntoPago,
      descuentoProntoPago,
      porcentajeInteresesMora,
      calculaIntereses,
      mesActual,
      diaActual,
      totalPendiente,
      totalGlobalDescuento, 
      totalGlobalIntereses
    };

  } catch (error) {
    return { success: false, error: 'Internal Server Error', error: error.message };
  }
};

const genExtractProvaiderNit = async (tercero, pool) => {
  try {
    let apiKeyERP = await getSysEnv({
      name: 'api_key_erp',
      pool: pool
    });

    let totalPendiente = 0;

    let billsFiltered = [];

    //GET CXP ERP
    let [cxpIds1Erp] = await pool.query(`SELECT GROUP_CONCAT(t2.id_erp) AS ids_cxp FROM conceptos_gastos t1 INNER JOIN erp_maestras t2 ON t2.id = t1.id_cuenta_por_pagar_erp WHERE t1.eliminado=0 AND (t2.codigo NOT LIKE "1105%" AND t2.codigo NOT LIKE "1110%")`);
         cxpIds1Erp = cxpIds1Erp[0].ids_cxp ? cxpIds1Erp[0].ids_cxp.split(",") : [];
    
    let [cxpIds2Erp] = await pool.query(`SELECT GROUP_CONCAT(t2.id_erp) AS ids_cxp FROM gastos t1 INNER JOIN erp_maestras t2 ON t2.id = t1.id_cuenta_x_pagar_egreso_gasto_erp WHERE t1.anulado=0 AND (t2.codigo NOT LIKE "1105%" AND t2.codigo NOT LIKE "1110%")`);
         cxpIds2Erp = cxpIds2Erp[0].ids_cxp ? cxpIds2Erp[0].ids_cxp.split(",") : [];

    let cxpIdsErp = Array.from(new Set([...cxpIds1Erp, ...cxpIds2Erp]));

    let getExtractNitERP = [];

    const instance = axios.create({
      baseURL: `${process.env.URL_API_ERP}`,
      headers: {
        'Authorization': apiKeyERP,
        'Content-Type': 'application/json'
      }
    });

    if(apiKeyERP){
      var url = `${process.env.URL_API_ERP}extracto?id_nit=${tercero}&id_tipo_cuenta=3`;
      getExtractNitERP = await instance.get(url);
      getExtractNitERP = getExtractNitERP.data.data;
    }

    const billsA = Object.values(getExtractNitERP);

    billsA.forEach(bill=>{
      if(Number(bill.saldo)>0){
        totalPendiente += Number(bill.saldo);

        billsFiltered.push({
          cuenta_id: bill.id_cuenta,
          factura: bill.consecutivo,
          docRef: bill.documento_referencia,
          fecha: bill.fecha_manual,
          concepto: bill.concepto,
          cuenta_numero: Number(bill.cuenta),
          totalFactura: Number(bill.total_facturas).toLocaleString('es-ES'),
          totalAbonos: Number(bill.total_abono||0).toLocaleString('es-ES'),
          totalPendiente: (Number(bill.saldo)).toLocaleString('es-ES')
        });
      }
    });

    billsFiltered.sort((a, b) => {
      if (a.cuenta_numero !== b.cuenta_numero) {
        return a.cuenta_numero.toString().localeCompare(b.cuenta_numero.toString());
      } else {
        return a.fecha.localeCompare(b.fecha);
      }
    });

    return {
      data: billsFiltered,
      totalPendiente
    };

  } catch (error) {
    return { success: false, error: 'Internal Server Error', error: error.message };
  }
};

export {
  genExtractCustomerNit,
  genExtractProvaiderNit
};
