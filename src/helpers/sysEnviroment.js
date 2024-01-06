import CryptoJS from "crypto-js";

const getLogoCompany = async ({pool, id})=>{
    let [logo] = await pool.query(`SELECT logo FROM cli_maximo_ph_admin.clientes WHERE id = ?`, [id] );
    
    logo = logo.length ? logo[0].logo : '';

    return logo;
};

const getSysEnv = async ({name, pool})=>{
    let [config] = await pool.query(`SELECT IFNULL(valor,'') AS valor FROM entorno WHERE campo = ?`, [name] );
    
    config = config.length ? config[0].valor : '';

    return config;
};

const updateSysEnv = async ({name, val, pool})=>{
    await pool.query(`UPDATE entorno SET valor = ? WHERE campo = ?`, [val, name] );
    
    return true;
};

const roundValues = async ({val, pool})=>{
    let [config] = await pool.query(`SELECT IFNULL(valor,'') AS valor FROM entorno WHERE campo = 'redondeo_conceptos'`);
    config = config.length ? (config[0].valor||1) : 0;
    config = config == 0 ? 1 : config;
    
    val = config==1 ? val : Math.round(val/config)*config;

    return val;
};

const roundValuesWithConfig = ({val, config})=>{
    config = config.length ? (config[0].valor||1) : 0;
    config = config == 0 ? 1 : config;

    val = config==1 ? val : Math.round(val/config)*config;

    return val;
};

const genRandomToken = async ()=>{
    const randomValue = Math.random().toString(36).substring(2);
    const token = CryptoJS.SHA256(randomValue).toString();

    return token;
}

const getModuleAccess = async ({user, client, module, pool})=>{
    let [access] = await pool.query(`SELECT 
            t3.nombre AS permiso, IF(IFNULL(t2.id,0)=0,0,1) AS asignado
        FROM cli_maximo_ph_admin.usuario_roles t1
            INNER JOIN cli_maximo_ph_admin.permisos t3 ON t3.id_modulo = ${module}
            LEFT OUTER JOIN cli_maximo_ph_admin.roles_permisos t2 ON t2.id_rol = t1.id_rol AND t2.id_permiso = t3.id
        WHERE 
            t1.id_cliente = ${client} AND 
            t1.id_usuario = ${user}`);
    return access;
}

const padLeft = (str, cantidad, char = "0")=>{
    str = str.toString();
    try{
        return str.length<8 ? char.repeat(cantidad - str.length) + str : str;
    } catch (error) {
        console.log("error padLeft");
        console.log(error.message);
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};
  

export {
    padLeft,
    getSysEnv,
    roundValues,
    roundValuesWithConfig,
    updateSysEnv,
    genRandomToken,
    getLogoCompany,
    getModuleAccess
};