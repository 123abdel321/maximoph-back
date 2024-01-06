import { createPool } from "mysql2/promise";
import dotenv from "dotenv";

dotenv.config();

const poolAdm = createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
  database: process.env.DB_DATABASE_ADMIN,
  multipleStatements: true
});

class poolSysCls {
  constructor() {
    this.connectionPools = {};
  }

  getPool(dbName) {
    if (!this.connectionPools[dbName]) {
      this.connectionPools[dbName] = createPool({
        host: process.env.DB_HOST,
        user: process.env.DB_USER,
        password: process.env.DB_PASSWORD,
        port: process.env.DB_PORT,
        database: `${process.env.DB_DATABASE_SYSTEM_PREFIX}_${dbName}`,
        multipleStatements: true,
        connectionLimit: 1000000000
      });
    }

    return this.connectionPools[dbName];
  }
}

const poolSys = new poolSysCls();

export {
  poolAdm,
  poolSys
};