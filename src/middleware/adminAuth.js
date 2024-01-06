import jwt from "jsonwebtoken";

const authAdmin = (req, res, next) => {
  const authHeader = req.headers.authorization;

  if (!authHeader) {
    return res.status(401).json({ message: "Authorization header missing" });
  }

  const token = authHeader;

  try {
    const decodedToken = jwt.verify(token, process.env.SECRET_PRIV_KEY);
    if (decodedToken.user.rol === "admin") {
      next();
    } else {
      return res
        .status(401)
        .json({ message: "You dont have permission to this data" });
    }
  } catch (error) {
    return res.status(500).json(error.message);
  }
};

export default authAdmin;
