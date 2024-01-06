import { Router } from "express";
import authAdmin from "../../middleware/adminAuth.js";

import {
  register,
  updateUser,
  addClient,
  removeClient,
  getClientUsers,
  updateTokenFBUser,
  getNotificationUser
} from "../../controllers/admin/adminUsers.controller.js";

import {
  getAllRolePermissions,
  putRolePermissions
} from "../../controllers/admin/adminRolePermissions.controller.js";

import {
  getAllRoles,
  deleteRole,
  createRole,
  putRole
} from "../../controllers/admin/adminRoles.controller.js";

const router = Router();

//USERS
router.get("/", getClientUsers);

//UPDATE USER
router.put("/", updateUser);

//FIREBASE ADMIN USER TOKEN
router.put("/fb-token", updateTokenFBUser);

//USER PUSH NOTIFICATION
router.get("/notifications", getNotificationUser);

//REGISTER USER
router.post("/register", register);

//ADD CLIENT ON USER
router.post("/addClient", addClient);

//REMOVE CLIENT FROM USER
router.post("/removeClient", removeClient);

//USER ROLES
router.get("/roles", getAllRoles);

router.get("/roles/permissions/:role", getAllRolePermissions);
router.put("/roles/permissions", putRolePermissions);

router.post("/roles", createRole);
router.put("/roles", putRole);
router.delete("/roles/:id", deleteRole);



export default router;
