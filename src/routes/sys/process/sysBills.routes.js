import { Router } from "express";

import {
  getSendEmailBillPDF,
  getAllBills,
  getBillPDF,
  getBillsPDF,
  deleteBill,
  deleteBills
} from "../../../controllers/sys/process/sysBills.controller.js";

const router = Router();

router.get("/PDF/:id", getBillPDF);
router.get("/PDFs/:id/:fisico", getBillsPDF);
router.get("/email/:id", getSendEmailBillPDF);
router.get("/", getAllBills);
router.delete("/:id", deleteBill);
router.delete("/history/:id", deleteBills);

export default router;
