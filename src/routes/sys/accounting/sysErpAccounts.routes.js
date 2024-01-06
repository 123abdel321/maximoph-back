import { Router } from "express";

import {
  getAllAccounts
} from "../../../controllers/sys/accounting/sysErpAccounts.controller.js";

const router = Router();

router.get("/", getAllAccounts);

export default router;
