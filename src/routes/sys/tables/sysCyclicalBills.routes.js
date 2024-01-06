import { Router } from "express";

import {
  getAllCyclicalBills,
  deleteCyclicalBill,
  createCyclicalBill,
  createCyclicalBillMassive,
  deleteCyclicalBillMassive,
  processCyclicalBill,
  putCyclicalBill
} from "../../../controllers/sys/tables/sysCyclicalBills.controller.js";

const router = Router();

router.get("/", getAllCyclicalBills);
router.post("/", createCyclicalBill);
router.post("/process", processCyclicalBill);
router.post("/massive", createCyclicalBillMassive);
router.post("/delete-massive", deleteCyclicalBillMassive);
router.put("/", putCyclicalBill);
router.delete("/:id", deleteCyclicalBill);

export default router;
