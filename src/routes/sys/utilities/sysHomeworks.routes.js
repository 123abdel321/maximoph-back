import { Router } from "express";

import {
  getAllHomeworks,
  getOwnHomeworks,
  deleteHomework,
  createHomework,
  putHomework,
  putCompleteHomework,
  createHomeworkMassive,
  deleteHomeworkMassive
} from "../../../controllers/sys/utilities/sysHomeworks.controller.js";

const router = Router();

router.get("/all", getAllHomeworks);
router.get("/", getOwnHomeworks);
router.post("/", createHomework);
router.post("/massive", createHomeworkMassive);
router.put("/", putHomework);
router.put("/massive", deleteHomeworkMassive);
router.post("/change-state", putCompleteHomework);
router.delete("/:id", deleteHomework);

export default router;
