import jwt from "jsonwebtoken";
import { poolAdm } from "../db.js";

const authToken = async (req, res, next) => {
  const authHeader = req.headers.authorization;

  if (!authHeader) {
    return res.status(401).json({ success: false, error: "Authorization header missing" });
  }

  const token = authHeader;

  if (!token) {
    return res.status(401).json({ success: false, error: "Authentication token missing" });
  }

  try {
    const decodedToken = jwt.verify(token, process.env.SECRET_PRIV_KEY);
    const now = Date.now().valueOf() / 1000; // DATE NOW ON SECONDS
    
    //VERIFY EXPIRED TOKEN
    if (decodedToken.exp < now) {
      return res.status(401).json({ success: false, error: "Authentication token has expired" });
    }
    
    //VERIFY CLIENT SELECTED
    if (!Number(decodedToken.user.id_cliente)) {
      return res.status(201).json({ success: false, error: "Please select your client." });
    }
    
    let poolAdmin = poolAdm;
    
     //VALIDATE SESSION TOKEN EXIST
     const [existSessionToken] = await poolAdmin.query(
      "SELECT * FROM usuarios WHERE session_token = ?",
      [token]
    );
    if (!existSessionToken.length) {
      return res.status(401).json({ success: false, error: "Authentication token has expired" });
    }
    
    req.user = decodedToken.user;
    next();
  } catch (err) {
    return res.status(401).json({ success: false, error: "Invalid authentication token" });
  }
};

export default authToken;
