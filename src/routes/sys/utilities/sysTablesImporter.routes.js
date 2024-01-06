import { Router } from "express";

import {
  genFileToImporter,
  uploadFileToImporter
} from "../../../controllers/sys/utilities/sysTablesImporter.controller.js";

const router = Router();

router.get("/download/:origin", genFileToImporter);
router.post("/upload", uploadFileToImporter);

export default router;
