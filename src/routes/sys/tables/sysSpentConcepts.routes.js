import { Router } from "express";

import {
  getAllSpentConcepts,
  deleteSpentConcept,
  createSpentConcept,
  putSpentConcept
} from "../../../controllers/sys/tables/sysSpentConcepts.controller.js";

const router = Router();

router.get("/", getAllSpentConcepts);
router.post("/", createSpentConcept);
router.put("/", putSpentConcept);
router.delete("/:id", deleteSpentConcept);

export default router;
