import { Router } from "express";

import {
  uploadPhotoPerson,
  getAllPersons,
  deletePerson,
  createPerson,
  syncERPPerson,
  putPerson
} from "../../../controllers/sys/tables/sysPersons.controller.js";

const router = Router();

router.get("/", getAllPersons);

router.get("/erp", (req, res, next) => { req.erp = true; next(); }, getAllPersons);

router.post("/", createPerson);
router.post("/sync-erp/:id", syncERPPerson);
router.post("/photo", uploadPhotoPerson);
router.put("/", putPerson);
router.delete("/:id", deletePerson);

export default router;
