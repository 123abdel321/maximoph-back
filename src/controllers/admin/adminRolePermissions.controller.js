import Joi  from "joi";
import { poolAdm } from "../../db.js";
import { getModuleAccess } from "../../helpers/sysEnviroment.js";

const getAllRolePermissions = async (req, res) => {
  try {
    const readRolePermissionsSchema = Joi.object({
      role: Joi.number().required()
    });
  
    //VALIDATE FORMAT FIELDS
    const { error } = readRolePermissionsSchema.validate(req.params);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }
    
    const { role } = req.params;
    
    let pool = poolAdm;
    
    let groupPermissions = [];

    const [listRolesPermissions] = await pool.query(`SELECT 
      IF(IFNULL(t2.id,0),1,0) AS asignado, t1.id AS id_permiso, t1.id_modulo, t1.nombre AS permiso_nombre, 
      t1.descripcion AS permiso_descripcion, t3.nombre AS nombre_modulo
    FROM permisos t1 
      LEFT OUTER JOIN roles_permisos t2 ON t2.id_permiso = t1.id AND t2.id_rol=?
      INNER JOIN maestras_base t3 ON t3.id = t1.id_modulo 
      ORDER BY CAST(t3.descripcion AS UNSIGNED) ASC`,[role]);
    
    let moduleAlter = '';
    let groupModule = {};

    listRolesPermissions.map((roleP,rolePPos)=>{
      if(roleP.nombre_modulo!=moduleAlter){
        moduleAlter = roleP.nombre_modulo;
        
        if(Object.entries(groupModule).length) groupPermissions.push(groupModule);

        groupModule = {
          module_id: roleP.id_modulo,
          module_name: roleP.nombre_modulo,
          permissions: [roleP]
        };
      }else{
        groupModule.permissions.push(roleP);
      }

      if(listRolesPermissions.length==(rolePPos+1)){
        groupPermissions.push(groupModule);
      }
    });

    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 12, 
      pool
    });

    //pool.end();
    
    return res.json({success: true, data: groupPermissions, access});
  } catch (error) {
    return res.json(error.message);
  }
};

const putRolePermissions = async (req, res) => {   
  try {  
    const registerSchema = Joi.object({
      permissions: Joi.string().allow(null,'').required(),
      role: Joi.number().required()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = registerSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { permissions, role } = req.body;
    
    let pool = poolAdm;
    
    const [roleMaximo] = await pool.query(
        `SELECT id, nombre FROM maestras_base WHERE id_cliente IS NULL AND id=?`,
        [role]
    );

    if (roleMaximo.length) {
        return res.status(201).json({ success: false, error: `El rol ${roleMaximo[0].nombre} no puede ser editado.` });
    }

    //DELETE ACTUAL ROLE PERMISSIONS
    await pool.query(`DELETE FROM roles_permisos WHERE id_rol = ?`,[role]);
    
    //REGISTER NEW ROLE PERMISSIONS
    let newPermissions = permissions.split(",");
    let queryNewPermissions = [];
    if(newPermissions.length){
      newPermissions.map(idPermission=>{
        queryNewPermissions.push(`INSERT INTO roles_permisos (id_rol, id_permiso) VALUES (${role}, ${idPermission})`);
      });
  
      queryNewPermissions = queryNewPermissions.join(";");
  
      await pool.query(queryNewPermissions);
    }
    
    //pool.end();

    return res.json({success: true});
  } catch (error) {
      return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
  }
};

export {
  getAllRolePermissions,
  putRolePermissions
};
