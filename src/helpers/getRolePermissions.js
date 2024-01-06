import { poolAdm } from "../db.js";

const getRolePermissions = async (roleId)=>{
    
    let poolAdmin = poolAdm;

    const [permissions] = await poolAdmin.query(`SELECT 
      t1.id AS cod_permiso, t2.nombre AS modulo, t1.nombre AS permiso, IF(IFNULL(t3.id,0)>0,1,0) AS habilitado
    FROM 
      permisos t1
      INNER JOIN maestras_base t2 ON t2.id = t1.id_modulo
      LEFT OUTER JOIN roles_permisos t3 ON t3.id_permiso = t1.id AND t3.id_rol = ?`,
      [roleId]
    );
  
    //poolAdmin.end();
    
    return permissions;
};

export {
    getRolePermissions
};