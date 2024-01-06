import { Router } from "express";

import {
  getExtractNit,
  getBillCashReceiptPDF,
  getPeaceAndSafetyPDF,
  deleteBillCashReceipt,
  createBillCashReceipt,
  createBillCashReceiptAnticipos,
  getAllBillCashReceipts,

  getOwnVouchers,
  getAllVouchers,
  createVoucher,
  changeStatusVoucher
} from "../../../controllers/sys/process/sysBillCashReceipts.controller.js";

const router = Router();

//BILL CASH RECEIPTS
router.get("/extract-nit/:tercero", getExtractNit);
router.get("/", getAllBillCashReceipts);
router.get("/PDF/:id", getBillCashReceiptPDF);
router.get("/peace-and-safety/PDF/:persona", getPeaceAndSafetyPDF);
router.post("/", createBillCashReceipt);
router.post("/anticipos", createBillCashReceiptAnticipos);
router.delete("/:id", deleteBillCashReceipt);

//VOUCHERS
router.get("/vouchers", getOwnVouchers);
router.get("/vouchers/all", getAllVouchers);
router.post("/vouchers", createVoucher);
router.put("/vouchers", changeStatusVoucher);

export default router;
