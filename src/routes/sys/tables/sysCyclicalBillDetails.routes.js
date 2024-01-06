import { Router } from "express";

import {
  getAllCyclicalBillDetails,
  deleteCyclicalBillDetail,
  createCyclicalBillDetail,
  putCyclicalBillDetail
} from "../../../controllers/sys/tables/sysCyclicalBillDetails.controller.js";

const router = Router();

router.get("/:id_factura_ciclica", getAllCyclicalBillDetails);
router.post("/", createCyclicalBillDetail);
router.put("/", putCyclicalBillDetail);
router.delete("/:id", deleteCyclicalBillDetail);

export default router;
