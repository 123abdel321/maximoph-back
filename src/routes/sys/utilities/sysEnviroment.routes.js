import { Router } from "express";

import {
  getSummaryErp,
  getSyncAPIKEYERP,
  getValidateAPIKEYERP,
  putEnviromentmaximo,
  deleteNotifications,
} from "../../../controllers/sys/utilities/sysEnviroment.controller.js";

const router = Router();

router.get("/", getSummaryErp);
router.put("/", putEnviromentmaximo);
router.delete("/notifications/:id", deleteNotifications);
router.post("/sync-data-erp", getSyncAPIKEYERP);
router.get("/validate-api-key-erp/:key", getValidateAPIKEYERP);

export default router;
