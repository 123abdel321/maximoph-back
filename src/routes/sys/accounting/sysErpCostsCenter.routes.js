import { Router } from "express";

import {
  getAllCostsCenter
} from "../../../controllers/sys/accounting/sysErpCostsCenter.controller.js";

const router = Router();

router.get("/", getAllCostsCenter);

export default router;
