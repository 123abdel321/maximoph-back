import { Router } from "express";

import {
  getAllTypesHomeworks,
  deleteTypeHomework,
  createTypeHomework,
  putTypeHomework
} from "../../../controllers/sys/tables/sysTypesHomework.controller.js";

const router = Router();

router.get("/", getAllTypesHomeworks);
router.post("/", createTypeHomework);
router.put("/", putTypeHomework);
router.delete("/:id", deleteTypeHomework);

export default router;
