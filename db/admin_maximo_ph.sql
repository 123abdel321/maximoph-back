-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 24, 2023 at 05:27 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cli_maximo_ph_admin`
--

-- --------------------------------------------------------

--
-- Table structure for table `clientes`
--

CREATE TABLE `clientes` (
  `id` int(11) NOT NULL,
  `tipo_documento` int(11) NOT NULL DEFAULT 0 COMMENT '0 - CÉDULA 1 - NIT',
  `numero_documento` varchar(100) NOT NULL,
  `razon_social` varchar(250) DEFAULT NULL,
  `nombres` varchar(250) NOT NULL,
  `cidudad` varchar(150) NOT NULL,
  `direccion` varchar(150) NOT NULL,
  `telefono` varchar(150) NOT NULL,
  `correo` varchar(150) NOT NULL,
  `estado` int(11) NOT NULL DEFAULT 0 COMMENT '0 -ACTIVA, 1 - SUSPENDIDA, 2 - CANCELADA',
  `tipo_unidad` int(11) NOT NULL DEFAULT 0 COMMENT '0 - CASAS, 1 - APTOS, 2 - OFICINAS, 3 - BODEGAS, 4 - LOCALES COMERCIALES',
  `numero_unidades` int(11) NOT NULL DEFAULT 0,
  `valor_suscripcion_mensual` varchar(100) NOT NULL,
  `token_db` varchar(250) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `upadted_by` int(11) DEFAULT NULL,
  `upadted_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `clientes`
--

INSERT INTO `clientes` (`id`, `tipo_documento`, `numero_documento`, `razon_social`, `nombres`, `cidudad`, `direccion`, `telefono`, `correo`, `estado`, `tipo_unidad`, `numero_unidades`, `valor_suscripcion_mensual`, `token_db`, `created_by`, `created_at`, `upadted_by`, `upadted_at`) VALUES
(12, 1, '654321', NULL, 'Jhon Doe', 'Medellín', 'Medellín', '12', 'jhondoe2@mail.com', 1, 1, 10, '20000', 'jhon_doe_654321', NULL, '2023-04-09 13:25:00', NULL, NULL),
(16, 1, '654388', NULL, 'Doe8 Jhon8', 'Medellín', 'Medellín', '12', 'jhondoe48@mail.com', 1, 1, 10, '20000', 'doe8_jhon8_654388', NULL, '2023-06-12 12:36:11', NULL, NULL),
(17, 1, '6543881', 'Doe8 Jhon8', 'Doe8 Jhon8', 'Medellín', 'Medellín', '12', 'jhondoe48@mail.com', 1, 1, 10, '20000', 'doe8_jhon8_6543881', NULL, '2023-06-12 15:03:11', NULL, NULL),
(18, 1, '65438812', 'Doe8 Jhon8', 'Doe8 Jhon8', 'Medellín', 'Medellín', '12', 'jhondoe48@mail.com', 1, 1, 10, '20000', 'doe8_jhon8_65438812', NULL, '2023-06-12 15:08:07', NULL, NULL),
(19, 1, '654388123', 'Doe8 Jhon8', 'Doe8 Jhon8', 'Medellín', 'Medellín', '12', 'jhondoe48@mail.com', 1, 1, 10, '20000', 'doe8_jhon8_654388123', NULL, '2023-06-12 15:11:14', NULL, NULL),
(20, 1, '6543881232', 'Doe8 Jhon8', 'Doe8 Jhon8', 'Medellín', 'Medellín', '12', 'jhondoe418@mail.com', 1, 1, 10, '20000', 'doe8_jhon8_6543881232', NULL, '2023-06-12 15:11:36', NULL, NULL),
(21, 1, '65438812322', 'Doe8 Jhon8', 'Doe8 Jhon8', 'Medellín', 'Medellín', '12', 'jhondoe418@mail.com', 1, 1, 10, '20000', 'doe8_jhon8_65438812322', NULL, '2023-06-12 15:12:20', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `cliente_contactos`
--

CREATE TABLE `cliente_contactos` (
  `id` int(11) NOT NULL,
  `id_cliente` int(11) NOT NULL,
  `tipo_documento` int(11) DEFAULT NULL COMMENT '0 - CÉDULA 1 - NIT',
  `numero_documento` varchar(100) DEFAULT NULL,
  `nombres` varchar(100) NOT NULL,
  `apellidos` varchar(100) DEFAULT NULL,
  `telefono` varchar(150) NOT NULL,
  `celular` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `maestras_base`
--

CREATE TABLE `maestras_base` (
  `id` int(11) NOT NULL,
  `tipo` int(11) NOT NULL DEFAULT 0 COMMENT '0 - ROL, 1 - MODULO',
  `nombre` varchar(50) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `maestras_base`
--

INSERT INTO `maestras_base` (`id`, `tipo`, `nombre`, `descripcion`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 0, 'ADMINISTRADOR', 'ADMINISTRADOR', NULL, '2023-04-08 00:03:51', NULL, '0000-00-00 00:00:00'),
(2, 1, 'Personas', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(3, 1, 'Inmuebles', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(4, 1, 'Proveedores', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(5, 1, 'Inmuebles > Zonas', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(6, 1, 'Inmueble > Personas', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(7, 1, 'Inmueble > Vehiculos', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(8, 1, 'Contable > Conceptos de Facturación', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(9, 1, 'Contable > Conceptos de Gastos', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(10, 1, 'General > Tipos de Tareas', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(11, 1, 'General > Conceptos de Ingresos', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(12, 1, 'Captura > Facturación Ciclica', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(13, 1, 'Captura > Gastos', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(14, 1, 'Captura > Control Ingreso', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(15, 1, 'Captura > Tareas', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(16, 1, 'Captura > Presupuesto Anual', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(17, 1, 'Utilidades > Mensajeria Masiva', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(18, 1, 'Utilidades > Entorno', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(19, 1, 'Utilidades > Logs', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(20, 1, 'Utilidades > Importador', NULL, NULL, '2023-04-08 21:43:35', NULL, '0000-00-00 00:00:00'),
(21, 1, 'Admin > Usuarios', NULL, NULL, '2023-04-09 01:54:57', NULL, '2023-04-09 01:55:17'),
(22, 1, 'Admin > Roles', NULL, NULL, '2023-04-09 01:54:57', NULL, '2023-04-09 01:55:25'),
(23, 1, 'Admin > Roles Permisos', NULL, NULL, '2023-04-09 01:54:57', NULL, '2023-04-09 01:55:25'),
(24, 0, 'PROPIETARIO', 'PROPIETARIO', NULL, '2023-04-08 00:03:51', NULL, '0000-00-00 00:00:00'),
(25, 0, 'INQUILINO', 'INQUILINO', NULL, '2023-04-08 00:03:51', NULL, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `permisos`
--

CREATE TABLE `permisos` (
  `id` int(11) NOT NULL,
  `id_modulo` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `permisos`
--

INSERT INTO `permisos` (`id`, `id_modulo`, `nombre`, `descripcion`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 2, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(2, 3, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(3, 4, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(4, 5, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(5, 6, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(6, 7, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(7, 8, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(8, 9, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(9, 10, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(10, 11, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(11, 12, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(12, 13, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(13, 14, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(14, 15, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(15, 16, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(16, 17, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(17, 18, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(18, 19, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(19, 20, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(32, 2, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(33, 3, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(34, 4, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(35, 5, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(36, 6, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(37, 7, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(38, 8, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(39, 9, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(40, 10, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(41, 11, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(42, 12, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(43, 13, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(44, 14, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(45, 15, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(46, 16, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(47, 17, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(48, 18, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(49, 19, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(50, 20, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(63, 2, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(64, 3, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(65, 4, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(66, 5, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(67, 6, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(68, 7, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(69, 8, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(70, 9, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(71, 10, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(72, 11, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(73, 12, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(74, 13, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(75, 14, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(76, 15, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(77, 16, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(78, 17, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(79, 18, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(80, 19, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(81, 20, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(94, 2, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(95, 3, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(96, 4, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(97, 5, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(98, 6, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(99, 7, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(100, 8, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(101, 9, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(102, 10, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(103, 11, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(104, 12, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(105, 13, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(106, 14, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(107, 15, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(108, 16, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(109, 17, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(110, 18, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(111, 19, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(112, 20, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(125, 21, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(126, 22, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(127, 23, 'INGRESAR', 'Acceso para lectura', NULL, '0000-00-00 00:00:00', NULL, NULL),
(128, 21, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(129, 22, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(130, 23, 'CREAR', 'Acceso para crear nuevos registros', NULL, '0000-00-00 00:00:00', NULL, NULL),
(131, 21, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(132, 22, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(133, 23, 'ACTUALIZAR', 'Acceso para actualizar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(134, 21, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(135, 22, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL),
(136, 23, 'ELIMINAR', 'Acceso para eliminar registros existentes', NULL, '0000-00-00 00:00:00', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `roles_permisos`
--

CREATE TABLE `roles_permisos` (
  `id` int(11) NOT NULL,
  `id_rol` int(11) NOT NULL,
  `id_permiso` int(11) NOT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `roles_permisos`
--

INSERT INTO `roles_permisos` (`id`, `id_rol`, `id_permiso`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(32, 1, 1, NULL, '2023-04-08 23:54:33', NULL, NULL),
(33, 1, 2, NULL, '2023-04-08 23:54:33', NULL, NULL),
(34, 1, 3, NULL, '2023-04-08 23:54:33', NULL, NULL),
(35, 1, 4, NULL, '2023-04-08 23:54:33', NULL, NULL),
(36, 1, 5, NULL, '2023-04-08 23:54:33', NULL, NULL),
(37, 1, 6, NULL, '2023-04-08 23:54:33', NULL, NULL),
(38, 1, 7, NULL, '2023-04-08 23:54:33', NULL, NULL),
(39, 1, 8, NULL, '2023-04-08 23:54:33', NULL, NULL),
(40, 1, 9, NULL, '2023-04-08 23:54:33', NULL, NULL),
(41, 1, 10, NULL, '2023-04-08 23:54:33', NULL, NULL),
(42, 1, 11, NULL, '2023-04-08 23:54:33', NULL, NULL),
(43, 1, 12, NULL, '2023-04-08 23:54:33', NULL, NULL),
(44, 1, 13, NULL, '2023-04-08 23:54:33', NULL, NULL),
(45, 1, 14, NULL, '2023-04-08 23:54:33', NULL, NULL),
(46, 1, 15, NULL, '2023-04-08 23:54:33', NULL, NULL),
(47, 1, 16, NULL, '2023-04-08 23:54:33', NULL, NULL),
(48, 1, 17, NULL, '2023-04-08 23:54:33', NULL, NULL),
(49, 1, 18, NULL, '2023-04-08 23:54:33', NULL, NULL),
(50, 1, 19, NULL, '2023-04-08 23:54:33', NULL, NULL),
(51, 1, 32, NULL, '2023-04-08 23:54:33', NULL, NULL),
(52, 1, 33, NULL, '2023-04-08 23:54:33', NULL, NULL),
(53, 1, 34, NULL, '2023-04-08 23:54:33', NULL, NULL),
(54, 1, 35, NULL, '2023-04-08 23:54:33', NULL, NULL),
(55, 1, 36, NULL, '2023-04-08 23:54:33', NULL, NULL),
(56, 1, 37, NULL, '2023-04-08 23:54:33', NULL, NULL),
(57, 1, 38, NULL, '2023-04-08 23:54:33', NULL, NULL),
(58, 1, 39, NULL, '2023-04-08 23:54:33', NULL, NULL),
(59, 1, 40, NULL, '2023-04-08 23:54:33', NULL, NULL),
(60, 1, 41, NULL, '2023-04-08 23:54:33', NULL, NULL),
(61, 1, 42, NULL, '2023-04-08 23:54:33', NULL, NULL),
(62, 1, 43, NULL, '2023-04-08 23:54:33', NULL, NULL),
(63, 1, 44, NULL, '2023-04-08 23:54:33', NULL, NULL),
(64, 1, 45, NULL, '2023-04-08 23:54:33', NULL, NULL),
(65, 1, 46, NULL, '2023-04-08 23:54:33', NULL, NULL),
(66, 1, 47, NULL, '2023-04-08 23:54:33', NULL, NULL),
(67, 1, 48, NULL, '2023-04-08 23:54:33', NULL, NULL),
(68, 1, 49, NULL, '2023-04-08 23:54:33', NULL, NULL),
(69, 1, 50, NULL, '2023-04-08 23:54:33', NULL, NULL),
(70, 1, 63, NULL, '2023-04-08 23:54:33', NULL, NULL),
(71, 1, 64, NULL, '2023-04-08 23:54:33', NULL, NULL),
(72, 1, 65, NULL, '2023-04-08 23:54:33', NULL, NULL),
(73, 1, 66, NULL, '2023-04-08 23:54:33', NULL, NULL),
(74, 1, 67, NULL, '2023-04-08 23:54:33', NULL, NULL),
(75, 1, 68, NULL, '2023-04-08 23:54:33', NULL, NULL),
(76, 1, 69, NULL, '2023-04-08 23:54:33', NULL, NULL),
(77, 1, 70, NULL, '2023-04-08 23:54:33', NULL, NULL),
(78, 1, 71, NULL, '2023-04-08 23:54:33', NULL, NULL),
(79, 1, 72, NULL, '2023-04-08 23:54:33', NULL, NULL),
(80, 1, 73, NULL, '2023-04-08 23:54:33', NULL, NULL),
(81, 1, 74, NULL, '2023-04-08 23:54:33', NULL, NULL),
(82, 1, 75, NULL, '2023-04-08 23:54:33', NULL, NULL),
(83, 1, 76, NULL, '2023-04-08 23:54:33', NULL, NULL),
(84, 1, 77, NULL, '2023-04-08 23:54:33', NULL, NULL),
(85, 1, 78, NULL, '2023-04-08 23:54:33', NULL, NULL),
(86, 1, 79, NULL, '2023-04-08 23:54:33', NULL, NULL),
(87, 1, 80, NULL, '2023-04-08 23:54:33', NULL, NULL),
(88, 1, 81, NULL, '2023-04-08 23:54:33', NULL, NULL),
(89, 1, 94, NULL, '2023-04-08 23:54:33', NULL, NULL),
(90, 1, 95, NULL, '2023-04-08 23:54:33', NULL, NULL),
(91, 1, 96, NULL, '2023-04-08 23:54:33', NULL, NULL),
(92, 1, 97, NULL, '2023-04-08 23:54:33', NULL, NULL),
(93, 1, 98, NULL, '2023-04-08 23:54:33', NULL, NULL),
(94, 1, 99, NULL, '2023-04-08 23:54:33', NULL, NULL),
(95, 1, 100, NULL, '2023-04-08 23:54:33', NULL, NULL),
(96, 1, 101, NULL, '2023-04-08 23:54:33', NULL, NULL),
(97, 1, 102, NULL, '2023-04-08 23:54:33', NULL, NULL),
(98, 1, 103, NULL, '2023-04-08 23:54:33', NULL, NULL),
(99, 1, 104, NULL, '2023-04-08 23:54:33', NULL, NULL),
(100, 1, 105, NULL, '2023-04-08 23:54:33', NULL, NULL),
(101, 1, 106, NULL, '2023-04-08 23:54:33', NULL, NULL),
(102, 1, 107, NULL, '2023-04-08 23:54:33', NULL, NULL),
(103, 1, 108, NULL, '2023-04-08 23:54:33', NULL, NULL),
(104, 1, 109, NULL, '2023-04-08 23:54:33', NULL, NULL),
(105, 1, 110, NULL, '2023-04-08 23:54:33', NULL, NULL),
(106, 1, 111, NULL, '2023-04-08 23:54:33', NULL, NULL),
(107, 1, 112, NULL, '2023-04-08 23:54:33', NULL, NULL),
(159, 1, 125, NULL, '2023-04-09 02:08:42', NULL, NULL),
(160, 1, 126, NULL, '2023-04-09 02:08:42', NULL, NULL),
(161, 1, 127, NULL, '2023-04-09 02:08:42', NULL, NULL),
(162, 1, 128, NULL, '2023-04-09 02:08:42', NULL, NULL),
(163, 1, 129, NULL, '2023-04-09 02:08:42', NULL, NULL),
(164, 1, 130, NULL, '2023-04-09 02:08:42', NULL, NULL),
(165, 1, 131, NULL, '2023-04-09 02:08:42', NULL, NULL),
(166, 1, 132, NULL, '2023-04-09 02:08:42', NULL, NULL),
(167, 1, 133, NULL, '2023-04-09 02:08:42', NULL, NULL),
(168, 1, 134, NULL, '2023-04-09 02:08:42', NULL, NULL),
(169, 1, 135, NULL, '2023-04-09 02:08:42', NULL, NULL),
(170, 1, 136, NULL, '2023-04-09 02:08:42', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `id_cliente` varchar(500) DEFAULT NULL,
  `id_persona_maximo` int(11) DEFAULT NULL,
  `id_rol` int(11) NOT NULL,
  `email` varchar(200) NOT NULL,
  `estado` tinyint(4) NOT NULL DEFAULT 1 COMMENT '0 - INACTIVO, 1 - ACTIVO',
  `password` varchar(200) NOT NULL,
  `session_token` varchar(500) DEFAULT NULL,
  `firebase_token` varchar(500) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`id`, `id_cliente`, `id_persona_maximo`, `id_rol`, `email`, `estado`, `password`, `session_token`, `firebase_token`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(4, '12', 1, 1, 'jhondoe2@mail.com', 1, '$2b$10$r33tA.UoJYME4R1S5IhtNeXJICbhnvtxx6RwURkXO/kcf.6bVuWrq', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjo0LCJpZF9jbGllbnRlIjoiMTIiLCJpZF9wZXJzb25hX21heGltbyI6MSwiaWRfcm9sIjoxLCJlbWFpbCI6Impob25kb2UyQG1haWwuY29tIiwidG9rZW5fZGIiOiJqaG9uX2RvZV82NTQzMjEifSwiaWF0IjoxNjk1NTQzNTEzLCJleHAiOjE2OTU2Mjk5MTN9.ONLnYvlC07I9eJLYqHkiJ26bPkMf0DeYtDTAV2nD8rM', 'dCMMVz0WVEuRABow3_6F5m:APA91bGH0tTfAQGctC0xGgKDhBOZUrcseo-fiR4Xl9fvxZcCwsehmV_1MKjyc-GCwJ7GlAiuQ5_NonfNwZRhoFmMzt0RdeKbsSOd7KKBj_nejrItNwd3oIffi302yH8VB-EF0ftgq8Jd', NULL, '2023-04-09 13:25:00', NULL, '2023-09-24 08:18:36'),
(11, '16,17,19', 1, 1, 'jhondoe48@mail.com', 1, '$2b$10$EX1PktiO3xe7WIbmHWFdE.8eiNwyLaTSmSJbEkpry2sSWw6PcghZK', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxMSwiaWRfY2xpZW50ZSI6IjE2LDE3LDE5IiwiaWRfcGVyc29uYV9tYXhpbW8iOjEsImlkX3JvbCI6MSwiZW1haWwiOiJqaG9uZG9lNDhAbWFpbC5jb20iLCJ0b2tlbl9kYiI6ImRvZThfamhvbjhfNjU0Mzg4In0sImlhdCI6MTY4NjU4MjY3NCwiZXhwIjoxNjg2NjY5MDc0fQ.qYVuE1pyRuC_iTocYJ1prvl7SdgaUDtlJo94GHIw_i4', NULL, NULL, '2023-06-12 12:36:11', NULL, '2023-06-12 15:11:14'),
(13, '21', 1, 1, 'jhondoe418@mail.com', 1, '$2b$10$.Fo3XRNHT/9N1UoVMLHugu1ywaiziFQjge9A5rb5fNqLVLrdgM8cm', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxMywiaWRfY2xpZW50ZSI6IjIxIiwiaWRfcGVyc29uYV9tYXhpbW8iOjEsImlkX3JvbCI6MSwiZW1haWwiOiJqaG9uZG9lNDE4QG1haWwuY29tIiwidG9rZW5fZGIiOiJkb2U4X2pob244XzY1NDM4ODEyMzIyIn0sImlhdCI6MTY4NjU4Mjc0MCwiZXhwIjoxNjg2NjY5MTQwfQ.NPO5YSw8vTVfuRwdE_tGrWQPSlvMffLSrvBE5L24LHw', NULL, NULL, '2023-06-12 15:12:20', NULL, '2023-06-12 15:12:20'),
(14, '12', 1, 24, 'propietario@mail.com', 1, '$2b$10$r33tA.UoJYME4R1S5IhtNeXJICbhnvtxx6RwURkXO/kcf.6bVuWrq', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNCwiaWRfY2xpZW50ZSI6IjEyIiwiaWRfcGVyc29uYV9tYXhpbW8iOjEsImlkX3JvbCI6MjQsImVtYWlsIjoicHJvcGlldGFyaW9AbWFpbC5jb20iLCJ0b2tlbl9kYiI6Impob25fZG9lXzY1NDMyMSJ9LCJpYXQiOjE2OTU1NDM1NDcsImV4cCI6MTY5NTYyOTk0N30.Nwyec4qtyk6_vfA4a34oiVeoc71FEG_Rm4Z4p92R478', 'dCMMVz0WVEuRABow3_6F5m:APA91bGH0tTfAQGctC0xGgKDhBOZUrcseo-fiR4Xl9fvxZcCwsehmV_1MKjyc-GCwJ7GlAiuQ5_NonfNwZRhoFmMzt0RdeKbsSOd7KKBj_nejrItNwd3oIffi302yH8VB-EF0ftgq8Jd', NULL, '2023-04-09 13:25:00', NULL, '2023-09-24 08:19:08'),
(15, '12', 1, 25, 'inquilino@mail.com', 1, '$2b$10$r33tA.UoJYME4R1S5IhtNeXJICbhnvtxx6RwURkXO/kcf.6bVuWrq', 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoxNSwiaWRfY2xpZW50ZSI6IjEyIiwiaWRfcGVyc29uYV9tYXhpbW8iOjEsImlkX3JvbCI6MjUsImVtYWlsIjoiaW5xdWlsaW5vQG1haWwuY29tIiwidG9rZW5fZGIiOiJqaG9uX2RvZV82NTQzMjEifSwiaWF0IjoxNjk1NTQzNTY4LCJleHAiOjE2OTU2Mjk5Njh9.bzDUuHAuBzmQmxRa7cEUBrr9xlxSBCwYZrGdX4YepSY', 'dCMMVz0WVEuRABow3_6F5m:APA91bGH0tTfAQGctC0xGgKDhBOZUrcseo-fiR4Xl9fvxZcCwsehmV_1MKjyc-GCwJ7GlAiuQ5_NonfNwZRhoFmMzt0RdeKbsSOd7KKBj_nejrItNwd3oIffi302yH8VB-EF0ftgq8Jd', NULL, '2023-04-09 13:25:00', NULL, '2023-09-24 09:13:55');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cliente_contactos`
--
ALTER TABLE `cliente_contactos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cliente` (`id_cliente`);

--
-- Indexes for table `maestras_base`
--
ALTER TABLE `maestras_base`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permisos`
--
ALTER TABLE `permisos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles_permisos`
--
ALTER TABLE `roles_permisos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `id_permiso` (`id_permiso`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_rol` (`id_rol`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `cliente_contactos`
--
ALTER TABLE `cliente_contactos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `maestras_base`
--
ALTER TABLE `maestras_base`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `permisos`
--
ALTER TABLE `permisos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=137;

--
-- AUTO_INCREMENT for table `roles_permisos`
--
ALTER TABLE `roles_permisos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=171;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
