import express from "express";
import dotenv from "dotenv";
import jwt from "jsonwebtoken";
import routes from "./routes/index.js";
import cors from "cors";

import {initializeApp, applicationDefault } from 'firebase-admin/app';

dotenv.config();

const token = jwt.sign({ username: "admin" }, "secret");

// generate a general token for all app
process.env.AUTH_TOKEN = token;

const app = express();
const PORT = process.env.SERVER_PORT;

app.use(
  cors({
    origin: "*",
    methods: ["GET", "POST", "PUT", "DELETE"],
    allowedHeaders: ["Authorization", "Content-Type"],
  })
);

app.use(express.json());



process.env.GOOGLE_APPLICATION_CREDENTIALS;
      
initializeApp({
  credential: applicationDefault(),
  projectId: process.env.FB_PROJECTID,
});

app.use("/api", routes);

app.use('/uploads/avatar', express.static('public/uploads/photoPersons'));
app.get('/uploads/avatar/:filename', (req, res) => {
  const filename = req.params.filename;
  res.sendFile(`${__dirname}/public/uploads/photoPersons/${filename}`);
});

app.use('/uploads/vehicles', express.static('public/uploads/photoVehicles'));
app.get('/uploads/vehicles/:filename', (req, res) => {
  const filename = req.params.filename;
  res.sendFile(`${__dirname}/public/uploads/photoVehicles/${filename}`);
});

app.use('/uploads/pets', express.static('public/uploads/photoPets'));
app.get('/uploads/pets/:filename', (req, res) => {
  const filename = req.params.filename;
  res.sendFile(`${__dirname}/public/uploads/photoPets/${filename}`);
});

app.use('/uploads/pqrsf', express.static('public/uploads/photoPqrsf'));
app.get('/uploads/pqrsf/:filename', (req, res) => {
  const filename = req.params.filename;
  res.sendFile(`${__dirname}/public/uploads/photoPqrsf/${filename}`);
});

app.use('/uploads/homeworks', express.static('public/uploads/photoHomeworks'));
app.get('/uploads/homeworks/:filename', (req, res) => {
  const filename = req.params.filename;
  res.sendFile(`${__dirname}/public/uploads/photoHomeworks/${filename}`);
});

app.use('/uploads/vouchers-Bill-cash-receipts', express.static('public/uploads/vouchersBillCashReceipts'));
app.get('/uploads/vouchers-Bill-cash-receipts/:filename', (req, res) => {
  const filename = req.params.filename;
  res.sendFile(`${__dirname}/public/uploads/vouchersBillCashReceipts/${filename}`);
});

app.use('/uploads/company-logo', express.static('public/uploads/companyLogo'));
app.get('/uploads/company-logo/:filename', (req, res) => {
  const filename = req.params.filename;
  res.sendFile(`${__dirname}/public/uploads/companyLogo/${filename}`);
});

app.use('/uploads/visitors', express.static('public/uploads/photoVisitors'));
app.get('/uploads/visitors/:filename', (req, res) => {
  const filename = req.params.filename;
  res.sendFile(`${__dirname}/public/uploads/photoVisitors/${filename}`);
});

app.use('/uploads/messages', express.static('public/uploads/photoMessages'));
app.get('/uploads/messages/:filename', (req, res) => {
  const filename = req.params.filename;
  res.sendFile(`${__dirname}/public/uploads/photoMessages/${filename}`);
});

app.use((req, res, next) => {
  res.status(404).json({
    message: "Not found",
  });
});

app.listen(PORT);

console.log(`Server running on ${PORT}`);
