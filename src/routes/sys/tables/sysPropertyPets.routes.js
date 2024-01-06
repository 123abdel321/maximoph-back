import { Router } from "express";

import {
  uploadPhotoPet,
  getAllPropertyPets,
  deletePropertyPet,
  createPropertyPet,
  putPropertyPet
} from "../../../controllers/sys/tables/sysPropertyPets.controller.js";

const router = Router();

router.get("/:id_inmueble", getAllPropertyPets);
router.post("/", createPropertyPet);
router.put("/", putPropertyPet);
router.post("/photo", uploadPhotoPet);
router.delete("/:id", deletePropertyPet);

export default router;
