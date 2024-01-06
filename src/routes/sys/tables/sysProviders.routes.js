import { Router } from "express";

import {
  getAllProviders,
  deleteProvider,
  createProvider,
  putProvider
} from "../../../controllers/sys/tables/sysProviders.controller.js";

const router = Router();

router.get("/", getAllProviders);
router.post("/", createProvider);
router.put("/", putProvider);
router.delete("/:id", deleteProvider);

export default router;
