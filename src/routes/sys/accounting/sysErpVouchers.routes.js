import { Router } from "express";

import {
  getAllVouchers
} from "../../../controllers/sys/accounting/sysErpVouchers.controller.js";

const router = Router();

router.get("/", getAllVouchers);

export default router;