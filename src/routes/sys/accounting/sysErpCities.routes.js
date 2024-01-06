import { Router } from "express";

import {
  getAllCities
} from "../../../controllers/sys/accounting/sysErpCities.controller.js";

const router = Router();

router.get("/", getAllCities);

export default router;