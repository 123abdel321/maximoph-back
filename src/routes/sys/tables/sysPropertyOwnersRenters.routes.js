import { Router } from "express";

import {
  getAllPropertyOwnersRenters,
  getAllPropertiesByOwnerRenter,
  deletePropertyOwnerRenter,
  createPropertyOwnerRenter,
  putPropertyOwnerRenter
} from "../../../controllers/sys/tables/sysPropertyOwnersRenters.controller.js";

const router = Router();

router.get("/:id_inmueble", getAllPropertyOwnersRenters);
router.get("/properties/:email", getAllPropertiesByOwnerRenter);
router.post("/", createPropertyOwnerRenter);
router.put("/", putPropertyOwnerRenter);
router.delete("/:id", deletePropertyOwnerRenter);

export default router;
