import { Router } from "express";

import { getAllMassiveMessages, getOwnMessages, createMassiveMessage, readMassiveMessage } from "../../../controllers/sys/utilities/sysMassiveMessages.controller.js";

const router = Router();

router.get("/receive", getOwnMessages);
router.get("/", getAllMassiveMessages);
router.post("/", createMassiveMessage);
router.put("/:id", readMassiveMessage);

export default router;
