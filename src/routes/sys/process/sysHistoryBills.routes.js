import { Router } from "express";

import {
  getAllHistoryBills,
  getAllHistoryBillsDetails,
} from "../../../controllers/sys/process/sysHistoryBills.controller.js";

const router = Router();

router.get("/gen/:idHistory?", getAllHistoryBills);
router.get("/details/:idHistory?", getAllHistoryBillsDetails);

export default router;
