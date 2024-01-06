import { Router } from "express";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

//ADMIN
import adminUsersRoutes from "./admin/adminUsers.routes.js";
import adminClientRoutes from "./admin/adminClients.routes.js";

//ERP
import sysErpCities from "./sys/accounting/sysErpCities.routes.js";
import sysErpAccounts from "./sys/accounting/sysErpAccounts.routes.js";
import sysErpVouchers from "./sys/accounting/sysErpVouchers.routes.js";
import sysErpCostsCenter from "./sys/accounting/sysErpCostsCenter.routes.js";

// TABLES
    //PROPERTIES
    import sysPropertiesRoutes from "./sys/tables/sysProperties.routes.js";

    //PROPERTY OWNERS RENTERS
    import sysPropertyOwnersRentersRoutes from "./sys/tables/sysPropertyOwnersRenters.routes.js";

    //PROPERTY VISITORS
    import sysPropertyVisitorsRoutes from "./sys/tables/sysPropertyVisitors.routes.js";

    //PROPERTY VEHICLES
    import sysPropertyVehiclesRoutes from "./sys/tables/sysPropertyVehicles.routes.js";

    //PROPERTY PETS
    import sysPropertyPetsRoutes from "./sys/tables/sysPropertyPets.routes.js";

    //CYCLICAL BILLS
    import sysCyclicalBillsRoutes from "./sys/tables/sysCyclicalBills.routes.js";

    //CYCLICAL BILL DETAIL
    import sysCyclicalBillDetailsRoutes from "./sys/tables/sysCyclicalBillDetails.routes.js";

    //PERSON
    import sysPersonsRoutes from "./sys/tables/sysPerson.routes.js";

    //ZONES
    import sysZonesRoutes from "./sys/tables/sysZones.routes.js";

    //VISIT CONCEPTS
    import sysVisitConcept from "./sys/tables/sysVisitConcept.routes.js";

    //TYPES HOMEWORK
    import sysTypesHomework from "./sys/tables/sysTypesHomework.routes.js";

    //PROVIDER TYPES
    import sysProviderTypes from "./sys/tables/sysProviderTypes.routes.js";

    //PROVIDERS
    import sysProviders from "./sys/tables/sysProviders.routes.js";

    //VEHICLE TYPES
    import sysVehicleTypes from "./sys/tables/sysVehicleTypes.routes.js";

    //BILLING CONCEPTS
    import sysBillingConcepts from "./sys/tables/sysBillingConcepts.routes.js";

    //SPENT CONCEPTS
    import sysSpentConcepts from "./sys/tables/sysSpentConcepts.routes.js";

// PROCESS

    //BILLS
    import sysBills from "./sys/process/sysBills.routes.js";

    //BILL CASH RECEIPTS
    import sysBillCashReceipts from "./sys/process/sysBillCashReceipts.routes.js";

    //HISTORY BILLS
    import sysHistoryBills from "./sys/process/sysHistoryBills.routes.js";

    //SPENTS
    import sysSpents from "./sys/process/sysSpents.routes.js";

    //PAYMENTS
    import sysPayments from "./sys/process/sysPayments.routes.js";

    //CONTROL VISITS
    import sysControlVisits from "./sys/process/sysControlVisits.routes.js";

// UTILITIES

    //SYS ENVIROMENT
    import sysEnviroment from "./sys/utilities/sysEnviroment.routes.js";

    //SYS LOGS
    import sysLogs from "./sys/utilities/sysLogs.routes.js";

    //SYS IMPORTER
    import sysTablesImporter from "./sys/utilities/sysTablesImporter.routes.js";

    //SYS MASSIVE MESSAGES
    import sysMassiveMessages from "./sys/utilities/sysMassiveMessages.routes.js";

    //SYS PQRSF
    import sysPqrsf from "./sys/utilities/sysPqrsf.routes.js";

    //SYS HOMEWORKS
    import sysHomeworks from "./sys/utilities/sysHomeworks.routes.js";

import { login } from "../controllers/admin/adminUsers.controller.js";

import authToken from "../middleware/auth.js";

dotenv.config();

const token = jwt.sign({ user: {id: 1}, username: "admin" }, process.env.SECRET_PRIV_KEY);

// generate a general token for all app
process.env.AUTH_TOKEN = token;

const router = Router();

//FREE ROUTES
    router.post("/users/login", login);

//PROTECTED ROUTES


//-----------------------------------------------------------------------------------------------------------------
//----------------------------------------------ADMIN ROUTES-------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------

    //ADMIN USERS
    router.use("/users", authToken, adminUsersRoutes);

    //ADMIN CLIENTS
    router.use("/admin/clients", authToken, adminClientRoutes);


//-----------------------------------------------------------------------------------------------------------------
//---------------------------------------------SYSTEM ROUTES-------------------------------------------------------
//-----------------------------------------------------------------------------------------------------------------

//ERP
    //SYS ERP COSTS CENTER
    router.use("/sys/accounting/erp-costs-center", authToken, sysErpCostsCenter);
    
    //SYS ERP VOUCHERS
    router.use("/sys/accounting/erp-vouchers", authToken, sysErpVouchers);

    //SYS ERP ACCOUNTS
    router.use("/sys/accounting/erp-accounts", authToken, sysErpAccounts);
    
    //SYS ERP CITIES
    router.use("/sys/accounting/erp-cities", authToken, sysErpCities);

//TABLES

    //SYS PROPERTIES
    router.use("/sys/tables/properties", authToken, sysPropertiesRoutes);

    //SYS PROPERTY OWNER RENTER
    router.use("/sys/tables/property-owners-renters", authToken, sysPropertyOwnersRentersRoutes);

    //SYS PROPERTY VISITORS
    router.use("/sys/tables/property-visitors", authToken, sysPropertyVisitorsRoutes);

    //SYS PROPERTY VEHICLES
    router.use("/sys/tables/property-vehicles", authToken, sysPropertyVehiclesRoutes);

    //SYS PROPERTY PETS
    router.use("/sys/tables/property-pets", authToken, sysPropertyPetsRoutes);

    //SYS CYCLICAL BILLS
    router.use("/sys/tables/cyclical-bills", authToken, sysCyclicalBillsRoutes);

    //SYS CYCLICAL BILL DETAIL
    router.use("/sys/tables/cyclical-bill-details", authToken, sysCyclicalBillDetailsRoutes);
    
    //SYS PERSONS
    router.use("/sys/tables/persons", authToken, sysPersonsRoutes);
    
    //SYS ZONES
    router.use("/sys/tables/zones", authToken, sysZonesRoutes);

    //SYS TYPE HOMEWORK
    router.use("/sys/tables/types-homework", authToken, sysTypesHomework);
    
    //SYS PROVIDER TYPE
    router.use("/sys/tables/provider-types", authToken, sysProviderTypes);

    //SYS PROVIDERS
    router.use("/sys/tables/providers", authToken, sysProviders);
    
    //SYS VEHICLE TYPE
    router.use("/sys/tables/vehicle-types", authToken, sysVehicleTypes);
    
    //SYS BILLING CONCEPTS
    router.use("/sys/tables/billing-concepts", authToken, sysBillingConcepts);
    
    //SYS SPENT CONCEPTS
    router.use("/sys/tables/spent-concepts", authToken, sysSpentConcepts);
    
    //SYS VISIT CONCEPTS
    router.use("/sys/tables/visit-concepts", authToken, sysVisitConcept);


//PROCESS    

    //SYS BILLS
    router.use("/sys/process/bills", authToken, sysBills);

    //SYS BILL CASH RECEIPTS
    router.use("/sys/process/bill-cash-receipts", authToken, sysBillCashReceipts);

    //SYS HISTORY BILLS
    router.use("/sys/process/history-bills", authToken, sysHistoryBills);

    //SYS SPENTS
    router.use("/sys/process/spents", authToken, sysSpents);

    //SYS PAYMENTS
    router.use("/sys/process/payments", authToken, sysPayments);

    //SYS CONTROL VISTIS
    router.use("/sys/process/control-visits", authToken, sysControlVisits);

//UTILITIES

    //SYS ENVIROMENT
    router.use("/sys/utilities/enviroment", authToken, sysEnviroment);

    //SYS LOGS
    router.use("/sys/utilities/logs", authToken, sysLogs);

    //SYS IMPORTER
    router.use("/sys/utilities/importer", authToken, sysTablesImporter);

    //SYS MASSIVE MESSAGES
    router.use("/sys/utilities/massive-messages", authToken, sysMassiveMessages);

    //SYS PQRSF
    router.use("/sys/utilities/pqrsf", authToken, sysPqrsf);

    //SYS HOMEWORKS
    router.use("/sys/utilities/homeworks", authToken, sysHomeworks);
    

export default router;
