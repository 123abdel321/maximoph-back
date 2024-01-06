import Joi  from "joi";
import { poolSys } from "../../../db.js";
import { getSysEnv, roundValuesWithConfig } from "../../../helpers/sysEnviroment.js";

import multer from "multer";
import stream from "stream";
import readline from "readline";

const storage = multer.memoryStorage();

const getColumnsByOrigin = (origin)=>{
    let csvColumns = [];
    
    switch(origin){
        case "inmuebles": 
            csvColumns = [
                "numero_interno_unidad_inmueble",
                "tipo_inmueble",
                "nombre_zona_inmueble",
                "area_inmueble",
                "numero_mascotas_caninas_inmueble",
                "numero_mascotas_felinas_inmueble",
                "observaciones"
            ];
        break;
        case "inmuebles-admon": 
            csvColumns = [
                "numero_interno_unidad_inmueble",
                "numero_documento_persona",
                "es_propietario",
                "porcentaje_administracion",
                "notificacion_push",
                "notificacion_correo",
                "notificacion_fisica"
            ];
        break;
        case "personas": 
            csvColumns = [
                "tipo_documento_persona",
                "numero_documento_persona",
                "genero_persona",
                "primer_nombre_persona",
                "segundo_nombre_persona",
                "primer_apellido_persona",
                "segundo_apellido_persona",
                "direccion_persona",
                "celular_persona",
                "email_persona"
            ];
        break;
        case "proveedores": 
            csvColumns = [
                "numero_documento_persona",
                "tipo_proveedor",
                "nombre_negocio",
                "observacion"
            ];
        break;
    }

    return csvColumns;
};

const processFileProperties = async (parsedFile, user, pool)=>{
    const [propertiesQ] = await pool.query(`SELECT numero_interno_unidad FROM inmuebles WHERE eliminado=0`);
    let properties = [];
    propertiesQ.map(property=>properties.push(property.numero_interno_unidad));

    const [zonesQ] = await pool.query(`SELECT id, nombre FROM zonas WHERE tipo=1`);
    let zones = [];
    let zonesById = [];
    zonesQ.map(zone=>{ 
        zones.push(zone.nombre.toUpperCase());
        zonesById[zone.nombre.toUpperCase()] = zone.id; 
    });

    let numeros_interno_unidad_inmueble = [];
    
    let numero_interno_unidad_inmueble = '';
    let tipo_inmueble = '';
    let nombre_zona_inmueble = '';
    let area_inmueble = '';
    let numero_mascotas_caninas_inmueble = '';
    let numero_mascotas_felinas_inmueble = '';
    let observaciones = '';
    
    let errors = [];
    let propertiesToInsert = [];
            
    let areaTotal = await getSysEnv({
        name: 'area_total_m2',
        pool: pool
    });
        
    let pptoTotal = await getSysEnv({
        name: 'valor_total_presupuesto_year_actual',
        pool: pool
    });

    let propertyTypes = {'INMUEBLE':0,'PARQUEADERO':1,'CUARTO ÚTIL':2,'CUARTO UTIL':2};
    
    let [configRound] = await pool.query(`SELECT IFNULL(valor,'') AS valor FROM entorno WHERE campo = 'redondeo_conceptos'`);

    await Promise.all(parsedFile.map(async (property, pK)=>{
        if(pK>0){
            parsedFile[pK].map((value, fK)=>{
                switch(fK){
                    case 0: numero_interno_unidad_inmueble = value; break;
                    case 1: tipo_inmueble = value; break;
                    case 2: nombre_zona_inmueble = value; break;
                    case 3: area_inmueble = value; break;
                    case 4: numero_mascotas_caninas_inmueble = value; break;
                    case 5: numero_mascotas_felinas_inmueble = value; break;
                    case 6: observaciones = value; break;
                }
            });

            if(!numero_interno_unidad_inmueble){
                errors.push([pK, `El número interno de la unidad es obligatorio.`]);
            }

            if(!tipo_inmueble){
                errors.push([pK, `El tipo de inmueble es obligatorio. Valores permitidos: INMUEBLE, PARQUEADERO, CUARTO UTIL.`]);
            }

            if(!nombre_zona_inmueble){
                errors.push([pK, `El nombre de la zona del inmueble es obligatorio.`]);
            }

            if(!Number(area_inmueble)){
                errors.push([pK, `El área del inmueble debe ser sólo un número con decimales separados por . y es obligatoria.`]);
            }

            if(properties.indexOf(numero_interno_unidad_inmueble)>=0){
                errors.push([pK, `El inmueble ${numero_interno_unidad_inmueble} ya se encuentra registrado.`]);
            }

            if(numeros_interno_unidad_inmueble.indexOf(numero_interno_unidad_inmueble)>=0){
                errors.push([pK, `El inmueble ${numero_interno_unidad_inmueble} se encuentra más de una vez en el archivo.`]);
            }
            
            numeros_interno_unidad_inmueble.push(numero_interno_unidad_inmueble);

            if(zones.indexOf(nombre_zona_inmueble.toUpperCase())<0){
                errors.push([pK, `La zona con el nombre ${nombre_zona_inmueble} no se encuentra registrada.`]);
            }

            if(Number(area_inmueble)>Number(areaTotal)){
                errors.push([pK, `El área ${area_inmueble} es mayor al área total del inmueble ${areaTotal}.`]);
            }
            
            if(['INMUEBLE','PARQUEADERO','CUARTO ÚTIL','CUARTO UTIL'].indexOf(tipo_inmueble.toUpperCase())<0){
                errors.push([pK, `El tipo de inmueble ${tipo_inmueble} es incorrecto. Valores permitidos: INMUEBLE, PARQUEADERO, CUARTO UTIL.`]);
            }

            let coeficienteValidate = (Number(area_inmueble)/areaTotal).toFixed(4);
            let admonValidate = Math.round(pptoTotal*Number(coeficienteValidate));
                admonValidate = Math.round((admonValidate/12));
                admonValidate = roundValuesWithConfig({
                    val: admonValidate,
                    config: configRound
                });
            //numero_interno_unidad, tipo, id_inmueble_zona, area, numero_perros, numero_gatos, observaciones, coeficiente, valor_total_administracion, created_by
            propertiesToInsert.push(`('${numero_interno_unidad_inmueble}', '${propertyTypes[tipo_inmueble.toUpperCase()]}', '${zonesById[nombre_zona_inmueble.toUpperCase()]}', '${Number(area_inmueble)}', '${Number(numero_mascotas_caninas_inmueble)}', '${Number(numero_mascotas_felinas_inmueble)}', '${observaciones}', '${coeficienteValidate}', '${admonValidate}', '${user}')`);
        }
    }));
    
    if(errors.length==0&&propertiesToInsert.length){
        let propertiesToInsertSql = propertiesToInsert.join(',');
        await pool.query(`INSERT INTO inmuebles (numero_interno_unidad, tipo, id_inmueble_zona, area, numero_perros, numero_gatos, observaciones, coeficiente, valor_total_administracion, created_by) VALUES ${propertiesToInsertSql};`);

        return {success: true, registers: propertiesToInsert.length};
    }else{
        return {success: false, error: 'in-file', errors: errors};
    }
};

const processFilePropertiesAdmon = async (parsedFile, user, pool)=>{
    const [propertiesQ] = await pool.query(`SELECT id, numero_interno_unidad FROM inmuebles WHERE eliminado=0`);
    let propertiesId = [];
    propertiesQ.map(property=>{
        propertiesId[property.numero_interno_unidad.toUpperCase()] = property.id;
    });
    
    const [personsQ] = await pool.query(`SELECT id, numero_documento FROM personas WHERE eliminado=0`);
    let personasId = [];
    personsQ.map(person=>{
        personasId[person.numero_documento.toUpperCase()] = person.id;
    });
    
    let numero_interno_unidad_inmueble = '';
    let numero_documento_persona = '';
    let es_propietario = '';
    let porcentaje_administracion = '';
    let notificacion_push = '';
    let notificacion_correo = '';
    let notificacion_fisica = '';
    
    let errors = [];
    let propertiesOwnersRentalsToInsert = [];

    parsedFile.map((property, pK)=>{
        if(pK>0){
            property.map((value, fK)=>{
                switch(fK){
                    case 0: numero_interno_unidad_inmueble = value; break;
                    case 1: numero_documento_persona = value.replaceAll(".",""); break;
                    case 2: es_propietario = value; break;
                    case 3: porcentaje_administracion = Number(value.replaceAll(",",".")); break;
                    case 4: notificacion_push = (value.toUpperCase()=='SI'?1:0); break;
                    case 5: notificacion_correo = (value.toUpperCase()=='SI'?1:0); break;
                    case 6: notificacion_fisica = (value.toUpperCase()=='SI'?1:0); break;
                }
            });

            if(!numero_interno_unidad_inmueble){
                errors.push([pK, `El número interno de la unidad es obligatorio.`]);
            }

            if(!numero_documento_persona){
                errors.push([pK, `El número de documento de la persona es obligatorio.`]);
            }

            if(!es_propietario){
                errors.push([pK, `Se debe especificar si es propietario o no. Si o No.`]);
            }
            
            let personId = personasId[numero_documento_persona.replaceAll(".","").toUpperCase()];
            if(!personId){
                errors.push([pK, `La persona con el documento ${numero_documento_persona} no se encuentra registrada.`]);
            }
            
            let propertyId = propertiesId[numero_interno_unidad_inmueble.replaceAll(".","").toUpperCase()];
            if(!propertyId){
                errors.push([pK, `El inmueble con el número ${numero_interno_unidad_inmueble} no se encuentra registrado.`]);
            }

            //id_inmueble, id_persona, tipo, porcentaje_administracion, paga_administracion, enviar_notificaciones, enviar_notificaciones_mail, enviar_notificaciones_fisica
            propertiesOwnersRentalsToInsert.push(`('${propertyId}', '${personId}', '${(es_propietario.toUpperCase()=='NO'?1:0)}', '${porcentaje_administracion}', 
            '${(porcentaje_administracion?1:0)}', '${notificacion_push}', '${notificacion_correo}', '${notificacion_fisica}', 1, '${user}')`);
        }
    });

    if(errors.length==0&&propertiesOwnersRentalsToInsert.length){
        let propertiesOwnersRentalsToInsertSql = propertiesOwnersRentalsToInsert.join(',');
        await pool.query(`INSERT INTO inmueble_personas_admon (id_inmueble, id_persona, tipo, porcentaje_administracion, paga_administracion, enviar_notificaciones, enviar_notificaciones_mail, enviar_notificaciones_fisica, importado, created_by) VALUES ${propertiesOwnersRentalsToInsertSql};`);

        return {success: true, registers: propertiesOwnersRentalsToInsert.length};
    }else{
        return {success: false, error: 'in-file', errors: errors};
    }
};

const processFilePersons = async (parsedFile, user, pool, req)=>{
    const [personsQ] = await pool.query(`SELECT id, numero_documento FROM personas WHERE eliminado=0`);
    let personasId = [];
    personsQ.map(person=>{
        personasId[person.numero_documento.toUpperCase()] = person.id;
    });
    
    let tipo_documento_persona = '';
    let numero_documento_persona = '';
    let genero_persona = '';
    let primer_nombre_persona = '';
    let segundo_nombre_persona = '';
    let primer_apellido_persona = '';
    let segundo_apellido_persona = '';
    let direccion_persona = '';
    let celular_persona = '';
    let email_persona = '';
    
    let errors = [];
    let personsToInsert = [];
    
    let genero = {'MASCULINO':0,'FEMENINO':1};
    let tipoDoc = {'CEDULA':0,'CÉDULA':0,'NIT':1};

    let [rowCityCustomer] = await pool.query(`SELECT ciudad FROM cli_maximo_ph_admin.clientes WHERE id = ${req.user.id_cliente};`);
         rowCityCustomer = rowCityCustomer[0].ciudad.split("-");
         rowCityCustomer = rowCityCustomer.length ? (rowCityCustomer[1]||rowCityCustomer[0]) : '';
        
        [rowCityCustomer] = await pool.query(`SELECT id FROM erp_maestras WHERE nombre LIKE '%${rowCityCustomer}%';`);
        rowCityCustomer = rowCityCustomer[0]?.id;
        rowCityCustomer = rowCityCustomer ? `'${rowCityCustomer}'` : 'NULL';

    parsedFile.map((property, pK)=>{
        if(pK>0){
            property.map((value, fK)=>{
                switch(fK){
                    case 0: tipo_documento_persona = value.toUpperCase(); break;
                    case 1: numero_documento_persona = value.replaceAll(".",""); break;
                    case 2: genero_persona = value.toUpperCase(); break;
                    case 3: primer_nombre_persona = value.toUpperCase(); break;
                    case 4: segundo_nombre_persona = value.toUpperCase(); break;
                    case 5: primer_apellido_persona = value.toUpperCase(); break;
                    case 6: segundo_apellido_persona = value.toUpperCase(); break;
                    case 7: direccion_persona = value.toUpperCase(); break;
                    case 8: celular_persona = value; break;
                    case 9: email_persona = value.toUpperCase(); break;
                }
            });

            if(!tipo_documento_persona){
                errors.push([pK, `El tipo de documento es obligatorio.`]);
            }
            console.log(tipoDoc, tipo_documento_persona);
            if(!tipoDoc[tipo_documento_persona]&&tipoDoc[tipo_documento_persona]!==0){
                errors.push([pK, `El tipo de documento ${tipo_documento_persona} es incorrecto, opciones permitidas CEDULA ó NIT.`]);
            }

            if(genero_persona&&!genero[genero_persona]&&genero[genero_persona]!==0){
                errors.push([pK, `El genero ${genero_persona} es incorrecto, opciones permitidas MASCULINO ó FEMENINO.`]);
            }

            if(!numero_documento_persona){
                errors.push([pK, `El número de documento de la persona es obligatorio.`]);
            }

            if(!primer_nombre_persona){
                errors.push([pK, `El primer nombre de la persona es obligatorio.`]);
            }
            
            let personId = personasId[numero_documento_persona.replaceAll(".","").toUpperCase()];
            if(personId){
                errors.push([pK, `La persona con el documento ${numero_documento_persona} ya se encuentra registrada.`]);
            }

            //tipo_documento, numero_documento, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, celular, email, direccion, sexo, importado, created_by
            personsToInsert.push(`('${tipoDoc[tipo_documento_persona]}', '${numero_documento_persona}', '${primer_nombre_persona}', '${segundo_nombre_persona}', 
            '${primer_apellido_persona}', '${segundo_apellido_persona}', '${celular_persona}', '${celular_persona}', '${email_persona}', '${direccion_persona}', '${genero[genero_persona]}', 1, '${user}', ${rowCityCustomer})`);
        }
    });

    if(errors.length==0&&personsToInsert.length){
        let personsToInsertSql = personsToInsert.join(',');
        await pool.query(`INSERT INTO personas (tipo_documento, numero_documento, primer_nombre, segundo_nombre, primer_apellido, segundo_apellido, telefono, celular, email, direccion, sexo, importado, created_by, id_ciudad_erp) VALUES ${personsToInsertSql};`);

        return {success: true, registers: personsToInsert.length};
    }else{
        return {success: false, error: 'in-file', errors: errors};
    }
};

const processFileProviders = async (parsedFile, user, pool)=>{
    const [providersTypeQ] = await pool.query(`SELECT id, nombre FROM maestras_base WHERE tipo=1 AND eliminado=0`);
    let providersTypeId = [];
    providersTypeQ.map(providerType=>{
        providersTypeId[providerType.nombre.toUpperCase()] = providerType.id;
    });
    
    const [personsQ] = await pool.query(`SELECT id, numero_documento FROM personas WHERE eliminado=0`);
    let personasId = [];
    personsQ.map(person=>{
        personasId[person.numero_documento.toUpperCase()] = person.id;
    });
    
    let numero_documento_persona = '';
    let tipo_proveedor = '';
    let nombre_negocio = '';
    let observacion = '';
    
    let errors = [];
    let providersToInsert = [];

    parsedFile.map((property, pK)=>{
        if(pK>0){
            property.map((value, fK)=>{
                switch(fK){
                    case 0: numero_documento_persona = value.replaceAll(".",""); break;
                    case 1: tipo_proveedor = value.toUpperCase(); break;
                    case 2: nombre_negocio = value.toUpperCase(); break;
                    case 3: observacion = value; break;
                }
            });

            if(!numero_documento_persona){
                errors.push([pK, `El número de documento de la persona es obligatorio.`]);
            }

            if(!tipo_proveedor){
                errors.push([pK, `El tipo de proveedor es obligatorio.`]);
            }

            if(!nombre_negocio){
                errors.push([pK, `El nombre del negocio del proveedor es obligatorio.`]);
            }
            
            let personId = personasId[numero_documento_persona.replaceAll(".","").toUpperCase()];
            if(!personId){
                errors.push([pK, `La persona con el documento ${numero_documento_persona} no se encuentra registrada.`]);
            }
            
            let providerTypeId = providersTypeId[tipo_proveedor];
            if(tipo_proveedor&&!providerTypeId){
                errors.push([pK, `El tipo de proveedor con el nombre ${tipo_proveedor} no se encuentra registrado.`]);
            }

            //id_persona, id_actividad, nombre_negocio, observacion, importado
            providersToInsert.push(`('${personId}', '${providerTypeId}', '${nombre_negocio}', '${observacion}', 1, '${user}')`);
        }
    });

    if(errors.length==0&&providersToInsert.length){
        let providersToInsertSql = providersToInsert.join(',');
        await pool.query(`INSERT INTO proveedores (id_persona, id_actividad, nombre_negocio, observacion, importado, created_by) VALUES ${providersToInsertSql};`);

        return {success: true, registers: providersToInsert.length};
    }else{
        return {success: false, error: 'in-file', errors: errors};
    }
};

const genFileToImporter = async (req, res) => {
    try { 
        const registerSchema = Joi.object({
            origin: Joi.string().valid('inmuebles', 'inmuebles-admon', 'personas', 'proveedores').required()
        });
    
        //VALIDATE FORMAT FIELDS
        const { error } = registerSchema.validate(req.params);
        if (error) {
          return res.status(201).json({ success: false, error: error.message });
        }
        const { origin } = req.params;

        let csvColumns = getColumnsByOrigin(origin);

        return   res.status(200).send({ success: true, columns: csvColumns, template_name: `plantilla_${origin.replaceAll("-","_")}_maximoph` });
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};

const uploadFileToImporter = async (req, res) => {
    try {
        multer({ storage }).single('template')(req, res, async(err) => {
            if (err) {
                console.log(err);
                return res.status(400).json({ message: "Failed file processing" });
            }

            const registerSchema = Joi.object({
                origin: Joi.string().valid('inmuebles', 'inmuebles-admon', 'personas', 'proveedores').required()
            });
        
            //VALIDATE FORMAT FIELDS
            const { error } = registerSchema.validate(req.body);
            if (error) {
              return res.status(201).json({ success: false, error: error.message });
            }
            const { origin } = req.body;

            const csvBuffer = req.file.buffer;

            const templateParsed = [];

            const readableStream = new stream.Readable();
            readableStream._read = () => {};

            readableStream.push(csvBuffer);
            readableStream.push(null);

            const rl = readline.createInterface({
                input: readableStream,
                crlfDelay: Infinity
            });
            
            let separatorFile = null;
            
            let lineFile = '';

            rl.on('line', (line) => {
                if (!separatorFile) {
                    if (line.includes(',')) {
                        separatorFile = ',';
                    } else if (line.includes(';')) {
                        separatorFile = ';';
                    }
                }
                
                if(separatorFile==";"){
                    lineFile = line.split(/;(?=(?:(?:[^"]*"){2})*[^"]*$)/);
                }else if(separatorFile==","){
                    lineFile = line.split(/,(?=(?:(?:[^"]*"){2})*[^"]*$)/);
                }

                lineFile = lineFile.map((val)=>{ return val.replace(/^"(.*)"$/, '$1').trim(); });

                templateParsed.push(lineFile);
            });

            rl.on('close', async () => {
                //VALIDATE COLUMNS FORMAT
                let originalTemplateColumns = getColumnsByOrigin(origin);

                if(JSON.stringify(originalTemplateColumns)!=JSON.stringify(templateParsed[0])){
                    return res.status(201).json({ success: false, error: 'template-format' });
                }
                
                //VALIDATE EMPTY TEMPLATE
                if(templateParsed.length==1){
                    return res.status(201).json({ success: false, error: 'template-empty' });
                }

                let pool = poolSys.getPool(req.user.token_db);
                let toReturn;

                switch(origin){
                    case "inmuebles":
                        toReturn = await processFileProperties(templateParsed, req.user.id, pool);
                    break;
                    
                    case "inmuebles-admon":
                        toReturn = await processFilePropertiesAdmon(templateParsed, req.user.id, pool);
                    break;

                    case "personas":
                        toReturn = await processFilePersons(templateParsed, req.user.id, pool, req);
                    break;

                    case "proveedores":
                        toReturn = await processFileProviders(templateParsed, req.user.id, pool);
                    break;
                }

                //pool.end();

                return res.status(200).json(toReturn);
            });

            rl.on('error', (err) => {
                console.error('Error al procesar el CSV: ', err);
                res.status(500).send('Error interno del servidor');
            });
        });
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};

export {
    genFileToImporter,
    uploadFileToImporter
};
  