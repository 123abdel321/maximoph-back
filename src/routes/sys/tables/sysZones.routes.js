import { Router } from "express";

import {
  getAllZones,
  deleteZone,
  createZone,
  putZone
} from "../../../controllers/sys/tables/sysZones.controller.js";

const router = Router();

router.get("/", getAllZones);
router.post("/", createZone);
router.put("/", putZone);
router.delete("/:id", deleteZone);

export default router;
