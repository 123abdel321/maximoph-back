import Joi  from "joi";
import { poolSys } from "../../../db.js";
import { getSysEnv, roundValues, getModuleAccess } from "../../../helpers/sysEnviroment.js";
import { createUpdatePropertyCyclicalBill } from "../../../helpers/sysPropertyCyclicalBill.js";
import { genLog } from "../../../helpers/sysLogs.js";

const getAllProperties = async (req, res) => {
    try {
        let pool = poolSys.getPool(req.user.token_db);

        let access = await getModuleAccess({
            user: req.user.id, 
            client: req.user.id_cliente, 
            module: 2, 
            pool
        });

        let accessToRead = false;
        access.map(permission=>{ if(permission.permiso=='INGRESAR'&&permission.asignado==1&&!accessToRead) accessToRead = true; });
        
        let properties = [];
        
        let totals = [];
        
        //if(accessToRead){
            [properties] = await pool.query(
                `SELECT 
                    t1.*, 
                    t2.nombre AS zonaText,
                    CASE t1.tipo 
                        WHEN 0 THEN 'INMUEBLE'
                        WHEN 1 THEN 'PARQUEADERO'
                        WHEN 2 THEN 'CUARTO ÚTIL'
                    END AS tipoText,
                    (SELECT 
                        TRIM(REPLACE(REPLACE(CONCAT(
                            IFNULL(t3.primer_nombre,''),' ',
                            IFNULL(t3.segundo_nombre,''),' ',
                            IFNULL(t3.primer_apellido,''),' ',
                            IFNULL(t3.segundo_apellido,''),' '
                          ),'  ',' '),'  ',' ')) AS inquilino
                    FROM inmueble_personas_admon t6 
                        INNER JOIN personas t3 ON t3.id = t6.id_persona
                    WHERE 
                        t6.tipo = 1 AND t6.id_inmueble = t1.id LIMIT 1) AS inquilino,
                    (SELECT 
                        TRIM(REPLACE(REPLACE(CONCAT(
                            IFNULL(t5.primer_nombre,''),' ',
                            IFNULL(t5.segundo_nombre,''),' ',
                            IFNULL(t5.primer_apellido,''),' ',
                            IFNULL(t5.segundo_apellido,''),' '
                        ),'  ',' '),'  ',' ')) AS propietario
                    FROM inmueble_personas_admon t4 
                        INNER JOIN personas t5 ON t5.id = t4.id_persona
                    WHERE 
                        t4.tipo = 0 AND t4.id_inmueble = t1.id LIMIT 1) AS propietario,
                    IFNULL((SELECT 
                        SUM(IFNULL(t9.porcentaje_administracion,0))
                    FROM inmueble_personas_admon t9 
                    WHERE 
                        t9.id_inmueble = t1.id),0) AS admon_completed
                FROM inmuebles t1 
                INNER JOIN zonas t2 ON t2.id = t1.id_inmueble_zona
                WHERE t1.eliminado=0`);
                
            [totals] = await pool.query(
                `SELECT 
                    COUNT(t1.id) AS unidades_ingresadas,
                    (SELECT IFNULL(t4.valor,0) FROM entorno t4 WHERE t4.campo='numero_total_unidades') AS unidades_entorno,
                    
                    SUM(IFNULL(t1.area,0)) AS area_ingresada,
                    (SELECT IFNULL(t2.valor,0) FROM entorno t2 WHERE t2.campo='area_total_m2') AS area_entorno,
                    
                    ROUND(SUM(IFNULL(t1.coeficiente,0)*100),2) AS coeficiente_ingresado,
                    100 AS coeficiente_entorno,

                    SUM(IFNULL(t1.valor_total_administracion,0)*12) AS ppto_ingresado,
                    (SELECT IFNULL(t3.valor,0) FROM entorno t3 WHERE t3.campo='valor_total_presupuesto_year_actual') AS ppto_entorno
                FROM inmuebles t1 
                WHERE t1.eliminado=0`);
            totals = totals[0];

            properties.map((propertie,pos)=>{
                propertie.label = `${propertie.zonaText} ${propertie.numero_interno_unidad} -  ${propertie.tipoText}`;
                propertie.value = propertie.id;

                properties[pos] = propertie;
            });
        //}
        
        let editarValorAdmonInmueble = await getSysEnv({
            name: 'editar_valor_admon_inmueble',
            pool: pool
        });

        //pool.end();

        return res.json({success: true, data: properties, totals: totals, editarValorAdmonInmueble, access});
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    } 
};

const createProperty = async (req, res) => {   
    try {
        const registerSchema = Joi.object({
            id_inmueble_zona: Joi.number().required(), 
            tipo: Joi.number().required(), 
            numero_interno_unidad: Joi.string().required(), 
            area: Joi.number().required(), 
            coeficiente: Joi.number().required(), 
            valor_total_administracion: Joi.number().required(), 
            numero_perros: Joi.number().required(), 
            numero_gatos: Joi.number().required(), 
            observaciones: Joi.string().allow(null,'')
        });

        //VALIDATE FORMAT FIELDS
        const { error } = registerSchema.validate(req.body);
        if (error) {
        return res.status(201).json({ success: false, error: error.message });
        }

        const { id_inmueble_zona, tipo, numero_interno_unidad, area, coeficiente, valor_total_administracion, numero_perros, numero_gatos, observaciones } = req.body;

        let pool = poolSys.getPool(req.user.token_db);

        let editarValorAdmonInmueble = await getSysEnv({
            name: 'editar_valor_admon_inmueble',
            pool: pool
        });
        
        let areaTotal = await getSysEnv({
            name: 'area_total_m2',
            pool: pool
        });
        
        let pptoTotal = await getSysEnv({
            name: 'valor_total_presupuesto_year_actual',
            pool: pool
        });
        console.log('pptoTotal: ',pptoTotal);
        console.log('areaTotal: ',areaTotal);
        if (!pptoTotal||!areaTotal) {
            return res.status(201).json({ success: false, error: `Antes de crear inmuebles debes configurar en Utilidades > Entorno, el Área Total y el Presupuesto Anual.` });
        }

        const [existProperty] = await pool.query(
            "SELECT * FROM inmuebles WHERE numero_interno_unidad = ?",
            [numero_interno_unidad]
        );

        if (existProperty.length) {
            return res.status(201).json({ success: false, error: `El número interno de unidad ${numero_interno_unidad} ya se encuentra registrado.` });
        }

        let coeficienteValidate = (area/areaTotal).toFixed(4);
        let admonValidate = Math.round(pptoTotal*Number(coeficienteValidate));
            admonValidate = Math.round((admonValidate/12));

        admonValidate = await roundValues({
            val: admonValidate,
            pool
        });

        if(editarValorAdmonInmueble){
            admonValidate = valor_total_administracion;
        }

        //CREATE PROPERTY
        const [insertedNewProperty] = await pool.query(`INSERT INTO inmuebles 
                (id_inmueble_zona, tipo, numero_interno_unidad, area, coeficiente, valor_total_administracion, numero_perros, numero_gatos, observaciones, created_by) 
                    VALUES 
                (?, ?, ?, ?, ?, ?, ?, ?, UPPER(?), ?)`,
        [id_inmueble_zona, tipo, numero_interno_unidad, area, coeficienteValidate, admonValidate, numero_perros, numero_gatos, observaciones, req.user.id]
        );
        
        //GET NEW PROPERTY
        const [rows] = await pool.query(`SELECT 
            t1.*, 
            t2.nombre AS zonaText,
            CASE t1.tipo 
                WHEN 0 THEN 'INMUEBLE'
                WHEN 1 THEN 'PARQUEADERO'
                WHEN 2 THEN 'CUARTO ÚTIL'
            END AS tipoText
        FROM inmuebles t1 
            INNER JOIN zonas t2 ON t2.id = t1.id_inmueble_zona
        WHERE 
            t1.id = ?`, [ insertedNewProperty.insertId ]);
        
        let property = rows[0];
        
        await genLog({
            module: 'inmuebles', 
            idRegister: property.id, 
            recordBefore: property, 
            oper: 'CREATE', 
            detail: `INMUEBLE CON CÓDIGO ${property.numero_interno_unidad} CREADO POR ${req.user.email}`, 
            user: req.user.id,
            pool
        });

        //pool.end();

        return res.json({success: true, data: {property}});
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    } 
};

const putProperty = async (req, res) => {   
    try {
        const registerSchema = Joi.object({
            id_inmueble_zona: Joi.number().required(), 
            tipo: Joi.number().required(), 
            numero_interno_unidad: Joi.string().required(), 
            area: Joi.number().required(), 
            coeficiente: Joi.number().required(), 
            valor_total_administracion: Joi.number().required(), 
            numero_perros: Joi.number().required(), 
            numero_gatos: Joi.number().required(), 
            observaciones: Joi.string().allow(null,''),
            label: Joi.allow(null,''),
            value: Joi.allow(null,''),
            inquilino: Joi.allow(null,''),
            propietario: Joi.allow(null,''),
            admon_completed: Joi.allow(null,''),
            zonaText: Joi.string(),
            tipoText: Joi.string(),
            created_by: Joi.number(), 
            created_at: Joi.date(), 
            importado: Joi.number().allow(null,''),
            updated_at: Joi.string().allow(null,''), 
            updated_by: Joi.number().allow(null,''), 
            id: Joi.number().required()
        });

        //VALIDATE FORMAT FIELDS
        const { error } = registerSchema.validate(req.body);
        if (error) {
        return res.status(201).json({ success: false, error: error.message });
        }

        const { id_inmueble_zona, tipo, numero_interno_unidad, area, coeficiente, valor_total_administracion, numero_perros, numero_gatos, observaciones, id } = req.body;

        let pool = poolSys.getPool(req.user.token_db);

        let editarValorAdmonInmueble = await getSysEnv({
            name: 'editar_valor_admon_inmueble',
            pool: pool
        });

        let areaTotal = await getSysEnv({
            name: 'area_total_m2',
            pool: pool
        });
        
        let pptoTotal = await getSysEnv({
            name: 'valor_total_presupuesto_year_actual',
            pool: pool
        });
        console.log('pptoTotal2: ',pptoTotal);
        console.log('areaTotal2: ',areaTotal);
        if (!pptoTotal||!areaTotal) {
            return res.status(201).json({ success: false, error: `Antes de crear inmuebles debes configurar en Utilidades > Entorno, el Área Total y el Presupuesto Anual.` });
        }

        const [existProperty] = await pool.query(
            "SELECT * FROM inmuebles WHERE numero_interno_unidad = ? AND id<>?",
            [numero_interno_unidad, id]
        );

        if (existProperty.length) {
            return res.status(201).json({ success: false, error: `El número interno de unidad ${numero_interno_unidad} ya se encuentra registrado.` });
        }

        let coeficienteValidate = (area/areaTotal).toFixed(4);
        let admonValidate = Math.round(pptoTotal*Number(coeficienteValidate));
            admonValidate = Math.round((admonValidate/12));

        admonValidate = await roundValues({
            val: admonValidate,
            pool
        });

        if(editarValorAdmonInmueble){
            admonValidate = valor_total_administracion;
        }

        //GET BEFORE EDITED PROPERTY
        const [rowsBefore] = await pool.query(`SELECT * FROM inmuebles WHERE id = ?`, [ id ]);

        let propertyBefore = rowsBefore[0];

        //UPDATE PROPERTY
        await pool.query(`UPDATE inmuebles SET
            id_inmueble_zona = ?,
            tipo = ?,
            numero_interno_unidad = ?,
            area = ?,
            coeficiente = ?,
            valor_total_administracion = ?,
            numero_perros = ?,
            numero_gatos = ?,
            observaciones = UPPER(?),
            updated_at = NOW(), 
            updated_by = ? 
        WHERE 
            id = ?`,
        [id_inmueble_zona, tipo, numero_interno_unidad, area, coeficienteValidate, admonValidate, numero_perros, numero_gatos, observaciones, req.user.id, id]
        );

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

        switch(Number(tipo)){
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
        await createUpdatePropertyCyclicalBill({ idInmueble: id, pool, adminConcept: conceptAdmonToUpdate, admonValidate, percent: coeficienteValidate, req });

        //GET EDITED PROPERTY
        const [rows] = await pool.query(`SELECT 
            t1.*, 
            t2.nombre AS zonaText,
            CASE t1.tipo 
                WHEN 0 THEN 'INMUEBLE'
                WHEN 1 THEN 'PARQUEADERO'
                WHEN 2 THEN 'CUARTO ÚTIL'
            END AS tipoText
        FROM inmuebles t1 
            INNER JOIN zonas t2 ON t2.id = t1.id_inmueble_zona
        WHERE 
            t1.id = ?`, [ id ]);
        
        let property = rows[0];
        
        await genLog({
            module: 'inmuebles', 
            idRegister: property.id, 
            recordBefore: propertyBefore, 
            oper: 'UPDATE', 
            detail: `INMUEBLE CON CÓDIGO ${property.numero_interno_unidad} ACTUALIZADO POR ${req.user.email}`, 
            user: req.user.id,
            pool
        });
        
        //pool.end();

        return res.json({success: true, data: {property}});
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    } 
};


const deleteProperty = async (req, res) => {    
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

        //GET PROPERTY
        let [property] = await pool.query(`SELECT * FROM inmuebles WHERE id = ?`,[id]);
        property = property[0];
        
        //DELETE PROPERTY
        await pool.query(`UPDATE inmuebles SET eliminado = 1 WHERE id = ?`,
        [id]
        );
        
        //DELETE PROPERTY CYCLICAL BILL
        await pool.query(`DELETE
            t3
        FROM inmuebles t1 
            LEFT OUTER JOIN facturas_ciclica t2 ON t2.id_inmueble =t1.id
            LEFT OUTER JOIN factura_ciclica_detalles t3 ON t3.id_factura_ciclica =t2.id
        WHERE 
            t1.eliminado = 1;
        
        DELETE
            t2
        FROM inmuebles t1 
            LEFT OUTER JOIN facturas_ciclica t2 ON t2.id_inmueble =t1.id
            LEFT OUTER JOIN factura_ciclica_detalles t3 ON t3.id_factura_ciclica =t2.id
        WHERE 
            t1.eliminado = 1;`);
        
        await genLog({
            module: 'inmuebles', 
            idRegister: property.id, 
            recordBefore: {}, 
            oper: 'DELETE', 
            detail: `INMUEBLE CON CÓDIGO ${property.numero_interno_unidad} ELIMINADO POR ${req.user.email}`, 
            user: req.user.id,
            pool
        });

        //pool.end();

        return res.json({success: true, data: {property: { id }}});
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};

export {
  getAllProperties,
  createProperty,
  deleteProperty,
  putProperty
};
