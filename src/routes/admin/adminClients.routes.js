import { Router } from "express";
import authAdmin from "../../middleware/adminAuth.js";

import {
  getAllClients,
  createClient,
  putClient,
  putClientLogo
} from "../../controllers/admin/adminClients.controller.js";
const router = Router();

router.get("/", getAllClients);
router.post("/", createClient);
router.post("/edit", putClient);
router.post("/edit-logo", putClientLogo);

export default router;
