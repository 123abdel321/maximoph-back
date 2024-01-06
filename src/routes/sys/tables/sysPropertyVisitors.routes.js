import { Router } from "express";

import {
  getAllPropertyVisitors,
  deletePropertyVisitor,
  createPropertyVisitor,
  putPropertyVisitor
} from "../../../controllers/sys/tables/sysPropertyVisitors.controller.js";

const router = Router();

router.get("/:id_inmueble", getAllPropertyVisitors);
router.post("/", createPropertyVisitor);
router.put("/", putPropertyVisitor);
router.delete("/:id", deletePropertyVisitor);

export default router;
