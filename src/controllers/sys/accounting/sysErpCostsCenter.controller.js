import { poolSys } from "../../../db.js";

const getAllCostsCenter = async (req, res) => {
    try {
        let pool = poolSys.getPool(req.user.token_db);
        
        let { query, id, id_erp, codigo, nombre } = req.query;

        const [costsCenter] = await pool.query(
            `SELECT 
            id, id_erp, codigo, nombre,
            id AS value,
            CONCAT(codigo,' - ',nombre) AS label
            FROM 
                erp_maestras 
            WHERE 
            tipo = 0 
            ${query ? (`AND (codigo LIKE "${query}%" OR nombre LIKE "${query}%")`) : ''}
            ${id ? (`AND id = "${id}"`) : ''}
            ${id_erp ? (`AND id_erp = "${id_erp}"`) : ''}
            ${codigo ? (`AND codigo = "${codigo}"`) : ''}
            ${nombre ? (`AND nombre = "${nombre}"`) : ''}
        `);

        return res.json({success: true, data: costsCenter});
    } catch (error) {
        return res.status(500).json({ success: false, error: 'Internal Server Error', error: error.message });
    }
};

export {
    getAllCostsCenter
};