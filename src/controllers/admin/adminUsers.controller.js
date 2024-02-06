import Joi  from "joi";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import { poolAdm, poolSys } from "../../db.js";
import { getModuleAccess } from "../../helpers/sysEnviroment.js";

import { getRolePermissions } from "../../helpers/getRolePermissions.js";
import { sendFBPushMessageUser } from "../../helpers/firebasePushNotification.js";

//PRIVATE HELPER ADD ROLE AND CLIENT TO USER
const addRoleClientUser = async (poolAdmin, email, client, role) => {
  //VALIDATE EMAIL EXIST
  const [existEmail] = await poolAdmin.query(
    "SELECT * FROM usuarios WHERE email = ?",
    [email]
  );

  if (!existEmail.length) {
    return res.status(201).json({ success: false, error: "Information provided is incorrect." });
  }

  let user = existEmail[0];
  let idClientes = user.id_cliente.split(",");

  //VERIFY IF CLIENT ADDED ON USER
  if(idClientes.indexOf(client)>=0){
    //REMOVE USER ROLE
    await poolAdmin.query(`DELETE FROM usuario_roles WHERE id_cliente = ? AND id_usuario = ?`, [client, role]);
  }else{
    // ADD CLIENT ON USER
    idClientes.push(client);
    idClientes = idClientes.join(",");

    await poolAdmin.query("UPDATE usuarios SET id_cliente = ? WHERE id = ?", [
      idClientes,
      user.id
    ]);
  }
    
  //CREATE NEW USER ROLE
  await poolAdmin.query(`INSERT INTO usuario_roles
    (id_cliente, id_usuario, id_rol) 
      VALUES 
    (?,?,?)`,
    [client, user.id, role]
  );
};

const getClientUsers = async (req, res) => {    
    //let dbUsers = `${process.env.DB_DATABASE_SYSTEM_PREFIX}_${req.user.token_db}`;
    
    let pool = poolAdm;

    /*const [listUsers] = await pool.query(
        `SELECT 
            t1.id, 
            CONCAT(IFNULL(t2.primer_nombre,''),' ',IFNULL(t2.segundo_nombre,''),' ',IFNULL(t2.primer_apellido,''),' ',IFNULL(t2.segundo_apellido,'')) As nombre,
            t2.telefono,
            t2.celular,
            t2.email,
            t1.estado,
            t1.id_rol,
            t3.nombre AS nombre_rol
        FROM usuarios t1
        INNER JOIN ${dbUsers}.personas t2 ON t2.id = t1.id_persona_maximo
        INNER JOIN maestras_base t3 ON t3.id = t1.id_rol
        WHERE 
          FIND_IN_SET(?, t1.id_cliente) > 0`,
        [req.user.id_cliente]
    );*/
    
    const [listUsers] = await pool.query(
        `SELECT 
            t1.id, 
            t2.id_rol, 
            t1.nombre,
            t1.email,
            t1.estado,
            t3.nombre AS nombre_rol
        FROM usuarios t1
        INNER JOIN usuario_roles t2 ON t2.id_cliente = ? AND t2.id_usuario = t1.id
        INNER JOIN maestras_base t3 ON t3.id = t2.id_rol
        WHERE 
          FIND_IN_SET(?, t1.id_cliente) > 0`,
        [req.user.id_cliente,req.user.id_cliente]
    );

    let access = await getModuleAccess({
      user: req.user.id, 
      client: req.user.id_cliente, 
      module: 13, 
      pool
    });
    
    //pool.end();

    return res.json({success: true, data: listUsers, access});
};

const login = async (req, res) => {    
    const loginSchema = Joi.object({
      password: Joi.string().required(),
      email: Joi.string().email().required(),
      idCliente: Joi.number()
    });

    //VALIDATE FORMAT FIELDS
    const { error } = loginSchema.validate(req.body);
    if (error) {
      return res.status(201).json({ success: false, error: error.message });
    }

    const { email, password, idCliente } = req.body;
    
    let poolAdmin = poolAdm;

    const [rows] = await poolAdmin.query(`SELECT 
        t1.id, t1.password AS passwordVerify, t1.id_cliente, t1.id_persona_maximo, 
        t1.nombre, t1.email, t1.session_token, t2.token_db, t1.firebase_token, t1.id_rol, t2.logo, IFNULL(t1.avatar,'') As avatar
      FROM usuarios t1 
        INNER JOIN clientes t2 ON t2.id = t1.id_cliente
      WHERE 
        t1.email = ?`, [ email ]);

    if (rows.length === 0) {
      return res.status(201).json({ success: false, error: "Information provided is incorrect." });
    }
    
    let user = rows[0];

    const isMatch = await bcrypt.compare(password, user.passwordVerify);

    if (!isMatch) {
      return res.status(201).json({ success: false, error: "Information provided is incorrect." });
    }
    
    let tokenBDUser = '';

    //VALIDATE IF SELECTED CLIENT OR RETURN LIST OF YOUR CLIENTS
    if(!idCliente){
      let idClientes = user.id_cliente;
      const [rowsClients] = await poolAdmin.query(`SELECT 
        t1.id, FORMAT(t1.numero_documento,0) AS cliente_numero_documento, t1.razon_social AS cliente_nombre, t1.estado
      FROM clientes t1
      WHERE 
        t1.id IN (${idClientes}) AND t1.estado IN (1, 2)`);
      return res.status(200).json({ success: true, data: {clients: rowsClients} });
    }else{
      //VERIFY IF CLIENT EXISTS
      const [rowClient] = await poolAdmin.query(`SELECT 
        t1.id, FORMAT(t1.numero_documento,0) AS cliente_numero_documento, t1.razon_social AS cliente_nombre, t1.logo
      FROM clientes t1
      WHERE 
        t1.id = ? AND t1.estado = 1`, [ idCliente ]);
        
      if (rowClient.length === 0) {
        return res.status(201).json({ success: false, error: "Information provided is incorrect." });
      }
      
      //VERIFY IF USER HAVE ACCESS TO THIS CLIENT
      let idClientes = user.id_cliente;
      if(idClientes.split(",").indexOf(idCliente)<0){
        return res.status(201).json({ success: false, error: "Information provided is incorrect." });
      }
      
      //GET TOKEN BD
      [tokenBDUser] = await poolAdmin.query(`SELECT token_db FROM clientes WHERE id = ?`, [ idCliente ]);

      tokenBDUser= tokenBDUser[0].token_db;
      
      //GET USER ROLE
      const [rowRole] = await poolAdmin.query(`SELECT id_rol FROM usuario_roles WHERE id_cliente = ? AND id_usuario = ?`, [ idCliente, user.id ]);

      user.id_cliente = idCliente;
      
      if(rowRole.length&&user.id_rol!=26){
        user.id_rol = rowRole[0].id_rol;
        user.logo = rowClient[0].logo;
      }else{
        user.id_rol = user.id_rol;
      }
    }

    // CREATE NEW SESSION FOR USER
    let userWhitoutSession = {
      id:user.id,
      id_cliente: user.id_cliente,
      id_persona_maximo: user.id_persona_maximo,
      id_rol: user.id_rol,
      email: user.email,
      token_db: tokenBDUser
    };

    const sessionTokenUser = jwt.sign({ user: userWhitoutSession }, process.env.SECRET_PRIV_KEY, {
      expiresIn: "18250d",
    });
    
    await poolAdmin.query("UPDATE usuarios SET session_token = ? WHERE id = ?", [
      sessionTokenUser,
      user.id
    ]);

    delete user.passwordVerify;
    user.session_token = sessionTokenUser;

    let pool = poolSys.getPool(user.token_db);
    const [enviromentMaximo] = await pool.query(
        `SELECT 
          campo, valor
        FROM 
            entorno
        WHERE 
            campo NOT IN ('id_comprobante_ventas_erp', 'id_comprobante_gastos_erp', 'id_comprobante_recibos_caja_erp', 'id_cuenta_intereses_erp')
    `);

    let [dataCliente] = await pool.query(`SELECT * FROM cli_maximo_ph_admin.clientes WHERE id = ${user.id_cliente};`);
        dataCliente = dataCliente[0];
    
    // enviromentMaximo.numero_total_unidades = dataCliente.numero_unidades;
    for (let index = 0; index < enviromentMaximo.length; index++) {
      const enviroment = enviromentMaximo[index];
      if (enviroment.campo == "numero_total_unidades") {
        enviromentMaximo[index].valor = dataCliente.numero_unidades;
      }
      
    }
    const [notifications] = await pool.query(`SELECT * FROM mensajes_push_historia WHERE id_usuario_notificado = ? AND vista=0 ORDER BY created_at DESC`,[user.id]);
    
    user.notifications = notifications;
    user.avatar_origin = 'user';
    if(!user.avatar){
      user.avatar_origin = 'person';
      const [avatar] = await pool.query(`SELECT avatar FROM personas WHERE email='${user.email}' AND (avatar IS NOT NULL AND avatar<>'')`);
      user.avatar = avatar.length ? avatar[0].avatar : '';
    }

    //poolAdmin.end();
    //pool.end();

    return res.json({success: true, data: {user, enviromentMaximo, notifications}});
};

const register = async (req, res) => {     
  const registerSchema = Joi.object({
    id_persona_maximo: Joi.number().required(),
    password: Joi.string().required(),
    confirmar_password: Joi.string().required(),
    role: Joi.number().required(),
    id_rol: Joi.allow(null,''),
    email: Joi.string().email().required(),
    nombre: Joi.string().required()
  });

  //VALIDATE FORMAT FIELDS
  const { error } = registerSchema.validate(req.body);
  if (error) {
    return res.status(201).json({ success: false, error: error.message });
  }

  const { id_persona_maximo, role, email, nombre, password } = req.body;
  
  let poolAdmin = poolAdm;
  
  //VALIDATE IF ROLE EXIST
  const [existRole] = await poolAdmin.query(
    "SELECT * FROM maestras_base WHERE id = ? AND tipo = 0",
    [role]
  );

  if (!existRole.length) {
    return res.status(201).json({ success: false, error: "Role dosen't exist." });
  }

  //VALIDATE EMAIL EXIST
  const [existEmail] = await poolAdmin.query(
    "SELECT * FROM usuarios WHERE email = ?",
    [email]
  );

  //ENCODE PASSWORD USER
  const hashedPassword = await bcrypt.hash(password, 10);

  if (existEmail.length) {
    await addRoleClientUser(poolAdmin, email, req.user.id_cliente, role);
    
    await poolAdmin.query(`UPDATE usuarios SET password = ? WHERE email = ?`,[hashedPassword, email]);

    return res.status(200).json({ success: true, error: "Email already in use and updated his client and role." });
    //return res.status(201).json({ success: false, error: "Email already in use." });
  }

  //CREATE NEW USER
  const [insertedNewUser] = await poolAdmin.query(`INSERT INTO usuarios 
    (id_cliente, id_persona_maximo, id_rol, email, nombre, estado, password) 
      VALUES 
    (?,?,?,?,UPPER(?),?,?)`,
    [req.user.id_cliente, id_persona_maximo, role, email, nombre, 1, hashedPassword]
  );
  
  //CREATE NEW USER ROLE
  await poolAdmin.query(`INSERT INTO usuario_roles
    (id_cliente, id_usuario, id_rol, created_by) 
      VALUES 
    (?,?,?,?)`,
    [req.user.id_cliente, insertedNewUser.insertId, role, req.user.id]
  );
  
  //GET NEW USER
  const [rows] = await poolAdmin.query(`SELECT 
      t1.id, t1.id_cliente, t1.id_persona_maximo, t1.id_rol, t1.nombre, t1.email, t2.token_db
    FROM usuarios t1 
      INNER JOIN clientes t2 ON t2.id = t1.id_cliente
    WHERE 
      t1.id = ?`, [ insertedNewUser.insertId ]);

  if (rows.length === 0) {
    return res.status(201).json({ success: false, error: "Information provided is incorrect." });
  }
  
  let user = rows[0];

  //poolAdmin.end();

  return res.json({success: true, data: {user}});
};

const addClient = async (req, res) => {
  const addClientSchema = Joi.object({
    email: Joi.string().email().required(),
    id_rol: Joi.number().required()
  });

  //VALIDATE FORMAT FIELDS
  const { error } = addClientSchema.validate(req.body);
  if (error) {
    return res.status(201).json({ success: false, error: error.message });
  }
  
  const { email } = req.body;
  
  let poolAdmin = poolAdm;

  await addRoleClientUser(poolAdmin, email, req.user.id_cliente, id_rol);

  //poolAdmin.end();

  return res.status(200).json({ success: true });
};

const removeClient = async (req, res) => {
  const addClientSchema = Joi.object({
    email: Joi.string().email().required()
  });

  //VALIDATE FORMAT FIELDS
  const { error } = addClientSchema.validate(req.body);
  if (error) {
    return res.status(201).json({ success: false, error: error.message });
  }
  
  const { email } = req.body;
  
  let poolAdmin = poolAdm;

  //VALIDATE EMAIL EXIST
  const [existEmail] = await poolAdmin.query(
    "SELECT * FROM usuarios WHERE email = ?",
    [email]
  );

  if (!existEmail.length) {
    return res.status(201).json({ success: false, error: "Information provided is incorrect." });
  }

  let user = existEmail[0];
  let idClientes = user.id_cliente.split(",");

  //VERIFY IF CLIENT ADDED ON USER
  if(idClientes.indexOf(req.user.id_cliente)<0){
    return res.status(201).json({ success: false, error: "Client not added." });
  }else{
    //REMOVE CLIENT FROM USER
    idClientes = idClientes.filter((item) => item != req.user.id_cliente);
    idClientes = idClientes.join(",");

    //VERIFY IF SESSION USER IS ACTIVE ON THIS CLIENT AND REMOVE SESSION
    if(user.session_token){
      try{
        const decodedToken = jwt.verify(user.session_token, process.env.SECRET_PRIV_KEY);
        if(decodedToken.user.id_cliente==req.user.id_cliente){
          user.session_token = "";
        }
      } catch (error) {}
    }
    
    await poolAdmin.query("UPDATE usuarios SET id_cliente = ?, session_token = ? WHERE id = ?", [
      idClientes,
      user.session_token,
      user.id
    ]);
    
    //REMOVE EMPTY USER
    if(idClientes==''){
     // await poolAdmin.query(`DELETE FROM usuarios WHERE id = ?`, [user.id]);
    }

    //REMOVE USER ROLE
    await poolAdmin.query(`DELETE FROM usuario_roles WHERE id_cliente = ? AND id_usuario = ?`, [req.user.id_cliente, user.id]);
  }

  //poolAdmin.end();

  return res.status(200).json({ success: true });
};

const updateUser = async (req, res) => {
  const registerSchema = Joi.object({
    id: Joi.number().required(),
    id_rol: Joi.number().required(),
    email: Joi.string().allow(null,''),
    nombre: Joi.string().allow(null,''),
    estado: Joi.allow(null,''),
    nombre_rol: Joi.allow(null,''),
    id_persona_maximo: Joi.allow(null,''),
    role: Joi.allow(null,''),
    password: Joi.string().allow(null,''),
    confirmar_password: Joi.string().allow(null,'')
  });

  //VALIDATE FORMAT FIELDS
  const { error } = registerSchema.validate(req.body);
  if (error) {
    return res.status(201).json({ success: false, error: error.message });
  }

  const { id, id_rol, nombre, password } = req.body;
  
  let poolAdmin = poolAdm;

  //VALIDATE USER EXIST
  const [existUser] = await poolAdmin.query(
    "SELECT * FROM usuarios WHERE id = ?",
    [id]
  );

  if (!existUser.length) {
    return res.status(201).json({ success: false, error: "User dosent exist." });
  }

  //ENCODE PASSWORD USER
  const hashedPassword = password ? await bcrypt.hash(password, 10) : false;

  //UPDATE PASSWORD
  if(hashedPassword){
    await poolAdmin.query(`UPDATE usuarios SET password = ? WHERE id = ?`,[hashedPassword, id]);
  }

  await poolAdmin.query(`UPDATE usuarios SET nombre = UPPER(?) WHERE id = ?`,[nombre, id]);
  
  //REMOVE ACTUAL USER ROLE
  await poolAdmin.query(`DELETE FROM usuario_roles WHERE id_cliente = ? AND id_usuario = ?`,[req.user.id_cliente, id]);
  
  //CREATE NEW USER ROLE
  await poolAdmin.query(`INSERT INTO usuario_roles
    (id_cliente, id_usuario, id_rol) 
      VALUES 
    (?,?,?)`,
    [req.user.id_cliente, id, id_rol]
  );
  
  //GET UPDATED USER
  const [rows] = await poolAdmin.query(`SELECT 
      t1.id, t1.id_cliente, t1.id_persona_maximo, t1.id_rol, t1.email, t2.token_db
    FROM usuarios t1 
      INNER JOIN clientes t2 ON t2.id = t1.id_cliente
    WHERE 
      t1.id = ?`, [ id ]);
  
  let user = rows[0];

  //poolAdmin.end();

  return res.json({success: true, data: {user}});
};

const updateTokenFBUser = async (req, res) => {
  try {
    if(!Number(req.user.id)){
      return res.status(201).json({ message: "You don't have permissions to edit another users." });
    }
    // data to update
    const { token } = req.body;
    
    let poolAdmin = poolAdm;

    await poolAdmin.query(
      "UPDATE usuarios SET firebase_token = ?, updated_at = NOW() WHERE id = ?",
      [token, req.user.id]
    );
    
    /*let pool = poolSys.getPool(req.user.token_db);

    await sendFBPushMessageUser(req.user.id, {title: 'Prueba de Título', body: 'Prueba de Cuerpo'}, pool);
    
    //pool.end();*/
    
    //poolAdmin.end();

    return res.json({ success: true });
  } catch (error) {
    return res.status(500).json({success: false, error: error.message});
  }
};

const getNotificationUser = async (req, res) => {
  try {
    let pool = poolSys.getPool(req.user.token_db);

    const [notifications] = await pool.query(`SELECT * FROM mensajes_push_historia WHERE id_usuario_notificado = ? AND vista=0 ORDER BY created_at DESC`,[req.user.id]);
    
    //pool.end();

    return res.json({success: true, data: notifications});
  } catch (error) {
    return res.status(500).json({success: false, error: error.message});
  }
};


export {
  getNotificationUser,
  updateTokenFBUser,
  getClientUsers,
  removeClient,
  addClient,
  register,
  updateUser,
  login
};
