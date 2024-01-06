import { Router } from "express";

import {
  getAllBillingConcepts,
  deleteBillingConcept,
  createBillingConcept,
  putBillingConcept
} from "../../../controllers/sys/tables/sysBillingConcepts.controller.js";

const router = Router();

router.get("/", getAllBillingConcepts);
router.post("/", createBillingConcept);
router.put("/", putBillingConcept);
router.delete("/:id", deleteBillingConcept);

export default router;
