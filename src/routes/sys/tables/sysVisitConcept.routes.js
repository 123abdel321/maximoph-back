import { Router } from "express";

import {
  getAllVisitConcepts,
  deleteVisitConcept,
  createVisitConcept,
  putVisitConcept
} from "../../../controllers/sys/tables/sysVisitConcepts.controller.js";

const router = Router();

router.get("/", getAllVisitConcepts);
router.post("/", createVisitConcept);
router.put("/", putVisitConcept);
router.delete("/:id", deleteVisitConcept);

export default router;
