import { Router } from "express";

import {
  uploadPhotoVehicle,
  getAllPropertyVehicles,
  deletePropertyVehicle,
  createPropertyVehicle,
  putPropertyVehicle
} from "../../../controllers/sys/tables/sysPropertyVehicles.controller.js";

const router = Router();

router.get("/:id_inmueble", getAllPropertyVehicles);
router.post("/", createPropertyVehicle);
router.put("/", putPropertyVehicle);
router.post("/photo", uploadPhotoVehicle);
router.delete("/:id", deletePropertyVehicle);

export default router;
