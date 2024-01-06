function getChangesRecords(objBefore, objAfter) {
    const changes = {};

    for (const key in objAfter) {
        if (objAfter.hasOwnProperty(key)) {
        if (objBefore[key] !== objAfter[key]) {
            changes[key] = objAfter[key];
        }
        }
    }

    return changes;
}

const genLog = async ({module, idRegister, recordBefore, oper, detail, user, pool})=>{
    let moduleCode = '';
    let moduleTable = '';

    switch(module){
        case "inmuebles": 
            moduleCode = 2;
            moduleTable = module;
        break;
        case "personas": 
            moduleCode = 3;
            moduleTable = module;
        break;
        case "proveedores": 
            moduleCode = 4;
            moduleTable = module;
        break;
        case "zonas": 
            moduleCode = 30;
            moduleTable = module;
        break;
        case "conceptos_facturacion": 
            moduleCode = 31;
            moduleTable = module;
        break;
        case "conceptos_gastos": 
            moduleCode = 32;
            moduleTable = module;
        break;
        case "conceptos_visitas": 
            moduleCode = 33;
            moduleTable = "maestras_base";
        break;
        case "tipos_tarea": 
            moduleCode = 34;
            moduleTable = "maestras_base";
        break;
        case "tipos_proveedor": 
            moduleCode = 35;
            moduleTable = "maestras_base";
        break;
        case "tipos_vehiculo": 
            moduleCode = 36;
            moduleTable = "maestras_base";
        break;
        case "control_ingresos": 
            moduleCode = 5;
            moduleTable = module;
        break;
        case "conceptos_inmuebles": 
            moduleCode = 6;
            moduleTable = "facturas_ciclica";
        break;
        case "facturacion_ciclica": 
            moduleCode = 7;
            moduleTable = "facturas";
        break;
        case "recibos_de_caja": 
            moduleCode = 8;
            moduleTable = "factura_recibos_caja";
        break;
        case "gastos": 
            moduleCode = 9;
            moduleTable = "gastos";
        break;
        case "pagos": 
            moduleCode = 10;
            moduleTable = "gasto_pagos";
        break;
        case "mensajes": 
            moduleCode = 41;
            moduleTable = module;
        break;
        case "tareas": 
            moduleCode = 43;
            moduleTable = module;
        break;
    }
    
    let recordAfter = {};
    if(['CREATE','UPDATE','DELETE'].indexOf(oper)>=0){
        [recordAfter] = await pool.query(`SELECT * FROM ${moduleTable} WHERE id = ${idRegister}`);
        recordAfter = recordAfter[0];
        if(oper=="UPDATE"){
            recordAfter = getChangesRecords(recordBefore, recordAfter);
        }
    }

    recordAfter = JSON.stringify(recordAfter);
    
    await pool.query(`INSERT INTO logs (id_modulo, tipo_operacion, descripcion, detalle_json, created_by) VALUES (?, ?, ?, ?, ?)`, [moduleCode, oper, detail, recordAfter, user] );

    return true;
};
  

export {
    genLog
};