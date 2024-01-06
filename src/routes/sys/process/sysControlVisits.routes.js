import { Router } from "express";

import {
  getAllControlVisits,
  deleteControlVisit,
  createControlVisit,
  getSearchVisitors,
  putControlVisit
} from "../../../controllers/sys/process/sysControlVisits.controller.js";

const router = Router();

router.get("/visitors/:patternSearch", getSearchVisitors);
router.get("/", getAllControlVisits);
router.post("/", createControlVisit);
router.put("/", putControlVisit);
router.delete("/:id", deleteControlVisit);

export default router;
