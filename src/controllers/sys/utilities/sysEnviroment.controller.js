import Joi  from "joi";
import axios from "axios";
import { poolSys } from "../../../db.js";
import { getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { updateSysEnv, getSysEnv } from "../../../helpers/sysEnviroment.js";
import { roundAllValuesPropertyCyclicalBill, createUpdatePropertyCyclicalBill } from "../../../helpers/sysPropertyCyclicalBill.js";

const getSummaryErp = async (req, res) => {
    try {
        let pool = poolSys.getPool(req.user.token_db);

        const [simpleEnviroment] = await pool.query(
            `SELECT 
            id, campo, valor
            FROM 
                entorno
            WHERE 
                campo NOT IN ('id_concepto_administracion', 'id_concepto_administracion_parqueadero','id_concepto_administracion_cuarto_util', 'id_comprobante_ventas_erp', 'id_comprobante_gastos_erp', 'id_comprobante_pagos_erp', 'id_comprobante_recibos_caja_erp', 'id_cuenta_intereses_erp', 'id_cuenta_descuento_erp', 'id_cuenta_ingreso_recibos_caja_erp', 'id_cuenta_ingreso_pasarela_erp', 'id_cuenta_egreso_pagos_erp', 'id_cuenta_anticipos_erp')
        `);
        
        const [erpBases] = await pool.query(
            `SELECT 
            t1.campo,
            t1.valor AS value,
            CONCAT(t2.codigo,' - ',t2.nombre) AS label
            FROM 
                entorno t1
            INNER JOIN erp_maestras t2 ON t2.id = t1.valor
            WHERE 
                t1.campo IN ('id_concepto_administracion', 'id_concepto_administracion_parqueadero','id_concepto_administracion_cuarto_util', 'id_comprobante_ventas_erp', 'id_comprobante_gastos_erp', 'id_comprobante_pagos_erp', 'id_comprobante_recibos_caja_erp', 'id_cuenta_intereses_erp', 'id_cuenta_descuento_erp', 'id_cuenta_ingreso_recibos_caja_erp', 'id_cuenta_ingreso_pasarela_erp', 'id_cuenta_egreso_pagos_erp', 'id_cuenta_anticipos_erp')
        `);
        
        const [erpTotalsSynced] = await pool.query(
            `SELECT 
             (SELECT COUNT(t2.id) FROM erp_maestras t2 WHERE t2.tipo = 0) AS centro_costos,
             (SELECT COUNT(t3.id) FROM erp_maestras t3 WHERE t3.tipo = 1) AS comprobantes,
             (SELECT COUNT(t4.id) FROM erp_maestras t4 WHERE t4.tipo = 2) AS cuentas
            FROM 
                entorno t1
            WHERE 
                t1.campo = 'api_key_erp'
        `);
        
        const [conceptoAdministracion] = await pool.query(
            `SELECT 
            t1.campo,
            t1.valor AS value,
            CONCAT(t2.id,' - ',t2.nombre) AS label
            FROM 
                entorno t1
            INNER JOIN conceptos_facturacion t2 ON t2.id = t1.valor
            WHERE 
                t1.campo IN ('id_concepto_administracion')
        `);

        const [conceptoAdministracionParqueadero] = await pool.query(
            `SELECT 
            t1.campo,
            t1.valor AS value,
            CONCAT(t2.id,' - ',t2.nombre) AS label
            FROM 
                entorno t1
            INNER JOIN conceptos_facturacion t2 ON t2.id = t1.valor
            WHERE 
                t1.campo IN ('id_concepto_administracion_parqueadero')
        `);

        const [conceptoAdministracionCuartoUtil] = await pool.query(
            `SELECT 
            t1.campo,
            t1.valor AS value,
            CONCAT(t2.id,' - ',t2.nombre) AS label
            FROM 
                entorno t1
            INNER JOIN conceptos_facturacion t2 ON t2.id = t1.valor
            WHERE 
                t1.campo IN ('id_concepto_administracion_cuarto_util')
        `);

        const [conceptoIntereses] = await pool.query(
            `SELECT 
            t1.campo,
            t1.valor AS value,
            CONCAT(t2.id,' - ',t2.nombre) AS label
            FROM 
                entorno t1
            INNER JOIN conceptos_facturacion t2 ON t2.id = t1.valor
            WHERE 
                t1.campo IN ('id_concepto_intereses')
        `);

        const [conceptoVisita] = await pool.query(
            `SELECT 
                t1.campo,
                t1.valor AS value,
                CONCAT(t2.id,' - ',t2.nombre) AS label
            FROM 
                entorno t1
            INNER JOIN maestras_base t2 ON t2.id = t1.valor AND t2.tipo = 3
            WHERE 
                t1.campo IN ('id_concepto_visita')
        `);
        
        let [logo] = await pool.query(`SELECT logo FROM cli_maximo_ph_admin.clientes WHERE id=?`,[req.user.id_cliente]);
             logo = logo[0].logo;

        let access = await getModuleAccess({
          user: req.user.id, 
          client: req.user.id_cliente, 
          module: 14, 
          pool
        });
    
        //pool.end();

        return res.json({success: true, data: {simpleEnviroment, erpBases, conceptoAdministracion, conceptoAdministracionParqueadero, conceptoAdministracionCuartoUtil, conceptoIntereses, conceptoVisita, erpTotalsSynced, access, logo}});
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};

const getValidateAPIKEYERP = async (req, res) => {
    console.log('getValidateAPIKEYERP');
    try {    
        const pool = poolSys.getPool(req.user.token_db);

        const { key } = req.params;

        const instance = axios.create({
            baseURL: `${process.env.URL_API_ERP}`,
            headers: {
              'Authorization': key,
              'Content-Type': 'application/json'
            }
        });

        var url = `${process.env.URL_API_ERP}nit`;
        let validateAPIKEYERP = await instance.get(url);
            validateAPIKEYERP = validateAPIKEYERP.data;
        
        await updateSysEnv({
            name: 'api_key_erp',
            val: key,
            pool: pool
        });
        
        //pool.end();

        return res.json({success: true, message: "The API KEY has been assigned into your environment."});
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};

const getSyncAPIKEYERP = async (req, res) => {
    try {    
        const registerSchema = Joi.object({
            origin: Joi.number().valid('cuentas', 'comprobantes', 'centro_costos', 'nits').required()
        });
    
        //VALIDATE FORMAT FIELDS
        const { error } = registerSchema.validate(req.body);
        if (error) {
          return res.status(201).json({ success: false, error: error.message });
        }
        const { origin } = req.body;
        
        const pool = poolSys.getPool(req.user.token_db);
                
        let api_key_erp = await getSysEnv({
            name: 'api_key_erp',
            pool: pool
        });
                
        let updateInsertERP = [];
        let pathERP = '';
        let typeERP = '';
        let codeFieldERP = 'codigo';

        switch(origin){
            case "cuentas":
                pathERP = 'plan-cuenta?auxiliar=1';
                typeERP = 2;
                codeFieldERP = 'cuenta';
            break;
            case "comprobantes":
                pathERP = 'comprobantes';
                typeERP = 1;
            break;
            case "centro_costos":
                pathERP = 'cecos';
                typeERP = 0;
            break;
            case "nits":
                pathERP = 'nit';
                typeERP = 3;
            break;
        }

        const instance = axios.create({
			baseURL: `${process.env.URL_API_ERP}`,
			headers: {
				'Authorization': api_key_erp,
				'Content-Type': 'application/json'
			}
		});

        let dataFromERP = await instance.get(pathERP);
            dataFromERP = dataFromERP.data.data;
            
        if(typeERP !=3 ) { //SINCRONIZAR CECOS, CUENTAS, COMRPOBANTES
            Object.keys(dataFromERP).forEach((id)=>{
                let recordERP = dataFromERP[id];
                updateInsertERP.push(`INSERT INTO erp_maestras (tipo, id_erp, codigo, nombre)
                    VALUES (${typeERP}, '${recordERP.id}', '${recordERP[codeFieldERP]}', '${recordERP.nombre}')
                    ON DUPLICATE KEY UPDATE id_erp = '${recordERP.id}',  codigo = '${recordERP[codeFieldERP]}', nombre = '${recordERP.nombre}'`);
            });
        } else {// SINCRONIZAR NITS
            dataFromERP.forEach(async (nitERP) => {
                var id_nit = await getPersona({//BUSCAR NIT
                    id_tercero_erp: nitERP.id,
                    pool: pool
                });

                if (id_nit) { //ACTUALIZAR SI EXITE NIT 
                    await pool.query(`UPDATE personas SET id_tercero_erp='${nitERP.id}' WHERE numero_documento='${nitERP.numero_documento}'`);
                } else { //CREAR SI NO EXISTE NIT
                    await pool.query(`INSERT INTO personas (id_tercero_erp, tipo_documento, numero_documento, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, celular, email, direccion, fecha_nacimiento, sexo, avatar, importado) VALUES (${nitERP.id},${nitERP.id_tipo_documento && nitERP.id_tipo_documento != null ? nitERP.id_tipo_documento : "''"},${nitERP.numero_documento && nitERP.numero_documento != null ? nitERP.numero_documento : "''"},${nitERP.primer_nombre && nitERP.primer_nombre != null ? "'"+nitERP.primer_nombre+"'" : "''"},${nitERP.otros_nombres && nitERP.otros_nombres != null ? "'"+nitERP.otros_nombres+"'" : "''"},${nitERP.primer_apellido && nitERP.primer_apellido != null ? "'"+nitERP.primer_apellido+"'" : "''"},${nitERP.segundo_apellido && nitERP.segundo_apellido != null ? "'"+nitERP.segundo_apellido+"'" : "''"},${nitERP.telefono_1 && nitERP.telefono_1 != null ? nitERP.telefono_1 : null},${nitERP.telefono_2 && nitERP.telefono_2 != null ? nitERP.telefono_2 : null},${nitERP.email && nitERP.email != null ? "'"+nitERP.email+"'" : null},${nitERP.direccion && nitERP.direccion != null ? "'"+nitERP.direccion+"'" : null},${null},${null},${null},${null})`);
                }
            });
        }
        if (updateInsertERP.length) {
            updateInsertERP = updateInsertERP.join(';');
            
            await pool.query(updateInsertERP);
        }

        //pool.end();

        return res.json({success: true, data: {message: 'Data synced'}});
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};

const getPersona = async ({id_tercero_erp, pool})=>{
    let [persona] = await pool.query(`SELECT id_tercero_erp FROM personas WHERE id_tercero_erp = ?`, [id_tercero_erp] );
    
    persona = persona.length ? persona[0].id_tercero_erp : "";

    return persona;
};

const putEnviromentmaximo = async (req, res) => {
    try {
        const registerSchema = Joi.object({
            area_total_m2:Joi.number().allow(null,''), 
            razon_social:Joi.string().allow(null,''), 
            nit:Joi.string().allow(null,''), 
            direccion:Joi.string().allow(null,''), 
            telefono:Joi.string().allow(null,''), 
            email:Joi.string().allow(null,''), 
            texto_cuenta_cobro:Joi.string().allow(null,''), 
            consecutivo_gastos:Joi.number().allow(null,''), 
            consecutivo_pagos:Joi.number().allow(null,''), 
            consecutivo_recibos_caja:Joi.number().allow(null,''), 
            consecutivo_ventas:Joi.number().allow(null,''), 
            validacion_estricta_area:Joi.boolean().allow(null,''), 
            agrupar_cuenta_cobro:Joi.boolean().allow(null,''), 
            id_comprobante_gastos_erp:Joi.number().allow(null,''), 
            id_comprobante_pagos_erp:Joi.number().allow(null,''), 
            id_comprobante_recibos_caja_erp:Joi.number().allow(null,''), 
            id_comprobante_ventas_erp:Joi.number().allow(null,''), 
            id_cuenta_intereses_erp:Joi.number().allow(null,''), 
            id_cuenta_descuento_erp:Joi.number().allow(null,''), 
            id_cuenta_anticipos_erp:Joi.number().allow(null,''), 
            id_cuenta_egreso_pagos_erp:Joi.number().allow(null,''), 
            id_cuenta_ingreso_recibos_caja_erp:Joi.number().allow(null,''), 
            id_cuenta_ingreso_pasarela_erp:Joi.number().allow(null,''), 
            id_concepto_administracion:Joi.number().allow(null,''), 
            id_concepto_administracion_parqueadero:Joi.number().allow(null,''), 
            id_concepto_administracion_cuarto_util:Joi.number().allow(null,''), 
            id_concepto_intereses:Joi.number().allow(null,''), 
            id_concepto_visita:Joi.number().allow(null,''), 
            numero_total_unidades:Joi.number().allow(null,''), 
            porcentaje_intereses_mora:Joi.number().allow(null,''), 
            redondeo_conceptos:Joi.number().allow(null,''), 
            control_fecha_digitacion:Joi.number().allow(null,''), 
            valor_total_presupuesto_year_actual: Joi.number().allow(null,''),
            periodo_facturacion: Joi.string().allow(null,''),
            dia_limite_pago_sin_interes:Joi.number().allow(null,''),
            dia_limite_descuento_pronto_pago:Joi.number().allow(null,''),
            porcentaje_descuento_pronto_pago:Joi.number().allow(null,''),
            editar_valor_admon_inmueble:Joi.boolean().allow(null,'')
        });
  
        //VALIDATE FORMAT FIELDS
        const { error } = registerSchema.validate(req.body);
        if (error) {
            return res.status(201).json({ success: false, error: error.message });
        }
        
        const { area_total_m2, validacion_estricta_area, agrupar_cuenta_cobro, consecutivo_gastos, consecutivo_pagos, consecutivo_recibos_caja, consecutivo_ventas, id_comprobante_gastos_erp, id_comprobante_pagos_erp, id_comprobante_recibos_caja_erp, id_comprobante_ventas_erp, id_cuenta_intereses_erp, id_cuenta_descuento_erp, id_cuenta_anticipos_erp, numero_total_unidades, porcentaje_intereses_mora, valor_total_presupuesto_year_actual, periodo_facturacion, razon_social, nit, direccion, telefono, email, texto_cuenta_cobro, id_concepto_administracion, id_concepto_administracion_parqueadero, id_concepto_administracion_cuarto_util, id_concepto_visita, id_concepto_intereses, redondeo_conceptos, control_fecha_digitacion, dia_limite_pago_sin_interes, dia_limite_descuento_pronto_pago,  porcentaje_descuento_pronto_pago, editar_valor_admon_inmueble, id_cuenta_ingreso_recibos_caja_erp, id_cuenta_egreso_pagos_erp, id_cuenta_ingreso_pasarela_erp } = req.body;
    
        let pool = poolSys.getPool(req.user.token_db);

        let editarValorAdmonInmueble = await getSysEnv({
            name: 'editar_valor_admon_inmueble',
            pool: pool
        });
        
        let valor_total_presupuesto_year_actual_before = await getSysEnv({
            name: 'valor_total_presupuesto_year_actual',
            pool: pool
        });
        valor_total_presupuesto_year_actual_before = Number(valor_total_presupuesto_year_actual_before);
        
        let area_total_m2_before = await getSysEnv({
            name: 'area_total_m2',
            pool: pool
        });
        area_total_m2_before = Number(area_total_m2_before);

        //EDIT ENVIROMENT
        await pool.query(`
                UPDATE entorno SET valor = ? WHERE campo = 'area_total_m2'; 
                UPDATE entorno SET valor = ? WHERE campo = 'consecutivo_gastos'; 
                UPDATE entorno SET valor = ? WHERE campo = 'consecutivo_recibos_caja'; 
                UPDATE entorno SET valor = ? WHERE campo = 'consecutivo_ventas'; 
                UPDATE entorno SET valor = ? WHERE campo = 'id_comprobante_gastos_erp'; 
                UPDATE entorno SET valor = ? WHERE campo = 'id_comprobante_recibos_caja_erp'; 
                UPDATE entorno SET valor = ? WHERE campo = 'id_comprobante_ventas_erp'; 
                UPDATE entorno SET valor = ? WHERE campo = 'id_cuenta_descuento_erp'; 
                UPDATE entorno SET valor = ? WHERE campo = 'id_cuenta_anticipos_erp'; 
                UPDATE entorno SET valor = ? WHERE campo = 'numero_total_unidades'; 
                UPDATE entorno SET valor = ? WHERE campo = 'porcentaje_intereses_mora'; 
                UPDATE entorno SET valor = ? WHERE campo = 'valor_total_presupuesto_year_actual'; 
                UPDATE entorno SET valor = ? WHERE campo = 'validacion_estricta_area'; 
                
                UPDATE entorno SET valor = ? WHERE campo = 'razon_social'; 
                UPDATE entorno SET valor = ? WHERE campo = 'nit'; 
                UPDATE entorno SET valor = ? WHERE campo = 'direccion'; 
                UPDATE entorno SET valor = ? WHERE campo = 'telefono'; 
                UPDATE entorno SET valor = ? WHERE campo = 'email'; 
                UPDATE entorno SET valor = ? WHERE campo = 'texto_cuenta_cobro'; 

                UPDATE entorno SET valor = ? WHERE campo = 'id_concepto_administracion'; 
                UPDATE entorno SET valor = ? WHERE campo = 'id_concepto_administracion_parqueadero'; 
                UPDATE entorno SET valor = ? WHERE campo = 'id_concepto_administracion_cuarto_util'; 

                UPDATE entorno SET valor = ? WHERE campo = 'id_concepto_visita'; 

                UPDATE entorno SET valor = ? WHERE campo = 'id_concepto_intereses'; 
                
                UPDATE entorno SET valor = ? WHERE campo = 'redondeo_conceptos';
                
                UPDATE entorno SET valor = ? WHERE campo = 'control_fecha_digitacion';
                
                UPDATE entorno SET valor = ? WHERE campo = 'periodo_facturacion';

                UPDATE entorno SET valor = ? WHERE campo = 'agrupar_cuenta_cobro';
                
                UPDATE entorno SET valor = ? WHERE campo = 'dia_limite_pago_sin_interes';
                
                UPDATE entorno SET valor = ? WHERE campo = 'dia_limite_descuento_pronto_pago';

                UPDATE entorno SET valor = ? WHERE campo = 'porcentaje_descuento_pronto_pago';
                
                UPDATE entorno SET valor = ? WHERE campo = 'editar_valor_admon_inmueble';

                UPDATE entorno SET valor = ? WHERE campo = 'consecutivo_pagos';
                
                UPDATE entorno SET valor = ? WHERE campo = 'id_comprobante_pagos_erp';

                UPDATE entorno SET valor = ? WHERE campo = 'id_cuenta_ingreso_recibos_caja_erp';
                
                UPDATE entorno SET valor = ? WHERE campo = 'id_cuenta_egreso_pagos_erp';
                
                UPDATE entorno SET valor = ? WHERE campo = 'id_cuenta_ingreso_pasarela_erp';
            `,
            [area_total_m2, consecutivo_gastos, consecutivo_recibos_caja, consecutivo_ventas, id_comprobante_gastos_erp, id_comprobante_recibos_caja_erp, id_comprobante_ventas_erp, id_cuenta_descuento_erp, id_cuenta_anticipos_erp, numero_total_unidades, porcentaje_intereses_mora, valor_total_presupuesto_year_actual, validacion_estricta_area, razon_social, nit, direccion, telefono, email, texto_cuenta_cobro, id_concepto_administracion, id_concepto_administracion_parqueadero, id_concepto_administracion_cuarto_util, id_concepto_visita, id_concepto_intereses, redondeo_conceptos, control_fecha_digitacion, periodo_facturacion, agrupar_cuenta_cobro, dia_limite_pago_sin_interes, dia_limite_descuento_pronto_pago,  porcentaje_descuento_pronto_pago,editar_valor_admon_inmueble, consecutivo_pagos, id_comprobante_pagos_erp, id_cuenta_ingreso_recibos_caja_erp, id_cuenta_egreso_pagos_erp, id_cuenta_ingreso_pasarela_erp]
        );

        if(area_total_m2_before!=area_total_m2){
            await pool.query(`UPDATE
                inmuebles t1
            SET
                t1.coeficiente = ROUND((t1.area/(SELECT t2.valor FROM entorno t2 WHERE t2.campo = 'area_total_m2')),4)
            WHERE 
                t1.eliminado=0`);
        }

        if((valor_total_presupuesto_year_actual_before!=valor_total_presupuesto_year_actual) || (area_total_m2_before!=area_total_m2)){
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

            if(!editarValorAdmonInmueble){
                //EDIT PROPERTY ADMON
                await pool.query(`UPDATE
                    inmuebles t1
                SET
                    t1.valor_total_administracion = ROUND((SELECT (t2.valor/12) FROM entorno t2 WHERE t2.campo = 'valor_total_presupuesto_year_actual')*t1.coeficiente)
                WHERE 
                    t1.eliminado=0`);
            }

            await pool.query(`DELETE t2 FROM facturas_ciclica t1 INNER JOIN factura_ciclica_detalles t2 ON t2.id_factura_ciclica = t1.id WHERE t2.id_concepto_factura=?`,[adminConcept]);

            await pool.query(`DELETE t1 FROM facturas_ciclica t1 LEFT OUTER JOIN factura_ciclica_detalles t2 ON t2.id_factura_ciclica = t1.id WHERE t2.id IS NULL`,[adminConcept]);

            await pool.query(`DELETE t2 FROM facturas_ciclica t1 INNER JOIN factura_ciclica_detalles t2 ON t2.id_factura_ciclica = t1.id WHERE t2.id_concepto_factura=?`,[adminConceptParqueadero]);

            await pool.query(`DELETE t1 FROM facturas_ciclica t1 LEFT OUTER JOIN factura_ciclica_detalles t2 ON t2.id_factura_ciclica = t1.id WHERE t2.id IS NULL`,[adminConceptParqueadero]);

            await pool.query(`DELETE t2 FROM facturas_ciclica t1 INNER JOIN factura_ciclica_detalles t2 ON t2.id_factura_ciclica = t1.id WHERE t2.id_concepto_factura=?`,[adminConceptCuartoUtil]);

            await pool.query(`DELETE t1 FROM facturas_ciclica t1 LEFT OUTER JOIN factura_ciclica_detalles t2 ON t2.id_factura_ciclica = t1.id WHERE t2.id IS NULL`,[adminConceptCuartoUtil]);

            let [properties] = await pool.query(`SELECT id, tipo FROM inmuebles WHERE eliminado=0`);
            
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

                //CREATE OR UPDATE CYCLICAL BILL
                await createUpdatePropertyCyclicalBill({ idInmueble: property.id, pool, adminConcept: conceptAdmonToUpdate, admonValidate: 0, percent: 0, req });
            }));
        }else{
            await roundAllValuesPropertyCyclicalBill({pool});
        }

        //pool.end();

        return res.json({success: true});
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};

const deleteNotifications = async (req, res) => {  
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
  
      //DELETE NOTIFICATION
      await pool.query(`UPDATE mensajes_push_historia SET vista = 1 WHERE id = ?`,
        [id]
      );
      
      //pool.end();
  
      return res.json({success: true, data: {Notification: { id }}});
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
  };
export {
    getSummaryErp,
    getSyncAPIKEYERP,
    deleteNotifications,
    getValidateAPIKEYERP,
    putEnviromentmaximo
};
  