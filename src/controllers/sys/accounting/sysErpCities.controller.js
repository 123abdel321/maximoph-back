import { poolSys } from "../../../db.js";

const getAllCities = async (req, res) => {
    try {
        let pool = poolSys.getPool(req.user.token_db);
        
        let { query, id, id_erp, codigo, nombre } = req.query;

        const [cities] = await pool.query(
            `SELECT 
            id, id_erp, codigo, nombre,
            id AS value,
            nombre AS label
            FROM 
                erp_maestras 
            WHERE 
            tipo = 3 
            ${query ? (`AND (codigo LIKE "${query}%" OR nombre LIKE "${query}%")`) : ''}
            ${id ? (`AND id = "${id}"`) : ''}
            ${id_erp ? (`AND id_erp = "${id_erp}"`) : ''}
            ${codigo ? (`AND codigo = "${codigo}"`) : ''}
            ${nombre ? (`AND nombre = "${nombre}"`) : ''}
        `);

        return res.json({success: true, data: cities});
    } catch (error) {
    return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};

export {
    getAllCities
};