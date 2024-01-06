import { Router } from "express";

import { getLogs } from "../../../controllers/sys/utilities/sysLogs.controller.js";

const router = Router();

router.get("/", getLogs);

export default router;
