import { Router } from "express";

import { getAllPqrsf, getOwnPqrsf, createPqrsf } from "../../../controllers/sys/utilities/sysPqrsf.controller.js";

const router = Router();

router.get("/", getOwnPqrsf);
router.get("/all", getAllPqrsf);
router.post("/", createPqrsf);

export default router;
