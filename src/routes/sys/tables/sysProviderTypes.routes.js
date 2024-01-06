import { Router } from "express";

import {
  getAllProviderTypes,
  deleteProviderType,
  createProviderType,
  putProviderType
} from "../../../controllers/sys/tables/sysProviderTypes.controller.js";

const router = Router();

router.get("/", getAllProviderTypes);
router.post("/", createProviderType);
router.put("/", putProviderType);
router.delete("/:id", deleteProviderType);

export default router;
