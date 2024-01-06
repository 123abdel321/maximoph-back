import { poolSys } from "../../../db.js";
import { getModuleAccess } from "../../../helpers/sysEnviroment.js";

const getLogs = async (req, res) => {
    try {
        let pool = poolSys.getPool(req.user.token_db);

        const [logs] = await pool.query(`SELECT tipo_operacion, descripcion, DATE_FORMAT(created_at,'%Y-%m-%d %H:%i') AS fecha FROM logs WHERE 1`);
            
        let access = await getModuleAccess({
          user: req.user.id, 
          client: req.user.id_cliente, 
          module: 40, 
          pool
        });
    
        //pool.end();

        return res.json({success: true, data: logs, access});
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};

export {
    getLogs
};
  