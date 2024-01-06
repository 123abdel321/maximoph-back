import { Router } from "express";

import {
  getAllProperties,
  deleteProperty,
  createProperty,
  putProperty
} from "../../../controllers/sys/tables/sysProperties.controller.js";

const router = Router();

router.get("/", getAllProperties);
router.post("/", createProperty);
router.put("/", putProperty);
router.delete("/:id", deleteProperty);

export default router;
