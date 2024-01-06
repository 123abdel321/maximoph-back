import { Router } from "express";

import {
  getAllVehicleTypes,
  deleteVehicleType,
  createVehicleType,
  putVehicleType
} from "../../../controllers/sys/tables/sysVehicleTypes.controller.js";

const router = Router();

router.get("/", getAllVehicleTypes);
router.post("/", createVehicleType);
router.put("/", putVehicleType);
router.delete("/:id", deleteVehicleType);

export default router;
