import { Router } from "express";

import {
  getExtractNit,
  getPaymentPDF,
  deletePayment,
  createPayment,
  getAllPayments,
  getAllAcumulate
} from "../../../controllers/sys/process/sysPayments.controller.js";

const router = Router();

router.get("/extract-nit/:tercero", getExtractNit);
router.get("/", getAllPayments);
router.get("/acumulate", getAllAcumulate);
router.get("/PDF/:id", getPaymentPDF);
router.post("/", createPayment);
router.delete("/:id", deletePayment);

export default router;
