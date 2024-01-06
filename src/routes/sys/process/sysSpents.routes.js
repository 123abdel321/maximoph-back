import { Router } from "express";

import {
  getAllSpents,
  deleteSpent,
  getSpentPDF,
  createSpent,
  putSpent,
  putSpentState
} from "../../../controllers/sys/process/sysSpents.controller.js";

const router = Router();

router.get("/", getAllSpents);
router.post("/", createSpent);
router.put("/", putSpent);
router.get("/PDF/:id", getSpentPDF);
router.put("/state/", putSpentState);
router.delete("/:id", deleteSpent);

export default router;
