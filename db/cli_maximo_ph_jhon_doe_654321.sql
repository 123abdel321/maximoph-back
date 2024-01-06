-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 67.207.83.69
-- Generation Time: Dec 02, 2023 at 08:17 PM
-- Server version: 8.0.35-0ubuntu0.23.04.1
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cli_maximo_ph_jhon_doe_654321`
--

-- --------------------------------------------------------

--
-- Table structure for table `activos_fijos`
--

CREATE TABLE `activos_fijos` (
  `id` int NOT NULL,
  `id_inmueble_zona` int DEFAULT NULL,
  `nombre` varchar(100) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `conceptos_facturacion`
--

CREATE TABLE `conceptos_facturacion` (
  `id` int NOT NULL,
  `id_cuenta_ingreso_erp` int NOT NULL,
  `id_cuenta_interes_erp` int DEFAULT NULL,
  `id_cuenta_iva_erp` int DEFAULT NULL,
  `id_cuenta_por_cobrar` int NOT NULL,
  `nombre` varchar(500) DEFAULT NULL,
  `intereses` tinyint NOT NULL DEFAULT '0' COMMENT '0 - NO, 1 - SI',
  `valor` varchar(100) DEFAULT NULL,
  `eliminado` tinyint NOT NULL DEFAULT '0',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `conceptos_facturacion`
--

INSERT INTO `conceptos_facturacion` (`id`, `id_cuenta_ingreso_erp`, `id_cuenta_interes_erp`, `id_cuenta_iva_erp`, `id_cuenta_por_cobrar`, `nombre`, `intereses`, `valor`, `eliminado`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 20117, NULL, NULL, 20213, 'ADMON APARTAMENTO', 1, '0', 0, 4, '2023-04-30 15:03:09', 24, '2023-11-09 17:34:49'),
(3, 19964, NULL, NULL, 19964, 'MULTA ROPA', 1, '80000', 1, 4, '2023-06-10 21:36:11', 4, '2023-11-02 20:17:02'),
(6, 19964, NULL, NULL, 19964, 'CUOTA EXTRA', 0, '0', 0, 25, '2023-09-19 21:38:04', 4, '2023-11-02 20:17:02'),
(7, 19964, NULL, NULL, 19964, 'INTERESES', 0, '0', 1, 24, '2023-09-26 23:58:07', NULL, '2023-11-02 20:17:02'),
(8, 19962, NULL, NULL, 21135, 'INTERESES', 0, '0', 0, 4, '2023-10-01 14:52:37', 24, '2023-11-22 18:20:07'),
(9, 19964, NULL, NULL, 19964, 'CUOTA EXTRA PINTURA DE CUARTO UTIL', 1, '10000', 0, 24, '2023-10-06 01:13:12', NULL, '2023-11-02 20:17:03'),
(10, 19964, NULL, NULL, 19964, 'MULTA GENERAL', 0, '100000', 0, 25, '2023-10-09 16:03:57', 25, '2023-11-02 20:17:03'),
(11, 19964, NULL, NULL, 19964, 'MULTA', 0, '10000', 0, 24, '2023-11-01 05:14:07', 24, '2023-11-02 20:17:03'),
(12, 19938, NULL, NULL, 19824, 'TEST  2', 0, '112', 1, 4, '2023-11-08 01:30:00', 4, '2023-11-08 01:30:25'),
(13, 22157, NULL, NULL, 21189, 'ADMON PARQUEDARO', 1, '', 0, 24, '2023-11-09 17:33:30', NULL, NULL),
(14, 22156, NULL, 19895, 21188, 'ADMON CUARTO UTIL', 1, '0', 0, 24, '2023-11-09 17:34:31', 24, '2023-11-29 20:38:38');

-- --------------------------------------------------------

--
-- Table structure for table `conceptos_gastos`
--

CREATE TABLE `conceptos_gastos` (
  `id` int NOT NULL,
  `id_cuenta_gasto_erp` int NOT NULL,
  `id_cuenta_iva_erp` int DEFAULT NULL,
  `porcentaje_iva` int NOT NULL DEFAULT '0',
  `id_cuenta_rete_fuente_erp` int DEFAULT NULL,
  `base_rete_fuente` int DEFAULT NULL,
  `porcentaje_rete_fuente` varchar(50) DEFAULT NULL,
  `id_cuenta_por_pagar_erp` int DEFAULT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `eliminado` tinyint NOT NULL DEFAULT '0',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `conceptos_gastos`
--

INSERT INTO `conceptos_gastos` (`id`, `id_cuenta_gasto_erp`, `id_cuenta_iva_erp`, `porcentaje_iva`, `id_cuenta_rete_fuente_erp`, `base_rete_fuente`, `porcentaje_rete_fuente`, `id_cuenta_por_pagar_erp`, `nombre`, `eliminado`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 20159, 19896, 19, 19885, 2, '2', 19866, 'ASEO Y CAFETERIA', 0, 4, '2023-04-30 15:36:53', 24, '2023-12-01 22:02:29'),
(3, 20068, NULL, 19, NULL, 1215000, '2.5', 19824, 'PAPELERIA ', 0, 4, '2023-06-10 21:52:56', 24, '2023-11-05 07:40:42'),
(5, 20228, 19896, 19, 19885, NULL, NULL, 19824, 'SERVICIOS', 0, 24, '2023-10-31 22:41:01', 4, '2023-12-02 11:50:19'),
(11, 19977, 19897, 19, 19837, NULL, NULL, NULL, 'SERVICIOS 1', 1, 4, '2023-12-02 19:15:11', NULL, '2023-12-02 19:15:17');

-- --------------------------------------------------------

--
-- Table structure for table `control_ingresos`
--

CREATE TABLE `control_ingresos` (
  `id` int NOT NULL,
  `id_persona_autoriza` int DEFAULT NULL,
  `id_inmueble` int DEFAULT NULL,
  `id_inmueble_zona` int DEFAULT NULL,
  `id_concepto_visita` int NOT NULL,
  `id_tipo_vehiculo` int DEFAULT NULL,
  `persona_visita` varchar(250) DEFAULT NULL,
  `placa` varchar(50) DEFAULT NULL,
  `fecha_ingreso` datetime DEFAULT NULL,
  `fecha_salida` datetime DEFAULT NULL,
  `observacion_visita_previa` varchar(500) DEFAULT NULL,
  `observacion` text,
  `url_foto_visitante` varchar(150) DEFAULT NULL,
  `roles_notificados` varchar(250) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `control_ingresos`
--

INSERT INTO `control_ingresos` (`id`, `id_persona_autoriza`, `id_inmueble`, `id_inmueble_zona`, `id_concepto_visita`, `id_tipo_vehiculo`, `persona_visita`, `placa`, `fecha_ingreso`, `fecha_salida`, `observacion_visita_previa`, `observacion`, `url_foto_visitante`, `roles_notificados`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(25, 144, 62, 1, 15, NULL, 'luis carlos acevedo', '', '2023-11-23 17:48:36', NULL, NULL, 'LLAME A DON FERNANDO Y AUTORIZO LA ENTRADA', NULL, NULL, 24, '2023-11-23 17:48:36', 24, '2023-11-28 15:43:48');

-- --------------------------------------------------------

--
-- Table structure for table `correos_enviados`
--

CREATE TABLE `correos_enviados` (
  `id` int NOT NULL,
  `tipo` int NOT NULL COMMENT '0 - INSTALACION, 1 - FACTURAS',
  `id_data` int NOT NULL,
  `correo_electronico` varchar(100) DEFAULT NULL,
  `mandrill_id` varchar(150) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `entorno`
--

CREATE TABLE `entorno` (
  `id` int NOT NULL,
  `campo` varchar(100) NOT NULL,
  `valor` varchar(500) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `entorno`
--

INSERT INTO `entorno` (`id`, `campo`, `valor`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 'id_comprobante_ventas_erp', '13270', NULL, '2023-05-20 17:33:23', NULL, '2023-10-16 01:50:58'),
(2, 'consecutivo_ventas', '663', NULL, '2023-05-20 17:33:23', NULL, '2023-11-22 20:15:09'),
(3, 'id_comprobante_gastos_erp', '13272', NULL, '2023-05-20 17:33:23', NULL, '2023-10-28 23:39:46'),
(4, 'consecutivo_gastos', '12', NULL, '2023-05-20 17:33:23', NULL, '2023-11-22 10:39:03'),
(5, 'id_comprobante_recibos_caja_erp', '2', NULL, '2023-05-20 17:33:23', NULL, '2023-06-19 11:42:14'),
(6, 'consecutivo_recibos_caja', '53', NULL, '2023-05-20 17:33:23', NULL, '2023-11-30 02:38:02'),
(7, 'id_cuenta_intereses_erp', '19964', NULL, '2023-05-20 17:33:23', NULL, '2023-11-02 20:17:39'),
(8, 'porcentaje_intereses_mora', '2', NULL, '2023-05-20 17:33:23', NULL, '2023-10-24 20:56:18'),
(9, 'api_key_erp', 'n0564ZUJ1czPF79uCXG7VOdEj4QGnaBO10a765bc68f39468aa48f1dbcc8c6bf6lSJOXT5bPqSLZVzoCOQChcoAIOS6G4Hb', NULL, '2023-05-20 17:33:23', NULL, '2023-10-15 17:44:03'),
(10, 'area_total_m2', '2242.01', NULL, '2023-05-20 17:33:23', NULL, '2023-10-09 15:52:41'),
(11, 'numero_total_unidades', '117', NULL, '2023-05-20 17:33:23', NULL, '2023-10-05 16:59:16'),
(12, 'valor_total_presupuesto_year_actual', '148159200', NULL, '2023-05-20 17:33:23', NULL, '2023-11-23 18:08:03'),
(13, 'id_concepto_administracion', '1', NULL, '2023-05-20 17:33:23', NULL, '2023-06-25 12:00:17'),
(14, 'razon_social', 'SANTA MARIA DEL MAR', NULL, '2023-07-03 15:13:29', NULL, '2023-09-20 21:37:24'),
(15, 'nit', '811044627-9', NULL, '2023-07-03 15:13:29', NULL, '2023-09-08 02:32:41'),
(16, 'direccion', 'CL 54 36A 54', NULL, '2023-07-03 15:13:29', NULL, '2023-09-08 02:34:21'),
(17, 'telefono', '2283247', NULL, '2023-07-03 15:13:29', NULL, '2023-09-08 02:34:21'),
(18, 'email', 'adolfomc2745@gmail.com', NULL, '2023-07-03 15:13:29', NULL, '2023-10-13 08:37:17'),
(19, 'texto_cuenta_cobro', 'POR FAVOR CONSIGNAR EN CUENTA CORRIENTE XXX-XXXXXX-XX BANCOLOMBIA', NULL, '2023-07-03 15:13:29', NULL, '2023-09-08 02:34:21'),
(20, 'validacion_estricta_area', '0', NULL, '2023-07-03 15:13:29', NULL, '2023-10-03 18:56:36'),
(21, 'id_concepto_visita', '15', NULL, '2023-07-03 15:13:29', NULL, '2023-09-20 13:32:05'),
(22, 'id_concepto_intereses', '8', NULL, '2023-07-03 15:13:29', NULL, '2023-10-20 16:48:26'),
(23, 'redondeo_conceptos', '0', NULL, '2023-07-03 15:13:29', NULL, '2023-10-24 21:09:56'),
(24, 'periodo_facturacion', '2023-12-01', NULL, '2023-07-03 15:13:29', NULL, '2023-11-22 20:15:15'),
(25, 'agrupar_cuenta_cobro', '0', NULL, '2023-07-03 15:13:29', NULL, '2023-10-19 20:54:21'),
(27, 'dia_limite_pago_sin_interes', '17', NULL, '2023-07-03 15:13:29', NULL, '2023-10-27 02:43:00'),
(28, 'dia_limite_descuento_pronto_pago', '10', NULL, '2023-07-03 15:13:29', NULL, '2023-10-27 02:43:00'),
(29, 'porcentaje_descuento_pronto_pago', '0', NULL, '2023-07-03 15:13:29', NULL, '2023-10-24 20:56:18'),
(30, 'id_cuenta_descuento_erp', '20129', NULL, '2023-10-23 11:18:48', NULL, '2023-11-27 10:36:43'),
(31, 'editar_valor_admon_inmueble', '1', NULL, '2023-10-23 11:18:48', NULL, '2023-10-24 10:35:28'),
(32, 'id_comprobante_pagos_erp', '3', NULL, '2023-05-20 17:33:23', NULL, '2023-11-02 12:51:53'),
(33, 'consecutivo_pagos', '7', NULL, '2023-05-20 17:33:23', NULL, '2023-11-23 16:36:47'),
(34, 'id_cuenta_ingreso_recibos_caja_erp', '19824', NULL, '2023-05-20 17:33:23', NULL, '2023-11-02 21:36:45'),
(35, 'id_cuenta_egreso_pagos_erp', '19824', NULL, '2023-05-20 17:33:23', NULL, '2023-11-02 21:36:45'),
(36, 'id_concepto_administracion_cuarto_util', '14', NULL, '2023-05-20 17:33:23', NULL, '2023-11-10 10:54:20'),
(37, 'id_concepto_administracion_parqueadero', '13', NULL, '2023-05-20 17:33:23', NULL, '2023-11-10 10:54:20'),
(38, 'id_cuenta_ingreso_pasarela_erp', '20094', NULL, '2023-05-20 17:33:23', NULL, '2023-11-27 10:36:43');

-- --------------------------------------------------------

--
-- Table structure for table `erp_maestras`
--

CREATE TABLE `erp_maestras` (
  `id` int NOT NULL,
  `tipo` int NOT NULL DEFAULT '0' COMMENT '0 - CENTRO DE COSTOS, 1 - COMPROBANTE, 2 - CUENTA, 3 - CIUDAD',
  `id_erp` int DEFAULT NULL,
  `codigo` varchar(25) DEFAULT NULL,
  `nombre` varchar(250) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `erp_maestras`
--

INSERT INTO `erp_maestras` (`id`, `tipo`, `id_erp`, `codigo`, `nombre`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 0, 1, '01', 'PRINCIPAL', NULL, '2023-06-10 14:47:21', NULL, '2023-12-01 22:22:43'),
(2, 1, 1, '01', 'INGRESOS', NULL, '2023-06-10 14:47:21', NULL, '2023-12-01 22:22:43'),
(3, 1, 2, '02', 'ORDENES DE PAGO', NULL, '2023-06-10 14:47:21', NULL, '2023-12-01 22:22:43'),
(4, 1, 3, '03', 'COMPRAS', NULL, '2023-06-10 14:47:21', NULL, '2023-12-01 22:22:43'),
(3520, 3, 1087, '29-263', 'Amazonas > EL ENCANTO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3521, 3, 1088, '29-405', 'Amazonas > LA CHORRERA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3522, 3, 1089, '29-407', 'Amazonas > LA PEDRERA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3523, 3, 1090, '29-430', 'Amazonas > LA VICTORIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3524, 3, 1086, '29-001', 'Amazonas > LETICIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3525, 3, 1091, '29-460', 'Amazonas > MIRITI - PARANÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3526, 3, 1092, '29-530', 'Amazonas > PUERTO ALEGRÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3527, 3, 1093, '29-536', 'Amazonas > PUERTO ARICA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3528, 3, 1094, '29-540', 'Amazonas > PUERTO NARIÑO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3529, 3, 1095, '29-669', 'Amazonas > PUERTO SANTANDER', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3530, 3, 1096, '29-798', 'Amazonas > TARAPACÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3531, 3, 2, '1-002', 'Antioquia > ABEJORRAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3532, 3, 3, '1-004', 'Antioquia > ABRIAQUÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3533, 3, 4, '1-021', 'Antioquia > ALEJANDRÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3534, 3, 5, '1-030', 'Antioquia > AMAGÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3535, 3, 6, '1-031', 'Antioquia > AMALFI', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3536, 3, 7, '1-034', 'Antioquia > ANDES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3537, 3, 8, '1-036', 'Antioquia > ANGELÓPOLIS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3538, 3, 9, '1-038', 'Antioquia > ANGOSTURA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3539, 3, 10, '1-040', 'Antioquia > ANORÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3540, 3, 12, '1-044', 'Antioquia > ANZA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3541, 3, 13, '1-045', 'Antioquia > APARTADÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3542, 3, 14, '1-051', 'Antioquia > ARBOLETES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3543, 3, 15, '1-055', 'Antioquia > ARGELIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3544, 3, 16, '1-059', 'Antioquia > ARMENIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3545, 3, 17, '1-079', 'Antioquia > BARBOSA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3546, 3, 19, '1-088', 'Antioquia > BELLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3547, 3, 18, '1-086', 'Antioquia > BELMIRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3548, 3, 20, '1-091', 'Antioquia > BETANIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3549, 3, 21, '1-093', 'Antioquia > BETULIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3550, 3, 23, '1-107', 'Antioquia > BRICEÑO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3551, 3, 24, '1-113', 'Antioquia > BURITICÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3552, 3, 25, '1-120', 'Antioquia > CÁCERES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3553, 3, 26, '1-125', 'Antioquia > CAICEDO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3554, 3, 27, '1-129', 'Antioquia > CALDAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3555, 3, 28, '1-134', 'Antioquia > CAMPAMENTO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3556, 3, 29, '1-138', 'Antioquia > CAÑASGORDAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3557, 3, 30, '1-142', 'Antioquia > CARACOLÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3558, 3, 31, '1-145', 'Antioquia > CARAMANTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3559, 3, 32, '1-147', 'Antioquia > CAREPA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3560, 3, 34, '1-150', 'Antioquia > CAROLINA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3561, 3, 35, '1-154', 'Antioquia > CAUCASIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3562, 3, 36, '1-172', 'Antioquia > CHIGORODÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3563, 3, 37, '1-190', 'Antioquia > CISNEROS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3564, 3, 22, '1-101', 'Antioquia > CIUDAD BOLÍVAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3565, 3, 38, '1-197', 'Antioquia > COCORNÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3566, 3, 39, '1-206', 'Antioquia > CONCEPCIÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3567, 3, 40, '1-209', 'Antioquia > CONCORDIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3568, 3, 41, '1-212', 'Antioquia > COPACABANA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3569, 3, 42, '1-234', 'Antioquia > DABEIBA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3570, 3, 43, '1-237', 'Antioquia > DON MATÍAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3571, 3, 44, '1-240', 'Antioquia > EBÉJICO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3572, 3, 45, '1-250', 'Antioquia > EL BAGRE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3573, 3, 33, '1-148', 'Antioquia > EL CARMEN DE VIBORAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3574, 3, 104, '1-697', 'Antioquia > EL SANTUARIO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3575, 3, 46, '1-264', 'Antioquia > ENTRERRIOS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3576, 3, 47, '1-266', 'Antioquia > ENVIGADO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3577, 3, 48, '1-282', 'Antioquia > FREDONIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3578, 3, 49, '1-284', 'Antioquia > FRONTINO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3579, 3, 50, '1-306', 'Antioquia > GIRALDO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3580, 3, 51, '1-308', 'Antioquia > GIRARDOTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3581, 3, 52, '1-310', 'Antioquia > GÓMEZ PLATA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3582, 3, 53, '1-313', 'Antioquia > GRANADA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3583, 3, 54, '1-315', 'Antioquia > GUADALUPE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3584, 3, 55, '1-318', 'Antioquia > GUARNE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3585, 3, 56, '1-321', 'Antioquia > GUATAPE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3586, 3, 57, '1-347', 'Antioquia > HELICONIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3587, 3, 58, '1-353', 'Antioquia > HISPANIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3588, 3, 59, '1-360', 'Antioquia > ITAGUI', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3589, 3, 60, '1-361', 'Antioquia > ITUANGO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3590, 3, 61, '1-364', 'Antioquia > JARDÍN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3591, 3, 62, '1-368', 'Antioquia > JERICÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3592, 3, 63, '1-376', 'Antioquia > LA CEJA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3593, 3, 64, '1-380', 'Antioquia > LA ESTRELLA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3594, 3, 65, '1-390', 'Antioquia > LA PINTADA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3595, 3, 66, '1-400', 'Antioquia > LA UNIÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3596, 3, 67, '1-411', 'Antioquia > LIBORINA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3597, 3, 68, '1-425', 'Antioquia > MACEO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3598, 3, 69, '1-440', 'Antioquia > MARINILLA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3599, 3, 1, '1-001', 'Antioquia > MEDELLIN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3600, 3, 70, '1-467', 'Antioquia > MONTEBELLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3601, 3, 71, '1-475', 'Antioquia > MURINDÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3602, 3, 72, '1-480', 'Antioquia > MUTATÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3603, 3, 73, '1-483', 'Antioquia > NARIÑO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3604, 3, 75, '1-495', 'Antioquia > NECHÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3605, 3, 74, '1-490', 'Antioquia > NECOCLÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3606, 3, 76, '1-501', 'Antioquia > OLAYA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3607, 3, 77, '1-541', 'Antioquia > PEÑOL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3608, 3, 78, '1-543', 'Antioquia > PEQUE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3609, 3, 79, '1-576', 'Antioquia > PUEBLORRICO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3610, 3, 80, '1-579', 'Antioquia > PUERTO BERRÍO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3611, 3, 81, '1-585', 'Antioquia > PUERTO NARE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3612, 3, 82, '1-591', 'Antioquia > PUERTO TRIUNFO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3613, 3, 83, '1-604', 'Antioquia > REMEDIOS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3614, 3, 84, '1-607', 'Antioquia > RETIRO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3615, 3, 85, '1-615', 'Antioquia > RIONEGRO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3616, 3, 86, '1-628', 'Antioquia > SABANALARGA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3617, 3, 87, '1-631', 'Antioquia > SABANETA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3618, 3, 88, '1-642', 'Antioquia > SALGAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3619, 3, 89, '1-647', 'Antioquia > SAN ANDRÉS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3620, 3, 90, '1-649', 'Antioquia > SAN CARLOS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3621, 3, 91, '1-652', 'Antioquia > SAN FRANCISCO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3622, 3, 92, '1-656', 'Antioquia > SAN JERÓNIMO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3623, 3, 93, '1-658', 'Antioquia > SAN JOSÉ DE LA MONTAÑA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3624, 3, 94, '1-659', 'Antioquia > SAN JUAN DE URABÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3625, 3, 95, '1-660', 'Antioquia > SAN LUIS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3626, 3, 96, '1-664', 'Antioquia > SAN PEDRO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3627, 3, 97, '1-665', 'Antioquia > SAN PEDRO DE URABA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3628, 3, 98, '1-667', 'Antioquia > SAN RAFAEL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3629, 3, 99, '1-670', 'Antioquia > SAN ROQUE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3630, 3, 100, '1-674', 'Antioquia > SAN VICENTE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3631, 3, 101, '1-679', 'Antioquia > SANTA BÁRBARA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3632, 3, 102, '1-686', 'Antioquia > SANTA ROSA DE OSOS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3633, 3, 11, '1-042', 'Antioquia > SANTAFÉ DE ANTIOQUIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3634, 3, 103, '1-690', 'Antioquia > SANTO DOMINGO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3635, 3, 105, '1-736', 'Antioquia > SEGOVIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3636, 3, 106, '1-756', 'Antioquia > SONSON', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3637, 3, 107, '1-761', 'Antioquia > SOPETRÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3638, 3, 108, '1-789', 'Antioquia > TÁMESIS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3639, 3, 109, '1-790', 'Antioquia > TARAZÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3640, 3, 110, '1-792', 'Antioquia > TARSO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3641, 3, 111, '1-809', 'Antioquia > TITIRIBÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3642, 3, 112, '1-819', 'Antioquia > TOLEDO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3643, 3, 113, '1-837', 'Antioquia > TURBO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3644, 3, 114, '1-842', 'Antioquia > URAMITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3645, 3, 115, '1-847', 'Antioquia > URRAO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3646, 3, 116, '1-854', 'Antioquia > VALDIVIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3647, 3, 117, '1-856', 'Antioquia > VALPARAÍSO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3648, 3, 118, '1-858', 'Antioquia > VEGACHÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3649, 3, 119, '1-861', 'Antioquia > VENECIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3650, 3, 120, '1-873', 'Antioquia > VIGÍA DEL FUERTE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3651, 3, 121, '1-885', 'Antioquia > YALÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3652, 3, 122, '1-887', 'Antioquia > YARUMAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3653, 3, 123, '1-890', 'Antioquia > YOLOMBÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3654, 3, 124, '1-893', 'Antioquia > YONDÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3655, 3, 125, '1-895', 'Antioquia > ZARAGOZA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3656, 3, 1045, '25-001', 'Arauca > ARAUCA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3657, 3, 1046, '25-065', 'Arauca > ARAUQUITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3658, 3, 1047, '25-220', 'Arauca > CRAVO NORTE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3659, 3, 1048, '25-300', 'Arauca > FORTUL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3660, 3, 1049, '25-591', 'Arauca > PUERTO RONDÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3661, 3, 1050, '25-736', 'Arauca > SARAVENA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3662, 3, 1051, '25-794', 'Arauca > TAME', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3663, 3, 1085, '28-564', 'Archipiélago de San Andrés - Providencia y Santa Catalina > PROVIDENCIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3664, 3, 1084, '28-001', 'Archipiélago de San Andrés - Providencia y Santa Catalina > SAN ANDRÉS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3665, 3, 127, '2-078', 'Atlántico > BARANOA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3666, 3, 126, '2-001', 'Atlántico > BARRANQUILLA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3667, 3, 128, '2-137', 'Atlántico > CAMPO DE LA CRUZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3668, 3, 129, '2-141', 'Atlántico > CANDELARIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3669, 3, 130, '2-296', 'Atlántico > GALAPA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3670, 3, 131, '2-372', 'Atlántico > JUAN DE ACOSTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3671, 3, 132, '2-421', 'Atlántico > LURUACO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3672, 3, 133, '2-433', 'Atlántico > MALAMBO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3673, 3, 134, '2-436', 'Atlántico > MANATÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3674, 3, 135, '2-520', 'Atlántico > PALMAR DE VARELA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3675, 3, 136, '2-549', 'Atlántico > PIOJÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3676, 3, 137, '2-558', 'Atlántico > POLONUEVO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3677, 3, 138, '2-560', 'Atlántico > PONEDERA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3678, 3, 139, '2-573', 'Atlántico > PUERTO COLOMBIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3679, 3, 140, '2-606', 'Atlántico > REPELÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3680, 3, 141, '2-634', 'Atlántico > SABANAGRANDE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3681, 3, 142, '2-638', 'Atlántico > SABANALARGA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3682, 3, 143, '2-675', 'Atlántico > SANTA LUCÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3683, 3, 144, '2-685', 'Atlántico > SANTO TOMÁS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3684, 3, 145, '2-758', 'Atlántico > SOLEDAD', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3685, 3, 146, '2-770', 'Atlántico > SUAN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3686, 3, 147, '2-832', 'Atlántico > TUBARÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3687, 3, 148, '2-849', 'Atlántico > USIACURÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3688, 3, 149, '3-001', 'Bogotá D.C > BOGOTÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3689, 3, 151, '4-006', 'Bolívar > ACHÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3690, 3, 152, '4-030', 'Bolívar > ALTOS DEL ROSARIO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3691, 3, 153, '4-042', 'Bolívar > ARENAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3692, 3, 154, '4-052', 'Bolívar > ARJONA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3693, 3, 155, '4-062', 'Bolívar > ARROYOHONDO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3694, 3, 156, '4-074', 'Bolívar > BARRANCO DE LOBA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3695, 3, 157, '4-140', 'Bolívar > CALAMAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3696, 3, 158, '4-160', 'Bolívar > CANTAGALLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3697, 3, 150, '4-001', 'Bolívar > CARTAGENA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3698, 3, 159, '4-188', 'Bolívar > CICUCO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3699, 3, 161, '4-222', 'Bolívar > CLEMENCIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3700, 3, 160, '4-212', 'Bolívar > CÓRDOBA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3701, 3, 162, '4-244', 'Bolívar > EL CARMEN DE BOLÍVAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3702, 3, 163, '4-248', 'Bolívar > EL GUAMO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3703, 3, 164, '4-268', 'Bolívar > EL PEÑÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3704, 3, 165, '4-300', 'Bolívar > HATILLO DE LOBA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3705, 3, 166, '4-430', 'Bolívar > MAGANGUÉ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3706, 3, 167, '4-433', 'Bolívar > MAHATES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3707, 3, 168, '4-440', 'Bolívar > MARGARITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3708, 3, 169, '4-442', 'Bolívar > MARÍA LA BAJA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3709, 3, 171, '4-468', 'Bolívar > MOMPÓS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3710, 3, 170, '4-458', 'Bolívar > MONTECRISTO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3711, 3, 172, '4-473', 'Bolívar > MORALES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3712, 3, 173, '4-549', 'Bolívar > PINILLOS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3713, 3, 174, '4-580', 'Bolívar > REGIDOR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3714, 3, 175, '4-600', 'Bolívar > RÍO VIEJO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3715, 3, 176, '4-620', 'Bolívar > SAN CRISTÓBAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3716, 3, 177, '4-647', 'Bolívar > SAN ESTANISLAO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3717, 3, 178, '4-650', 'Bolívar > SAN FERNANDO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3718, 3, 179, '4-654', 'Bolívar > SAN JACINTO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3719, 3, 180, '4-655', 'Bolívar > SAN JACINTO DEL CAUCA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3720, 3, 181, '4-657', 'Bolívar > SAN JUAN NEPOMUCENO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3721, 3, 182, '4-667', 'Bolívar > SAN MARTÍN DE LOBA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3722, 3, 183, '4-670', 'Bolívar > SAN PABLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3723, 3, 184, '4-673', 'Bolívar > SANTA CATALINA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3724, 3, 185, '4-683', 'Bolívar > SANTA ROSA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3725, 3, 186, '4-688', 'Bolívar > SANTA ROSA DEL SUR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3726, 3, 187, '4-744', 'Bolívar > SIMITÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3727, 3, 188, '4-760', 'Bolívar > SOPLAVIENTO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3728, 3, 189, '4-780', 'Bolívar > TALAIGUA NUEVO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3729, 3, 190, '4-810', 'Bolívar > TIQUISIO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3730, 3, 191, '4-836', 'Bolívar > TURBACO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3731, 3, 192, '4-838', 'Bolívar > TURBANÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3732, 3, 193, '4-873', 'Bolívar > VILLANUEVA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3733, 3, 194, '4-894', 'Bolívar > ZAMBRANO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3734, 3, 196, '5-022', 'Boyacá > ALMEIDA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3735, 3, 197, '5-047', 'Boyacá > AQUITANIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3736, 3, 198, '5-051', 'Boyacá > ARCABUCO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3737, 3, 199, '5-087', 'Boyacá > BELÉN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3738, 3, 200, '5-090', 'Boyacá > BERBEO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3739, 3, 201, '5-092', 'Boyacá > BETÉITIVA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3740, 3, 202, '5-097', 'Boyacá > BOAVITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3741, 3, 203, '5-104', 'Boyacá > BOYACÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3742, 3, 204, '5-106', 'Boyacá > BRICEÑO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3743, 3, 205, '5-109', 'Boyacá > BUENAVISTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3744, 3, 206, '5-114', 'Boyacá > BUSBANZÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3745, 3, 207, '5-131', 'Boyacá > CALDAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3746, 3, 208, '5-135', 'Boyacá > CAMPOHERMOSO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3747, 3, 209, '5-162', 'Boyacá > CERINZA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3748, 3, 210, '5-172', 'Boyacá > CHINAVITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3749, 3, 211, '5-176', 'Boyacá > CHIQUINQUIRÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3750, 3, 224, '5-232', 'Boyacá > CHÍQUIZA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3751, 3, 212, '5-180', 'Boyacá > CHISCAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3752, 3, 213, '5-183', 'Boyacá > CHITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3753, 3, 214, '5-185', 'Boyacá > CHITARAQUE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3754, 3, 215, '5-187', 'Boyacá > CHIVATÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3755, 3, 225, '5-236', 'Boyacá > CHIVOR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3756, 3, 216, '5-189', 'Boyacá > CIÉNEGA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3757, 3, 217, '5-204', 'Boyacá > CÓMBITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3758, 3, 218, '5-212', 'Boyacá > COPER', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3759, 3, 219, '5-215', 'Boyacá > CORRALES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3760, 3, 220, '5-218', 'Boyacá > COVARACHÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3761, 3, 221, '5-223', 'Boyacá > CUBARÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3762, 3, 222, '5-224', 'Boyacá > CUCAITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3763, 3, 223, '5-226', 'Boyacá > CUÍTIVA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3764, 3, 226, '5-238', 'Boyacá > DUITAMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3765, 3, 227, '5-244', 'Boyacá > EL COCUY', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3766, 3, 228, '5-248', 'Boyacá > EL ESPINO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3767, 3, 229, '5-272', 'Boyacá > FIRAVITOBA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3768, 3, 230, '5-276', 'Boyacá > FLORESTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3769, 3, 231, '5-293', 'Boyacá > GACHANTIVÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3770, 3, 232, '5-296', 'Boyacá > GAMEZA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3771, 3, 233, '5-299', 'Boyacá > GARAGOA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3772, 3, 234, '5-317', 'Boyacá > GUACAMAYAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3773, 3, 235, '5-322', 'Boyacá > GUATEQUE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3774, 3, 236, '5-325', 'Boyacá > GUAYATÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3775, 3, 237, '5-332', 'Boyacá > GÜICÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3776, 3, 238, '5-362', 'Boyacá > IZA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3777, 3, 239, '5-367', 'Boyacá > JENESANO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3778, 3, 240, '5-368', 'Boyacá > JERICÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3779, 3, 242, '5-380', 'Boyacá > LA CAPILLA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3780, 3, 244, '5-403', 'Boyacá > LA UVITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3781, 3, 243, '5-401', 'Boyacá > LA VICTORIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3782, 3, 241, '5-377', 'Boyacá > LABRANZAGRANDE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3783, 3, 246, '5-425', 'Boyacá > MACANAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3784, 3, 247, '5-442', 'Boyacá > MARIPÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3785, 3, 248, '5-455', 'Boyacá > MIRAFLORES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3786, 3, 249, '5-464', 'Boyacá > MONGUA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3787, 3, 250, '5-466', 'Boyacá > MONGUÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3788, 3, 251, '5-469', 'Boyacá > MONIQUIRÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3789, 3, 252, '5-476', 'Boyacá > MOTAVITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3790, 3, 253, '5-480', 'Boyacá > MUZO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3791, 3, 254, '5-491', 'Boyacá > NOBSA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3792, 3, 255, '5-494', 'Boyacá > NUEVO COLÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3793, 3, 256, '5-500', 'Boyacá > OICATÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3794, 3, 257, '5-507', 'Boyacá > OTANCHE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3795, 3, 258, '5-511', 'Boyacá > PACHAVITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3796, 3, 259, '5-514', 'Boyacá > PÁEZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3797, 3, 260, '5-516', 'Boyacá > PAIPA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3798, 3, 261, '5-518', 'Boyacá > PAJARITO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3799, 3, 262, '5-522', 'Boyacá > PANQUEBA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3800, 3, 263, '5-531', 'Boyacá > PAUNA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3801, 3, 264, '5-533', 'Boyacá > PAYA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3802, 3, 265, '5-537', 'Boyacá > PAZ DE RÍO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3803, 3, 266, '5-542', 'Boyacá > PESCA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3804, 3, 267, '5-550', 'Boyacá > PISBA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3805, 3, 268, '5-572', 'Boyacá > PUERTO BOYACÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3806, 3, 269, '5-580', 'Boyacá > QUÍPAMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3807, 3, 270, '5-599', 'Boyacá > RAMIRIQUÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3808, 3, 271, '5-600', 'Boyacá > RÁQUIRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3809, 3, 272, '5-621', 'Boyacá > RONDÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3810, 3, 273, '5-632', 'Boyacá > SABOYÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3811, 3, 274, '5-638', 'Boyacá > SÁCHICA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3812, 3, 275, '5-646', 'Boyacá > SAMACÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3813, 3, 276, '5-660', 'Boyacá > SAN EDUARDO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3814, 3, 277, '5-664', 'Boyacá > SAN JOSÉ DE PARE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3815, 3, 278, '5-667', 'Boyacá > SAN LUIS DE GACENO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3816, 3, 279, '5-673', 'Boyacá > SAN MATEO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3817, 3, 280, '5-676', 'Boyacá > SAN MIGUEL DE SEMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3818, 3, 281, '5-681', 'Boyacá > SAN PABLO DE BORBUR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3819, 3, 283, '5-690', 'Boyacá > SANTA MARÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3820, 3, 284, '5-693', 'Boyacá > SANTA ROSA DE VITERBO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3821, 3, 285, '5-696', 'Boyacá > SANTA SOFÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3822, 3, 282, '5-686', 'Boyacá > SANTANA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3823, 3, 286, '5-720', 'Boyacá > SATIVANORTE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3824, 3, 287, '5-723', 'Boyacá > SATIVASUR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3825, 3, 288, '5-740', 'Boyacá > SIACHOQUE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3826, 3, 289, '5-753', 'Boyacá > SOATÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3827, 3, 291, '5-757', 'Boyacá > SOCHA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3828, 3, 290, '5-755', 'Boyacá > SOCOTÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3829, 3, 292, '5-759', 'Boyacá > SOGAMOSO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3830, 3, 293, '5-761', 'Boyacá > SOMONDOCO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3831, 3, 294, '5-762', 'Boyacá > SORA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3832, 3, 296, '5-764', 'Boyacá > SORACÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3833, 3, 295, '5-763', 'Boyacá > SOTAQUIRÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3834, 3, 297, '5-774', 'Boyacá > SUSACÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3835, 3, 298, '5-776', 'Boyacá > SUTAMARCHÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3836, 3, 299, '5-778', 'Boyacá > SUTATENZA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3837, 3, 300, '5-790', 'Boyacá > TASCO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3838, 3, 301, '5-798', 'Boyacá > TENZA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3839, 3, 302, '5-804', 'Boyacá > TIBANÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3840, 3, 303, '5-806', 'Boyacá > TIBASOSA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3841, 3, 304, '5-808', 'Boyacá > TINJACÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3842, 3, 305, '5-810', 'Boyacá > TIPACOQUE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3843, 3, 306, '5-814', 'Boyacá > TOCA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3844, 3, 307, '5-816', 'Boyacá > TOGÜÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3845, 3, 308, '5-820', 'Boyacá > TÓPAGA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3846, 3, 309, '5-822', 'Boyacá > TOTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3847, 3, 195, '5-001', 'Boyacá > TUNJA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3848, 3, 310, '5-832', 'Boyacá > TUNUNGUÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3849, 3, 311, '5-835', 'Boyacá > TURMEQUÉ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3850, 3, 312, '5-837', 'Boyacá > TUTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3851, 3, 313, '5-839', 'Boyacá > TUTAZÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3852, 3, 314, '5-842', 'Boyacá > UMBITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3853, 3, 315, '5-861', 'Boyacá > VENTAQUEMADA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3854, 3, 245, '5-407', 'Boyacá > VILLA DE LEYVA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3855, 3, 316, '5-879', 'Boyacá > VIRACACHÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3856, 3, 317, '5-897', 'Boyacá > ZETAQUIRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3857, 3, 319, '6-013', 'Caldas > AGUADAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3858, 3, 320, '6-042', 'Caldas > ANSERMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3859, 3, 321, '6-050', 'Caldas > ARANZAZU', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3860, 3, 322, '6-088', 'Caldas > BELALCÁZAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3861, 3, 323, '6-174', 'Caldas > CHINCHINÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3862, 3, 324, '6-272', 'Caldas > FILADELFIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3863, 3, 325, '6-380', 'Caldas > LA DORADA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3864, 3, 326, '6-388', 'Caldas > LA MERCED', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3865, 3, 318, '6-001', 'Caldas > MANIZALES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3866, 3, 327, '6-433', 'Caldas > MANZANARES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3867, 3, 328, '6-442', 'Caldas > MARMATO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3868, 3, 329, '6-444', 'Caldas > MARQUETALIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3869, 3, 330, '6-446', 'Caldas > MARULANDA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3870, 3, 331, '6-486', 'Caldas > NEIRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3871, 3, 332, '6-495', 'Caldas > NORCASIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3872, 3, 333, '6-513', 'Caldas > PÁCORA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3873, 3, 334, '6-524', 'Caldas > PALESTINA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3874, 3, 335, '6-541', 'Caldas > PENSILVANIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3875, 3, 336, '6-614', 'Caldas > RIOSUCIO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3876, 3, 337, '6-616', 'Caldas > RISARALDA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3877, 3, 338, '6-653', 'Caldas > SALAMINA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3878, 3, 339, '6-662', 'Caldas > SAMANÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3879, 3, 340, '6-665', 'Caldas > SAN JOSÉ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3880, 3, 341, '6-777', 'Caldas > SUPÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3881, 3, 342, '6-867', 'Caldas > VICTORIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3882, 3, 343, '6-873', 'Caldas > VILLAMARÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3883, 3, 344, '6-877', 'Caldas > VITERBO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3884, 3, 346, '7-029', 'Caquetá > ALBANIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3885, 3, 347, '7-094', 'Caquetá > BELÉN DE LOS ANDAQUIES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3886, 3, 348, '7-150', 'Caquetá > CARTAGENA DEL CHAIRÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3887, 3, 349, '7-205', 'Caquetá > CURILLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3888, 3, 350, '7-247', 'Caquetá > EL DONCELLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3889, 3, 351, '7-256', 'Caquetá > EL PAUJIL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3890, 3, 345, '7-001', 'Caquetá > FLORENCIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3891, 3, 352, '7-410', 'Caquetá > LA MONTAÑITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3892, 3, 353, '7-460', 'Caquetá > MILÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3893, 3, 354, '7-479', 'Caquetá > MORELIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3894, 3, 355, '7-592', 'Caquetá > PUERTO RICO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3895, 3, 356, '7-610', 'Caquetá > SAN JOSÉ DEL FRAGUA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3896, 3, 357, '7-753', 'Caquetá > SAN VICENTE DEL CAGUÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3897, 3, 358, '7-756', 'Caquetá > SOLANO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3898, 3, 359, '7-785', 'Caquetá > SOLITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3899, 3, 360, '7-860', 'Caquetá > VALPARAÍSO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3900, 3, 1053, '26-010', 'Casanare > AGUAZUL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3901, 3, 1054, '26-015', 'Casanare > CHAMEZA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3902, 3, 1055, '26-125', 'Casanare > HATO COROZAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3903, 3, 1056, '26-136', 'Casanare > LA SALINA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3904, 3, 1057, '26-139', 'Casanare > MANÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3905, 3, 1058, '26-162', 'Casanare > MONTERREY', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3906, 3, 1059, '26-225', 'Casanare > NUNCHÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3907, 3, 1060, '26-230', 'Casanare > OROCUÉ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3908, 3, 1061, '26-250', 'Casanare > PAZ DE ARIPORO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3909, 3, 1062, '26-263', 'Casanare > PORE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3910, 3, 1063, '26-279', 'Casanare > RECETOR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3911, 3, 1064, '26-300', 'Casanare > SABANALARGA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3912, 3, 1065, '26-315', 'Casanare > SÁCAMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3913, 3, 1066, '26-325', 'Casanare > SAN LUIS DE PALENQUE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3914, 3, 1067, '26-400', 'Casanare > TÁMARA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3915, 3, 1068, '26-410', 'Casanare > TAURAMENA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3916, 3, 1069, '26-430', 'Casanare > TRINIDAD', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3917, 3, 1070, '26-440', 'Casanare > VILLANUEVA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3918, 3, 1052, '26-001', 'Casanare > YOPAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3919, 3, 362, '8-022', 'Cauca > ALMAGUER', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3920, 3, 363, '8-050', 'Cauca > ARGELIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3921, 3, 364, '8-075', 'Cauca > BALBOA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3922, 3, 365, '8-100', 'Cauca > BOLÍVAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3923, 3, 366, '8-110', 'Cauca > BUENOS AIRES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3924, 3, 367, '8-130', 'Cauca > CAJIBÍO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3925, 3, 368, '8-137', 'Cauca > CALDONO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3926, 3, 369, '8-142', 'Cauca > CALOTO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3927, 3, 370, '8-212', 'Cauca > CORINTO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3928, 3, 371, '8-256', 'Cauca > EL TAMBO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3929, 3, 372, '8-290', 'Cauca > FLORENCIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3930, 3, 373, '8-318', 'Cauca > GUAPI', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3931, 3, 374, '8-355', 'Cauca > INZÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3932, 3, 375, '8-364', 'Cauca > JAMBALÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3933, 3, 376, '8-392', 'Cauca > LA SIERRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3934, 3, 377, '8-397', 'Cauca > LA VEGA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3935, 3, 378, '8-418', 'Cauca > LÓPEZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3936, 3, 379, '8-450', 'Cauca > MERCADERES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3937, 3, 380, '8-455', 'Cauca > MIRANDA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3938, 3, 381, '8-473', 'Cauca > MORALES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3939, 3, 382, '8-513', 'Cauca > PADILLA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3940, 3, 383, '8-517', 'Cauca > PAEZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3941, 3, 384, '8-532', 'Cauca > PATÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3942, 3, 385, '8-533', 'Cauca > PIAMONTE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3943, 3, 386, '8-548', 'Cauca > PIENDAMÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3944, 3, 361, '8-001', 'Cauca > POPAYÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3945, 3, 387, '8-573', 'Cauca > PUERTO TEJADA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3946, 3, 388, '8-585', 'Cauca > PURACÉ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3947, 3, 389, '8-622', 'Cauca > ROSAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3948, 3, 390, '8-693', 'Cauca > SAN SEBASTIÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3949, 3, 392, '8-701', 'Cauca > SANTA ROSA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3950, 3, 391, '8-698', 'Cauca > SANTANDER DE QUILICHAO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3951, 3, 393, '8-743', 'Cauca > SILVIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3952, 3, 394, '8-760', 'Cauca > SOTARA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3953, 3, 395, '8-780', 'Cauca > SUÁREZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3954, 3, 396, '8-785', 'Cauca > SUCRE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3955, 3, 397, '8-807', 'Cauca > TIMBÍO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3956, 3, 398, '8-809', 'Cauca > TIMBIQUÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3957, 3, 399, '8-821', 'Cauca > TORIBIO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3958, 3, 400, '8-824', 'Cauca > TOTORÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3959, 3, 401, '8-845', 'Cauca > VILLA RICA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3960, 3, 403, '9-011', 'Cesar > AGUACHICA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3961, 3, 404, '9-013', 'Cesar > AGUSTÍN CODAZZI', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3962, 3, 405, '9-032', 'Cesar > ASTREA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3963, 3, 406, '9-045', 'Cesar > BECERRIL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3964, 3, 407, '9-060', 'Cesar > BOSCONIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3965, 3, 408, '9-175', 'Cesar > CHIMICHAGUA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3966, 3, 409, '9-178', 'Cesar > CHIRIGUANÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3967, 3, 410, '9-228', 'Cesar > CURUMANÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3968, 3, 411, '9-238', 'Cesar > EL COPEY', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3969, 3, 412, '9-250', 'Cesar > EL PASO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3970, 3, 413, '9-295', 'Cesar > GAMARRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3971, 3, 414, '9-310', 'Cesar > GONZÁLEZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3972, 3, 415, '9-383', 'Cesar > LA GLORIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3973, 3, 416, '9-400', 'Cesar > LA JAGUA DE IBIRICO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3974, 3, 422, '9-621', 'Cesar > LA PAZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3975, 3, 417, '9-443', 'Cesar > MANAURE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3976, 3, 418, '9-517', 'Cesar > PAILITAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3977, 3, 419, '9-550', 'Cesar > PELAYA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3978, 3, 420, '9-570', 'Cesar > PUEBLO BELLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3979, 3, 421, '9-614', 'Cesar > RÍO DE ORO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3980, 3, 423, '9-710', 'Cesar > SAN ALBERTO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3981, 3, 424, '9-750', 'Cesar > SAN DIEGO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3982, 3, 425, '9-770', 'Cesar > SAN MARTÍN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3983, 3, 426, '9-787', 'Cesar > TAMALAMEQUE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3984, 3, 402, '9-001', 'Cesar > VALLEDUPAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3985, 3, 572, '12-006', 'Chocó > ACANDÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3986, 3, 573, '12-025', 'Chocó > ALTO BAUDO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3987, 3, 574, '12-050', 'Chocó > ATRATO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3988, 3, 575, '12-073', 'Chocó > BAGADÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3989, 3, 576, '12-075', 'Chocó > BAHÍA SOLANO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3990, 3, 577, '12-077', 'Chocó > BAJO BAUDÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3991, 3, 578, '12-086', 'Chocó > BELÉN DE BAJIRÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3992, 3, 579, '12-099', 'Chocó > BOJAYA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3993, 3, 581, '12-150', 'Chocó > CARMEN DEL DARIEN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3994, 3, 582, '12-160', 'Chocó > CÉRTEGUI', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3995, 3, 583, '12-205', 'Chocó > CONDOTO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3996, 3, 580, '12-135', 'Chocó > EL CANTÓN DEL SAN PABLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3997, 3, 584, '12-245', 'Chocó > EL CARMEN DE ATRATO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3998, 3, 585, '12-250', 'Chocó > EL LITORAL DEL SAN JUAN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(3999, 3, 586, '12-361', 'Chocó > ISTMINA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4000, 3, 587, '12-372', 'Chocó > JURADÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4001, 3, 588, '12-413', 'Chocó > LLORÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4002, 3, 589, '12-425', 'Chocó > MEDIO ATRATO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4003, 3, 590, '12-430', 'Chocó > MEDIO BAUDÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4004, 3, 591, '12-450', 'Chocó > MEDIO SAN JUAN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4005, 3, 592, '12-491', 'Chocó > NÓVITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4006, 3, 593, '12-495', 'Chocó > NUQUÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4007, 3, 571, '12-001', 'Chocó > QUIBDÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4008, 3, 594, '12-580', 'Chocó > RÍO IRO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4009, 3, 595, '12-600', 'Chocó > RÍO QUITO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4010, 3, 596, '12-615', 'Chocó > RIOSUCIO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4011, 3, 597, '12-660', 'Chocó > SAN JOSÉ DEL PALMAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4012, 3, 598, '12-745', 'Chocó > SIPÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4013, 3, 599, '12-787', 'Chocó > TADÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4014, 3, 600, '12-800', 'Chocó > UNGUÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4015, 3, 601, '12-810', 'Chocó > UNIÓN PANAMERICANA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4016, 3, 428, '10-068', 'Córdoba > AYAPEL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4017, 3, 429, '10-079', 'Córdoba > BUENAVISTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4018, 3, 430, '10-090', 'Córdoba > CANALETE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4019, 3, 431, '10-162', 'Córdoba > CERETÉ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4020, 3, 432, '10-168', 'Córdoba > CHIMÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4021, 3, 433, '10-182', 'Córdoba > CHINÚ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4022, 3, 434, '10-189', 'Córdoba > CIÉNAGA DE ORO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4023, 3, 435, '10-300', 'Córdoba > COTORRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4024, 3, 436, '10-350', 'Córdoba > LA APARTADA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4025, 3, 437, '10-417', 'Córdoba > LORICA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4026, 3, 438, '10-419', 'Córdoba > LOS CÓRDOBAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4027, 3, 439, '10-464', 'Córdoba > MOMIL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4028, 3, 441, '10-500', 'Córdoba > MOÑITOS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4029, 3, 440, '10-466', 'Córdoba > MONTELÍBANO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4030, 3, 427, '10-001', 'Córdoba > MONTERÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4031, 3, 442, '10-555', 'Córdoba > PLANETA RICA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4032, 3, 443, '10-570', 'Córdoba > PUEBLO NUEVO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4033, 3, 444, '10-574', 'Córdoba > PUERTO ESCONDIDO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4034, 3, 445, '10-580', 'Córdoba > PUERTO LIBERTADOR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4035, 3, 446, '10-586', 'Córdoba > PURÍSIMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4036, 3, 447, '10-660', 'Córdoba > SAHAGÚN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4037, 3, 448, '10-670', 'Córdoba > SAN ANDRÉS SOTAVENTO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4038, 3, 449, '10-672', 'Córdoba > SAN ANTERO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4039, 3, 450, '10-675', 'Córdoba > SAN BERNARDO DEL VIENTO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4040, 3, 451, '10-678', 'Córdoba > SAN CARLOS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4041, 3, 452, '10-686', 'Córdoba > SAN PELAYO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4042, 3, 453, '10-807', 'Córdoba > TIERRALTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4043, 3, 454, '10-855', 'Córdoba > VALENCIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4044, 3, 455, '11-001', 'Cundinamarca > AGUA DE DIOS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4045, 3, 456, '11-019', 'Cundinamarca > ALBÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4046, 3, 457, '11-035', 'Cundinamarca > ANAPOIMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4047, 3, 458, '11-040', 'Cundinamarca > ANOLAIMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4048, 3, 529, '11-599', 'Cundinamarca > APULO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4049, 3, 459, '11-053', 'Cundinamarca > ARBELÁEZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4050, 3, 460, '11-086', 'Cundinamarca > BELTRÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4051, 3, 461, '11-095', 'Cundinamarca > BITUIMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4052, 3, 462, '11-099', 'Cundinamarca > BOJACÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4053, 3, 463, '11-120', 'Cundinamarca > CABRERA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4054, 3, 464, '11-123', 'Cundinamarca > CACHIPAY', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4055, 3, 465, '11-126', 'Cundinamarca > CAJICÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4056, 3, 466, '11-148', 'Cundinamarca > CAPARRAPÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4057, 3, 467, '11-151', 'Cundinamarca > CAQUEZA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4058, 3, 468, '11-154', 'Cundinamarca > CARMEN DE CARUPA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4059, 3, 469, '11-168', 'Cundinamarca > CHAGUANÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4060, 3, 470, '11-175', 'Cundinamarca > CHÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4061, 3, 471, '11-178', 'Cundinamarca > CHIPAQUE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4062, 3, 472, '11-181', 'Cundinamarca > CHOACHÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4063, 3, 473, '11-183', 'Cundinamarca > CHOCONTÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4064, 3, 474, '11-200', 'Cundinamarca > COGUA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4065, 3, 475, '11-214', 'Cundinamarca > COTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4066, 3, 476, '11-224', 'Cundinamarca > CUCUNUBÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4067, 3, 477, '11-245', 'Cundinamarca > EL COLEGIO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4068, 3, 478, '11-258', 'Cundinamarca > EL PEÑÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4069, 3, 479, '11-260', 'Cundinamarca > EL ROSAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4070, 3, 480, '11-269', 'Cundinamarca > FACATATIVÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4071, 3, 481, '11-279', 'Cundinamarca > FOMEQUE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4072, 3, 482, '11-281', 'Cundinamarca > FOSCA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4073, 3, 483, '11-286', 'Cundinamarca > FUNZA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4074, 3, 484, '11-288', 'Cundinamarca > FÚQUENE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4075, 3, 485, '11-290', 'Cundinamarca > FUSAGASUGÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4076, 3, 486, '11-293', 'Cundinamarca > GACHALA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4077, 3, 487, '11-295', 'Cundinamarca > GACHANCIPÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4078, 3, 488, '11-297', 'Cundinamarca > GACHETÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4079, 3, 489, '11-299', 'Cundinamarca > GAMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4080, 3, 490, '11-307', 'Cundinamarca > GIRARDOT', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4081, 3, 491, '11-312', 'Cundinamarca > GRANADA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4082, 3, 492, '11-317', 'Cundinamarca > GUACHETÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4083, 3, 493, '11-320', 'Cundinamarca > GUADUAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4084, 3, 494, '11-322', 'Cundinamarca > GUASCA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4085, 3, 495, '11-324', 'Cundinamarca > GUATAQUÍ', NULL, '2023-07-01 13:09:24', NULL, NULL);
INSERT INTO `erp_maestras` (`id`, `tipo`, `id_erp`, `codigo`, `nombre`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(4086, 3, 496, '11-326', 'Cundinamarca > GUATAVITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4087, 3, 497, '11-328', 'Cundinamarca > GUAYABAL DE SIQUIMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4088, 3, 498, '11-335', 'Cundinamarca > GUAYABETAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4089, 3, 499, '11-339', 'Cundinamarca > GUTIÉRREZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4090, 3, 500, '11-368', 'Cundinamarca > JERUSALÉN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4091, 3, 501, '11-372', 'Cundinamarca > JUNÍN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4092, 3, 502, '11-377', 'Cundinamarca > LA CALERA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4093, 3, 503, '11-386', 'Cundinamarca > LA MESA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4094, 3, 504, '11-394', 'Cundinamarca > LA PALMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4095, 3, 505, '11-398', 'Cundinamarca > LA PEÑA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4096, 3, 506, '11-402', 'Cundinamarca > LA VEGA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4097, 3, 507, '11-407', 'Cundinamarca > LENGUAZAQUE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4098, 3, 508, '11-426', 'Cundinamarca > MACHETA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4099, 3, 509, '11-430', 'Cundinamarca > MADRID', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4100, 3, 510, '11-436', 'Cundinamarca > MANTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4101, 3, 511, '11-438', 'Cundinamarca > MEDINA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4102, 3, 512, '11-473', 'Cundinamarca > MOSQUERA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4103, 3, 513, '11-483', 'Cundinamarca > NARIÑO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4104, 3, 514, '11-486', 'Cundinamarca > NEMOCÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4105, 3, 515, '11-488', 'Cundinamarca > NILO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4106, 3, 516, '11-489', 'Cundinamarca > NIMAIMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4107, 3, 517, '11-491', 'Cundinamarca > NOCAIMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4108, 3, 519, '11-513', 'Cundinamarca > PACHO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4109, 3, 520, '11-518', 'Cundinamarca > PAIME', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4110, 3, 521, '11-524', 'Cundinamarca > PANDI', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4111, 3, 522, '11-530', 'Cundinamarca > PARATEBUENO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4112, 3, 523, '11-535', 'Cundinamarca > PASCA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4113, 3, 524, '11-572', 'Cundinamarca > PUERTO SALGAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4114, 3, 525, '11-580', 'Cundinamarca > PULÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4115, 3, 526, '11-592', 'Cundinamarca > QUEBRADANEGRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4116, 3, 527, '11-594', 'Cundinamarca > QUETAME', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4117, 3, 528, '11-596', 'Cundinamarca > QUIPILE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4118, 3, 530, '11-612', 'Cundinamarca > RICAURTE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4119, 3, 531, '11-645', 'Cundinamarca > SAN ANTONIO DEL TEQUENDAMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4120, 3, 532, '11-649', 'Cundinamarca > SAN BERNARDO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4121, 3, 533, '11-653', 'Cundinamarca > SAN CAYETANO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4122, 3, 534, '11-658', 'Cundinamarca > SAN FRANCISCO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4123, 3, 535, '11-662', 'Cundinamarca > SAN JUAN DE RÍO SECO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4124, 3, 536, '11-718', 'Cundinamarca > SASAIMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4125, 3, 537, '11-736', 'Cundinamarca > SESQUILÉ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4126, 3, 538, '11-740', 'Cundinamarca > SIBATÉ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4127, 3, 539, '11-743', 'Cundinamarca > SILVANIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4128, 3, 540, '11-745', 'Cundinamarca > SIMIJACA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4129, 3, 541, '11-754', 'Cundinamarca > SOACHA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4130, 3, 542, '11-758', 'Cundinamarca > SOPÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4131, 3, 543, '11-769', 'Cundinamarca > SUBACHOQUE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4132, 3, 544, '11-772', 'Cundinamarca > SUESCA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4133, 3, 545, '11-777', 'Cundinamarca > SUPATÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4134, 3, 546, '11-779', 'Cundinamarca > SUSA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4135, 3, 547, '11-781', 'Cundinamarca > SUTATAUSA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4136, 3, 548, '11-785', 'Cundinamarca > TABIO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4137, 3, 549, '11-793', 'Cundinamarca > TAUSA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4138, 3, 550, '11-797', 'Cundinamarca > TENA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4139, 3, 551, '11-799', 'Cundinamarca > TENJO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4140, 3, 552, '11-805', 'Cundinamarca > TIBACUY', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4141, 3, 553, '11-807', 'Cundinamarca > TIBIRITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4142, 3, 554, '11-815', 'Cundinamarca > TOCAIMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4143, 3, 555, '11-817', 'Cundinamarca > TOCANCIPÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4144, 3, 556, '11-823', 'Cundinamarca > TOPAIPÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4145, 3, 557, '11-839', 'Cundinamarca > UBALÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4146, 3, 558, '11-841', 'Cundinamarca > UBAQUE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4147, 3, 560, '11-845', 'Cundinamarca > UNE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4148, 3, 561, '11-851', 'Cundinamarca > ÚTICA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4149, 3, 518, '11-506', 'Cundinamarca > VENECIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4150, 3, 562, '11-862', 'Cundinamarca > VERGARA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4151, 3, 563, '11-867', 'Cundinamarca > VIANÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4152, 3, 559, '11-843', 'Cundinamarca > VILLA DE SAN DIEGO DE UBATE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4153, 3, 564, '11-871', 'Cundinamarca > VILLAGÓMEZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4154, 3, 565, '11-873', 'Cundinamarca > VILLAPINZÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4155, 3, 566, '11-875', 'Cundinamarca > VILLETA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4156, 3, 567, '11-878', 'Cundinamarca > VIOTÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4157, 3, 568, '11-885', 'Cundinamarca > YACOPÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4158, 3, 569, '11-898', 'Cundinamarca > ZIPACÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4159, 3, 570, '11-899', 'Cundinamarca > ZIPAQUIRÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4160, 3, 1098, '30-343', 'Guainía > BARRANCO MINAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4161, 3, 1103, '30-886', 'Guainía > CACAHUAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4162, 3, 1097, '30-001', 'Guainía > INÍRIDA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4163, 3, 1102, '30-885', 'Guainía > LA GUADALUPE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4164, 3, 1099, '30-663', 'Guainía > MAPIRIPANA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4165, 3, 1105, '30-888', 'Guainía > MORICHAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4166, 3, 1104, '30-887', 'Guainía > PANA PANA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4167, 3, 1101, '30-884', 'Guainía > PUERTO COLOMBIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4168, 3, 1100, '30-883', 'Guainía > SAN FELIPE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4169, 3, 1107, '31-015', 'Guaviare > CALAMAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4170, 3, 1108, '31-025', 'Guaviare > EL RETORNO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4171, 3, 1109, '31-200', 'Guaviare > MIRAFLORES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4172, 3, 1106, '31-001', 'Guaviare > SAN JOSÉ DEL GUAVIARE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4173, 3, 603, '13-006', 'Huila > ACEVEDO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4174, 3, 604, '13-013', 'Huila > AGRADO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4175, 3, 605, '13-016', 'Huila > AIPE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4176, 3, 606, '13-020', 'Huila > ALGECIRAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4177, 3, 607, '13-026', 'Huila > ALTAMIRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4178, 3, 608, '13-078', 'Huila > BARAYA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4179, 3, 609, '13-132', 'Huila > CAMPOALEGRE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4180, 3, 610, '13-206', 'Huila > COLOMBIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4181, 3, 611, '13-244', 'Huila > ELÍAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4182, 3, 612, '13-298', 'Huila > GARZÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4183, 3, 613, '13-306', 'Huila > GIGANTE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4184, 3, 614, '13-319', 'Huila > GUADALUPE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4185, 3, 615, '13-349', 'Huila > HOBO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4186, 3, 616, '13-357', 'Huila > IQUIRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4187, 3, 617, '13-359', 'Huila > ISNOS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4188, 3, 618, '13-378', 'Huila > LA ARGENTINA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4189, 3, 619, '13-396', 'Huila > LA PLATA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4190, 3, 620, '13-483', 'Huila > NÁTAGA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4191, 3, 602, '13-001', 'Huila > NEIVA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4192, 3, 621, '13-503', 'Huila > OPORAPA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4193, 3, 622, '13-518', 'Huila > PAICOL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4194, 3, 623, '13-524', 'Huila > PALERMO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4195, 3, 624, '13-530', 'Huila > PALESTINA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4196, 3, 625, '13-548', 'Huila > PITAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4197, 3, 626, '13-551', 'Huila > PITALITO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4198, 3, 627, '13-615', 'Huila > RIVERA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4199, 3, 628, '13-660', 'Huila > SALADOBLANCO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4200, 3, 629, '13-668', 'Huila > SAN AGUSTÍN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4201, 3, 630, '13-676', 'Huila > SANTA MARÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4202, 3, 631, '13-770', 'Huila > SUAZA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4203, 3, 632, '13-791', 'Huila > TARQUI', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4204, 3, 634, '13-799', 'Huila > TELLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4205, 3, 635, '13-801', 'Huila > TERUEL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4206, 3, 633, '13-797', 'Huila > TESALIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4207, 3, 636, '13-807', 'Huila > TIMANÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4208, 3, 637, '13-872', 'Huila > VILLAVIEJA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4209, 3, 638, '13-885', 'Huila > YAGUARÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4210, 3, 640, '14-035', 'La Guajira > ALBANIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4211, 3, 641, '14-078', 'La Guajira > BARRANCAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4212, 3, 642, '14-090', 'La Guajira > DIBULLA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4213, 3, 643, '14-098', 'La Guajira > DISTRACCIÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4214, 3, 644, '14-110', 'La Guajira > EL MOLINO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4215, 3, 645, '14-279', 'La Guajira > FONSECA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4216, 3, 646, '14-378', 'La Guajira > HATONUEVO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4217, 3, 647, '14-420', 'La Guajira > LA JAGUA DEL PILAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4218, 3, 648, '14-430', 'La Guajira > MAICAO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4219, 3, 649, '14-560', 'La Guajira > MANAURE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4220, 3, 639, '14-001', 'La Guajira > RIOHACHA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4221, 3, 650, '14-650', 'La Guajira > SAN JUAN DEL CESAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4222, 3, 651, '14-847', 'La Guajira > URIBIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4223, 3, 652, '14-855', 'La Guajira > URUMITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4224, 3, 653, '14-874', 'La Guajira > VILLANUEVA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4225, 3, 655, '15-030', 'Magdalena > ALGARROBO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4226, 3, 656, '15-053', 'Magdalena > ARACATACA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4227, 3, 657, '15-058', 'Magdalena > ARIGUANÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4228, 3, 658, '15-161', 'Magdalena > CERRO SAN ANTONIO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4229, 3, 659, '15-170', 'Magdalena > CHIBOLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4230, 3, 660, '15-189', 'Magdalena > CIÉNAGA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4231, 3, 661, '15-205', 'Magdalena > CONCORDIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4232, 3, 662, '15-245', 'Magdalena > EL BANCO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4233, 3, 663, '15-258', 'Magdalena > EL PIÑON', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4234, 3, 664, '15-268', 'Magdalena > EL RETÉN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4235, 3, 665, '15-288', 'Magdalena > FUNDACIÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4236, 3, 666, '15-318', 'Magdalena > GUAMAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4237, 3, 667, '15-460', 'Magdalena > NUEVA GRANADA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4238, 3, 668, '15-541', 'Magdalena > PEDRAZA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4239, 3, 669, '15-545', 'Magdalena > PIJIÑO DEL CARMEN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4240, 3, 670, '15-551', 'Magdalena > PIVIJAY', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4241, 3, 671, '15-555', 'Magdalena > PLATO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4242, 3, 672, '15-570', 'Magdalena > PUEBLOVIEJO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4243, 3, 673, '15-605', 'Magdalena > REMOLINO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4244, 3, 674, '15-660', 'Magdalena > SABANAS DE SAN ANGEL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4245, 3, 675, '15-675', 'Magdalena > SALAMINA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4246, 3, 676, '15-692', 'Magdalena > SAN SEBASTIÁN DE BUENAVISTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4247, 3, 677, '15-703', 'Magdalena > SAN ZENÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4248, 3, 678, '15-707', 'Magdalena > SANTA ANA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4249, 3, 679, '15-720', 'Magdalena > SANTA BÁRBARA DE PINTO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4250, 3, 654, '15-001', 'Magdalena > SANTA MARTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4251, 3, 680, '15-745', 'Magdalena > SITIONUEVO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4252, 3, 681, '15-798', 'Magdalena > TENERIFE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4253, 3, 682, '15-960', 'Magdalena > ZAPAYÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4254, 3, 683, '15-980', 'Magdalena > ZONA BANANERA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4255, 3, 685, '16-006', 'Meta > ACACÍAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4256, 3, 686, '16-110', 'Meta > BARRANCA DE UPÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4257, 3, 687, '16-124', 'Meta > CABUYARO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4258, 3, 688, '16-150', 'Meta > CASTILLA LA NUEVA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4259, 3, 689, '16-223', 'Meta > CUBARRAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4260, 3, 690, '16-226', 'Meta > CUMARAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4261, 3, 691, '16-245', 'Meta > EL CALVARIO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4262, 3, 692, '16-251', 'Meta > EL CASTILLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4263, 3, 693, '16-270', 'Meta > EL DORADO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4264, 3, 694, '16-287', 'Meta > FUENTE DE ORO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4265, 3, 695, '16-313', 'Meta > GRANADA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4266, 3, 696, '16-318', 'Meta > GUAMAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4267, 3, 699, '16-350', 'Meta > LA MACARENA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4268, 3, 701, '16-400', 'Meta > LEJANÍAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4269, 3, 697, '16-325', 'Meta > MAPIRIPÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4270, 3, 698, '16-330', 'Meta > MESETAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4271, 3, 702, '16-450', 'Meta > PUERTO CONCORDIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4272, 3, 703, '16-568', 'Meta > PUERTO GAITÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4273, 3, 705, '16-577', 'Meta > PUERTO LLERAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4274, 3, 704, '16-573', 'Meta > PUERTO LÓPEZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4275, 3, 706, '16-590', 'Meta > PUERTO RICO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4276, 3, 707, '16-606', 'Meta > RESTREPO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4277, 3, 708, '16-680', 'Meta > SAN CARLOS DE GUAROA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4278, 3, 709, '16-683', 'Meta > SAN JUAN DE ARAMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4279, 3, 710, '16-686', 'Meta > SAN JUANITO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4280, 3, 711, '16-689', 'Meta > SAN MARTÍN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4281, 3, 700, '16-370', 'Meta > URIBE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4282, 3, 684, '16-001', 'Meta > VILLAVICENCIO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4283, 3, 712, '16-711', 'Meta > VISTAHERMOSA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4284, 3, 714, '17-019', 'Nariño > ALBÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4285, 3, 715, '17-022', 'Nariño > ALDANA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4286, 3, 716, '17-036', 'Nariño > ANCUYÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4287, 3, 717, '17-051', 'Nariño > ARBOLEDA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4288, 3, 718, '17-079', 'Nariño > BARBACOAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4289, 3, 719, '17-083', 'Nariño > BELÉN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4290, 3, 720, '17-110', 'Nariño > BUESACO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4291, 3, 728, '17-240', 'Nariño > CHACHAGÜÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4292, 3, 721, '17-203', 'Nariño > COLÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4293, 3, 722, '17-207', 'Nariño > CONSACA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4294, 3, 723, '17-210', 'Nariño > CONTADERO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4295, 3, 724, '17-215', 'Nariño > CÓRDOBA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4296, 3, 725, '17-224', 'Nariño > CUASPUD', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4297, 3, 726, '17-227', 'Nariño > CUMBAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4298, 3, 727, '17-233', 'Nariño > CUMBITARA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4299, 3, 729, '17-250', 'Nariño > EL CHARCO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4300, 3, 730, '17-254', 'Nariño > EL PEÑOL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4301, 3, 731, '17-256', 'Nariño > EL ROSARIO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4302, 3, 732, '17-258', 'Nariño > EL TABLÓN DE GÓMEZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4303, 3, 733, '17-260', 'Nariño > EL TAMBO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4304, 3, 755, '17-520', 'Nariño > FRANCISCO PIZARRO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4305, 3, 734, '17-287', 'Nariño > FUNES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4306, 3, 735, '17-317', 'Nariño > GUACHUCAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4307, 3, 736, '17-320', 'Nariño > GUAITARILLA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4308, 3, 737, '17-323', 'Nariño > GUALMATÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4309, 3, 738, '17-352', 'Nariño > ILES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4310, 3, 739, '17-354', 'Nariño > IMUÉS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4311, 3, 740, '17-356', 'Nariño > IPIALES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4312, 3, 741, '17-378', 'Nariño > LA CRUZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4313, 3, 742, '17-381', 'Nariño > LA FLORIDA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4314, 3, 743, '17-385', 'Nariño > LA LLANADA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4315, 3, 744, '17-390', 'Nariño > LA TOLA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4316, 3, 745, '17-399', 'Nariño > LA UNIÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4317, 3, 746, '17-405', 'Nariño > LEIVA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4318, 3, 747, '17-411', 'Nariño > LINARES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4319, 3, 748, '17-418', 'Nariño > LOS ANDES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4320, 3, 749, '17-427', 'Nariño > MAGÜI', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4321, 3, 750, '17-435', 'Nariño > MALLAMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4322, 3, 751, '17-473', 'Nariño > MOSQUERA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4323, 3, 752, '17-480', 'Nariño > NARIÑO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4324, 3, 753, '17-490', 'Nariño > OLAYA HERRERA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4325, 3, 754, '17-506', 'Nariño > OSPINA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4326, 3, 713, '17-001', 'Nariño > PASTO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4327, 3, 756, '17-540', 'Nariño > POLICARPA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4328, 3, 757, '17-560', 'Nariño > POTOSÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4329, 3, 758, '17-565', 'Nariño > PROVIDENCIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4330, 3, 759, '17-573', 'Nariño > PUERRES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4331, 3, 760, '17-585', 'Nariño > PUPIALES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4332, 3, 761, '17-612', 'Nariño > RICAURTE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4333, 3, 762, '17-621', 'Nariño > ROBERTO PAYÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4334, 3, 763, '17-678', 'Nariño > SAMANIEGO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4335, 3, 765, '17-685', 'Nariño > SAN BERNARDO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4336, 3, 766, '17-687', 'Nariño > SAN LORENZO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4337, 3, 767, '17-693', 'Nariño > SAN PABLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4338, 3, 768, '17-694', 'Nariño > SAN PEDRO DE CARTAGO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4339, 3, 764, '17-683', 'Nariño > SANDONÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4340, 3, 769, '17-696', 'Nariño > SANTA BÁRBARA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4341, 3, 770, '17-699', 'Nariño > SANTACRUZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4342, 3, 771, '17-720', 'Nariño > SAPUYES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4343, 3, 772, '17-786', 'Nariño > TAMINANGO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4344, 3, 773, '17-788', 'Nariño > TANGUA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4345, 3, 774, '17-835', 'Nariño > TUMACO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4346, 3, 775, '17-838', 'Nariño > TÚQUERRES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4347, 3, 776, '17-885', 'Nariño > YACUANQUER', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4348, 3, 778, '18-003', 'Norte de Santander > ABREGO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4349, 3, 779, '18-051', 'Norte de Santander > ARBOLEDAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4350, 3, 780, '18-099', 'Norte de Santander > BOCHALEMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4351, 3, 781, '18-109', 'Norte de Santander > BUCARASICA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4352, 3, 783, '18-128', 'Norte de Santander > CACHIRÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4353, 3, 782, '18-125', 'Norte de Santander > CÁCOTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4354, 3, 784, '18-172', 'Norte de Santander > CHINÁCOTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4355, 3, 785, '18-174', 'Norte de Santander > CHITAGÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4356, 3, 786, '18-206', 'Norte de Santander > CONVENCIÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4357, 3, 777, '18-001', 'Norte de Santander > CÚCUTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4358, 3, 787, '18-223', 'Norte de Santander > CUCUTILLA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4359, 3, 788, '18-239', 'Norte de Santander > DURANIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4360, 3, 789, '18-245', 'Norte de Santander > EL CARMEN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4361, 3, 790, '18-250', 'Norte de Santander > EL TARRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4362, 3, 791, '18-261', 'Norte de Santander > EL ZULIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4363, 3, 792, '18-313', 'Norte de Santander > GRAMALOTE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4364, 3, 793, '18-344', 'Norte de Santander > HACARÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4365, 3, 794, '18-347', 'Norte de Santander > HERRÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4366, 3, 796, '18-385', 'Norte de Santander > LA ESPERANZA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4367, 3, 797, '18-398', 'Norte de Santander > LA PLAYA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4368, 3, 795, '18-377', 'Norte de Santander > LABATECA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4369, 3, 798, '18-405', 'Norte de Santander > LOS PATIOS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4370, 3, 799, '18-418', 'Norte de Santander > LOURDES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4371, 3, 800, '18-480', 'Norte de Santander > MUTISCUA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4372, 3, 801, '18-498', 'Norte de Santander > OCAÑA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4373, 3, 802, '18-518', 'Norte de Santander > PAMPLONA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4374, 3, 803, '18-520', 'Norte de Santander > PAMPLONITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4375, 3, 804, '18-553', 'Norte de Santander > PUERTO SANTANDER', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4376, 3, 805, '18-599', 'Norte de Santander > RAGONVALIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4377, 3, 806, '18-660', 'Norte de Santander > SALAZAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4378, 3, 807, '18-670', 'Norte de Santander > SAN CALIXTO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4379, 3, 808, '18-673', 'Norte de Santander > SAN CAYETANO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4380, 3, 809, '18-680', 'Norte de Santander > SANTIAGO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4381, 3, 810, '18-720', 'Norte de Santander > SARDINATA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4382, 3, 811, '18-743', 'Norte de Santander > SILOS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4383, 3, 812, '18-800', 'Norte de Santander > TEORAMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4384, 3, 813, '18-810', 'Norte de Santander > TIBÚ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4385, 3, 814, '18-820', 'Norte de Santander > TOLEDO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4386, 3, 815, '18-871', 'Norte de Santander > VILLA CARO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4387, 3, 816, '18-874', 'Norte de Santander > VILLA DEL ROSARIO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4388, 3, 1072, '27-219', 'Putumayo > COLÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4389, 3, 1077, '27-573', 'Putumayo > LEGUÍZAMO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4390, 3, 1071, '27-001', 'Putumayo > MOCOA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4391, 3, 1073, '27-320', 'Putumayo > ORITO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4392, 3, 1074, '27-568', 'Putumayo > PUERTO ASÍS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4393, 3, 1075, '27-569', 'Putumayo > PUERTO CAICEDO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4394, 3, 1076, '27-571', 'Putumayo > PUERTO GUZMÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4395, 3, 1079, '27-755', 'Putumayo > SAN FRANCISCO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4396, 3, 1080, '27-757', 'Putumayo > SAN MIGUEL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4397, 3, 1081, '27-760', 'Putumayo > SANTIAGO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4398, 3, 1078, '27-749', 'Putumayo > SIBUNDOY', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4399, 3, 1082, '27-865', 'Putumayo > VALLE DEL GUAMUEZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4400, 3, 1083, '27-885', 'Putumayo > VILLAGARZÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4401, 3, 817, '19-001', 'Quindio > ARMENIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4402, 3, 818, '19-111', 'Quindio > BUENAVISTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4403, 3, 819, '19-130', 'Quindio > CALARCA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4404, 3, 820, '19-190', 'Quindio > CIRCASIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4405, 3, 821, '19-212', 'Quindio > CÓRDOBA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4406, 3, 822, '19-272', 'Quindio > FILANDIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4407, 3, 823, '19-302', 'Quindio > GÉNOVA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4408, 3, 824, '19-401', 'Quindio > LA TEBAIDA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4409, 3, 825, '19-470', 'Quindio > MONTENEGRO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4410, 3, 826, '19-548', 'Quindio > PIJAO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4411, 3, 827, '19-594', 'Quindio > QUIMBAYA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4412, 3, 828, '19-690', 'Quindio > SALENTO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4413, 3, 830, '20-045', 'Risaralda > APÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4414, 3, 831, '20-075', 'Risaralda > BALBOA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4415, 3, 832, '20-088', 'Risaralda > BELÉN DE UMBRÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4416, 3, 833, '20-170', 'Risaralda > DOSQUEBRADAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4417, 3, 834, '20-318', 'Risaralda > GUÁTICA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4418, 3, 835, '20-383', 'Risaralda > LA CELIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4419, 3, 836, '20-400', 'Risaralda > LA VIRGINIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4420, 3, 837, '20-440', 'Risaralda > MARSELLA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4421, 3, 838, '20-456', 'Risaralda > MISTRATÓ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4422, 3, 829, '20-001', 'Risaralda > PEREIRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4423, 3, 839, '20-572', 'Risaralda > PUEBLO RICO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4424, 3, 840, '20-594', 'Risaralda > QUINCHÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4425, 3, 841, '20-682', 'Risaralda > SANTA ROSA DE CABAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4426, 3, 842, '20-687', 'Risaralda > SANTUARIO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4427, 3, 844, '21-013', 'Santander > AGUADA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4428, 3, 845, '21-020', 'Santander > ALBANIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4429, 3, 846, '21-051', 'Santander > ARATOCA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4430, 3, 847, '21-077', 'Santander > BARBOSA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4431, 3, 848, '21-079', 'Santander > BARICHARA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4432, 3, 849, '21-081', 'Santander > BARRANCABERMEJA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4433, 3, 850, '21-092', 'Santander > BETULIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4434, 3, 851, '21-101', 'Santander > BOLÍVAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4435, 3, 843, '21-001', 'Santander > BUCARAMANGA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4436, 3, 852, '21-121', 'Santander > CABRERA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4437, 3, 853, '21-132', 'Santander > CALIFORNIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4438, 3, 854, '21-147', 'Santander > CAPITANEJO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4439, 3, 855, '21-152', 'Santander > CARCASÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4440, 3, 856, '21-160', 'Santander > CEPITÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4441, 3, 857, '21-162', 'Santander > CERRITO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4442, 3, 858, '21-167', 'Santander > CHARALÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4443, 3, 859, '21-169', 'Santander > CHARTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4444, 3, 860, '21-176', 'Santander > CHIMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4445, 3, 861, '21-179', 'Santander > CHIPATÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4446, 3, 862, '21-190', 'Santander > CIMITARRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4447, 3, 863, '21-207', 'Santander > CONCEPCIÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4448, 3, 864, '21-209', 'Santander > CONFINES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4449, 3, 865, '21-211', 'Santander > CONTRATACIÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4450, 3, 866, '21-217', 'Santander > COROMORO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4451, 3, 867, '21-229', 'Santander > CURITÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4452, 3, 868, '21-235', 'Santander > EL CARMEN DE CHUCURÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4453, 3, 869, '21-245', 'Santander > EL GUACAMAYO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4454, 3, 870, '21-250', 'Santander > EL PEÑÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4455, 3, 871, '21-255', 'Santander > EL PLAYÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4456, 3, 872, '21-264', 'Santander > ENCINO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4457, 3, 873, '21-266', 'Santander > ENCISO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4458, 3, 874, '21-271', 'Santander > FLORIÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4459, 3, 875, '21-276', 'Santander > FLORIDABLANCA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4460, 3, 876, '21-296', 'Santander > GALÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4461, 3, 877, '21-298', 'Santander > GAMBITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4462, 3, 878, '21-307', 'Santander > GIRÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4463, 3, 879, '21-318', 'Santander > GUACA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4464, 3, 880, '21-320', 'Santander > GUADALUPE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4465, 3, 881, '21-322', 'Santander > GUAPOTÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4466, 3, 882, '21-324', 'Santander > GUAVATÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4467, 3, 883, '21-327', 'Santander > GÜEPSA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4468, 3, 884, '21-344', 'Santander > HATO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4469, 3, 885, '21-368', 'Santander > JESÚS MARÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4470, 3, 886, '21-370', 'Santander > JORDÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4471, 3, 887, '21-377', 'Santander > LA BELLEZA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4472, 3, 889, '21-397', 'Santander > LA PAZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4473, 3, 888, '21-385', 'Santander > LANDÁZURI', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4474, 3, 890, '21-406', 'Santander > LEBRÍJA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4475, 3, 891, '21-418', 'Santander > LOS SANTOS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4476, 3, 892, '21-425', 'Santander > MACARAVITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4477, 3, 893, '21-432', 'Santander > MÁLAGA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4478, 3, 894, '21-444', 'Santander > MATANZA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4479, 3, 895, '21-464', 'Santander > MOGOTES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4480, 3, 896, '21-468', 'Santander > MOLAGAVITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4481, 3, 897, '21-498', 'Santander > OCAMONTE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4482, 3, 898, '21-500', 'Santander > OIBA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4483, 3, 899, '21-502', 'Santander > ONZAGA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4484, 3, 900, '21-522', 'Santander > PALMAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4485, 3, 901, '21-524', 'Santander > PALMAS DEL SOCORRO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4486, 3, 902, '21-533', 'Santander > PÁRAMO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4487, 3, 903, '21-547', 'Santander > PIEDECUESTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4488, 3, 904, '21-549', 'Santander > PINCHOTE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4489, 3, 905, '21-572', 'Santander > PUENTE NACIONAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4490, 3, 906, '21-573', 'Santander > PUERTO PARRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4491, 3, 907, '21-575', 'Santander > PUERTO WILCHES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4492, 3, 908, '21-615', 'Santander > RIONEGRO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4493, 3, 909, '21-655', 'Santander > SABANA DE TORRES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4494, 3, 910, '21-669', 'Santander > SAN ANDRÉS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4495, 3, 911, '21-673', 'Santander > SAN BENITO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4496, 3, 912, '21-679', 'Santander > SAN GIL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4497, 3, 913, '21-682', 'Santander > SAN JOAQUÍN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4498, 3, 914, '21-684', 'Santander > SAN JOSÉ DE MIRANDA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4499, 3, 915, '21-686', 'Santander > SAN MIGUEL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4500, 3, 916, '21-689', 'Santander > SAN VICENTE DE CHUCURÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4501, 3, 917, '21-705', 'Santander > SANTA BÁRBARA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4502, 3, 918, '21-720', 'Santander > SANTA HELENA DEL OPÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4503, 3, 919, '21-745', 'Santander > SIMACOTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4504, 3, 920, '21-755', 'Santander > SOCORRO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4505, 3, 921, '21-770', 'Santander > SUAITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4506, 3, 922, '21-773', 'Santander > SUCRE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4507, 3, 923, '21-780', 'Santander > SURATÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4508, 3, 924, '21-820', 'Santander > TONA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4509, 3, 925, '21-855', 'Santander > VALLE DE SAN JOSÉ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4510, 3, 926, '21-861', 'Santander > VÉLEZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4511, 3, 927, '21-867', 'Santander > VETAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4512, 3, 928, '21-872', 'Santander > VILLANUEVA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4513, 3, 929, '21-895', 'Santander > ZAPATOCA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4514, 3, 931, '22-110', 'Sucre > BUENAVISTA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4515, 3, 932, '22-124', 'Sucre > CAIMITO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4516, 3, 936, '22-230', 'Sucre > CHALÁN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4517, 3, 933, '22-204', 'Sucre > COLOSO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4518, 3, 934, '22-215', 'Sucre > COROZAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4519, 3, 935, '22-221', 'Sucre > COVEÑAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4520, 3, 937, '22-233', 'Sucre > EL ROBLE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4521, 3, 938, '22-235', 'Sucre > GALERAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4522, 3, 939, '22-265', 'Sucre > GUARANDA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4523, 3, 940, '22-400', 'Sucre > LA UNIÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4524, 3, 941, '22-418', 'Sucre > LOS PALMITOS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4525, 3, 942, '22-429', 'Sucre > MAJAGUAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4526, 3, 943, '22-473', 'Sucre > MORROA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4527, 3, 944, '22-508', 'Sucre > OVEJAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4528, 3, 945, '22-523', 'Sucre > PALMITO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4529, 3, 946, '22-670', 'Sucre > SAMPUÉS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4530, 3, 947, '22-678', 'Sucre > SAN BENITO ABAD', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4531, 3, 948, '22-702', 'Sucre > SAN JUAN DE BETULIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4532, 3, 949, '22-708', 'Sucre > SAN MARCOS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4533, 3, 950, '22-713', 'Sucre > SAN ONOFRE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4534, 3, 951, '22-717', 'Sucre > SAN PEDRO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4535, 3, 954, '22-820', 'Sucre > SANTIAGO DE TOLÚ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4536, 3, 952, '22-742', 'Sucre > SINCÉ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4537, 3, 930, '22-001', 'Sucre > SINCELEJO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4538, 3, 953, '22-771', 'Sucre > SUCRE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4539, 3, 955, '22-823', 'Sucre > TOLÚ VIEJO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4540, 3, 957, '23-024', 'Tolima > ALPUJARRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4541, 3, 958, '23-026', 'Tolima > ALVARADO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4542, 3, 959, '23-030', 'Tolima > AMBALEMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4543, 3, 960, '23-043', 'Tolima > ANZOÁTEGUI', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4544, 3, 961, '23-055', 'Tolima > ARMERO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4545, 3, 962, '23-067', 'Tolima > ATACO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4546, 3, 963, '23-124', 'Tolima > CAJAMARCA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4547, 3, 964, '23-148', 'Tolima > CARMEN DE APICALÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4548, 3, 965, '23-152', 'Tolima > CASABIANCA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4549, 3, 966, '23-168', 'Tolima > CHAPARRAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4550, 3, 967, '23-200', 'Tolima > COELLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4551, 3, 968, '23-217', 'Tolima > COYAIMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4552, 3, 969, '23-226', 'Tolima > CUNDAY', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4553, 3, 970, '23-236', 'Tolima > DOLORES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4554, 3, 971, '23-268', 'Tolima > ESPINAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4555, 3, 972, '23-270', 'Tolima > FALAN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4556, 3, 973, '23-275', 'Tolima > FLANDES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4557, 3, 974, '23-283', 'Tolima > FRESNO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4558, 3, 975, '23-319', 'Tolima > GUAMO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4559, 3, 976, '23-347', 'Tolima > HERVEO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4560, 3, 977, '23-349', 'Tolima > HONDA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4561, 3, 956, '23-001', 'Tolima > IBAGUÉ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4562, 3, 978, '23-352', 'Tolima > ICONONZO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4563, 3, 979, '23-408', 'Tolima > LÉRIDA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4564, 3, 980, '23-411', 'Tolima > LÍBANO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4565, 3, 981, '23-443', 'Tolima > MARIQUITA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4566, 3, 982, '23-449', 'Tolima > MELGAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4567, 3, 983, '23-461', 'Tolima > MURILLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4568, 3, 984, '23-483', 'Tolima > NATAGAIMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4569, 3, 985, '23-504', 'Tolima > ORTEGA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4570, 3, 986, '23-520', 'Tolima > PALOCABILDO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4571, 3, 987, '23-547', 'Tolima > PIEDRAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4572, 3, 988, '23-555', 'Tolima > PLANADAS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4573, 3, 989, '23-563', 'Tolima > PRADO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4574, 3, 990, '23-585', 'Tolima > PURIFICACIÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4575, 3, 991, '23-616', 'Tolima > RIOBLANCO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4576, 3, 992, '23-622', 'Tolima > RONCESVALLES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4577, 3, 993, '23-624', 'Tolima > ROVIRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4578, 3, 994, '23-671', 'Tolima > SALDAÑA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4579, 3, 995, '23-675', 'Tolima > SAN ANTONIO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4580, 3, 996, '23-678', 'Tolima > SAN LUIS', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4581, 3, 997, '23-686', 'Tolima > SANTA ISABEL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4582, 3, 998, '23-770', 'Tolima > SUÁREZ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4583, 3, 999, '23-854', 'Tolima > VALLE DE SAN JUAN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4584, 3, 1000, '23-861', 'Tolima > VENADILLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4585, 3, 1001, '23-870', 'Tolima > VILLAHERMOSA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4586, 3, 1002, '23-873', 'Tolima > VILLARRICA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4587, 3, 1004, '24-020', 'Valle del Cauca > ALCALÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4588, 3, 1005, '24-036', 'Valle del Cauca > ANDALUCÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4589, 3, 1006, '24-041', 'Valle del Cauca > ANSERMANUEVO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4590, 3, 1007, '24-054', 'Valle del Cauca > ARGELIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4591, 3, 1008, '24-100', 'Valle del Cauca > BOLÍVAR', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4592, 3, 1009, '24-109', 'Valle del Cauca > BUENAVENTURA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4593, 3, 1011, '24-113', 'Valle del Cauca > BUGALAGRANDE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4594, 3, 1012, '24-122', 'Valle del Cauca > CAICEDONIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4595, 3, 1003, '24-001', 'Valle del Cauca > CALI', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4596, 3, 1013, '24-126', 'Valle del Cauca > CALIMA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4597, 3, 1014, '24-130', 'Valle del Cauca > CANDELARIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4598, 3, 1015, '24-147', 'Valle del Cauca > CARTAGO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4599, 3, 1016, '24-233', 'Valle del Cauca > DAGUA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4600, 3, 1017, '24-243', 'Valle del Cauca > EL ÁGUILA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4601, 3, 1018, '24-246', 'Valle del Cauca > EL CAIRO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4602, 3, 1019, '24-248', 'Valle del Cauca > EL CERRITO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4603, 3, 1020, '24-250', 'Valle del Cauca > EL DOVIO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4604, 3, 1021, '24-275', 'Valle del Cauca > FLORIDA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4605, 3, 1022, '24-306', 'Valle del Cauca > GINEBRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4606, 3, 1023, '24-318', 'Valle del Cauca > GUACARÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4607, 3, 1010, '24-111', 'Valle del Cauca > GUADALAJARA DE BUGA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4608, 3, 1024, '24-364', 'Valle del Cauca > JAMUNDÍ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4609, 3, 1025, '24-377', 'Valle del Cauca > LA CUMBRE', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4610, 3, 1026, '24-400', 'Valle del Cauca > LA UNIÓN', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4611, 3, 1027, '24-403', 'Valle del Cauca > LA VICTORIA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4612, 3, 1028, '24-497', 'Valle del Cauca > OBANDO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4613, 3, 1029, '24-520', 'Valle del Cauca > PALMIRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4614, 3, 1030, '24-563', 'Valle del Cauca > PRADERA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4615, 3, 1031, '24-606', 'Valle del Cauca > RESTREPO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4616, 3, 1032, '24-616', 'Valle del Cauca > RIOFRÍO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4617, 3, 1033, '24-622', 'Valle del Cauca > ROLDANILLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4618, 3, 1034, '24-670', 'Valle del Cauca > SAN PEDRO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4619, 3, 1035, '24-736', 'Valle del Cauca > SEVILLA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4620, 3, 1036, '24-823', 'Valle del Cauca > TORO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4621, 3, 1037, '24-828', 'Valle del Cauca > TRUJILLO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4622, 3, 1038, '24-834', 'Valle del Cauca > TULUÁ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4623, 3, 1039, '24-845', 'Valle del Cauca > ULLOA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4624, 3, 1040, '24-863', 'Valle del Cauca > VERSALLES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4625, 3, 1041, '24-869', 'Valle del Cauca > VIJES', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4626, 3, 1042, '24-890', 'Valle del Cauca > YOTOCO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4627, 3, 1043, '24-892', 'Valle del Cauca > YUMBO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4628, 3, 1044, '24-895', 'Valle del Cauca > ZARZAL', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4629, 3, 1111, '32-161', 'Vaupés > CARURU', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4630, 3, 1110, '32-001', 'Vaupés > MITÚ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4631, 3, 1112, '32-511', 'Vaupés > PACOA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4632, 3, 1114, '32-777', 'Vaupés > PAPUNAUA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4633, 3, 1113, '32-666', 'Vaupés > TARAIRA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4634, 3, 1115, '32-889', 'Vaupés > YAVARATÉ', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4635, 3, 1119, '33-773', 'Vichada > CUMARIBO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4636, 3, 1117, '33-524', 'Vichada > LA PRIMAVERA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4637, 3, 1116, '33-001', 'Vichada > PUERTO CARREÑO', NULL, '2023-07-01 13:09:24', NULL, NULL),
(4638, 3, 1118, '33-624', 'Vichada > SANTA ROSALÍA', NULL, '2023-07-01 13:09:24', NULL, NULL),
(13270, 1, 4, '04', 'CAUSACION ADMIN', NULL, '2023-10-15 14:21:52', NULL, '2023-12-01 22:22:43');
INSERT INTO `erp_maestras` (`id`, `tipo`, `id_erp`, `codigo`, `nombre`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(13271, 1, 5, '05', 'PRODUCCION', NULL, '2023-10-15 14:21:52', NULL, '2023-12-01 22:22:43'),
(13272, 1, 6, '06', 'GASTOS Y SERVICIOS', NULL, '2023-10-15 14:21:52', NULL, '2023-12-01 22:22:43'),
(13273, 1, 7, '07', 'NÓMINA', NULL, '2023-10-15 14:21:52', NULL, '2023-12-01 22:22:43'),
(13274, 1, 8, '08', 'PARAFISCALES', NULL, '2023-10-15 14:21:52', NULL, '2023-12-01 22:22:43'),
(13275, 1, 9, '09', 'PRESTACIONES', NULL, '2023-10-15 14:21:52', NULL, '2023-12-01 22:22:43'),
(13276, 1, 10, '10', 'DESCARGUES DE INVENTARIO', NULL, '2023-10-15 14:21:52', NULL, '2023-12-01 22:22:43'),
(13277, 1, 11, '11', 'NOTAS', NULL, '2023-10-15 14:21:52', NULL, '2023-12-01 22:22:43'),
(13278, 1, 12, '13', 'TOMA DE INVENTARIO', NULL, '2023-10-15 14:21:52', NULL, '2023-12-01 22:22:43'),
(13279, 1, 13, '90', 'SALDOS INICIALES', NULL, '2023-10-15 14:21:52', NULL, '2023-12-01 22:22:43'),
(13280, 1, 14, '99', 'CIERRE ANUAL', NULL, '2023-10-15 14:21:52', NULL, '2023-12-01 22:22:43'),
(13281, 1, 15, '14', 'DEVOLUCION VENTAS', NULL, '2023-10-15 14:21:52', NULL, '2023-12-01 22:22:43'),
(13282, 1, 16, '15', 'DEVOLUCION COMPRAS', NULL, '2023-10-15 14:21:52', NULL, '2023-12-01 22:22:43'),
(13284, 0, 12, '02', 'TORRE 1', NULL, '2023-10-15 14:22:10', NULL, '2023-12-01 22:22:43'),
(13285, 0, 13, '03', 'TORRE 2', NULL, '2023-10-15 14:22:10', NULL, '2023-12-01 22:22:43'),
(19824, 2, 6035656, '110505', 'CAJA GENERAL', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19825, 2, 6035657, '110510', 'CAJAS MENORES', NULL, '2023-11-02 20:12:31', NULL, NULL),
(19826, 2, 6035664, '125020', 'CEDULAS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19827, 2, 6035669, '131020', 'PARTICULARES', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19828, 2, 6035671, '133005', 'A PROVEEDORES', NULL, '2023-11-02 20:12:31', NULL, NULL),
(19829, 2, 6035672, '133010', 'A CONTRATISTAS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19830, 2, 6035673, '133015', 'A TRABAJADORES', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19831, 2, 6035674, '133020', 'A AGENTES', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19832, 2, 6035675, '133025', 'A CONCESIONARIOS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19833, 2, 6035676, '133030', 'DE ADJUDICACIONES', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19834, 2, 6035677, '133095', 'A AGENTES ANTICIPOS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19835, 2, 6035679, '133530', 'PARA ADQUISICION DE DERECHOS SOCIALES', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19836, 2, 6035683, '135510', 'ANTICIPO DE INDUSTRIA Y COMERCIO', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19837, 2, 6035684, '135515', 'RETENCION EN LA FUENTE', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19838, 2, 6035686, '138025', 'PAGOS POR CUENTA DE TERCEROS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19839, 2, 6035687, '138035', 'CUENTAS POR COBRAR PROPIETARIOS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19840, 2, 6035688, '138095', 'DEUDORES VARIOS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19841, 2, 6035691, '143501', 'INVENTARIO DE MERCANCIAS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19842, 2, 6035692, '143599', 'AJUSTES POR INFLACION', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19843, 2, 6035695, '151680', 'BODEGAS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19844, 2, 6035696, '151699', 'AJUSTES POR INFLACION', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19845, 2, 6035698, '152405', 'MUEBLES Y ENSERES', NULL, '2023-11-02 20:12:31', NULL, NULL),
(19846, 2, 6035699, '152410', 'EQUIPOS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19847, 2, 6035700, '152495', 'OTROS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19848, 2, 6035702, '152805', 'EQUIPO DE PROCESAMIENTO DE DATOS', NULL, '2023-11-02 20:12:31', NULL, NULL),
(19849, 2, 6035703, '152810', 'EQUIPO DE TELECOMUNICACIONES', NULL, '2023-11-02 20:12:31', NULL, NULL),
(19850, 2, 6035704, '152825', 'LINEAS TELEFONICAS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19851, 2, 6035705, '152895', 'OTROS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19852, 2, 6035707, '154005', 'AUTOS CAMIONETAS Y CAMPEROS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19853, 2, 6035708, '154099', 'AJUSTES POR INFLACION', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19854, 2, 6035710, '156201', 'ENVASES Y EMPAQUES', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19855, 2, 6035712, '159205', 'CONSTRUCCIONES Y EDIFICACIONES', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19856, 2, 6035713, '159210', 'MAQUINARIA Y EQUIPO', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19857, 2, 6035714, '159215', 'EQUIPO DE OFICINA', NULL, '2023-11-02 20:12:31', NULL, NULL),
(19858, 2, 6035715, '159220', 'EQUIPO DE COMPUTACION Y COMUNICACION', NULL, '2023-11-02 20:12:31', NULL, NULL),
(19859, 2, 6035716, '159225', 'EQUIPO MEDICO CIENTIFICO', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19860, 2, 6035717, '159265', 'ENVASES Y EMPAQUES', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19861, 2, 6035722, '210505', 'SOBREGIROS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19862, 2, 6035723, '210510', 'PAGARES', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19863, 2, 6035724, '210515', 'CARTAS DE CREDITO', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19864, 2, 6035725, '210520', 'ACEPTACIONES BANCARIAS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19865, 2, 6035726, '210525', 'TARJETA DE CREDITO', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19866, 2, 6035729, '220501', 'PROVEEDORES NACIONALES', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19867, 2, 6035731, '221005', 'PROVEEDORES DEL EXTERIOR', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19868, 2, 6035734, '230505', 'ACREEDORES VARIOS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19869, 2, 6035736, '233505', 'FINANCIEROS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19870, 2, 6035737, '233510', 'LEGALES', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19871, 2, 6035738, '233515', 'LIBROS, SUSCRIPCIONES, PERIODICOS Y R', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19872, 2, 6035739, '233520', 'COMISIONES', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19873, 2, 6035740, '233525', 'HONORARIOS', NULL, '2023-11-02 20:12:31', NULL, NULL),
(19874, 2, 6035741, '233530', 'SERVICIOS TECNICOS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19875, 2, 6035742, '233535', 'SERVICIOS DE MANTENIMIENTO', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19876, 2, 6035743, '233540', 'ARRENDAMIENTOS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19877, 2, 6035744, '233545', 'TRANSPORTES, FLETES Y ACARREOS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19878, 2, 6035745, '233550', 'SERVICIOS PUBLICOS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19879, 2, 6035746, '233555', 'SEGUROS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19880, 2, 6035747, '233560', 'GASTOS DE VIAJE', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19881, 2, 6035748, '233565', 'GASTOS REPRESENTACION Y RELAC. PUBLICAS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19882, 2, 6035749, '233570', 'SERVICIOS ADUANEROS', NULL, '2023-11-02 20:12:31', NULL, '2023-12-01 22:22:44'),
(19883, 2, 6035750, '233595', 'OTROS GASTOS POR PAGAR', NULL, '2023-11-02 20:12:32', NULL, NULL),
(19884, 2, 6035752, '236505', 'SALARIOS Y PAGOS LABORALES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19885, 2, 6035753, '236510', 'COMPRAS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19886, 2, 6035757, '236595', 'OTROS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19887, 2, 6035759, '237005', 'APORTES A E.P.S.', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19888, 2, 6035760, '237006', 'APORTES A RIESGOS PROFESIONALES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19889, 2, 6035761, '237007', 'APORTES A PENSIONES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19890, 2, 6035762, '237010', 'APORTES PARAFISCALES ICBF-SENA-CAJAS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19891, 2, 6035763, '237030', 'LIBRANZAS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19892, 2, 6035764, '237045', 'APORTES A FONDOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19893, 2, 6035765, '237095', 'OTROS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19894, 2, 6035767, '238095', 'OTROS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19895, 2, 6035771, '24080101', 'IVA EN VENTAS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19896, 2, 6035773, '24080202', 'IVA EN COMPRAS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19897, 2, 6035775, '24080301', 'PAGOS DE IVA PRESENTE ANO', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19898, 2, 6035776, '24080302', 'IVA RETENIDO', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19899, 2, 6035777, '240804', 'IVA EN DESCUENTOS COMERCIALES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19900, 2, 6035778, '240805', 'PAGOS DE IVA', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19901, 2, 6035779, '240810', 'SALDOS A FAVOR', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19902, 2, 6035782, '250505', 'NOMINA POR PAGAR', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19903, 2, 6035784, '251005', 'LEY LABORAL ANTERIOR', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19904, 2, 6035785, '251010', 'LEY 50 DE 1990 Y NORMAS POSTERIORES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19905, 2, 6035786, '251097', 'PAGOS DE CESANTIAS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19906, 2, 6035788, '251505', 'INTERESES SOBRE CESANTIAS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19907, 2, 6035790, '252005', 'PRIMA DE SERVICIOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19908, 2, 6035792, '252505', 'ADMINISTRACION', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19909, 2, 6035794, '253005', 'PRIMAS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19910, 2, 6035795, '253010', 'AUXILIOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19911, 2, 6035796, '253015', 'DOTACION Y SUMINISTRO A TRABAJADORES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19912, 2, 6035797, '253020', 'BONIFICACIONES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19913, 2, 6035798, '253025', 'SEGUROS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19914, 2, 6035799, '253095', 'OTRAS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19915, 2, 6035801, '254005', 'INDEMNIZACION A TRABAJADORES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19916, 2, 6035804, '260505', 'INTERESES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19917, 2, 6035805, '260510', 'COMISIONES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19918, 2, 6035806, '260515', 'HONORARIOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19919, 2, 6035807, '260520', 'SERVICIOS TECNICOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19920, 2, 6035809, '261005', 'CESANTIAS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19921, 2, 6035810, '261010', 'INTERESES SOBRE CESANTIAS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19922, 2, 6035811, '261015', 'VACACIONES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19923, 2, 6035812, '261020', 'PRIMA DE SERVICIOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19924, 2, 6035813, '261025', 'PRESTACIONES EXTRALEGALES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19925, 2, 6035814, '261030', 'VIATICOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19926, 2, 6035815, '261095', 'OTROS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19927, 2, 6035818, '270505', 'INTERESES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19928, 2, 6035819, '270510', 'COMISIONES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19929, 2, 6035820, '270515', 'ARRENDAMIENTOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19930, 2, 6035821, '270520', 'HONORARIOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19931, 2, 6035822, '270525', 'SERVICIOS TECNICOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19932, 2, 6035823, '270530', 'DE SUSCRIPTORES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19933, 2, 6035824, '270535', 'TRANSPOTES FLETES Y ACARREOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19934, 2, 6035825, '270540', 'MERCANCIA EN TRANSITO YA VENDIDA', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19935, 2, 6035826, '270545', 'MATRICULAS Y PENSIONES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19936, 2, 6035827, '270550', 'CUOTAS DE ADMINISTRACION', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19937, 2, 6035828, '270595', 'OTROS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19938, 2, 6035832, '280510', 'SOBRE CONTRATOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19939, 2, 6035833, '280515', 'PARA OBRAS EN PROCESO', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19940, 2, 6035834, '280595', 'OTROS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19941, 2, 6035836, '281005', 'PARA FUTURA SUSCRIPCION DE ACCIONES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19942, 2, 6035837, '281010', 'PARA FUTURO PAGO DE CUOTAS  ODERECHOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19943, 2, 6035838, '281015', 'PARA GARANTIA EN LA PRESTAC. SERVICIO', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19944, 2, 6035839, '281020', 'PARA GARANTIA DE CONTRATOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19945, 2, 6035840, '281025', 'DE LICITACIONES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19946, 2, 6035841, '281030', 'DE MANEJO DE BIENES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19947, 2, 6035842, '281035', 'FONDO DE RESERVA', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19948, 2, 6035843, '281040', 'PARA PAGO DE SERVICIOS COMPARTIDOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:44'),
(19949, 2, 6035844, '281095', 'OTROS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19950, 2, 6035847, '281510', 'VENTA POR CUENTA DE TERCEROS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19951, 2, 6035851, '313001', 'CAPITAL', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19952, 2, 6035854, '340505', 'DE CAPITAL SOCIAL', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19953, 2, 6035855, '340510', 'DE SUPERAVIT DE CAPITAL', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19954, 2, 6035856, '340520', 'DE RESULT. EJERCICIOS ANTERIORES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19955, 2, 6035859, '360505', 'RESULTADOS DEL PERIODO ACTUAL-EXCEDENTE', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19956, 2, 6035861, '361005', 'RESULTADOS DEL PERIODO ACTUAL- DEFICIT', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19957, 2, 6035864, '370501', 'RESULTADOS ACUMULADOS-EXCEDENTES', NULL, '2023-11-02 20:12:32', NULL, NULL),
(19958, 2, 6035865, '370505', 'RESULTADOS ACUMULADOS-DEFICIT', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19959, 2, 6035870, '41354405', 'PRODUCTOS NO GRAVADOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19960, 2, 6035871, '413550', 'VENTA DE REACTIVOS QUIMICOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19961, 2, 6035872, '413595', 'VENTA DE OTROS PRODUCTOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19962, 2, 6035875, '41701001', 'INGRESO DE INTERESES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19963, 2, 6035879, '421095', 'OTROS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19964, 2, 6035881, '422010', 'LOCALES COMERCIALES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19965, 2, 6035882, '422062', 'OTROS BIENES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19966, 2, 6035884, '425035', 'DE PROVISIONES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19967, 2, 6035885, '425050', 'REINTEGRO COSTOS Y GASTOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19968, 2, 6035886, '425060', 'CONSIGACIONES SIN IDENTIFICAR VIGENCIAS ANTERIORES  2014-2016', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19969, 2, 6035888, '425520', 'RECONOCIMIENTO POLIZA DE SEGURO', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19970, 2, 6035890, '429553', 'SOBRANTES DE CAJA', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19971, 2, 6035893, '470510', 'INVENTARIOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19972, 2, 6035894, '470515', 'PROPIEDADES, PLANTA Y EQUIPO', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19973, 2, 6035895, '470540', 'PATRIMONIO', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19974, 2, 6035896, '470565', 'INGRESOS OPERACIONALES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19975, 2, 6035897, '470575', 'GASTOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19976, 2, 6035898, '470590', 'COMPRAS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19977, 2, 6035902, '510503', 'SALARIO INTEGRAL', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19978, 2, 6035903, '510506', 'SUELDOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19979, 2, 6035904, '510512', 'JORNALES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19980, 2, 6035905, '510515', 'HORAS EXTRAS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19981, 2, 6035906, '510518', 'COMISIONES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19982, 2, 6035907, '510521', 'VIATICOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19983, 2, 6035908, '510524', 'INCAPACIDADES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19984, 2, 6035909, '510527', 'AUXILIO DE TRANSPORTE', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19985, 2, 6035910, '510530', 'CESANTIAS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19986, 2, 6035911, '510533', 'INTERESES SOBRE CESANTIAS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19987, 2, 6035912, '510536', 'PRIMA DE SERVICIOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19988, 2, 6035913, '510539', 'VACACIONES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19989, 2, 6035914, '510540', 'AGUINALDO', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19990, 2, 6035915, '510542', 'PRIMAS EXTRALEGALES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19991, 2, 6035916, '510545', 'AUXILIOS', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19992, 2, 6035917, '510548', 'BONIFICACIONES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19993, 2, 6035918, '510551', 'DOTACION Y SUMINISTRO A TRABAJADORES', NULL, '2023-11-02 20:12:32', NULL, '2023-12-01 22:22:45'),
(19994, 2, 6035919, '510554', 'SEGUROS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(19995, 2, 6035920, '510557', 'CU', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(19996, 2, 6035921, '510560', 'INDEMNIZACIONES LABORALES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(19997, 2, 6035922, '510563', 'CAPACITACION DE PERSONAL', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(19998, 2, 6035923, '510566', 'GASTOS DEPORTIVOS Y DE RECREACION', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(19999, 2, 6035924, '510568', 'APORTES A ADMINISTRADORAS ARP', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20000, 2, 6035925, '510569', 'APORTES A E.P.S', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20001, 2, 6035926, '510570', 'APORTES A FONDOS DE PENSIONES Y CESAN', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20002, 2, 6035927, '510572', 'APORTES CAJA DE COMPENSAC. FLIAR  4%', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20003, 2, 6035928, '510575', 'APORTES A ICBF 3%', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20004, 2, 6035929, '510578', 'APORTES AL SENA 2%', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20005, 2, 6035930, '510584', 'GASTOS MEDICOS Y DROGAS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20006, 2, 6035931, '510595', 'OTROS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20007, 2, 6035933, '511005', 'JUNTA DIRECTIVA', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20008, 2, 6035934, '511010', 'REVISORIA FISCAL', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20009, 2, 6035935, '511015', 'AUDITORIA EXTERNA', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20010, 2, 6035936, '511020', 'AVALUOS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20011, 2, 6035937, '511025', 'ASESORIA JURIDICA', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20012, 2, 6035938, '511030', 'ASESORIA FINANCIERA', NULL, '2023-11-02 20:12:33', NULL, NULL),
(20013, 2, 6035939, '511035', 'ASESORIA TECNICA', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20014, 2, 6035940, '511040', 'ASESORIA CONTABLE', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20015, 2, 6035941, '511095', 'OTROS-ADMINISTRACION', NULL, '2023-11-02 20:12:33', NULL, NULL),
(20016, 2, 6035943, '511505', 'INDUSTRIA Y COMERCIO', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20017, 2, 6035944, '511510', 'DE TIMBRES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20018, 2, 6035945, '511520', 'DERECHOS SOBRE INSTRUMENTOS PUBLICOS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20019, 2, 6035946, '511525', 'DE VALORIZACION', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20020, 2, 6035947, '511530', 'DE TURISMO', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20021, 2, 6035948, '511535', 'TASA POR UTILIZACION DE PUERTOS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20022, 2, 6035949, '511540', 'DE VEHICULOS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20023, 2, 6035950, '511545', 'DE ESPECTACULOS PUBLICOS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20024, 2, 6035951, '511550', 'CUOTAS DE FOEMNTO', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20025, 2, 6035952, '511570', 'IVA MAYOR VALOR DEL GASTO', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20026, 2, 6035953, '511595', 'OTROS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20027, 2, 6035955, '512010', 'CONSTRUCCIONES Y EDIFICACIONES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20028, 2, 6035957, '512095', 'OTROS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20029, 2, 6035959, '513005', 'MANEJO', NULL, '2023-11-02 20:12:33', NULL, NULL),
(20030, 2, 6035960, '513010', 'CUMPLIMIENTO', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20031, 2, 6035961, '513015', 'CORRIENTE DEBIL', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20032, 2, 6035962, '513020', 'DE VIDA COLECTIVO', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20033, 2, 6035963, '513025', 'INCENDIO', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20034, 2, 6035964, '513030', 'TERREMOTO', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20035, 2, 6035965, '513035', 'SUSTRACCION Y HURTO', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20036, 2, 6035966, '513095', 'POLIZA COPROPIEDAD', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20037, 2, 6035969, '51350505', 'ASEO', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20038, 2, 6035970, '51350510', 'VIGILANCIA', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20039, 2, 6035971, '513510', 'TEMPORALES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20040, 2, 6035976, '513550', 'TRANSPORTES FLETES Y ACARREOS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20041, 2, 6035978, '513595', 'OTROS-ADMINISTRACION', NULL, '2023-11-02 20:12:33', NULL, NULL),
(20042, 2, 6035980, '514005', 'NOTARIALES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20043, 2, 6035981, '514010', 'REGISTRO MERCANTIL', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20044, 2, 6035982, '514015', 'TRAMITES Y LICENCIAS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20045, 2, 6035983, '514020', 'ADUANEROS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20046, 2, 6035984, '514025', 'CONSULARES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20047, 2, 6035985, '514095', 'OTROS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20048, 2, 6035987, '514505', 'TERRENOS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20049, 2, 6035989, '514511', 'ALUMBRADO PUBLICO', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20050, 2, 6035991, '514513', 'HUMEDADES APARTAMENTOS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20051, 2, 6035993, '514520', 'EQUIPO DE OFICINA', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20052, 2, 6035995, '514530', 'EQUIPO MEDICO-CIENTIFICO', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20053, 2, 6035997, '515015', 'REPARACIONES LOCATIVAS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20054, 2, 6035999, '515505', 'ALOJAMIENTO Y MANUTENCION', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20055, 2, 6036000, '515510', 'PASAJES FLUVIALES Y/O MARITIMOS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20056, 2, 6036001, '515515', 'PASAJES AEREOS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20057, 2, 6036002, '515520', 'PASAJES TERRESTRES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20058, 2, 6036003, '515525', 'PASJES FERREOS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20059, 2, 6036004, '515595', 'OTROS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20060, 2, 6036006, '516005', 'CONSTRUCCIONES Y EDIFICACIONES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20061, 2, 6036007, '516010', 'MAQUINARIA Y EQUIPO', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20062, 2, 6036008, '516015', 'EQUIPO DE OFICINA', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20063, 2, 6036009, '516020', 'EQUIPO DE COMPUTACION Y COMUNICACION', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20064, 2, 6036010, '516065', 'ENVASES Y EMPAQUES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20065, 2, 6036012, '519505', 'COMISIONES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20066, 2, 6036013, '519510', 'LIBROS,SUSCRIPC, PERIODICOS, REVISTAS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20067, 2, 6036014, '519515', 'MUSICA AMBIENTAL', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20068, 2, 6036018, '51953005', 'UTILES Y PAPELERIA', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20069, 2, 6036019, '519535', 'COMBUSTIBLES Y LUBRICANTES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20070, 2, 6036020, '519540', 'ENVASES Y EMPAQUES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20071, 2, 6036021, '519545', 'TAXIS Y BUSES', NULL, '2023-11-02 20:12:33', NULL, NULL),
(20072, 2, 6036022, '519550', 'ESTAMPLILLAS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20073, 2, 6036023, '519555', 'MICROFILMACION', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20074, 2, 6036024, '519560', 'CASINO Y RESTAURANTE', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20075, 2, 6036025, '519565', 'PARQUEADEROS', NULL, '2023-11-02 20:12:33', NULL, NULL),
(20076, 2, 6036026, '519570', 'INDEMINIZACION POR DAÑOS A TERCEROS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20077, 2, 6036027, '519575', 'POLVORA SIMILARES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20078, 2, 6036028, '519580', 'FLETES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20079, 2, 6036029, '519585', 'CORRESPONDENCIA', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20080, 2, 6036035, '530520', 'INTERESES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20081, 2, 6036036, '530525', 'DIFERENCIA EN CAMBIO', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20082, 2, 6036037, '530530', 'GASTOS NEGOCIACION CERTIFICAC. CAMBIO', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20083, 2, 6036038, '530535', 'DESCUENTOS COMERCIALES CONCEDIDOS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20084, 2, 6036039, '530550', 'GRAVAMEN MVTOS FROS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20085, 2, 6036040, '530595', 'OTROS', NULL, '2023-11-02 20:12:33', NULL, NULL),
(20086, 2, 6036042, '531520', 'IMPUESTOS ASUMIDOS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20087, 2, 6036044, '539520', 'MULTAS, SANCIONES Y LITIGIOS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20088, 2, 6036045, '539525', 'DONACIONES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20089, 2, 6036046, '539595', 'OTROS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20090, 2, 6036050, '620505', 'MERCANCIAS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20091, 2, 6036051, '620520', 'NACIONALIZACION DE MERCANCIAS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20092, 2, 6036052, '620525', 'NACIONALIZACION DE MERCANCIAS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20093, 2, 6036053, '159505', 'EDIFICIOS', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20094, 2, 6036054, '11100501', 'BANCOLOMBIA', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20095, 2, 6036055, '11201001', 'BANCOLOMBIA', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20096, 2, 6036056, '51451005', 'ZONAS COMUNES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20097, 2, 6036057, '51451010', 'PRADOS Y JARDINES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20098, 2, 6036058, '51451015', 'PISCINA', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20099, 2, 6036059, '51451020', 'SALON SOCIAL', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20100, 2, 6036060, '51451025', ' PORTERIA', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20101, 2, 6036061, '51451505', 'ASCENSORES', NULL, '2023-11-02 20:12:33', NULL, '2023-12-01 22:22:45'),
(20102, 2, 6036062, '51451510', 'PUERTAS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20103, 2, 6036063, '51451515', 'BOMBAS E HIDROFLO', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20104, 2, 6036064, '51952005', 'EVENTOS ESPECIALES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20105, 2, 6036066, '51500505', 'ACCESORIOS ELECTRICOS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20106, 2, 6036067, '51500510', 'REPARACIONES ELECTRICAS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20107, 2, 6036069, '51959505', 'IMPREVISTOS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20108, 2, 6036072, '170520', 'SEGUROS Y FIANZAS', NULL, '2023-11-02 20:12:34', NULL, NULL),
(20109, 2, 6036074, '171025', 'VIDEO CAMARAS DE SEGURIDAD', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20110, 2, 6036075, '23651505', 'HONORARIOS 10%', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20111, 2, 6036076, '23651510', 'HONORARIOS 11%', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20112, 2, 6036077, '23652505', 'SERVICIOS 1%', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20113, 2, 6036078, '23652510', 'SERVICIOS TEMPORALES 2%', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20114, 2, 6036079, '23652515', 'SERVICIOS HOTELEROS 3.5%', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20115, 2, 6036080, '23652520', 'SERVICIOS GENERALES 4%', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20116, 2, 6036081, '23652525', 'SERVICIOS GRALES 6%', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20117, 2, 6156104, '41701005', 'ADMON APARTAMENTO', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20118, 2, 6036083, '531515', 'COSTOS Y GASTOS DE EJERC. ANTERIORES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20119, 2, 6036084, '51350515', 'FUMIGACION', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20120, 2, 6036085, '51350520', 'RECARGA DE EXTINTORES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20121, 2, 6036088, '26959505', 'PARA IMPREVISTOS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20122, 2, 6036089, '26959510', 'FONDO DE RECUPERACION PATRIMONIAL', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20123, 2, 6036091, '23653005', 'BIENES MUEBLES 4%', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20124, 2, 6036092, '23653010', 'BIENES INMUEBLES 3.5%', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20125, 2, 6036093, '11100502', 'BANCO AV VILLAS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20126, 2, 6036094, '11201002', 'Banco AV Villas', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20127, 2, 6036095, '171008', 'REMODELACIONES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20128, 2, 6036096, '51451030', 'TURCO', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20129, 2, 6036097, '421040', 'DESCUENTOS COMERCIALES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20130, 2, 6036098, '429533', 'MULTAS Y RECARGOS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20131, 2, 6036102, '83959524', 'MUEBLES Y ENSERES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20132, 2, 6036103, '83959526', 'DEPRECIACION MUEBLES Y ENSERES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20133, 2, 6036104, '83959528', 'EQUIPOS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20134, 2, 6036105, '83959530', 'DEPRECIACION EQUIPO OFICINA', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20135, 2, 6036106, '26959515', 'ASAMBLEA', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20136, 2, 6036107, '26959520', 'GASTOS NAVIDEâ•¤OS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20137, 2, 6036108, '26959525', 'EVENTOS SOCIALES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20138, 2, 6036109, '51959510', 'ARREGLOS NAVIDEÑOS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20139, 2, 6036110, '51952010', 'GASTOS ASAMBLEA', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20140, 2, 6036111, '513526', 'AGUA RESIDUAL', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20141, 2, 6036112, '51451009', 'BOMBAS Y SUMIDEROS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20142, 2, 6036113, '26959530', 'FONDO PARA LA RECUPERACION DE EQUIPOS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20143, 2, 6036114, '51959515', 'FONDO PARA LA RECUPERACION DE EQUIPOS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20144, 2, 6036115, '41701010', 'CUOTAS EXTRAS-USO EXPECIFICO', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20145, 2, 6036116, '51451012', 'LAVADA DE TANQUES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20146, 2, 6036119, '12450505', 'RESERVA LEY 675 - FIDUCUENTA INVERS. No. 1550', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20147, 2, 6036120, '12450510', 'RESERVA REPOSICION ACTIVOS - FIDUCUENTA INVERS. No. 1551', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20148, 2, 6036121, '26959535', 'FIESTA DE NIâ•¤OS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20149, 2, 6036122, '51952015', 'FIESTA DE NIÑOS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20150, 2, 6036595, '170550', 'FUMIGACIONES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20151, 2, 6036600, '51952020', 'BONIFICACION', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20152, 2, 6036601, '26959540', 'BONIFICACIONES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20153, 2, 6036602, '51952025', 'BONIFICACION CONSEJO ADMON', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20154, 2, 6036603, '26959545', 'BONIFICACION CONSEJO DE ADMON', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20155, 2, 6036605, '236905', 'RETENCION 0.3%', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20156, 2, 6036606, '236910', 'RETENCION 0.6%', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20157, 2, 6036607, '236915', 'RETENCION 1.5%', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20158, 2, 6036608, '51350511', 'IVA EN VIGILANCIA', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20159, 2, 6036609, '51952505', 'ELEMENTOS DE ASEO Y CAFETERIA', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20160, 2, 6036610, '51952510', 'IVA EN ELEMENTOS DE ASEO Y CAFETERIA ', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20161, 2, 6036611, '51952511', 'IVA EN ELEMENTOS DE ASEO Y CAFETERIA 5%', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20162, 2, 6036612, '51500509', 'IVA EN ACCESORIOS ELECTRICOS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20163, 2, 6036613, '51500519', 'IVA EN REPARACIONES ELECTRICAS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20164, 2, 6036614, '51451006', 'IVA EN ZONAS COMUNES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20165, 2, 6036615, '51451506', 'IVA EN ASCENSORES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20166, 2, 6036616, '51350506', 'IVA SERVICIO DE ASEO', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20167, 2, 6036617, '51452506', 'IVA CIRCUITO CERRADO DE TV', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20168, 2, 6036618, '514006', 'IVA EN NOTARIALES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20169, 2, 6036619, '513536', 'IVA EN TELEFONIA', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20170, 2, 6036620, '51451016', 'IVA EN PISCINA', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20171, 2, 6036621, '51350521', 'IVA EXTINTORES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20172, 2, 6036622, '51451026', 'IVA EN PORTERIA', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20173, 2, 6036623, '51451511', 'IVA EN MTTO PUERTAS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20174, 2, 6036624, '51452505', 'CIRCUITO CERRADO DE TV', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20175, 2, 6036625, '53050505', 'GASTOS BANCARIOS-CUOTA MANEJO', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20176, 2, 6036626, '53050506', 'IVA CUOTA DE MANEJO Y OTROS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20177, 2, 6036627, '53150505', 'COMISIONES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20178, 2, 6036629, '53051505', 'COMISIONES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:45'),
(20179, 2, 6036631, '53051506', 'IVA EN COMISIONES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20180, 2, 6036632, '51451516', 'IVA EN MTTO BOMBAS E HIDROFLO', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20181, 2, 6036633, '51953006', 'IVA EN UTILES Y PAPELERIA', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20182, 2, 6036634, '51451013', 'IVA EN LAVADA DE TANQUES', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20183, 2, 6036647, '51451031', 'IVA EN MTTO TURCO', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20184, 2, 6036648, '12450515', 'RESERVA OTROS FINES No. 2251', NULL, '2023-11-02 20:12:34', NULL, NULL),
(20185, 2, 6036649, '51959520', 'GORROS PARA PISCINA', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20186, 2, 6036650, '51959521', 'IVA DESCONTABLE', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20187, 2, 6036651, '133532', 'CONSIGNACIONES POR IDENTIFICAR', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20188, 2, 6037213, '51451007', 'FACHADA', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20189, 2, 6037214, '51451008', 'IVA FACHADA', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20190, 2, 6037220, '51350516', 'IVA FUMIGACION', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20191, 2, 6037778, '51952011', 'IVA GASTOS ASAMBLEA', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20192, 2, 6037784, '330510', 'FONDO PARA LA RECUPERACION DE EQUIPOS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20193, 2, 6038017, '530501', 'IVA DESCONTABLE 16%', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20194, 2, 6041651, '51053505', 'DESCUENTOS COMERCIALES CONCEDIDOS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20195, 2, 6041655, '33050501', 'FONDO DE IMPREVISTOS LEY  675 DE 2001', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20196, 2, 6041656, '33050502', 'USO DE RESERVA LEY 675 DE 2001', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20197, 2, 6041658, '33059505', 'FONDO PARA LA REPOSICION DE  ACTIVOS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20198, 2, 6041659, '33059510', 'ASIGNACIONES DE ASAMBLEA', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20199, 2, 6041722, '42100505', 'RENDIMIENTOS FINANCIEROS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20200, 2, 6041723, '42100510', 'INTERESES DE MORA', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20201, 2, 6041724, '23654005', 'COMPRAS 2.5%', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20202, 2, 6041725, '23654010', 'COMPRAS 3.5%', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20203, 2, 6041726, '51451035', 'PARQUEADEROS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20204, 2, 6041727, '51451036', 'IVA PARQUEADEROS', NULL, '2023-11-02 20:12:34', NULL, '2023-12-01 22:22:46'),
(20205, 2, 6041755, '51451520', 'EQUIPO DE GYM', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20206, 2, 6041756, '51451521', 'IVA MTTO EQUIPO DE GYM', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20207, 2, 6041757, '28150515', 'CUOTA EXTRA FACHADA', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20208, 2, 6041824, '380505', 'ACCIONES', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20209, 2, 6041825, '39050501', 'DEUDORES', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20210, 2, 6041827, '39050503', 'PROPIEDAD PLANTA Y EQUIPO', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20211, 2, 6041830, '133531', 'FONDO DE IMPREVISTOS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20212, 2, 6041831, '41701002', 'FONDO DE IMPREVISTOS LEY 675', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20213, 2, 6042902, '13050505', 'ADMON APARTAMENTO', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20214, 2, 6042903, '13050510', 'CONSIGNACIONES POR IDENTIFICAR pasar a la 2', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20215, 2, 6042907, '16254005', 'POLIZA SEGURO COPROPIEDAD', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20216, 2, 6042910, '16982505', 'POLIZA COPROPIEDAD', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20217, 2, 6043535, '51452507', 'SEGURIDAD PERIMETRAL', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20218, 2, 6043536, '51452508', 'IVA SEGURIDAD PERIMETRAL', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20219, 2, 6043537, '51451205', 'TUBERIAS DE AGUAS NEGRAS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20220, 2, 6043538, '51451206', 'IVA  TUBERIAS DE AGUAS NEGRAS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20221, 2, 6046051, '511045', 'ADMINISTRACION', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20222, 2, 6046052, '51451011', 'IVA JARDINERIA', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20223, 2, 6046125, '51952006', 'IVA EVENTOS ESPECIALES', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20224, 2, 6046133, '370502', 'EJECUCION EXCEDENTES ACUMULADOS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20225, 2, 6046152, '26300510', 'PARA CIRCUITO CERRADO DE TV', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20226, 2, 6046154, '26301010', 'PARA CIRCUITO CERRADO DE TV', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20227, 2, 6046173, '28050505', 'CUOTAS DE ADMON COPROPIETARIOS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20228, 2, 6046188, '51352005', 'SERVICIO FACTURACION', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20229, 2, 6046189, '51352505', 'ACUEDUCTO', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20230, 2, 6046190, '51352506', 'ALCANTARILLADO', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20231, 2, 6046191, '51352507', 'AGUA RESIDUAL', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20232, 2, 6046192, '51352508', 'SANEAMIENTO', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20233, 2, 6046193, '51353005', 'ENERGIA ELECTRICA', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20234, 2, 6046194, '51353505', 'TELEFONIA', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20235, 2, 6046195, '51353506', 'IVA TELEFONIA', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20236, 2, 6046205, '51501005', 'DOTACION Y HERRAMIENTAS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20237, 2, 6046206, '51501006', 'IVA DOTACION Y HERRAMIENTAS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20238, 2, 6046221, '51206005', 'REDES DE GAS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20239, 2, 6046222, '51206006', 'IVA REDES DE GAS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20240, 2, 6046224, '51451405', 'REDES DE GAS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20241, 2, 6046225, '51451406', 'IVA REDES DE GAS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20242, 2, 6046236, '51453505', 'DOTACION PLAN DE EMERGENCIAS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20243, 2, 6046237, '51453506', 'IVA DOTACION PLAN DE EMERGENCIAS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20244, 2, 6046246, '51355505', 'GAS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20245, 2, 6075138, '28150520', 'CUOTA EXTRA MANTENIMIENTOS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20246, 2, 6075199, '33059506', 'USO FONDO PARA LA REPOSICION DE  ACTIVOS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20247, 2, 6075219, '51959511', 'IVA ARREGLOS NAVIDEÑOS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20248, 2, 6075259, '511021', 'IVA AVALUOS 19%', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20249, 2, 6075284, '12250505', 'CERTIFICADO DEPOSITO A TERMINO', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20250, 2, 6075301, '12250510', 'INVERSION VIRTUAL 27601418966', NULL, '2023-11-02 20:12:35', NULL, NULL),
(20251, 2, 6075302, '12250515', 'INVERSION VIRTUAL 27601215338', NULL, '2023-11-02 20:12:35', NULL, NULL),
(20252, 2, 6075303, '12250520', 'INVERSION VIRTUAL 27601215320', NULL, '2023-11-02 20:12:35', NULL, NULL),
(20253, 2, 6075305, '511026', 'IVA ASESORIA JURIDICA ', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20254, 2, 6075320, '13451005', 'RENDIMIENTOS FINANCIEROS', NULL, '2023-11-02 20:12:35', NULL, '2023-12-01 22:22:46'),
(20255, 2, 6075322, '12250525', 'INVERSION VIRTUAL 27601625963', NULL, '2023-11-02 20:12:35', NULL, NULL),
(21135, 2, 6156005, '13050501', 'INTERESES', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21136, 2, 6156006, '110501', 'CAJA MENOR', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21137, 2, 6156007, '11201003', 'COBELEN', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21138, 2, 6156008, '11201004', 'AHORRO PROGRAMADO', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21139, 2, 6156009, '12250501', 'CDT1', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21140, 2, 6156010, '12250502', 'CDT2', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21141, 2, 6156011, '12250506', 'CTD3', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21142, 2, 6156012, '28150501', 'CUOTA EXTRA OBRA 2018', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21143, 2, 6156014, '28151505', 'PENDIENTE', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21144, 2, 6156016, '37050101', 'PENDIENTE', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21145, 2, 6156017, '28150505', 'CUOTA EXTRA OBRA 2019', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46');
INSERT INTO `erp_maestras` (`id`, `tipo`, `id_erp`, `codigo`, `nombre`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(21146, 2, 6156019, '11201505', 'ORGANISMOS COOPERATIVOS FINANCIEROS', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21147, 2, 6156029, '13300505', 'A PROVEEDORES', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21148, 2, 6156032, '15240505', 'MUEBLES Y ENSERES', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21149, 2, 6156035, '15280505', 'EQUIPO DE PROCESAMIENTO DE DATOS', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21150, 2, 6156037, '15281005', 'EQUIPO DE TELECOMUNICACIONES', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21151, 2, 6156040, '15921505', 'EQUIPO DE OFICINA', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21152, 2, 6156042, '15922005', 'EQUIPO DE COMPUTACIÓN Y COMUNICACIÓN', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21153, 2, 6156046, '17052005', 'SEGUROS Y FIANZAS', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21154, 2, 6156051, '23352515', 'HONORARIOS', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21155, 2, 6156053, '23359505', 'OTROS', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21156, 2, 6156056, '23652502', 'SERVICIOS', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21157, 2, 6156057, '23652503', 'SERVICIOS ASEO Y VIG. 2%', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21158, 2, 6156058, '23652504', 'RET. SERVICIOS 4%', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21159, 2, 6156069, '33050505', 'PENDIENTE', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21160, 2, 6156071, '36100101', 'PÉRDIDA DEL EJERCICIO  ** 1 A LA 98 **', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21161, 2, 6156072, '42100501', 'INTERESES', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21162, 2, 6156073, '42100502', 'INTERESES BANCARIOS CTAS  AHORRO', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21163, 2, 6156075, '42959505', 'OTROS', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21164, 2, 6156076, '42959510', 'AJUSTES AL PESO', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21165, 2, 6156077, '51103005', 'ASESORÍA FINANCIERA', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21166, 2, 6156078, '51103006', 'HONORARIOS ASESORÍA FINANCIERA', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21167, 2, 6156079, '51109501', 'OTROS', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21168, 2, 6156080, '51300505', 'MANEJO', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21169, 2, 6156081, '51350598', 'SERVICIO ASEO', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21170, 2, 6156082, '51353598', 'TELÉFONO', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21171, 2, 6156083, '51359520', 'OTROS', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21172, 2, 6156084, '51359525', 'SERVICIO DE FUMIGACION', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21173, 2, 6156085, '51451001', 'CONSTRUCCIONES Y EDIFICACIONES', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21174, 2, 6156086, '51451002', 'ARREGLO DE CANOAS, BAJANTES Y TECHOS', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21175, 2, 6156087, '51451003', 'MTTO. MOTOBOMBAS', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21176, 2, 6156088, '51451098', 'MTTO.PUERTAS DE ACCESO VEHICULAR Y PEATONAL', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21177, 2, 6156089, '51451598', 'MTTO. ASCENSORES', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21178, 2, 6156090, '51954505', 'TAXIS Y BUSES', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21179, 2, 6156091, '51956505', 'PARQUEADEROS', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21180, 2, 6156092, '51959540', 'COMPRAS MENORES DE MATERIALES', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21181, 2, 6156093, '51959545', 'GASTOS ASAMBLEA COPROPIETARIOS', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21182, 2, 6156094, '51959550', 'GASTOS EVENTOS ESPECIALES Y CONVIVENCIA', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21183, 2, 6156095, '51959595', 'REFRIGERIO CONSEJO', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21184, 2, 6156098, '51991005', 'DEUDORES', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21185, 2, 6156099, '53059505', 'OTROS', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21186, 2, 6156100, '53059510', 'G.M.F.', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21187, 2, 6156101, '53059515', 'RETENCION FUENTE ASUMIDAD', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21188, 2, 6156102, '13050506', 'ADMON CUARTO UTIL', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(21189, 2, 6156103, '13050507', 'ADMON PARQUEADERO', NULL, '2023-11-09 17:07:00', NULL, '2023-12-01 22:22:46'),
(22156, 2, 6156105, '41701006', 'ADMON CUARTO UTIL', NULL, '2023-11-09 17:32:14', NULL, '2023-12-01 22:22:46'),
(22157, 2, 6156106, '41701007', 'ADMON PARQUEADERO', NULL, '2023-11-09 17:32:14', NULL, '2023-12-01 22:22:46'),
(24098, 2, 6156107, '42959515', 'PENDIENTE', NULL, '2023-11-17 18:05:59', NULL, '2023-12-01 22:22:46'),
(24099, 2, 6156108, '28150510', 'PENDIENTE ERROR', NULL, '2023-11-17 18:05:59', NULL, '2023-12-01 22:22:46');

-- --------------------------------------------------------

--
-- Table structure for table `facturas`
--

CREATE TABLE `facturas` (
  `id` int NOT NULL,
  `id_persona` int NOT NULL,
  `id_inmueble` int DEFAULT NULL,
  `consecutivo` varchar(20) DEFAULT NULL,
  `valor_total` varchar(150) NOT NULL,
  `estado` tinyint DEFAULT '1' COMMENT '0 - ANULADA, 1 - REGISTRADA',
  `total_abonos` varchar(250) DEFAULT NULL,
  `saldo_anterior` varchar(100) DEFAULT NULL,
  `token_erp` varchar(150) NOT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `facturas`
--

INSERT INTO `facturas` (`id`, `id_persona`, `id_inmueble`, `consecutivo`, `valor_total`, `estado`, `total_abonos`, `saldo_anterior`, `token_erp`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(8884, 52, NULL, '163', '195400', 1, NULL, '0', '6751f613a86fa9ce79d48030890c9fa2a0fe3608b372d42eaebf8c8974cd958e', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8885, 57, NULL, '173', '180600', 1, NULL, '0', 'a0911c9d4d754f462c19a99d2264f07d1a7dcc387972041a761212cecb48247d', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8886, 62, NULL, '176', '180600', 1, NULL, '0', '026c3938407c8e4006b60f5244793c4fda2b52484aa5e8c341179412a18df918', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8887, 64, NULL, '175', '292399', 1, NULL, '0', '7f10546623e55e5ef328bbfdc5dad69b9b9d187efb84f5e22e89f03a31321ad5', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8888, 63, NULL, '174', '225428', 1, NULL, '0', '5aefd8c8f31d67addda2830b704f0b6faf5dbb659261460f9523d8f3ca2505bb', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8889, 65, NULL, '177', '300400', 1, NULL, '0', '465eef52b4bb4db71d9af0a7d23d85e52434095e3ac1454b70fdb6caefcb9e88', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8890, 66, NULL, '182', '240000', 1, NULL, '0', '12408e28749d3873f6004943ec99dea7049e75e68748a5674a372c1abaebd67c', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8891, 81, NULL, '192', '218715', 1, NULL, '0', 'e6c13dab4bcbd59e1ae9a3daf29b2c4f467a9e693dc1e39b0db16a3e20e0991d', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8892, 61, NULL, '172', '180600', 1, NULL, '0', '2d2a8168251b637220485d8fb294ce682571c6356d701b36d0505216cb2a67d7', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8893, 96, NULL, '209', '44700', 1, NULL, '0', '62acb552cf12a9655dfe7b13a7f3ae1cc03ec4866af57bc25103c2fc4144af8b', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8894, 54, NULL, '168', '240000', 1, NULL, '0', 'a53ce9424fab72359349fdd75ce714495dca3c982c40752ea5b79100da246cd2', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8895, 69, NULL, '180', '219479', 1, NULL, '0', '7f4b048facb02d62053a6e07f2118c65329da0dcb48e68cceff249a3153e509c', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8896, 70, NULL, '181', '257228', 1, NULL, '0', '9ab4edbb17a3ec14029545c9f203ebc0ed7028c2db07b2d729df483553221988', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8897, 94, NULL, '211', '36600', 1, NULL, '0', '9f3d6ed349dc9452948a733cf6434897a4ff4316b409b3a7467616b524cbb5b7', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8898, 67, NULL, '178', '220500', 1, NULL, '0', 'bbc58df6ab45f4e3faea84b1557683f17c59610d655d7f7b3bb78d65ffe20af2', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8899, 75, NULL, '186', '224170', 1, NULL, '0', 'd3e25fa4b6efe709016be4d04a831809080697e01b37ab3ef231221a4458b8a9', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8900, 56, NULL, '164', '233185', 1, NULL, '0', 'b659e16c9b9495620d315f39b0f2f7db75fd46f55f4ce8fbeb5bc1ca105ae5ce', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8901, 68, NULL, '179', '180600', 1, NULL, '0', 'ac299032c5ca09661e6578db8b8a9c906461f6e6ec0ba1248a30e6782f2db5d3', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8902, 58, NULL, '165', '289128', 1, NULL, '0', '7aa4a9c235baf69c4430a4c04d0416c906abc5a319c2bee722151ccfef555031', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8903, 98, NULL, '208', '215971', 1, NULL, '0', '7cef2e43550196734bd48625b0a812ca4ff9e4067d45f4913126a4b8f2bb458b', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8904, 55, NULL, '170', '241385', 1, NULL, '0', '89bbfb2a7610cd3ca2af9e700d33873c6c67aac0ec20a7371dcb6e79fcc6acad', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8905, 76, NULL, '167', '676676', 1, NULL, '0', 'e9c9e72dcd28a6cb0a8606bd2a7a34bb3dd6c90e35b91513a1b37be5da7b1a52', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8906, 74, NULL, '188', '180600', 1, NULL, '0', '4665c0934788b172e2b3b35899edb2fedccc6b3441b1b71ddb944317120691a5', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8907, 73, NULL, '185', '215013', 1, NULL, '0', 'bfb0b87333a66bf973a38fe8312b658ba5524dba9c60830d2a800ac3984da030', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8908, 71, NULL, '183', '265328', 1, NULL, '0', '37b9c6d0db50d09d326a33e7c267416b5e6facac38201fe4b0ee9d1dad538337', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8909, 72, NULL, '184', '285800', 1, NULL, '0', '4b0e959a37cbd5bc9c3f23264f3a866497782cb7534dd6be0b5252c7f83ccf5e', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8910, 77, NULL, '187', '305028', 1, NULL, '0', '9b78edf81371ca0dd519c1d4934a1f346d8b97aec2ecb11ba50af704e70288de', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8911, 59, NULL, '169', '305043', 1, NULL, '0', '05709e024cf5fe42ac63bfa88dd2aeb4312457d0c736ceb9bc9abbb1ad4750fc', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8912, 78, NULL, '189', '279899', 1, NULL, '0', '6ed996ecc1472df9d63aedf5736f650f9f0c09e8a88bd9c1e337c557756f3c82', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8913, 80, NULL, '191', '221500', 1, NULL, '0', '9d79d5391b2f2c0eb55b4317a04934f7a72d831bf80a469f4c5272e807fea5ae', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8914, 79, NULL, '190', '190814', 1, NULL, '0', '4f4b3b69641e8cad61f5e3581f0d612a086e262c52f01b406d0c73356603352b', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8915, 60, NULL, '171', '284628', 1, NULL, '0', '6dee53b14ffb84ab9bf5841f05ca1503a5fc15c26e698aa93355c30a9ba90d12', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8916, 91, NULL, '201', '365728', 1, NULL, '0', '5fa549740ad025fa9d92facc56a215869270d767a61a0de4fd9dea8833005003', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8917, 82, NULL, '193', '297028', 1, NULL, '0', 'b56afeed34b4753efc60f8fe5b031768e545e52dfa6b006c7dcae5ace106bdc9', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8918, 99, NULL, '206', '43128', 1, NULL, '0', '3ca6cc12633fb775687fda2ae3d31da72119a66b1962064d002a4167f91aed21', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8919, 95, NULL, '213', '38900', 1, NULL, '0', 'a06e95a1e084d366888a5ff72e0b7242f550b03722a64c8eca2f8aceed6e145f', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8920, 93, NULL, '212', '16734', 1, NULL, '0', 'cf58dda81ee0e43bf9feda010300b9fef7fb801d63a933e6f73ab7e3567908c5', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8921, 84, NULL, '195', '507500', 1, NULL, '0', '27d73c786618dead087177893110e61d30d82f6a63b8311dbd663b3b09072a45', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8922, 108, NULL, '214', '549772', 1, NULL, '0', '4280e761690ece03f5dec58fc93e784f869061bac581a039b2fb9e1c250c52e7', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8923, 88, NULL, '198', '284585', 1, NULL, '0', '72b8a0643a097268fd5fa9d22877f9bbf24059feccfb4d24e7d8ec730d10e4a4', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8924, 83, NULL, '194', '304985', 1, NULL, '0', '96c1270f6bc668ba36ec44e226343616526a5f0cf42e71344282c7a5e0b69e5a', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8925, 86, NULL, '197', '199000', 1, NULL, '0', '8956aec43a7fb4459ea5174d11aa71a10b6dea0c9819513870b8fa91f731cc68', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8926, 97, NULL, '207', '38900', 1, NULL, '0', 'f064412a680cc6162a725043a2d14364f0c5eea328c7942cbffe7deae9647a56', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8927, 92, NULL, '202', '337128', 1, NULL, '0', '3f7c6b7ac4ea5c3f9c3a9e909d91ca8c345a0f36071d7366ac919e764e3afc59', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8928, 87, NULL, '199', '292399', 1, NULL, '0', 'f8218e16413d9037225c8b8b49f6978703a3acada6076b849f12f8e9c6a65094', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8929, 90, NULL, '200', '242070', 1, NULL, '0', '625a789a18d533541a4ec9c160db73b25daa90c2e0f9aaa4e671b8e855ba424d', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8930, 85, NULL, '196', '199000', 1, NULL, '0', '5cb72e91a41e21d90b7775665ea8022980b4fed84ac1fa1c2261fb73100c3508', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8931, 53, NULL, '166', '320462', 1, NULL, '1738076', '24bd6189def35ea8d4bf2cc0f1ddf1619cdbbc13859f81ef1638fb50a8d3bffa', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8932, 101, NULL, '205', '259285', 1, NULL, '0', 'ece46cad13c1b1bf2c61526a0e49e5bdb7d9b8f0f7412df5dd1e98f4d882aded', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8933, 89, NULL, '203', '245542', 1, NULL, '0', 'ae0176b2b9e76c09563a0405b5f0b5ec9ca88867c85778141504efa980cfcf1e', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8934, 109, NULL, '216', '50329', 1, NULL, '0', 'eafd223857aa14a2c71038a5aac4ee01b921a249d931d17ec55f8b9988444ab8', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8935, 110, NULL, '215', '298300', 1, NULL, '0', '0c5d9d8cce9f8fd31564162ec41f42e6a5bfb503c63f865641b31d0f1710bf39', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8936, 100, NULL, '210', '42699', 1, NULL, '0', '9ca34921ac3c856523a1f27675e1a850125207b0f3377de04d58ec7c087e7811', NULL, '2023-01-01 00:00:00', NULL, NULL),
(8937, 102, NULL, '204', '258228', 1, NULL, '0', '540db2f88fd37ea3d7fc88a91f8b75c922bfb41a1075fc09376e233e13c8b79c', NULL, '2023-01-01 00:00:00', NULL, NULL),
(9312, 52, NULL, '345', '211000', 1, NULL, '0', '94854333ed10e808d3665c85c8c0a602d33af40e25cfb54325327dfd35998d23', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9313, 61, NULL, '355', '214816', 1, NULL, '990802', '340db1f4a1c14a6798843faaf5ab41f333e1ab9856c239b28da07b095366d549', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9314, 62, NULL, '356', '195000', 1, NULL, '0', '444156408df47dccad2cb17456e4a68155bc77863727c8cf341ca7ebb183f29e', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9315, 110, NULL, '349', '322164', 1, NULL, '0', '20ecc83c8dc599a1734716fe2c511a7b8d11ea96eaceba478e5cbacd54635a24', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9316, 58, NULL, '350', '312200', 1, NULL, '0', '8bb6a4ed3b51a4ce48fcf7c32e4727ec7ecd49202f6e48716c01df4bb7e30488', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9317, 54, NULL, '351', '260432', 1, NULL, '61615', '10620839114b2ab31bb7e31123e8b72fa1d6facd51454db6e5f6f0a7375a2f88', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9318, 64, NULL, '358', '315799', 1, NULL, '0', '5a856ac1066da2b2bf081e74673217cda117b2cb70f7acc5d994a7b6d505d7b9', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9319, 79, NULL, '373', '210222', 1, NULL, '206100', '8d262b7b8690c846a64fdd6d475bafbb8b74851022ca79e37d8dad3619fc105e', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9320, 67, NULL, '361', '238101', 1, NULL, '0', 'dee5a3babba3b48ea6a82649f4794623a722cbe48fbcd632bcb34c7b586581ea', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9321, 100, NULL, '389', '45700', 1, NULL, '0', '3a3526586afb15092610a5dd5bbc36969e0bebcb15c980cea6c527c7e6f862eb', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9322, 96, NULL, '393', '48300', 1, NULL, '0', '80a7564a2c0dc3e644637e9f645847f45e91f127b521586dc91d5fbf8310a7f1', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9323, 81, NULL, '375', '235901', 1, NULL, '0', '80741e19700952433e6cca85f8cf13cb252ffb87db30fcd124ea5a5ce2aa177d', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9324, 57, NULL, '352', '195000', 1, NULL, '0', 'efb564f89f4fbd04da0cde4eb3121a38989cdd19b8cbf84b463900343115cea2', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9325, 63, NULL, '357', '243400', 1, NULL, '0', '6e8612f79451c709601f03a584c965271e292da5692aa4a49a77661d77e23e10', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9326, 56, NULL, '348', '251701', 1, NULL, '0', '754452a95ad71abf347877a22f55e3ec37c563c3ce98a854f7ea3aec1088cdaa', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9327, 72, NULL, '366', '311047', 1, NULL, '0', '1ba6e44feaa25fe6aab04d1a510b10781722ea6c1cc7cf325cabbbf253684958', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9328, 90, NULL, '383', '288035', 1, NULL, '1331690', 'c6455a404fbcaa0acf8cc0eaea0bed515fb6016d6afc89921537cb49f76e8afb', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9329, 53, NULL, '347', '412127', 1, NULL, '5176326', '9f1e522d28953b4acbb5025c6e35c5d00b034ff4db58736fa8aa5cbc094477bd', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9330, 94, NULL, '396', '40471', 1, NULL, '43494', '72390b2c1ae3b27ac047bd364563675e212b6af1c9dd7754c408d8e75e3d5d8d', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9331, 60, NULL, '354', '308337', 1, NULL, '46800', 'af789b6828ffc91c9e37eb9c7b2aaf55e972e1626cb6d637c5a37a7d6390b4e2', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9332, 66, NULL, '360', '259200', 1, NULL, '0', '3af2e075d4a04cf0b7e29256a1f935012c2d69c1da088f26ab4c93a8b723836c', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9333, 70, NULL, '364', '292296', 1, NULL, '724787', '9f8ceb26cb4d5954a78d6fc563c82276edc700826322c00c8a3b67feede54b54', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9334, 65, NULL, '359', '324400', 1, NULL, '0', '599e901f124e9217f68ba401e776e1802847ad6908cb432b39ac918d4147e407', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9335, 71, NULL, '365', '286500', 1, NULL, '0', '367e126eb9fd84c9d383f0f1f9771eba9e01e790c13d4745de311778d67d1414', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9336, 82, NULL, '376', '320800', 1, NULL, '0', '5f6f01aea943b6259de3bd00b38bb9572f42aff610f6ab47e6cb5528092586de', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9337, 68, NULL, '362', '195000', 1, NULL, '0', 'eb4ae0f5cfb5e806e06a3a1498758e85b6fe99c00bc8177ad72d25c2f5305f7b', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9338, 75, NULL, '369', '246755', 1, NULL, '237700', '7e67cee360bdf92a6c9952f6ba4ed6bf59f0379b5076d8d3144bd69db23e3752', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9339, 77, NULL, '371', '329694', 1, NULL, '14700', '954d9525b9e4a1a6c72cc22eb61a75fcccb9fbed42e68207ac874f7bb46f2d28', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9340, 73, NULL, '367', '232200', 1, NULL, '0', 'cb628b90b0f4965c7bb90ef41d57d7cfef0a8ec827f6277dfd320027f23cc144', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9341, 98, NULL, '368', '233280', 1, NULL, '0', '81e9dd56b4514e53be40f651f240c3ffcbc40fb6764b9a8db71475b0fdfc777f', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9342, 55, NULL, '346', '260600', 1, NULL, '0', 'f0374481f769f761ab505aca41a5d35304a552184069842ff69be29b0fd383ae', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9343, 69, NULL, '363', '237201', 1, NULL, '0', 'd31658cc3276f53b62433d7405c8bc431cc21fe41b7a2197552ff87b977ba9ee', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9344, 80, NULL, '374', '239199', 1, NULL, '0', '8d3f584463497821a92e986c22da3c11f098335d3a11a402160cff17f377c7bd', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9345, 83, NULL, '377', '329400', 1, NULL, '0', '8ca43efc44bc38f7e1dda2c3ce2fd0072ac0fd65fa0cc4748a2385bb35788a8b', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9346, 76, NULL, '370', '314749', 1, NULL, '0', '0c5ce0c68dca516fa8233d3902bf6b5af463e578904545f922af011c6dcd5ea2', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9347, 88, NULL, '382', '307400', 1, NULL, '0', '8780dd9dbc85e8aa327208eb63bcb810b9fd8175e11d02129d210d16bece4ccb', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9348, 101, NULL, '388', '279901', 1, NULL, '0', '831c53ceced0e45ec77cbb385c550a9457b8cead01ea33d90a7b9079fe9a8203', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9349, 84, NULL, '379', '259200', 1, NULL, '0', '6c9d60ff00422d39127b0e1e96ecc90e0fbc444005cb7dc3e63c5bac29a4741f', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9350, 59, NULL, '353', '329400', 1, NULL, '0', 'e4697624acee73748546128d8cc36fc5696bc5efb29c1fb915ac05e755c873bf', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9351, 91, NULL, '384', '401743', 1, NULL, '337104', 'fc47081f3a532d287e1bec873f3a6376a25aa8ee5dc5128a2e29308ba7a3c68c', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9352, 78, NULL, '372', '302300', 1, NULL, '0', '5f30c3d9b70a936f218de0187acc28da5b7ddcf48c1086573c0f027de6a3a752', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9353, 93, NULL, '397', '11100', 1, NULL, '0', '1e1c2497d46b126129ca618cd44678f1dce2ef9ae3d68077cacfbae66621e5f0', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9354, 109, NULL, '391', '53000', 1, NULL, '0', 'a3d76752bb06530910aecdbe77aa6fb93af56393f7b0f7e5498724fc31163bd6', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9355, 87, NULL, '381', '315799', 1, NULL, '0', 'fdc216307b75ce84c0b925d56da891489759923617ff4654aca6e96ec8b10d50', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9356, 89, NULL, '386', '265100', 1, NULL, '0', '4657bfbee997608665b24e7d9d8937a1181fab5143f44d73b76e6e1e02f1eb7b', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9357, 99, NULL, '390', '46501', 1, NULL, '0', 'b2eaf2742e294b6cbc91d99fb23f29eb6af053c69cc089e92fa985b48096c2c1', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9358, 97, NULL, '392', '46972', 1, NULL, '248624', 'e17476facdb800808af25c3f5b70bda5c782b3a6421dbb61de91ca13cb773626', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9359, 102, NULL, '387', '278901', 1, NULL, '0', '5627fcbf3caa97fbcac01ae6eb6dbfe82415761ae35cddcbfa24ce20749afcae', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9360, 92, NULL, '385', '364101', 1, NULL, '0', 'ca20a2fc1582f01654f07c30cd9fcc13bb440424621d22ea2324045c24041973', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9361, 86, NULL, '380', '214899', 1, NULL, '0', '87c77194cffb53da290f3f1d99282ed07f2170f8e48c975f329444cb4f047daf', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9362, 85, NULL, '378', '214899', 1, NULL, '0', '7fa166ff5e499b1275cf0afe8be2d59ffc77cc098c7d242d29bc8edd5c067b9f', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9363, 108, NULL, '395', '39500', 1, NULL, '0', '97ef50f77d3dc0875c8e36be7fad19a9dc92a9ed87a479b7b7e4a5b04e6a25fc', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9364, 95, NULL, '394', '42637', 1, NULL, '31840', 'bde4305eb7eba6047eaa259f9fe29a3b9510797356f974df388e3887add66223', NULL, '2023-10-01 00:00:00', NULL, NULL),
(9577, 110, NULL, '614', '322200', 1, NULL, '0', 'd93b0988ace23212be48a15656298c8c0129eaf3054314e528275f59d65b0c1b', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9578, 71, NULL, '630', '286500', 1, NULL, '0', '4e9e007e0cc686d974db5422a271d90d5ffd65c48da2eb42ed4ffc22291b2b67', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9579, 56, NULL, '613', '251700', 1, NULL, '0', 'da48fac110a92db8b31cc4712b36ff5b08203a60a0fa022c773622d92da2f3f4', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9580, 63, NULL, '622', '243400', 1, NULL, '0', 'e33d895881d9eb7c07e699263cde2e56f657977cc52259470d405cd5ab8d40a8', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9581, 97, NULL, '657', '42000', 1, NULL, '0', 'a159d8a4d00cffb0a3435d500f979e852374417d4687ed2cbfd1043177c77fd2', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9582, 69, NULL, '628', '237200', 1, NULL, '0', '4137f0aba9430ad07a8b902156eb3602f0a456037dd22240c0b6bad731726351', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9583, 76, NULL, '635', '314700', 1, NULL, '0', '193fd1a49a1e16df4591825aa8f8e40525f686a9d50bd8bfb8063e3bf5fe380c', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9584, 66, NULL, '625', '259200', 1, NULL, '0', '35006bed151cb0f951a1228ef9175d61590b73082fa6a5e2e2364991df677ea3', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9585, 61, NULL, '620', '219263', 1, NULL, '1213166', '3aaa093e7cd7d49aaa73e9dc03c5bd3d9328345067db80c10604d2e78dcb0da8', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9586, 109, NULL, '656', '53000', 1, NULL, '0', 'bd497851b008c96e4b6a8d378d0ee1692773bac653364db4295afde514fc0660', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9587, 60, NULL, '619', '307400', 1, NULL, '0', '8295f7134b2150f19a5cc261fbef64706092a3525ae5c2168124a8eeeb39e649', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9588, 87, NULL, '646', '315800', 1, NULL, '0', '54570e432dfac92dad7e826b6c4cb2f267cf1dd8f3be281944cfdea018bb64c6', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9589, 79, NULL, '638', '206100', 1, NULL, '0', '457330d0b6efc2d5b30d98362827b64ca96e1fd5f689bf44e239654280eeae43', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9590, 83, NULL, '642', '329400', 1, NULL, '0', '4ffd35abed0ce7b44147ddcf6dfb788c7fee6a1c3865e2c681b90039aa0e83fb', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9591, 67, NULL, '626', '238100', 1, NULL, '0', '33c5ac63f0fb5cb232a11b96100b24b49466a67b931f21607ee108c2ac2fd8c3', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9592, 102, NULL, '652', '278900', 1, NULL, '0', '56d15f8c046c8af38a66b5a5dc5fc067a8cbc18e8e9a447f28c46233e1049fb3', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9593, 59, NULL, '618', '329400', 1, NULL, '0', '7e79b00fad4eb12164a42c2226d259390f7b0770ec818680d1d0c199f75d8972', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9594, 55, NULL, '611', '260600', 1, NULL, '0', '4e9a1f19e4d6f016399555a24a3b644c57b597b05a2f4a7f5f4540eae3cb55fc', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9595, 72, NULL, '631', '308600', 1, NULL, '0', '57eebe8e4e443a7356e7efdbe9e9dfb41bc8abc0fb051724f2c9513961d1ae71', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9596, 70, NULL, '629', '296542', 1, NULL, '937115', '5603cb898ddd855dc15aba43ab97df8affdd4bd0d0b4e11178652380e58b9160', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9597, 98, NULL, '633', '237840', 1, NULL, '42000', 'c04432a60c43de30760c79081f3bd7a027bd1a37ede49c7121fcae9b4dec3d98', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9598, 52, NULL, '610', '211000', 1, NULL, '0', '371b81f6f12f88f3270819ee0e30ea20a3b86ed1aa51e171e13b0ce7e3f5e0ec', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9599, 90, NULL, '648', '261400', 1, NULL, '0', '65af991e121ccd5de833ca00a39dcf5ffaf2b41a0bfefa864cb54dbbd1187db6', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9600, 53, NULL, '612', '421772', 1, NULL, '5658622', '5a02c2476b0439963f2a2586e89d3cb933023a22d8171b7f1291b1886c5d643f', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9601, 73, NULL, '632', '232200', 1, NULL, '0', 'd4a49b48ac83e28230813032d1465c031cc877d978d69a85e41aeac5b50d1b1a', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9602, 82, NULL, '641', '320800', 1, NULL, '0', '44c7437379e6276b5ecbe9230466cb5b1e486d9400661f892b4b3f0e5a8bbbdd', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9603, 64, NULL, '623', '315800', 1, NULL, '0', '6ead0de30b8f72144ff69637c6cd475a61d5116c9affa657038f7f6e76616def', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9604, 75, NULL, '634', '242000', 1, NULL, '0', '1f918dac11bb708ecdb276a28a524ebeb106758ee028d78af8ce7d89986c0cf9', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9605, 92, NULL, '650', '364100', 1, NULL, '0', '6c22fe1e93355d0793e9fde5828e2ea0b3c572a4b86aba430c178ac456ad3fc0', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9606, 99, NULL, '655', '46500', 1, NULL, '0', '85c49083953fe1486b3bd2e2565f44650028c109497f52425109ba728dc7daaf', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9607, 84, NULL, '644', '259200', 1, NULL, '0', '4af30b4173f694116d0b4c8dc267a8686d761437dfc14fb61b903a4bdfd0848f', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9608, 81, NULL, '640', '235900', 1, NULL, '0', '37014fb150ffa9bf0a0279783f4c0e01a9eb4ad9dd61b98b3c176408bb1ca63d', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9609, 58, NULL, '615', '312200', 1, NULL, '0', '6268a3d885c09b5f28169c7adf987e8f03ef6fd308a8ed6a43715321d557dc68', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9610, 101, NULL, '653', '279900', 1, NULL, '0', 'e34523f4415dcf92ef6b336b1045b879de4158e3d4fc7c7ed899ed186eb0c8e6', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9611, 57, NULL, '617', '195000', 1, NULL, '0', '167df2e45230a2149706b4136327e3f2886dbd86442bc432f69e69b5d7ea9b1a', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9612, 93, NULL, '662', '11100', 1, NULL, '0', '3dc49ae04fe617127b9bf54218a6e876a61bc0f43bd5fd6a42998678ea856ba6', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9613, 96, NULL, '658', '48300', 1, NULL, '0', '22a9387340f78fef48762e2e9adf3a106f0f32eeb7660b958e89e71888d1b896', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9614, 88, NULL, '647', '307400', 1, NULL, '0', 'ae8dc4e872b861a64a7c097a13a8e80ea6e3d90046dfbcb395590df9753d5651', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9615, 78, NULL, '637', '302300', 1, NULL, '0', '6820abc3b04c75005ddb95c13d7e65072c1fa0ef223df74f704a4ccc2625bd54', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9616, 95, NULL, '659', '42000', 1, NULL, '0', 'cab70f9c812f121be27465e35ffb19b8ce42bbd18098ab5cad864b789b79fb22', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9617, 77, NULL, '636', '329400', 1, NULL, '0', '9e870fa255a54634a265e8d5798b36b9f116dbb2b25917ff086dec17ef4c527e', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9618, 86, NULL, '645', '214900', 1, NULL, '0', '35a75d90e8b384f2e90a10ae3f00a79791eb5e2c2d60b2b0fea779bb00fd97f5', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9619, 89, NULL, '651', '265100', 1, NULL, '0', 'd9a48b7365b6b839a773053617f171d47a228796de4bdabb836243b0d134728f', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9620, 85, NULL, '643', '214900', 1, NULL, '0', '30bfeee6a45aac7fe4ed5d5352cfd2ca1bf503123a846b93f278c64a8822aeaf', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9621, 68, NULL, '627', '195000', 1, NULL, '0', 'bfdee12d5e0c2b310a9d36f43494c2a91772809dc9f2cab9e2e927871a012023', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9622, 100, NULL, '654', '45700', 1, NULL, '0', 'f003279bbe244b88e3f022e8ec99b787364d986a36fadd7c390ccf5791e12370', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9623, 94, NULL, '661', '47006', 1, NULL, '0', '7723f8a40e8b4621a82623faaeb4a4b2de6bbcdb5a0126a5ac8e93c0a980331e', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9624, 62, NULL, '621', '195000', 1, NULL, '0', 'a751113cfff4dd0e7b4b8cba5038075bb49df4d7ec1b32dec9f1dd809b54f3f4', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9625, 108, NULL, '660', '39500', 1, NULL, '0', '8935fa19edd14337f79b87a2a788c7d5465ef8e6f536fab80253d0fea34fb98b', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9626, 80, NULL, '639', '239200', 1, NULL, '0', 'e5dfc69fe263f699c8905c37108ceb76ca871ee0a6f5cf2c33d85868f8211578', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9627, 65, NULL, '624', '324400', 1, NULL, '0', '1d0afd50b3c30e6734b8d00d62b814ad723f5d4bbe401bb2229d00cfd8058081', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9628, 54, NULL, '616', '265953', 1, NULL, '337659', '4e5baf4b766e6c5828eeeca352728acf4bcf72984fded27ca86f40f92f1613a5', NULL, '2023-11-01 00:00:00', NULL, NULL),
(9629, 91, NULL, '649', '395000', 1, NULL, '0', 'a4eed6d91d30fbb8ea8b95579172b9bd078b64b3bfc180b7e07d1d8349164785', NULL, '2023-11-01 00:00:00', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `facturas_ciclica`
--

CREATE TABLE `facturas_ciclica` (
  `id` int NOT NULL,
  `id_inmueble` int NOT NULL,
  `id_persona` int DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `valor_total` varchar(150) NOT NULL,
  `observacion` text,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `facturas_ciclica`
--

INSERT INTO `facturas_ciclica` (`id`, `id_inmueble`, `id_persona`, `fecha_inicio`, `fecha_fin`, `valor_total`, `observacion`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(8713, 27, 110, '2023-11-23', NULL, '281448', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8714, 133, 100, '2023-11-23', NULL, '4938', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8715, 28, 110, '2023-11-23', NULL, '34596', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8716, 29, 110, '2023-11-23', NULL, '6156', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8717, 30, 54, '2023-11-23', NULL, '259200', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8719, 26, 53, '2023-11-23', NULL, '308600', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8720, 130, 101, '2023-11-23', NULL, '41967', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8721, 132, 100, '2023-11-23', NULL, '40762', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8722, 131, 101, '2023-11-23', NULL, '7405', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8723, 134, 99, '2023-11-23', NULL, '41563', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8724, 31, 55, '2023-11-23', NULL, '211227', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8725, 137, 109, '2023-11-23', NULL, '12343', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8726, 32, 56, '2023-11-23', NULL, '210968', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8727, 33, 57, '2023-11-23', NULL, '195000', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8728, 34, 55, '2023-11-23', NULL, '41967', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8729, 35, 56, '2023-11-23', NULL, '33327', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8730, 36, 55, '2023-11-23', NULL, '7406', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8731, 37, 56, '2023-11-23', NULL, '7405', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8732, 38, 58, '2023-11-23', NULL, '272702', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8733, 39, 58, '2023-11-23', NULL, '33327', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8734, 40, 58, '2023-11-23', NULL, '6171', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8735, 41, 59, '2023-11-23', NULL, '281262', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8736, 42, 59, '2023-11-23', NULL, '40732', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8737, 43, 59, '2023-11-23', NULL, '7406', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8738, 44, 60, '2023-11-23', NULL, '259263', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8739, 47, 61, '2023-11-23', NULL, '195000', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8740, 48, 60, '2023-11-23', NULL, '7406', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8741, 52, 63, '2023-11-23', NULL, '195264', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8742, 49, 60, '2023-11-23', NULL, '40731', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8743, 53, 63, '2023-11-23', NULL, '40730', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8744, 57, 64, '2023-11-23', NULL, '4945', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8745, 60, 65, '2023-11-23', NULL, '6171', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8746, 61, 66, '2023-11-23', NULL, '259200', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8747, 62, 67, '2023-11-23', NULL, '193842', NULL, 24, '2023-11-23 18:08:03', NULL, '2023-11-27 03:34:16'),
(8748, 63, 67, '2023-11-23', NULL, '35796', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8749, 64, 67, '2023-11-23', NULL, '7405', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8750, 65, 68, '2023-11-23', NULL, '195000', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8751, 66, 69, '2023-11-23', NULL, '195234', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8752, 67, 69, '2023-11-23', NULL, '37029', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8753, 68, 69, '2023-11-23', NULL, '4937', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8754, 69, 70, '2023-11-23', NULL, '272862', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8755, 71, 71, '2023-11-23', NULL, '281562', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8756, 73, 72, '2023-11-23', NULL, '256758', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8757, 76, 73, '2023-11-23', NULL, '195170', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8759, 80, 75, '2023-11-23', NULL, '195095', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8760, 82, 75, '2023-11-23', NULL, '4938', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8761, 83, 76, '2023-11-23', NULL, '272782', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8762, 85, 77, '2023-11-23', NULL, '281262', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8763, 87, 77, '2023-11-23', NULL, '7406', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8764, 88, 78, '2023-11-23', NULL, '259098', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8765, 89, 78, '2023-11-23', NULL, '35796', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8766, 90, 78, '2023-11-23', NULL, '7406', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8767, 92, 79, '2023-11-23', NULL, '11109', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8768, 93, 80, '2023-11-23', NULL, '196000', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8769, 95, 80, '2023-11-23', NULL, '6171', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8770, 96, 81, '2023-11-23', NULL, '195168', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8771, 97, 81, '2023-11-23', NULL, '33327', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8772, 99, 82, '2023-11-23', NULL, '272662', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8773, 100, 82, '2023-11-23', NULL, '40732', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8774, 102, 83, '2023-11-23', NULL, '281262', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8775, 106, 85, '2023-11-23', NULL, '214900', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8776, 107, 86, '2023-11-23', NULL, '214900', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8777, 135, 99, '2023-11-23', NULL, '4937', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8778, 118, 91, '2023-11-23', NULL, '7406', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8779, 136, 109, '2023-11-23', NULL, '40657', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8780, 138, 97, '2023-11-23', NULL, '42000', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8781, 139, 98, '2023-11-23', NULL, '42000', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8782, 140, 96, '2023-11-23', NULL, '48300', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8783, 141, 95, '2023-11-23', NULL, '42000', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8784, 142, 108, '2023-11-23', NULL, '39500', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8785, 143, 94, '2023-11-23', NULL, '39600', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8786, 144, 94, '2023-11-23', NULL, '7406', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8787, 145, 93, '2023-11-23', NULL, '11100', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8788, 146, 72, '2023-11-23', NULL, '44436', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8789, 113, 90, '2023-11-23', NULL, '214496', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8790, 50, 62, '2023-11-23', NULL, '195000', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8791, 125, 89, '2023-11-23', NULL, '7406', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8792, 101, 82, '2023-11-23', NULL, '7406', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8793, 121, 92, '2023-11-23', NULL, '7405', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8794, 103, 83, '2023-11-23', NULL, '40732', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8795, 116, 91, '2023-11-23', NULL, '346863', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8796, 54, 63, '2023-11-23', NULL, '7406', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8797, 104, 83, '2023-11-23', NULL, '7406', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8798, 105, 84, '2023-11-23', NULL, '259200', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8799, 55, 64, '2023-11-23', NULL, '272591', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8800, 108, 87, '2023-11-23', NULL, '281239', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8801, 86, 77, '2023-11-23', NULL, '40732', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8802, 70, 70, '2023-11-23', NULL, '4938', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8803, 81, 75, '2023-11-23', NULL, '41967', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8804, 84, 76, '2023-11-23', NULL, '41918', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8805, 94, 80, '2023-11-23', NULL, '37029', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8806, 98, 81, '2023-11-23', NULL, '7405', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8807, 74, 71, '2023-11-23', NULL, '4938', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8808, 110, 87, '2023-11-23', NULL, '34561', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8809, 128, 102, '2023-11-23', NULL, '7405', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8810, 111, 88, '2023-11-23', NULL, '37029', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8811, 75, 72, '2023-11-23', NULL, '7406', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8812, 114, 90, '2023-11-23', NULL, '41967', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8813, 77, 73, '2023-11-23', NULL, '32092', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8814, 56, 64, '2023-11-23', NULL, '38264', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8815, 58, 65, '2023-11-23', NULL, '281200', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8816, 78, 73, '2023-11-23', NULL, '4938', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8817, 91, 79, '2023-11-23', NULL, '194991', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8818, 124, 89, '2023-11-23', NULL, '43201', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8819, 59, 65, '2023-11-23', NULL, '37029', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8820, 129, 101, '2023-11-23', NULL, '230528', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8821, 119, 92, '2023-11-23', NULL, '315963', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8822, 109, 88, '2023-11-23', NULL, '258028', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8823, 126, 102, '2023-11-23', NULL, '230763', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8824, 127, 102, '2023-11-23', NULL, '40732', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8825, 115, 90, '2023-11-23', NULL, '4937', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8826, 117, 91, '2023-11-23', NULL, '40731', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8827, 123, 89, '2023-11-23', NULL, '214493', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8828, 120, 92, '2023-11-23', NULL, '40732', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8829, 122, 88, '2023-11-23', NULL, '12343', NULL, 24, '2023-11-23 18:08:03', NULL, '0000-00-00 00:00:00'),
(8830, 79, 74, '2023-11-24', NULL, '195000', NULL, 25, '2023-11-24 15:42:51', NULL, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `factura_ciclica_detalles`
--

CREATE TABLE `factura_ciclica_detalles` (
  `id` int NOT NULL,
  `id_factura_ciclica` int NOT NULL,
  `id_concepto_factura` int NOT NULL,
  `cantidad` int NOT NULL DEFAULT '1',
  `valor_unitario` varchar(150) NOT NULL DEFAULT '0',
  `total` varchar(150) NOT NULL DEFAULT '0',
  `descripcion` text,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factura_ciclica_detalles`
--

INSERT INTO `factura_ciclica_detalles` (`id`, `id_factura_ciclica`, `id_concepto_factura`, `cantidad`, `valor_unitario`, `total`, `descripcion`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(8707, 8718, 1, 1, '211000', '211000', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8708, 8719, 1, 1, '308600', '308600', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8709, 8713, 1, 1, '281448', '281448', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8710, 8720, 13, 1, '41967', '41967', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8711, 8714, 14, 1, '4938', '4938', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8712, 8721, 13, 1, '40762', '40762', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8713, 8722, 14, 1, '7405', '7405', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8714, 8723, 13, 1, '41563', '41563', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8715, 8725, 14, 1, '12343', '12343', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8716, 8715, 13, 1, '34596', '34596', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8717, 8716, 14, 1, '6156', '6156', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8718, 8717, 1, 1, '259200', '259200', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8719, 8724, 1, 1, '211227', '211227', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8720, 8726, 1, 1, '210968', '210968', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8721, 8727, 1, 1, '195000', '195000', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8722, 8729, 13, 1, '33327', '33327', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8723, 8728, 13, 1, '41967', '41967', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8724, 8730, 14, 1, '7406', '7406', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8725, 8731, 14, 1, '7405', '7405', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8726, 8733, 13, 1, '33327', '33327', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8727, 8732, 1, 1, '272702', '272702', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8728, 8734, 14, 1, '6171', '6171', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8729, 8735, 1, 1, '281262', '281262', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8730, 8736, 13, 1, '40732', '40732', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8731, 8737, 14, 1, '7406', '7406', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8732, 8738, 1, 1, '259263', '259263', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8733, 8740, 14, 1, '7406', '7406', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8734, 8741, 1, 1, '195264', '195264', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8735, 8742, 13, 1, '40731', '40731', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8736, 8739, 1, 1, '195000', '195000', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8737, 8745, 14, 1, '6171', '6171', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8738, 8744, 14, 1, '4945', '4945', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8739, 8743, 13, 1, '40730', '40730', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8740, 8746, 1, 1, '259200', '259200', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8741, 8747, 1, 1, '193842', '193842', NULL, 24, '2023-11-23 18:08:03', 24, '2023-11-27 03:34:16'),
(8742, 8748, 13, 1, '35796', '35796', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8743, 8749, 14, 1, '7405', '7405', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8744, 8750, 1, 1, '195000', '195000', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8745, 8763, 14, 1, '7406', '7406', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8746, 8764, 1, 1, '259098', '259098', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8747, 8765, 13, 1, '35796', '35796', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8748, 8766, 14, 1, '7406', '7406', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8749, 8767, 14, 1, '11109', '11109', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8750, 8751, 1, 1, '195234', '195234', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8751, 8754, 1, 1, '272862', '272862', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8752, 8756, 1, 1, '256758', '256758', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8753, 8759, 1, 1, '195095', '195095', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8754, 8757, 1, 1, '195170', '195170', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8755, 8762, 1, 1, '281262', '281262', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8756, 8760, 14, 1, '4938', '4938', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8757, 8755, 1, 1, '281562', '281562', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8758, 8752, 13, 1, '37029', '37029', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8759, 8753, 14, 1, '4937', '4937', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8760, 8761, 1, 1, '272782', '272782', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8761, 8758, 1, 1, '195000', '195000', NULL, 24, '2023-11-23 18:08:03', 25, '2023-11-24 15:42:51'),
(8762, 8795, 1, 1, '346863', '346863', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8763, 8796, 14, 1, '7406', '7406', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8764, 8768, 1, 1, '196000', '196000', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8765, 8779, 13, 1, '40657', '40657', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8766, 8777, 14, 1, '4937', '4937', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8767, 8770, 1, 1, '195168', '195168', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8768, 8782, 13, 1, '48300', '48300', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8769, 8772, 1, 1, '272662', '272662', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8770, 8784, 13, 1, '39500', '39500', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8771, 8788, 13, 1, '44436', '44436', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8772, 8781, 13, 1, '42000', '42000', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8773, 8775, 1, 1, '214900', '214900', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8774, 8774, 1, 1, '281262', '281262', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8775, 8783, 13, 1, '42000', '42000', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8776, 8769, 14, 1, '6171', '6171', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8777, 8771, 13, 1, '33327', '33327', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8778, 8776, 1, 1, '214900', '214900', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8779, 8786, 14, 1, '7406', '7406', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8780, 8773, 13, 1, '40732', '40732', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8781, 8778, 14, 1, '7406', '7406', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8782, 8780, 13, 1, '42000', '42000', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8783, 8787, 14, 1, '11100', '11100', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8784, 8785, 13, 1, '39600', '39600', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8785, 8790, 1, 1, '195000', '195000', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8786, 8792, 14, 1, '7406', '7406', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8787, 8791, 14, 1, '7406', '7406', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8788, 8793, 14, 1, '7405', '7405', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8789, 8789, 1, 1, '214496', '214496', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8790, 8794, 13, 1, '40732', '40732', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8791, 8819, 13, 1, '37029', '37029', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8792, 8800, 1, 1, '281239', '281239', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8793, 8797, 14, 1, '7406', '7406', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8794, 8798, 1, 1, '259200', '259200', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8795, 8801, 13, 1, '40732', '40732', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8796, 8799, 1, 1, '272591', '272591', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8797, 8811, 14, 1, '7406', '7406', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8798, 8813, 13, 1, '32092', '32092', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8799, 8802, 14, 1, '4938', '4938', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8800, 8809, 14, 1, '7405', '7405', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8801, 8812, 13, 1, '41967', '41967', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8802, 8814, 13, 1, '38264', '38264', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8803, 8816, 14, 1, '4938', '4938', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8804, 8815, 1, 1, '281200', '281200', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8805, 8810, 13, 1, '37029', '37029', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8806, 8806, 14, 1, '7405', '7405', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8807, 8805, 13, 1, '37029', '37029', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8808, 8804, 13, 1, '41918', '41918', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8809, 8807, 14, 1, '4938', '4938', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8810, 8808, 13, 1, '34561', '34561', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8811, 8803, 13, 1, '41967', '41967', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8812, 8817, 1, 1, '194991', '194991', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8813, 8818, 13, 1, '43201', '43201', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8814, 8822, 1, 1, '258028', '258028', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8815, 8824, 13, 1, '40732', '40732', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8816, 8821, 1, 1, '315963', '315963', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8817, 8820, 1, 1, '230528', '230528', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8818, 8825, 14, 1, '4937', '4937', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8819, 8827, 1, 1, '214493', '214493', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8820, 8829, 14, 1, '12343', '12343', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8821, 8828, 13, 1, '40732', '40732', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8822, 8823, 1, 1, '230763', '230763', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8823, 8826, 13, 1, '40731', '40731', NULL, 24, '2023-11-23 18:08:03', NULL, NULL),
(8824, 8830, 1, 1, '195000', '195000', NULL, 25, '2023-11-24 15:42:51', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `factura_ciclica_historial`
--

CREATE TABLE `factura_ciclica_historial` (
  `id` int NOT NULL,
  `valor_total` varchar(150) NOT NULL,
  `estado` int DEFAULT '1' COMMENT '0 - ANULADO, 1 - GENERADO',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factura_ciclica_historial`
--

INSERT INTO `factura_ciclica_historial` (`id`, `valor_total`, `estado`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(168, '12819119', 1, 25, '2023-01-01 00:00:00', NULL, '2023-11-02 22:32:04'),
(176, '12534380', 1, 24, '2023-10-01 00:00:00', NULL, '2023-11-10 13:38:01'),
(181, '12517776', 1, 24, '2023-11-01 00:00:00', NULL, '2023-11-22 20:15:15');

-- --------------------------------------------------------

--
-- Table structure for table `factura_ciclica_historial_detalle`
--

CREATE TABLE `factura_ciclica_historial_detalle` (
  `id` int NOT NULL,
  `id_factura_ciclica` int NOT NULL,
  `id_factura` int NOT NULL,
  `total` varchar(150) NOT NULL DEFAULT '0',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factura_ciclica_historial_detalle`
--

INSERT INTO `factura_ciclica_historial_detalle` (`id`, `id_factura_ciclica`, `id_factura`, `total`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(8407, 168, 8884, '195400', 25, '2023-11-02 22:32:03', NULL, NULL),
(8408, 168, 8885, '180600', 25, '2023-11-02 22:32:03', NULL, NULL),
(8409, 168, 8886, '180600', 25, '2023-11-02 22:32:03', NULL, NULL),
(8410, 168, 8887, '292399', 25, '2023-11-02 22:32:03', NULL, NULL),
(8411, 168, 8888, '225428', 25, '2023-11-02 22:32:03', NULL, NULL),
(8412, 168, 8889, '300400', 25, '2023-11-02 22:32:03', NULL, NULL),
(8413, 168, 8890, '240000', 25, '2023-11-02 22:32:03', NULL, NULL),
(8414, 168, 8892, '180600', 25, '2023-11-02 22:32:03', NULL, NULL),
(8415, 168, 8893, '44700', 25, '2023-11-02 22:32:03', NULL, NULL),
(8416, 168, 8894, '240000', 25, '2023-11-02 22:32:03', NULL, NULL),
(8417, 168, 8895, '219479', 25, '2023-11-02 22:32:03', NULL, NULL),
(8418, 168, 8896, '257228', 25, '2023-11-02 22:32:03', NULL, NULL),
(8419, 168, 8897, '36600', 25, '2023-11-02 22:32:03', NULL, NULL),
(8420, 168, 8900, '233185', 25, '2023-11-02 22:32:03', NULL, NULL),
(8421, 168, 8901, '180600', 25, '2023-11-02 22:32:03', NULL, NULL),
(8422, 168, 8899, '224170', 25, '2023-11-02 22:32:03', NULL, NULL),
(8423, 168, 8902, '289128', 25, '2023-11-02 22:32:03', NULL, NULL),
(8424, 168, 8903, '215971', 25, '2023-11-02 22:32:03', NULL, NULL),
(8425, 168, 8898, '220500', 25, '2023-11-02 22:32:03', NULL, NULL),
(8426, 168, 8891, '218715', 25, '2023-11-02 22:32:03', NULL, NULL),
(8427, 168, 8904, '241385', 25, '2023-11-02 22:32:03', NULL, NULL),
(8428, 168, 8905, '676676', 25, '2023-11-02 22:32:03', NULL, NULL),
(8429, 168, 8906, '180600', 25, '2023-11-02 22:32:03', NULL, NULL),
(8430, 168, 8907, '215013', 25, '2023-11-02 22:32:03', NULL, NULL),
(8431, 168, 8908, '265328', 25, '2023-11-02 22:32:03', NULL, NULL),
(8432, 168, 8909, '285800', 25, '2023-11-02 22:32:03', NULL, NULL),
(8433, 168, 8910, '305028', 25, '2023-11-02 22:32:03', NULL, NULL),
(8434, 168, 8911, '305043', 25, '2023-11-02 22:32:03', NULL, NULL),
(8435, 168, 8912, '279899', 25, '2023-11-02 22:32:03', NULL, NULL),
(8436, 168, 8913, '221500', 25, '2023-11-02 22:32:03', NULL, NULL),
(8437, 168, 8914, '190814', 25, '2023-11-02 22:32:03', NULL, NULL),
(8438, 168, 8915, '284628', 25, '2023-11-02 22:32:03', NULL, NULL),
(8439, 168, 8916, '365728', 25, '2023-11-02 22:32:03', NULL, NULL),
(8440, 168, 8917, '297028', 25, '2023-11-02 22:32:03', NULL, NULL),
(8441, 168, 8918, '43128', 25, '2023-11-02 22:32:03', NULL, NULL),
(8442, 168, 8919, '38900', 25, '2023-11-02 22:32:03', NULL, NULL),
(8443, 168, 8920, '16734', 25, '2023-11-02 22:32:04', NULL, NULL),
(8444, 168, 8921, '507500', 25, '2023-11-02 22:32:04', NULL, NULL),
(8445, 168, 8922, '549772', 25, '2023-11-02 22:32:04', NULL, NULL),
(8446, 168, 8923, '284585', 25, '2023-11-02 22:32:04', NULL, NULL),
(8447, 168, 8924, '304985', 25, '2023-11-02 22:32:04', NULL, NULL),
(8448, 168, 8925, '199000', 25, '2023-11-02 22:32:04', NULL, NULL),
(8449, 168, 8926, '38900', 25, '2023-11-02 22:32:04', NULL, NULL),
(8450, 168, 8927, '337128', 25, '2023-11-02 22:32:04', NULL, NULL),
(8451, 168, 8928, '292399', 25, '2023-11-02 22:32:04', NULL, NULL),
(8452, 168, 8929, '242070', 25, '2023-11-02 22:32:04', NULL, NULL),
(8453, 168, 8930, '199000', 25, '2023-11-02 22:32:04', NULL, NULL),
(8454, 168, 8931, '320462', 25, '2023-11-02 22:32:04', NULL, NULL),
(8455, 168, 8932, '259285', 25, '2023-11-02 22:32:04', NULL, NULL),
(8456, 168, 8933, '245542', 25, '2023-11-02 22:32:04', NULL, NULL),
(8457, 168, 8934, '50329', 25, '2023-11-02 22:32:04', NULL, NULL),
(8458, 168, 8937, '258228', 25, '2023-11-02 22:32:04', NULL, NULL),
(8459, 168, 8935, '298300', 25, '2023-11-02 22:32:04', NULL, NULL),
(8460, 168, 8936, '42699', 25, '2023-11-02 22:32:04', NULL, NULL),
(8835, 176, 9312, '211000', 24, '2023-11-10 13:38:01', NULL, NULL),
(8836, 176, 9313, '214816', 24, '2023-11-10 13:38:01', NULL, NULL),
(8837, 176, 9314, '195000', 24, '2023-11-10 13:38:01', NULL, NULL),
(8838, 176, 9315, '322164', 24, '2023-11-10 13:38:01', NULL, NULL),
(8839, 176, 9316, '312200', 24, '2023-11-10 13:38:01', NULL, NULL),
(8840, 176, 9317, '260432', 24, '2023-11-10 13:38:01', NULL, NULL),
(8841, 176, 9318, '315799', 24, '2023-11-10 13:38:01', NULL, NULL),
(8842, 176, 9319, '210222', 24, '2023-11-10 13:38:01', NULL, NULL),
(8843, 176, 9321, '45700', 24, '2023-11-10 13:38:01', NULL, NULL),
(8844, 176, 9322, '48300', 24, '2023-11-10 13:38:01', NULL, NULL),
(8845, 176, 9324, '195000', 24, '2023-11-10 13:38:01', NULL, NULL),
(8846, 176, 9325, '243400', 24, '2023-11-10 13:38:01', NULL, NULL),
(8847, 176, 9326, '251701', 24, '2023-11-10 13:38:01', NULL, NULL),
(8848, 176, 9327, '311047', 24, '2023-11-10 13:38:01', NULL, NULL),
(8849, 176, 9328, '288035', 24, '2023-11-10 13:38:01', NULL, NULL),
(8850, 176, 9329, '412127', 24, '2023-11-10 13:38:01', NULL, NULL),
(8851, 176, 9330, '40471', 24, '2023-11-10 13:38:01', NULL, NULL),
(8852, 176, 9331, '308337', 24, '2023-11-10 13:38:01', NULL, NULL),
(8853, 176, 9320, '238101', 24, '2023-11-10 13:38:01', NULL, NULL),
(8854, 176, 9323, '235901', 24, '2023-11-10 13:38:01', NULL, NULL),
(8855, 176, 9332, '259200', 24, '2023-11-10 13:38:01', NULL, NULL),
(8856, 176, 9333, '292296', 24, '2023-11-10 13:38:01', NULL, NULL),
(8857, 176, 9334, '324400', 24, '2023-11-10 13:38:01', NULL, NULL),
(8858, 176, 9335, '286500', 24, '2023-11-10 13:38:01', NULL, NULL),
(8859, 176, 9336, '320800', 24, '2023-11-10 13:38:01', NULL, NULL),
(8860, 176, 9337, '195000', 24, '2023-11-10 13:38:01', NULL, NULL),
(8861, 176, 9338, '246755', 24, '2023-11-10 13:38:01', NULL, NULL),
(8862, 176, 9339, '329694', 24, '2023-11-10 13:38:01', NULL, NULL),
(8863, 176, 9340, '232200', 24, '2023-11-10 13:38:01', NULL, NULL),
(8864, 176, 9341, '233280', 24, '2023-11-10 13:38:01', NULL, NULL),
(8865, 176, 9342, '260600', 24, '2023-11-10 13:38:01', NULL, NULL),
(8866, 176, 9343, '237201', 24, '2023-11-10 13:38:01', NULL, NULL),
(8867, 176, 9344, '239199', 24, '2023-11-10 13:38:01', NULL, NULL),
(8868, 176, 9345, '329400', 24, '2023-11-10 13:38:01', NULL, NULL),
(8869, 176, 9346, '314749', 24, '2023-11-10 13:38:01', NULL, NULL),
(8870, 176, 9348, '279901', 24, '2023-11-10 13:38:01', NULL, NULL),
(8871, 176, 9347, '307400', 24, '2023-11-10 13:38:01', NULL, NULL),
(8872, 176, 9349, '259200', 24, '2023-11-10 13:38:01', NULL, NULL),
(8873, 176, 9350, '329400', 24, '2023-11-10 13:38:01', NULL, NULL),
(8874, 176, 9351, '401743', 24, '2023-11-10 13:38:01', NULL, NULL),
(8875, 176, 9352, '302300', 24, '2023-11-10 13:38:01', NULL, NULL),
(8876, 176, 9353, '11100', 24, '2023-11-10 13:38:01', NULL, NULL),
(8877, 176, 9354, '53000', 24, '2023-11-10 13:38:01', NULL, NULL),
(8878, 176, 9355, '315799', 24, '2023-11-10 13:38:01', NULL, NULL),
(8879, 176, 9356, '265100', 24, '2023-11-10 13:38:01', NULL, NULL),
(8880, 176, 9357, '46501', 24, '2023-11-10 13:38:01', NULL, NULL),
(8881, 176, 9358, '46972', 24, '2023-11-10 13:38:01', NULL, NULL),
(8882, 176, 9359, '278901', 24, '2023-11-10 13:38:01', NULL, NULL),
(8883, 176, 9360, '364101', 24, '2023-11-10 13:38:01', NULL, NULL),
(8884, 176, 9361, '214899', 24, '2023-11-10 13:38:01', NULL, NULL),
(8885, 176, 9363, '39500', 24, '2023-11-10 13:38:01', NULL, NULL),
(8886, 176, 9364, '42637', 24, '2023-11-10 13:38:01', NULL, NULL),
(8887, 176, 9362, '214899', 24, '2023-11-10 13:38:01', NULL, NULL),
(9100, 181, 9577, '322200', 24, '2023-11-22 20:15:15', NULL, NULL),
(9101, 181, 9578, '286500', 24, '2023-11-22 20:15:15', NULL, NULL),
(9102, 181, 9579, '251700', 24, '2023-11-22 20:15:15', NULL, NULL),
(9103, 181, 9580, '243400', 24, '2023-11-22 20:15:15', NULL, NULL),
(9104, 181, 9581, '42000', 24, '2023-11-22 20:15:15', NULL, NULL),
(9105, 181, 9582, '237200', 24, '2023-11-22 20:15:15', NULL, NULL),
(9106, 181, 9583, '314700', 24, '2023-11-22 20:15:15', NULL, NULL),
(9107, 181, 9584, '259200', 24, '2023-11-22 20:15:15', NULL, NULL),
(9108, 181, 9585, '219263', 24, '2023-11-22 20:15:15', NULL, NULL),
(9109, 181, 9586, '53000', 24, '2023-11-22 20:15:15', NULL, NULL),
(9110, 181, 9587, '307400', 24, '2023-11-22 20:15:15', NULL, NULL),
(9111, 181, 9588, '315800', 24, '2023-11-22 20:15:15', NULL, NULL),
(9112, 181, 9589, '206100', 24, '2023-11-22 20:15:15', NULL, NULL),
(9113, 181, 9592, '278900', 24, '2023-11-22 20:15:15', NULL, NULL),
(9114, 181, 9593, '329400', 24, '2023-11-22 20:15:15', NULL, NULL),
(9115, 181, 9595, '308600', 24, '2023-11-22 20:15:15', NULL, NULL),
(9116, 181, 9597, '237840', 24, '2023-11-22 20:15:15', NULL, NULL),
(9117, 181, 9596, '296542', 24, '2023-11-22 20:15:15', NULL, NULL),
(9118, 181, 9594, '260600', 24, '2023-11-22 20:15:15', NULL, NULL),
(9119, 181, 9598, '211000', 24, '2023-11-22 20:15:15', NULL, NULL),
(9120, 181, 9591, '238100', 24, '2023-11-22 20:15:15', NULL, NULL),
(9121, 181, 9599, '261400', 24, '2023-11-22 20:15:15', NULL, NULL),
(9122, 181, 9590, '329400', 24, '2023-11-22 20:15:15', NULL, NULL),
(9123, 181, 9601, '232200', 24, '2023-11-22 20:15:15', NULL, NULL),
(9124, 181, 9602, '320800', 24, '2023-11-22 20:15:15', NULL, NULL),
(9125, 181, 9600, '421772', 24, '2023-11-22 20:15:15', NULL, NULL),
(9126, 181, 9603, '315800', 24, '2023-11-22 20:15:15', NULL, NULL),
(9127, 181, 9604, '242000', 24, '2023-11-22 20:15:15', NULL, NULL),
(9128, 181, 9605, '364100', 24, '2023-11-22 20:15:15', NULL, NULL),
(9129, 181, 9606, '46500', 24, '2023-11-22 20:15:15', NULL, NULL),
(9130, 181, 9607, '259200', 24, '2023-11-22 20:15:15', NULL, NULL),
(9131, 181, 9609, '312200', 24, '2023-11-22 20:15:15', NULL, NULL),
(9132, 181, 9608, '235900', 24, '2023-11-22 20:15:15', NULL, NULL),
(9133, 181, 9610, '279900', 24, '2023-11-22 20:15:15', NULL, NULL),
(9134, 181, 9611, '195000', 24, '2023-11-22 20:15:15', NULL, NULL),
(9135, 181, 9612, '11100', 24, '2023-11-22 20:15:15', NULL, NULL),
(9136, 181, 9613, '48300', 24, '2023-11-22 20:15:15', NULL, NULL),
(9137, 181, 9614, '307400', 24, '2023-11-22 20:15:15', NULL, NULL),
(9138, 181, 9615, '302300', 24, '2023-11-22 20:15:15', NULL, NULL),
(9139, 181, 9616, '42000', 24, '2023-11-22 20:15:15', NULL, NULL),
(9140, 181, 9617, '329400', 24, '2023-11-22 20:15:15', NULL, NULL),
(9141, 181, 9618, '214900', 24, '2023-11-22 20:15:15', NULL, NULL),
(9142, 181, 9619, '265100', 24, '2023-11-22 20:15:15', NULL, NULL),
(9143, 181, 9621, '195000', 24, '2023-11-22 20:15:15', NULL, NULL),
(9144, 181, 9622, '45700', 24, '2023-11-22 20:15:15', NULL, NULL),
(9145, 181, 9623, '47006', 24, '2023-11-22 20:15:15', NULL, NULL),
(9146, 181, 9624, '195000', 24, '2023-11-22 20:15:15', NULL, NULL),
(9147, 181, 9625, '39500', 24, '2023-11-22 20:15:15', NULL, NULL),
(9148, 181, 9627, '324400', 24, '2023-11-22 20:15:15', NULL, NULL),
(9149, 181, 9628, '265953', 24, '2023-11-22 20:15:15', NULL, NULL),
(9150, 181, 9626, '239200', 24, '2023-11-22 20:15:15', NULL, NULL),
(9151, 181, 9620, '214900', 24, '2023-11-22 20:15:15', NULL, NULL),
(9152, 181, 9629, '395000', 24, '2023-11-22 20:15:15', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `factura_detalles`
--

CREATE TABLE `factura_detalles` (
  `id` int NOT NULL,
  `id_factura` int NOT NULL,
  `id_inmueble` int DEFAULT NULL,
  `id_concepto_factura` int NOT NULL,
  `cantidad` int NOT NULL DEFAULT '1',
  `valor_unitario` varchar(150) NOT NULL DEFAULT '0',
  `total` varchar(150) NOT NULL DEFAULT '0',
  `descripcion` text,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factura_detalles`
--

INSERT INTO `factura_detalles` (`id`, `id_factura`, `id_inmueble`, `id_concepto_factura`, `cantidad`, `valor_unitario`, `total`, `descripcion`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(26166, 8884, 25, 1, 1, '195400', '195400', 'INMUEBLE:  A201 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26167, 8885, 33, 1, 1, '180600', '180600', 'INMUEBLE:  A301 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26168, 8886, 50, 1, 1, '180600', '180600', 'INMUEBLE:  A306 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26169, 8887, 55, 1, 1, '252399', '252399', 'INMUEBLE:  A402 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26170, 8887, 56, 1, 1, '35400', '35400', 'PARQUEADERO:  P1 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26171, 8887, 57, 1, 1, '4600', '4600', 'CUARTO UTIL:  U4 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26172, 8888, 54, 1, 1, '6900', '6900', 'CUARTO UTIL:  U19 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26173, 8888, 52, 1, 1, '180828', '180828', 'INMUEBLE:  A401 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26174, 8888, 53, 1, 1, '37700', '37700', 'PARQUEADERO:  P22 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26175, 8889, 60, 1, 1, '5700', '5700', 'CUARTO UTIL:  U5 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26176, 8889, 58, 1, 1, '260400', '260400', 'INMUEBLE:  A403 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26177, 8889, 59, 1, 1, '34300', '34300', 'PARQUEADERO:  P2 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26178, 8890, 61, 1, 1, '240000', '240000', 'INMUEBLE:  A404 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26179, 8891, 97, 1, 1, '30900', '30900', 'PARQUEADERO:  P30 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26180, 8891, 98, 1, 1, '6857', '6857', 'CUARTO UTIL:  U22 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26181, 8891, 96, 1, 1, '180958', '180958', 'INMUEBLE:  A701 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26182, 8892, 47, 1, 1, '180600', '180600', 'INMUEBLE:  A305 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26183, 8893, 140, 1, 1, '44700', '44700', 'PARQUEADERO:  P31 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26184, 8894, 30, 1, 1, '240000', '240000', 'INMUEBLE:  A204 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26185, 8895, 68, 1, 1, '4600', '4600', 'CUARTO UTIL:  U35 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26186, 8895, 66, 1, 1, '180579', '180579', 'INMUEBLE:  A501 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26187, 8895, 67, 1, 1, '34300', '34300', 'PARQUEADERO:  P14 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26188, 8896, 69, 1, 1, '252628', '252628', 'INMUEBLE:  A502 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26189, 8896, 70, 1, 1, '4600', '4600', 'CUARTO UTIL:  U34 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26190, 8897, 143, 1, 1, '29700', '29700', 'PARQUEADERO:  P37 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26191, 8897, 144, 1, 1, '6900', '6900', 'CUARTO UTIL:  U31 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26192, 8898, 62, 1, 1, '180499', '180499', 'INMUEBLE:  A405 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26193, 8898, 63, 1, 1, '33144', '33144', 'PARQUEADERO:  P28 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26194, 8898, 64, 1, 1, '6857', '6857', 'CUARTO UTIL:  U21 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26195, 8900, 35, 1, 1, '30900', '30900', 'PARQUEADERO:  P38 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26196, 8900, 37, 1, 1, '6900', '6900', 'CUARTO UTIL:  U30 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26197, 8900, 32, 1, 1, '195385', '195385', 'INMUEBLE:  A206 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26198, 8901, 65, 1, 1, '180600', '180600', 'INMUEBLE:  A406 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26199, 8899, 80, 1, 1, '180670', '180670', 'INMUEBLE:  A601 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26200, 8899, 81, 1, 1, '38900', '38900', 'PARQUEADERO:  P25 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26201, 8899, 82, 1, 1, '4600', '4600', 'CUARTO UTIL:  U27 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26202, 8902, 38, 1, 1, '252528', '252528', 'INMUEBLE:  A302 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26203, 8902, 39, 1, 1, '30900', '30900', 'PARQUEADERO:  P5 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26204, 8902, 40, 1, 1, '5700', '5700', 'CUARTO UTIL:  U2 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26205, 8903, 139, 1, 1, '35400', '35400', 'PARQUEADERO:  P13 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26206, 8903, 79, 1, 1, '180571', '180571', 'INMUEBLE:  A506 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26207, 8904, 36, 1, 1, '6900', '6900', 'CUARTO UTIL:  U28 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26208, 8904, 31, 1, 1, '195585', '195585', 'INMUEBLE:  A205 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26209, 8904, 34, 1, 1, '38900', '38900', 'PARQUEADERO:  P33 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26210, 8905, 27, 1, 1, '260600', '260600', 'INMUEBLE:  A203 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26211, 8905, 28, 1, 1, '32000', '32000', 'PARQUEADERO:  P4 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26212, 8905, 29, 1, 1, '5700', '5700', 'CUARTO UTIL:  U1 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26213, 8905, 83, 1, 1, '252576', '252576', 'INMUEBLE:  A602 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26214, 8905, 84, 1, 1, '38900', '38900', 'PARQUEADERO:  P24 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26215, 8905, 136, 1, 1, '38900', '38900', 'PARQUEADERO:  P34 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26216, 8905, 137, 1, 1, '11400', '11400', 'CUARTO UTIL:  U25 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26217, 8905, 142, 1, 1, '36600', '36600', 'PARQUEADERO:  P35 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26218, 8906, 79, 1, 1, '180600', '180600', 'INMUEBLE:  A506 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26219, 8907, 77, 1, 1, '29700', '29700', 'PARQUEADERO:  P29 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26220, 8907, 78, 1, 1, '4600', '4600', 'CUARTO UTIL:  U3 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26221, 8907, 76, 1, 1, '180713', '180713', 'INMUEBLE:  A505 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26222, 8908, 71, 1, 1, '260728', '260728', 'INMUEBLE:  A503 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26223, 8908, 74, 1, 1, '4600', '4600', 'CUARTO UTIL:  U13 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26224, 8909, 73, 1, 1, '240000', '240000', 'INMUEBLE:  A504 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26225, 8909, 75, 1, 1, '6900', '6900', 'CUARTO UTIL:  U6 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26226, 8909, 146, 1, 1, '38900', '38900', 'PARQUEADERO:  P6 ', NULL, '2023-11-02 22:32:02', NULL, NULL),
(26227, 8910, 86, 1, 1, '37700', '37700', 'PARQUEADERO:  P8 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26228, 8910, 87, 1, 1, '6900', '6900', 'CUARTO UTIL:  U8 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26229, 8910, 85, 1, 1, '260428', '260428', 'INMUEBLE:  A603 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26230, 8911, 42, 1, 1, '37715', '37715', 'PARQUEADERO:  P9 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26231, 8911, 43, 1, 1, '6900', '6900', 'CUARTO UTIL:  U9 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26232, 8911, 41, 1, 1, '260428', '260428', 'INMUEBLE:  A303 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26233, 8912, 90, 1, 1, '6900', '6900', 'CUARTO UTIL:  U29 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26234, 8912, 89, 1, 1, '33100', '33100', 'PARQUEADERO:  P36 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26235, 8912, 88, 1, 1, '239899', '239899', 'INMUEBLE:  A604 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26236, 8913, 93, 1, 1, '181500', '181500', 'INMUEBLE:  A606 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26237, 8913, 95, 1, 1, '5700', '5700', 'CUARTO UTIL:  U14 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26238, 8913, 94, 1, 1, '34300', '34300', 'PARQUEADERO:  P15 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26239, 8914, 91, 1, 1, '180514', '180514', 'INMUEBLE:  A605 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26240, 8914, 92, 1, 1, '10300', '10300', 'CUARTO UTIL:  U32 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26241, 8915, 44, 1, 1, '240028', '240028', 'INMUEBLE:  A304 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26242, 8915, 49, 1, 1, '37700', '37700', 'PARQUEADERO:  P7 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26243, 8915, 48, 1, 1, '6900', '6900', 'CUARTO UTIL:  U7 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26244, 8916, 116, 1, 1, '321128', '321128', 'INMUEBLE:  A903 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26245, 8916, 118, 1, 1, '6900', '6900', 'CUARTO UTIL:  U16 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26246, 8916, 117, 1, 1, '37700', '37700', 'PARQUEADERO:  P19 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26247, 8917, 99, 1, 1, '252428', '252428', 'INMUEBLE:  A702 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26248, 8917, 100, 1, 1, '37700', '37700', 'PARQUEADERO:  P27 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26249, 8917, 101, 1, 1, '6900', '6900', 'CUARTO UTIL:  U20 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26250, 8918, 135, 1, 1, '4600', '4600', 'CUARTO UTIL:  U26 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26251, 8918, 134, 1, 1, '38528', '38528', 'PARQUEADERO:  P23 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26252, 8919, 141, 1, 1, '38900', '38900', 'PARQUEADERO:  P32 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26253, 8920, 145, 1, 1, '16734', '16734', 'CUARTO UTIL:  U24 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26254, 8921, 104, 1, 1, '6900', '6900', 'CUARTO UTIL:  U18 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26255, 8921, 102, 1, 1, '260600', '260600', 'INMUEBLE:  A703 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26256, 8921, 105, 1, 1, '240000', '240000', 'INMUEBLE:  A704 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26257, 8922, 27, 1, 1, '260600', '260600', 'INMUEBLE:  A203 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26258, 8922, 83, 1, 1, '252600', '252600', 'INMUEBLE:  A602 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26259, 8922, 142, 1, 1, '36572', '36572', 'PARQUEADERO:  P35 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26260, 8923, 109, 1, 1, '238885', '238885', 'INMUEBLE:  A804 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26261, 8923, 111, 1, 1, '34300', '34300', 'PARQUEADERO:  P3 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26262, 8923, 122, 1, 1, '11400', '11400', 'CUARTO UTIL:  U33 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26263, 8924, 103, 1, 1, '37700', '37700', 'PARQUEADERO:  P21 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26264, 8924, 102, 1, 1, '260428', '260428', 'INMUEBLE:  A703 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26265, 8924, 104, 1, 1, '6857', '6857', 'CUARTO UTIL:  U18 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26266, 8925, 107, 1, 1, '199000', '199000', 'INMUEBLE:  A706 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26267, 8926, 138, 1, 1, '38900', '38900', 'PARQUEADERO:  P11 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26268, 8927, 119, 1, 1, '292528', '292528', 'INMUEBLE:  A904 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26269, 8927, 120, 1, 1, '37700', '37700', 'PARQUEADERO:  P10 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26270, 8927, 121, 1, 1, '6900', '6900', 'CUARTO UTIL:  U10 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26271, 8928, 110, 1, 1, '32000', '32000', 'PARQUEADERO:  P17 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26272, 8928, 108, 1, 1, '260399', '260399', 'INMUEBLE:  A803 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26273, 8929, 113, 1, 1, '198570', '198570', 'INMUEBLE:  A806 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26274, 8929, 114, 1, 1, '38900', '38900', 'PARQUEADERO:  P26 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26275, 8929, 115, 1, 1, '4600', '4600', 'CUARTO UTIL:  U12 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26276, 8930, 106, 1, 1, '199000', '199000', 'INMUEBLE:  A705 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26277, 8931, 26, 1, 1, '285700', '285700', 'INMUEBLE:  A202 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26278, 8931, 26, 8, 1, '34762', '34762', 'INMUEBLE:  A202 INTERESES % 2 - BASE: 1.738.076', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26279, 8932, 129, 1, 1, '213485', '213485', 'INMUEBLE:  A906 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26280, 8932, 130, 1, 1, '38900', '38900', 'PARQUEADERO:  P18 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26281, 8932, 131, 1, 1, '6900', '6900', 'CUARTO UTIL:  U15 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26282, 8933, 123, 1, 1, '198642', '198642', 'INMUEBLE:  A805 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26283, 8933, 125, 1, 1, '6900', '6900', 'CUARTO UTIL:  U23 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26284, 8933, 124, 1, 1, '40000', '40000', 'PARQUEADERO:  P12 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26285, 8934, 136, 1, 1, '38900', '38900', 'PARQUEADERO:  P34 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26286, 8934, 137, 1, 1, '11429', '11429', 'CUARTO UTIL:  U25 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26287, 8937, 126, 1, 1, '213628', '213628', 'INMUEBLE:  A905 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26288, 8937, 127, 1, 1, '37700', '37700', 'PARQUEADERO:  P20 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26289, 8937, 128, 1, 1, '6900', '6900', 'CUARTO UTIL:  U17 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26290, 8935, 28, 1, 1, '32000', '32000', 'PARQUEADERO:  P4 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26291, 8935, 27, 1, 1, '260600', '260600', 'INMUEBLE:  A203 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26292, 8935, 29, 1, 1, '5700', '5700', 'CUARTO UTIL:  U1 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26293, 8936, 132, 1, 1, '38099', '38099', 'PARQUEADERO:  P16 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(26294, 8936, 133, 1, 1, '4600', '4600', 'CUARTO UTIL:  U11 ', NULL, '2023-11-02 22:32:03', NULL, NULL),
(27414, 9312, 25, 1, 1, '211000', '211000', 'INMUEBLE:  A201 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27415, 9313, 47, 1, 1, '195000', '195000', 'INMUEBLE:  A305 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27416, 9313, 47, 8, 1, '19816', '19816', 'INMUEBLE:  A305 INTERESES % 2 - BASE: 990.802', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27417, 9314, 50, 1, 1, '195000', '195000', 'INMUEBLE:  A306 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27418, 9315, 29, 14, 1, '6156', '6156', 'CUARTO UTIL:  U1 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27419, 9315, 27, 1, 1, '281448', '281448', 'INMUEBLE:  A203 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27420, 9315, 28, 13, 1, '34560', '34560', 'PARQUEADERO:  P4 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27421, 9316, 38, 1, 1, '272702', '272702', 'INMUEBLE:  A302 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27422, 9316, 40, 14, 1, '6171', '6171', 'CUARTO UTIL:  U2 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27423, 9316, 39, 13, 1, '33327', '33327', 'PARQUEADERO:  P5 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27424, 9317, 30, 1, 1, '259200', '259200', 'INMUEBLE:  A204 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27425, 9317, 30, 8, 1, '1232', '1232', 'INMUEBLE:  A204 INTERESES % 2 - BASE: 61.615', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27426, 9318, 56, 13, 1, '38263', '38263', 'PARQUEADERO:  P1 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27427, 9318, 55, 1, 1, '272591', '272591', 'INMUEBLE:  A402 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27428, 9318, 57, 14, 1, '4945', '4945', 'CUARTO UTIL:  U4 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27429, 9319, 92, 14, 1, '11109', '11109', 'CUARTO UTIL:  U32 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27430, 9319, 91, 1, 1, '194991', '194991', 'INMUEBLE:  A605 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27431, 9319, 92, 8, 1, '4122', '4122', 'CUARTO UTIL:  U32 INTERESES % 2 - BASE: 206.100', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27432, 9320, 63, 13, 1, '35796', '35796', 'PARQUEADERO:  P28 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27433, 9320, 62, 1, 1, '194899', '194899', 'INMUEBLE:  A405 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27434, 9320, 64, 14, 1, '7406', '7406', 'CUARTO UTIL:  U21 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27435, 9321, 133, 14, 1, '4938', '4938', 'CUARTO UTIL:  U11 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27436, 9321, 132, 13, 1, '40762', '40762', 'PARQUEADERO:  P16 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27437, 9322, 140, 13, 1, '48300', '48300', 'PARQUEADERO:  P31 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27438, 9323, 96, 1, 1, '195168', '195168', 'INMUEBLE:  A701 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27439, 9323, 97, 13, 1, '33327', '33327', 'PARQUEADERO:  P30 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27440, 9323, 98, 14, 1, '7406', '7406', 'CUARTO UTIL:  U22 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27441, 9324, 33, 1, 1, '195000', '195000', 'INMUEBLE:  A301 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27442, 9325, 52, 1, 1, '195264', '195264', 'INMUEBLE:  A401 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27443, 9325, 54, 14, 1, '7406', '7406', 'CUARTO UTIL:  U19 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27444, 9325, 53, 13, 1, '40730', '40730', 'PARQUEADERO:  P22 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27445, 9326, 37, 14, 1, '7406', '7406', 'CUARTO UTIL:  U30 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27446, 9326, 35, 13, 1, '33327', '33327', 'PARQUEADERO:  P38 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27447, 9326, 32, 1, 1, '210968', '210968', 'INMUEBLE:  A206 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27448, 9327, 73, 1, 1, '259205', '259205', 'INMUEBLE:  A504 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27449, 9327, 75, 14, 1, '7406', '7406', 'CUARTO UTIL:  U6 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27450, 9327, 146, 13, 1, '44436', '44436', 'PARQUEADERO:  P6 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27451, 9328, 113, 1, 1, '214496', '214496', 'INMUEBLE:  A806 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27452, 9328, 114, 13, 1, '41967', '41967', 'PARQUEADERO:  P26 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27453, 9328, 115, 14, 1, '4938', '4938', 'CUARTO UTIL:  U12 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27454, 9328, 113, 8, 1, '26634', '26634', 'INMUEBLE:  A806 INTERESES % 2 - BASE: 1.331.690', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27455, 9329, 26, 1, 1, '308600', '308600', 'INMUEBLE:  A202 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27456, 9329, 26, 8, 1, '103527', '103527', 'INMUEBLE:  A202 INTERESES % 2 - BASE: 5.176.326', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27457, 9330, 144, 14, 1, '7406', '7406', 'CUARTO UTIL:  U31 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27458, 9330, 143, 13, 1, '32195', '32195', 'PARQUEADERO:  P37 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27459, 9330, 144, 8, 1, '870', '870', 'CUARTO UTIL:  U31 INTERESES % 2 - BASE: 43.494', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27460, 9331, 44, 1, 1, '259263', '259263', 'INMUEBLE:  A304 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27461, 9331, 48, 14, 1, '7406', '7406', 'CUARTO UTIL:  U7 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27462, 9331, 49, 13, 1, '40732', '40732', 'PARQUEADERO:  P7 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27463, 9331, 44, 8, 1, '936', '936', 'INMUEBLE:  A304 INTERESES % 2 - BASE: 46.800', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27464, 9332, 61, 1, 1, '259200', '259200', 'INMUEBLE:  A404 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27465, 9333, 69, 1, 1, '272862', '272862', 'INMUEBLE:  A502 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27466, 9333, 70, 14, 1, '4938', '4938', 'CUARTO UTIL:  U34 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27467, 9333, 69, 8, 1, '14496', '14496', 'INMUEBLE:  A502 INTERESES % 2 - BASE: 724.787', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27468, 9334, 58, 1, 1, '281200', '281200', 'INMUEBLE:  A403 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27469, 9334, 59, 13, 1, '37029', '37029', 'PARQUEADERO:  P2 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27470, 9334, 60, 14, 1, '6171', '6171', 'CUARTO UTIL:  U5 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27471, 9335, 71, 1, 1, '281562', '281562', 'INMUEBLE:  A503 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27472, 9335, 74, 14, 1, '4938', '4938', 'CUARTO UTIL:  U13 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27473, 9336, 99, 1, 1, '272662', '272662', 'INMUEBLE:  A702 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27474, 9336, 100, 13, 1, '40732', '40732', 'PARQUEADERO:  P27 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27475, 9336, 101, 14, 1, '7406', '7406', 'CUARTO UTIL:  U20 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27476, 9337, 65, 1, 1, '195000', '195000', 'INMUEBLE:  A406 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27477, 9338, 81, 13, 1, '41967', '41967', 'PARQUEADERO:  P25 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27478, 9338, 80, 1, 1, '195096', '195096', 'INMUEBLE:  A601 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27479, 9338, 82, 14, 1, '4938', '4938', 'CUARTO UTIL:  U27 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27480, 9338, 81, 8, 1, '4754', '4754', 'PARQUEADERO:  P25 INTERESES % 2 - BASE: 237.700', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27481, 9339, 85, 1, 1, '281262', '281262', 'INMUEBLE:  A603 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27482, 9339, 86, 13, 1, '40732', '40732', 'PARQUEADERO:  P8 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27483, 9339, 87, 14, 1, '7406', '7406', 'CUARTO UTIL:  U8 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27484, 9339, 85, 8, 1, '294', '294', 'INMUEBLE:  A603 INTERESES % 2 - BASE: 14.700', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27485, 9340, 76, 1, 1, '195170', '195170', 'INMUEBLE:  A505 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27486, 9340, 77, 13, 1, '32092', '32092', 'PARQUEADERO:  P29 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27487, 9340, 78, 14, 1, '4938', '4938', 'CUARTO UTIL:  U3 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27488, 9341, 79, 1, 1, '195017', '195017', 'INMUEBLE:  A506 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27489, 9341, 139, 13, 1, '38263', '38263', 'PARQUEADERO:  P13 ', NULL, '2023-11-10 13:38:00', NULL, NULL),
(27490, 9342, 36, 14, 1, '7406', '7406', 'CUARTO UTIL:  U28 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27491, 9342, 34, 13, 1, '41967', '41967', 'PARQUEADERO:  P33 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27492, 9342, 31, 1, 1, '211227', '211227', 'INMUEBLE:  A205 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27493, 9343, 66, 1, 1, '195234', '195234', 'INMUEBLE:  A501 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27494, 9343, 68, 14, 1, '4938', '4938', 'CUARTO UTIL:  U35 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27495, 9343, 67, 13, 1, '37029', '37029', 'PARQUEADERO:  P14 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27496, 9344, 94, 13, 1, '37029', '37029', 'PARQUEADERO:  P15 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27497, 9344, 93, 1, 1, '195999', '195999', 'INMUEBLE:  A606 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27498, 9344, 95, 14, 1, '6171', '6171', 'CUARTO UTIL:  U14 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27499, 9345, 103, 13, 1, '40732', '40732', 'PARQUEADERO:  P21 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27500, 9345, 104, 14, 1, '7406', '7406', 'CUARTO UTIL:  U18 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27501, 9345, 102, 1, 1, '281262', '281262', 'INMUEBLE:  A703 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27502, 9346, 84, 13, 1, '41967', '41967', 'PARQUEADERO:  P24 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27503, 9346, 83, 1, 1, '272782', '272782', 'INMUEBLE:  A602 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27504, 9348, 131, 14, 1, '7406', '7406', 'CUARTO UTIL:  U15 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27505, 9348, 129, 1, 1, '230528', '230528', 'INMUEBLE:  A906 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27506, 9348, 130, 13, 1, '41967', '41967', 'PARQUEADERO:  P18 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27507, 9347, 109, 1, 1, '258028', '258028', 'INMUEBLE:  A804 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27508, 9347, 111, 13, 1, '37029', '37029', 'PARQUEADERO:  P3 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27509, 9347, 122, 14, 1, '12343', '12343', 'CUARTO UTIL:  U33 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27510, 9349, 105, 1, 1, '259200', '259200', 'INMUEBLE:  A704 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27511, 9350, 41, 1, 1, '281262', '281262', 'INMUEBLE:  A303 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27512, 9350, 42, 13, 1, '40732', '40732', 'PARQUEADERO:  P9 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27513, 9350, 43, 14, 1, '7406', '7406', 'CUARTO UTIL:  U9 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27514, 9351, 116, 1, 1, '346863', '346863', 'INMUEBLE:  A903 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27515, 9351, 117, 13, 1, '40732', '40732', 'PARQUEADERO:  P19 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27516, 9351, 118, 14, 1, '7406', '7406', 'CUARTO UTIL:  U16 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27517, 9351, 116, 8, 1, '6742', '6742', 'INMUEBLE:  A903 INTERESES % 2 - BASE: 337.104', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27518, 9352, 90, 14, 1, '7406', '7406', 'CUARTO UTIL:  U29 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27519, 9352, 88, 1, 1, '259098', '259098', 'INMUEBLE:  A604 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27520, 9352, 89, 13, 1, '35796', '35796', 'PARQUEADERO:  P36 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27521, 9353, 145, 14, 1, '11100', '11100', 'CUARTO UTIL:  U24 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27522, 9354, 136, 13, 1, '40657', '40657', 'PARQUEADERO:  P34 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27523, 9354, 137, 14, 1, '12343', '12343', 'CUARTO UTIL:  U25 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27524, 9355, 108, 1, 1, '281238', '281238', 'INMUEBLE:  A803 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27525, 9355, 110, 13, 1, '34561', '34561', 'PARQUEADERO:  P17 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27526, 9356, 123, 1, 1, '214493', '214493', 'INMUEBLE:  A805 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27527, 9356, 125, 14, 1, '7406', '7406', 'CUARTO UTIL:  U23 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27528, 9356, 124, 13, 1, '43201', '43201', 'PARQUEADERO:  P12 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27529, 9357, 134, 13, 1, '41563', '41563', 'PARQUEADERO:  P23 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27530, 9357, 135, 14, 1, '4938', '4938', 'CUARTO UTIL:  U26 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27531, 9358, 138, 13, 1, '42000', '42000', 'PARQUEADERO:  P11 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27532, 9358, 138, 8, 1, '4972', '4972', 'PARQUEADERO:  P11 INTERESES % 2 - BASE: 248.624', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27533, 9359, 127, 13, 1, '40732', '40732', 'PARQUEADERO:  P20 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27534, 9359, 126, 1, 1, '230763', '230763', 'INMUEBLE:  A905 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27535, 9359, 128, 14, 1, '7406', '7406', 'CUARTO UTIL:  U17 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27536, 9360, 119, 1, 1, '315963', '315963', 'INMUEBLE:  A904 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27537, 9360, 120, 13, 1, '40732', '40732', 'PARQUEADERO:  P10 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27538, 9360, 121, 14, 1, '7406', '7406', 'CUARTO UTIL:  U10 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27539, 9361, 107, 1, 1, '214899', '214899', 'INMUEBLE:  A706 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27540, 9362, 106, 1, 1, '214899', '214899', 'INMUEBLE:  A705 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27541, 9363, 142, 13, 1, '39500', '39500', 'PARQUEADERO:  P35 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27542, 9364, 141, 13, 1, '42000', '42000', 'PARQUEADERO:  P32 ', NULL, '2023-11-10 13:38:01', NULL, NULL),
(27543, 9364, 141, 8, 1, '637', '637', 'PARQUEADERO:  P32 INTERESES % 2 - BASE: 31.840', NULL, '2023-11-10 13:38:01', NULL, NULL),
(28032, 9577, 29, 14, 1, '6156', '6156', 'CUARTO UTIL:  U1 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28033, 9577, 27, 1, 1, '281448', '281448', 'INMUEBLE:  A203 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28034, 9577, 28, 13, 1, '34596', '34596', 'PARQUEADERO:  P4 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28035, 9578, 71, 1, 1, '281562', '281562', 'INMUEBLE:  A503 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28036, 9578, 74, 14, 1, '4938', '4938', 'CUARTO UTIL:  U13 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28037, 9579, 37, 14, 1, '7405', '7405', 'CUARTO UTIL:  U30 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28038, 9579, 35, 13, 1, '33327', '33327', 'PARQUEADERO:  P38 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28039, 9579, 32, 1, 1, '210968', '210968', 'INMUEBLE:  A206 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28040, 9580, 52, 1, 1, '195264', '195264', 'INMUEBLE:  A401 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28041, 9580, 54, 14, 1, '7406', '7406', 'CUARTO UTIL:  U19 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28042, 9580, 53, 13, 1, '40730', '40730', 'PARQUEADERO:  P22 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28043, 9581, 138, 13, 1, '42000', '42000', 'PARQUEADERO:  P11 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28044, 9582, 66, 1, 1, '195234', '195234', 'INMUEBLE:  A501 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28045, 9582, 68, 14, 1, '4937', '4937', 'CUARTO UTIL:  U35 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28046, 9582, 67, 13, 1, '37029', '37029', 'PARQUEADERO:  P14 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28047, 9583, 84, 13, 1, '41918', '41918', 'PARQUEADERO:  P24 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28048, 9583, 83, 1, 1, '272782', '272782', 'INMUEBLE:  A602 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28049, 9584, 61, 1, 1, '259200', '259200', 'INMUEBLE:  A404 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28050, 9585, 47, 1, 1, '195000', '195000', 'INMUEBLE:  A305 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28051, 9585, 47, 8, 1, '24263', '24263', 'INMUEBLE:  A305 INTERESES % 2 - BASE: 1.213.166', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28052, 9586, 136, 13, 1, '40657', '40657', 'PARQUEADERO:  P34 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28053, 9586, 137, 14, 1, '12343', '12343', 'CUARTO UTIL:  U25 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28054, 9587, 44, 1, 1, '259263', '259263', 'INMUEBLE:  A304 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28055, 9587, 48, 14, 1, '7406', '7406', 'CUARTO UTIL:  U7 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28056, 9587, 49, 13, 1, '40731', '40731', 'PARQUEADERO:  P7 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28057, 9588, 108, 1, 1, '281239', '281239', 'INMUEBLE:  A803 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28058, 9588, 110, 13, 1, '34561', '34561', 'PARQUEADERO:  P17 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28059, 9589, 92, 14, 1, '11109', '11109', 'CUARTO UTIL:  U32 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28060, 9589, 91, 1, 1, '194991', '194991', 'INMUEBLE:  A605 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28061, 9590, 103, 13, 1, '40732', '40732', 'PARQUEADERO:  P21 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28062, 9590, 104, 14, 1, '7406', '7406', 'CUARTO UTIL:  U18 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28063, 9590, 102, 1, 1, '281262', '281262', 'INMUEBLE:  A703 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28064, 9591, 63, 13, 1, '35796', '35796', 'PARQUEADERO:  P28 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28065, 9591, 62, 1, 1, '194899', '194899', 'INMUEBLE:  A405 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28066, 9591, 64, 14, 1, '7405', '7405', 'CUARTO UTIL:  U21 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28067, 9592, 127, 13, 1, '40732', '40732', 'PARQUEADERO:  P20 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28068, 9592, 126, 1, 1, '230763', '230763', 'INMUEBLE:  A905 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28069, 9592, 128, 14, 1, '7405', '7405', 'CUARTO UTIL:  U17 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28070, 9593, 41, 1, 1, '281262', '281262', 'INMUEBLE:  A303 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28071, 9593, 42, 13, 1, '40732', '40732', 'PARQUEADERO:  P9 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28072, 9593, 43, 14, 1, '7406', '7406', 'CUARTO UTIL:  U9 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28073, 9595, 73, 1, 1, '256758', '256758', 'INMUEBLE:  A504 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28074, 9595, 75, 14, 1, '7406', '7406', 'CUARTO UTIL:  U6 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28075, 9595, 146, 13, 1, '44436', '44436', 'PARQUEADERO:  P6 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28076, 9597, 79, 1, 1, '195000', '195000', 'INMUEBLE:  A506 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28077, 9597, 139, 13, 1, '42000', '42000', 'PARQUEADERO:  P13 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28078, 9597, 79, 8, 1, '840', '840', 'INMUEBLE:  A506 INTERESES % 2 - BASE: 42.000', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28079, 9596, 69, 1, 1, '272862', '272862', 'INMUEBLE:  A502 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28080, 9596, 70, 14, 1, '4938', '4938', 'CUARTO UTIL:  U34 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28081, 9596, 69, 8, 1, '18742', '18742', 'INMUEBLE:  A502 INTERESES % 2 - BASE: 937.115', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28082, 9594, 36, 14, 1, '7406', '7406', 'CUARTO UTIL:  U28 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28083, 9594, 34, 13, 1, '41967', '41967', 'PARQUEADERO:  P33 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28084, 9594, 31, 1, 1, '211227', '211227', 'INMUEBLE:  A205 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28085, 9598, 25, 1, 1, '211000', '211000', 'INMUEBLE:  A201 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28086, 9599, 113, 1, 1, '214496', '214496', 'INMUEBLE:  A806 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28087, 9599, 114, 13, 1, '41967', '41967', 'PARQUEADERO:  P26 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28088, 9599, 115, 14, 1, '4937', '4937', 'CUARTO UTIL:  U12 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28089, 9600, 26, 1, 1, '308600', '308600', 'INMUEBLE:  A202 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28090, 9600, 26, 8, 1, '113172', '113172', 'INMUEBLE:  A202 INTERESES % 2 - BASE: 5.658.622', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28091, 9601, 76, 1, 1, '195170', '195170', 'INMUEBLE:  A505 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28092, 9601, 77, 13, 1, '32092', '32092', 'PARQUEADERO:  P29 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28093, 9601, 78, 14, 1, '4938', '4938', 'CUARTO UTIL:  U3 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28094, 9602, 99, 1, 1, '272662', '272662', 'INMUEBLE:  A702 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28095, 9602, 100, 13, 1, '40732', '40732', 'PARQUEADERO:  P27 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28096, 9602, 101, 14, 1, '7406', '7406', 'CUARTO UTIL:  U20 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28097, 9603, 56, 13, 1, '38264', '38264', 'PARQUEADERO:  P1 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28098, 9603, 55, 1, 1, '272591', '272591', 'INMUEBLE:  A402 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28099, 9603, 57, 14, 1, '4945', '4945', 'CUARTO UTIL:  U4 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28100, 9604, 81, 13, 1, '41967', '41967', 'PARQUEADERO:  P25 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28101, 9604, 80, 1, 1, '195095', '195095', 'INMUEBLE:  A601 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28102, 9604, 82, 14, 1, '4938', '4938', 'CUARTO UTIL:  U27 ', NULL, '2023-11-22 20:15:14', NULL, NULL),
(28103, 9605, 119, 1, 1, '315963', '315963', 'INMUEBLE:  A904 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28104, 9605, 120, 13, 1, '40732', '40732', 'PARQUEADERO:  P10 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28105, 9605, 121, 14, 1, '7405', '7405', 'CUARTO UTIL:  U10 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28106, 9606, 134, 13, 1, '41563', '41563', 'PARQUEADERO:  P23 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28107, 9606, 135, 14, 1, '4937', '4937', 'CUARTO UTIL:  U26 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28108, 9607, 105, 1, 1, '259200', '259200', 'INMUEBLE:  A704 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28109, 9608, 96, 1, 1, '195168', '195168', 'INMUEBLE:  A701 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28110, 9608, 97, 13, 1, '33327', '33327', 'PARQUEADERO:  P30 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28111, 9608, 98, 14, 1, '7405', '7405', 'CUARTO UTIL:  U22 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28112, 9609, 38, 1, 1, '272702', '272702', 'INMUEBLE:  A302 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28113, 9609, 40, 14, 1, '6171', '6171', 'CUARTO UTIL:  U2 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28114, 9609, 39, 13, 1, '33327', '33327', 'PARQUEADERO:  P5 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28115, 9610, 131, 14, 1, '7405', '7405', 'CUARTO UTIL:  U15 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28116, 9610, 129, 1, 1, '230528', '230528', 'INMUEBLE:  A906 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28117, 9610, 130, 13, 1, '41967', '41967', 'PARQUEADERO:  P18 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28118, 9611, 33, 1, 1, '195000', '195000', 'INMUEBLE:  A301 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28119, 9612, 145, 14, 1, '11100', '11100', 'CUARTO UTIL:  U24 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28120, 9613, 140, 13, 1, '48300', '48300', 'PARQUEADERO:  P31 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28121, 9614, 109, 1, 1, '258028', '258028', 'INMUEBLE:  A804 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28122, 9614, 111, 13, 1, '37029', '37029', 'PARQUEADERO:  P3 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28123, 9614, 122, 14, 1, '12343', '12343', 'CUARTO UTIL:  U33 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28124, 9615, 90, 14, 1, '7406', '7406', 'CUARTO UTIL:  U29 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28125, 9615, 88, 1, 1, '259098', '259098', 'INMUEBLE:  A604 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28126, 9615, 89, 13, 1, '35796', '35796', 'PARQUEADERO:  P36 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28127, 9616, 141, 13, 1, '42000', '42000', 'PARQUEADERO:  P32 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28128, 9617, 85, 1, 1, '281262', '281262', 'INMUEBLE:  A603 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28129, 9617, 86, 13, 1, '40732', '40732', 'PARQUEADERO:  P8 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28130, 9617, 87, 14, 1, '7406', '7406', 'CUARTO UTIL:  U8 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28131, 9618, 107, 1, 1, '214900', '214900', 'INMUEBLE:  A706 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28132, 9619, 123, 1, 1, '214493', '214493', 'INMUEBLE:  A805 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28133, 9619, 125, 14, 1, '7406', '7406', 'CUARTO UTIL:  U23 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28134, 9619, 124, 13, 1, '43201', '43201', 'PARQUEADERO:  P12 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28135, 9620, 106, 1, 1, '214900', '214900', 'INMUEBLE:  A705 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28136, 9621, 65, 1, 1, '195000', '195000', 'INMUEBLE:  A406 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28137, 9622, 133, 14, 1, '4938', '4938', 'CUARTO UTIL:  U11 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28138, 9622, 132, 13, 1, '40762', '40762', 'PARQUEADERO:  P16 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28139, 9623, 144, 14, 1, '7406', '7406', 'CUARTO UTIL:  U31 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28140, 9623, 143, 13, 1, '39600', '39600', 'PARQUEADERO:  P37 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28141, 9624, 50, 1, 1, '195000', '195000', 'INMUEBLE:  A306 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28142, 9625, 142, 13, 1, '39500', '39500', 'PARQUEADERO:  P35 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28143, 9627, 58, 1, 1, '281200', '281200', 'INMUEBLE:  A403 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28144, 9627, 59, 13, 1, '37029', '37029', 'PARQUEADERO:  P2 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28145, 9627, 60, 14, 1, '6171', '6171', 'CUARTO UTIL:  U5 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28146, 9628, 30, 1, 1, '259200', '259200', 'INMUEBLE:  A204 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28147, 9628, 30, 8, 1, '6753', '6753', 'INMUEBLE:  A204 INTERESES % 2 - BASE: 337.659', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28148, 9626, 94, 13, 1, '37029', '37029', 'PARQUEADERO:  P15 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28149, 9626, 93, 1, 1, '196000', '196000', 'INMUEBLE:  A606 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28150, 9626, 95, 14, 1, '6171', '6171', 'CUARTO UTIL:  U14 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28151, 9629, 116, 1, 1, '346863', '346863', 'INMUEBLE:  A903 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28152, 9629, 117, 13, 1, '40731', '40731', 'PARQUEADERO:  P19 ', NULL, '2023-11-22 20:15:15', NULL, NULL),
(28153, 9629, 118, 14, 1, '7406', '7406', 'CUARTO UTIL:  U16 ', NULL, '2023-11-22 20:15:15', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `factura_recibos_caja`
--

CREATE TABLE `factura_recibos_caja` (
  `id` int NOT NULL,
  `consecutivo` int NOT NULL,
  `id_persona` int NOT NULL,
  `fecha_recibo` date DEFAULT NULL,
  `valor_recibo` int NOT NULL,
  `estado` tinyint NOT NULL DEFAULT '1' COMMENT '0 - ANULADO, 1 - REGISTRADO',
  `observacion` varchar(500) DEFAULT NULL,
  `token_erp` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factura_recibos_caja`
--

INSERT INTO `factura_recibos_caja` (`id`, `consecutivo`, `id_persona`, `fecha_recibo`, `valor_recibo`, `estado`, `observacion`, `token_erp`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(95, 27, 83, '2023-11-21', 329400, 1, ' DETALLE: DOC. REF: A703-1123 ABONO: 281.262 | DOC. REF: U18-1123 ABONO: 7406 | DOC. REF: P21-1123 ABONO: 40.732', 'bc60def29d1476803037568c9d3ab5d2288500a1b18d8ee65f8fab61bee30abd', '2023-11-21 15:53:55', 25, NULL, NULL),
(96, 28, 100, '2023-11-22', 30000, 1, 'PASARELA DE PAGOS DETALLE: DOC. REF: U11-1123 ABONO: 4938 | DOC. REF: P16-1123 ABONO: 25.062', '5f013bfdda0a7f350a60a416d2071b278c7ae9e587e0c64c79ae196ad5b2ff13', '2023-11-22 20:19:21', 32, NULL, NULL),
(97, 29, 100, '2023-11-22', 10000, 1, ' DETALLE: DOC. REF: P16-1123 ABONO: 10.000', 'cbf1fdc6fc7f198e0e60fab9cb33309a1b802b5b7e04ab587f291f27566a54e6', '2023-11-22 20:23:45', 24, NULL, NULL),
(98, 30, 77, '2023-11-22', 329400, 1, ' DETALLE: DOC. REF: A603-1123 ABONO: 281.262 | DOC. REF: 0U8-1123 ABONO: 7406 | DOC. REF: 0P8-1123 ABONO: 40.732', 'b0e88b2be8856bef0057ad36e03989e4df5feb8e5ef69512e740e8db604f04ff', '2023-11-23 01:09:13', 25, NULL, NULL),
(99, 31, 95, '2023-11-22', 42000, 1, ' DETALLE: DOC. REF: P32-1123 ABONO: 42.000', 'bce68d49f7ca1af3711cd5c58890d42c219eb9aae54ff1a200a29909f28fceb3', '2023-11-23 01:10:02', 25, NULL, NULL),
(100, 32, 69, '2023-11-22', 237200, 1, ' DETALLE: DOC. REF: A501-1123 ABONO: 195.234 | DOC. REF: U35-1123 ABONO: 4937 | DOC. REF: P14-1123 ABONO: 37.029', '2657f73f82e0693ae79b2f769d68089645a19495220fc78f21cdbf6d7537076f', '2023-11-23 01:11:02', 25, NULL, NULL),
(101, 33, 99, '2023-11-22', 46500, 1, ' DETALLE: DOC. REF: U26-1123 ABONO: 4937 | DOC. REF: P23-1123 ABONO: 41.563', '84b489dc1e999160912a37985b5171338043ffafa83e3eaa410efaf68fd614bb', '2023-11-23 01:11:49', 25, NULL, NULL),
(102, 34, 101, '2023-11-22', 279900, 1, ' DETALLE: DOC. REF: A906-1123 ABONO: 230.528 | DOC. REF: U15-1123 ABONO: 7405 | DOC. REF: P18-1123 ABONO: 41.967', '2556eddb20fcf5393bc4e8892741d7639bb900efaa85b7047fe06e4912ec571c', '2023-11-23 01:12:23', 25, NULL, NULL),
(103, 35, 76, '2023-11-22', 314700, 1, ' DETALLE: DOC. REF: A203-1123 ABONO: 281.448 | DOC. REF: A602-1123 ABONO: 33.252', '24967a2968433163b1c1872925bbd71897292c9b9b86d694e70a394e12e04f1d', '2023-11-23 01:13:35', 25, NULL, NULL),
(104, 36, 64, '2023-11-22', 315800, 1, ' DETALLE: DOC. REF: A402-1123 ABONO: 272.591 | DOC. REF: 0U4-1123 ABONO: 4945 | DOC. REF: 0P1-1123 ABONO: 38.264', 'c06d0b756d12f28ca92e9a478317211e89286c571b473f9f4cb902a30e05f22c', '2023-11-23 01:14:08', 25, NULL, NULL),
(105, 37, 88, '2023-11-22', 307400, 1, ' DETALLE: DOC. REF: A804-1123 ABONO: 258.028 | DOC. REF: U33-1123 ABONO: 12.343 | DOC. REF: 0P3-1123 ABONO: 37.029', '866e21b94216fd8ae7e27561fb229a69bff050881e7b1b99d8c5690a252541b2', '2023-11-23 01:14:47', 25, NULL, NULL),
(106, 38, 55, '2023-11-22', 260600, 1, ' DETALLE: DOC. REF: A205-1123 ABONO: 211.227 | DOC. REF: U28-1123 ABONO: 7406 | DOC. REF: P33-1123 ABONO: 41.967', 'a7749dd338588160b6153bf32f158bdf915b209cdf4ac0a756bbb2e274107100', '2023-11-23 01:15:37', 25, NULL, NULL),
(107, 39, 110, '2023-11-22', 322200, 1, ' DETALLE: DOC. REF: A602-1123 ABONO: 239.530 | DOC. REF: 0U1-1123 ABONO: 6156 | DOC. REF: 0P4-1123 ABONO: 34.596 | DOC. REF: P24-1123 ABONO: 41.918', '255c5cf728d6fef17bfc18d113424592053f102b5fbb0ec57e64f2eb1c07838d', '2023-11-23 01:16:39', 25, NULL, NULL),
(108, 40, 90, '2023-11-22', 261400, 1, ' DETALLE: DOC. REF: A806-1123 ABONO: 214.496 | DOC. REF: U12-1123 ABONO: 4937 | DOC. REF: P26-1123 ABONO: 41.967', 'd91fd7b64ce2d9fc649f22e4ae6b42206cbbf4643565e04fe2f46d84826f92f7', '2023-11-23 01:20:00', 25, NULL, NULL),
(109, 41, 70, '2023-11-22', 290800, 1, ' DETALLE: DOC. REF: A502-1123 ABONO: 18.742 | DOC. REF: 00000001 ABONO: 272.058', '4900aaf1057bf8bc1cca914120b47a3a580dd0a3dc8a032fe510996573f87e99', '2023-11-23 01:22:40', 25, NULL, NULL),
(110, 42, 62, '2023-11-22', 195000, 1, ' DETALLE: DOC. REF: A306-1123 ABONO: 195.000', '4ab7306adcf0c785fb486f39e65aeb5ceebb2858ef1885f98b44af7c0882361d', '2023-11-23 01:24:05', 25, NULL, NULL),
(114, 46, 85, '2023-11-29', 200000, 1, 'PASARELA DE PAGOS DETALLE: DOC. REF: A705-1123 ABONO: 200.000', 'f7e2cc747ab1631010ecbf0b38e4dce7d61952bf082e58a12534c0831bbeb136', '2023-11-29 20:12:53', 22, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `factura_recibo_caja_comprobante`
--

CREATE TABLE `factura_recibo_caja_comprobante` (
  `id` int NOT NULL,
  `id_persona` int NOT NULL,
  `id_recibo_caja` int DEFAULT NULL,
  `fecha` date NOT NULL,
  `valor` varchar(100) NOT NULL,
  `estado` int DEFAULT '0' COMMENT '0 - PENDIENTE, 1 - ACEPTADO, 2 - RECHAZADO, 3 - PREVIAMENTE REGISTRADO',
  `observacion_administrador` varchar(500) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `factura_recibo_caja_comprobante`
--

INSERT INTO `factura_recibo_caja_comprobante` (`id`, `id_persona`, `id_recibo_caja`, `fecha`, `valor`, `estado`, `observacion_administrador`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(5, 81, 113, '2023-11-28', '200000', 1, 'TODO BIEN', '2023-11-29 03:44:54', 21, '2023-11-29 03:47:42', 24),
(6, 81, 119, '2023-11-21', '160000', 1, '', '2023-11-30 02:33:00', 36, '2023-11-30 02:37:14', 24);

-- --------------------------------------------------------

--
-- Table structure for table `gastos`
--

CREATE TABLE `gastos` (
  `id` int NOT NULL,
  `id_persona_proveedor` int NOT NULL,
  `id_cuenta_x_pagar_egreso_gasto_erp` int DEFAULT NULL,
  `consecutivo` int DEFAULT NULL,
  `valor_total_iva` varchar(150) NOT NULL,
  `porcentaje_retencion` varchar(10) NOT NULL,
  `valor_total_retencion` varchar(150) NOT NULL,
  `valor_total` varchar(150) NOT NULL,
  `token_erp` varchar(150) NOT NULL,
  `url_comprobante_gasto` varchar(150) NOT NULL,
  `fecha_documento` date DEFAULT NULL,
  `observacion` text,
  `anulado` int NOT NULL DEFAULT '0' COMMENT '0 - NO, 1 - SI',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `gasto_detalle`
--

CREATE TABLE `gasto_detalle` (
  `id` int NOT NULL,
  `id_gasto` int NOT NULL,
  `id_concepto_gasto` int NOT NULL,
  `id_centro_costos_erp` varchar(100) DEFAULT NULL,
  `cantidad` int NOT NULL DEFAULT '1',
  `valor_unitario` varchar(150) NOT NULL DEFAULT '0',
  `porcentaje_iva` varchar(150) NOT NULL DEFAULT '0',
  `valor_unitario_iva` varchar(150) NOT NULL DEFAULT '0',
  `valor_total_iva` varchar(150) NOT NULL DEFAULT '0',
  `total` varchar(150) NOT NULL DEFAULT '0',
  `descripcion` text,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `gasto_pagos`
--

CREATE TABLE `gasto_pagos` (
  `id` int NOT NULL,
  `consecutivo` int NOT NULL,
  `id_persona` int NOT NULL,
  `fecha_pago` date DEFAULT NULL,
  `valor_pago` int NOT NULL,
  `estado` tinyint NOT NULL DEFAULT '1' COMMENT '0 - ANULADO, 1 - REGISTRADO',
  `observacion` varchar(500) DEFAULT NULL,
  `token_erp` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gasto_pagos`
--

INSERT INTO `gasto_pagos` (`id`, `consecutivo`, `id_persona`, `fecha_pago`, `valor_pago`, `estado`, `observacion`, `token_erp`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(10, 6, 113, '2023-11-23', 100000, 1, ' DETALLE: DOC. REF: 00000004 ABONO: 100.000', '8d4943608e20127108f4da7e99c2d53ffec48342a6a7331abd3fa9313864c1f8', '2023-11-23 16:36:47', 24, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `importador_historia`
--

CREATE TABLE `importador_historia` (
  `id` int NOT NULL,
  `id_modulo` int NOT NULL,
  `archivo` varchar(500) NOT NULL,
  `peso` varchar(10) NOT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `inmuebles`
--

CREATE TABLE `inmuebles` (
  `id` int NOT NULL,
  `id_inmueble_zona` int DEFAULT NULL,
  `tipo` int NOT NULL DEFAULT '0' COMMENT '0 - Inmueble, 1 - Parqueadero, 2 - Cuarto Util',
  `numero_interno_unidad` varchar(50) DEFAULT NULL,
  `area` varchar(20) DEFAULT NULL,
  `coeficiente` varchar(20) DEFAULT NULL,
  `valor_total_administracion` varchar(50) NOT NULL DEFAULT '0',
  `numero_perros` varchar(50) NOT NULL DEFAULT '0',
  `numero_gatos` varchar(50) NOT NULL DEFAULT '0',
  `observaciones` text,
  `eliminado` tinyint NOT NULL DEFAULT '0' COMMENT '0 - NO, 1 - SI',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inmuebles`
--

INSERT INTO `inmuebles` (`id`, `id_inmueble_zona`, `tipo`, `numero_interno_unidad`, `area`, `coeficiente`, `valor_total_administracion`, `numero_perros`, `numero_gatos`, `observaciones`, `eliminado`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(25, 1, 0, 'A201', '38.45', '0.0171', '211000', '0', '0', '', 0, 4, '2023-09-08 10:56:54', 25, '2023-11-09 09:39:50'),
(26, 1, 0, 'A202', '56.15', '0.0250', '308600', '0', '0', '', 0, 21, '2023-09-09 02:06:05', 25, '2023-11-09 09:39:50'),
(27, 1, 0, 'A203', '51.05', '0.0228', '281448', '0', '0', '', 0, 21, '2023-09-09 02:06:39', 25, '2023-11-09 09:39:50'),
(28, 1, 1, 'P4', '6.3', '0.0028', '34596', '0', '0', '', 0, 21, '2023-09-09 02:17:01', 24, '2023-11-21 20:33:07'),
(29, 1, 2, 'U1', '1.1', '0.0005', '6156', '0', '0', '', 0, 21, '2023-09-09 02:19:25', 25, '2023-11-09 09:39:50'),
(30, 1, 0, 'A204', '47.15', '0.0210', '259200', '0', '0', '', 0, 21, '2023-09-09 02:21:11', 25, '2023-11-09 09:39:50'),
(31, 1, 0, 'A205', '38.45', '0.0171', '211227', '0', '0', '', 0, 21, '2023-09-09 02:21:53', 4, '2023-11-09 17:18:10'),
(32, 1, 0, 'A206', '38.45', '0.0171', '210968', '0', '0', '', 0, 21, '2023-09-09 02:25:47', 25, '2023-11-09 09:39:50'),
(33, 1, 0, 'A301', '35.5', '0.0158', '195000', '0', '0', '', 0, 21, '2023-09-09 02:26:52', 25, '2023-11-09 09:39:50'),
(34, 1, 1, 'P33', '7.65', '0.0034', '41967', '0', '0', '', 0, 21, '2023-09-09 02:27:40', 4, '2023-11-09 17:17:01'),
(35, 1, 1, 'P38', '6.15', '0.0027', '33327', '0', '0', '', 0, 21, '2023-09-09 02:28:26', 21, '2023-11-09 09:39:50'),
(36, 1, 2, 'U28', '1.3', '0.0006', '7406', '0', '0', '', 0, 21, '2023-09-09 02:29:37', 4, '2023-11-09 17:16:44'),
(37, 1, 2, 'U30', '1.35', '0.0006', '7405', '0', '0', '', 0, 21, '2023-09-09 02:30:46', 24, '2023-11-21 20:38:20'),
(38, 1, 0, 'A302', '49.5', '0.0221', '272702', '0', '0', '', 0, 21, '2023-09-09 19:12:28', 25, '2023-11-09 09:39:50'),
(39, 1, 1, 'P5', '5.95', '0.0027', '33327', '0', '0', '', 0, 21, '2023-09-09 19:13:31', 21, '2023-11-09 09:39:50'),
(40, 1, 2, 'U2', '1.05', '0.0005', '6171', '0', '0', '', 0, 21, '2023-09-09 19:14:06', 21, '2023-11-09 09:39:50'),
(41, 1, 0, 'A303', '51.05', '0.0228', '281262', '0', '0', '', 0, 21, '2023-09-09 19:16:19', 25, '2023-11-09 09:39:50'),
(42, 1, 1, 'P9', '7.3', '0.0033', '40732', '0', '0', '', 0, 21, '2023-09-09 19:16:44', 24, '2023-11-09 09:39:50'),
(43, 1, 2, 'U9', '1.3', '0.0006', '7406', '0', '0', '', 0, 21, '2023-09-09 19:17:10', 24, '2023-11-09 09:39:50'),
(44, 1, 0, 'A304', '47.15', '0.0210', '259263', '0', '0', '', 0, 21, '2023-09-09 19:19:36', 25, '2023-11-09 09:39:50'),
(47, 1, 0, 'A305', '35.5', '0.0158', '195000', '0', '0', '', 0, 21, '2023-09-09 20:02:49', 25, '2023-11-09 09:39:50'),
(48, 1, 2, 'U7', '1.3', '0.0006', '7406', '0', '0', '', 0, 21, '2023-09-09 20:03:32', 24, '2023-11-09 09:39:50'),
(49, 1, 1, 'P7', '7.3', '0.0033', '40731', '0', '0', '', 0, 21, '2023-09-09 20:03:56', 24, '2023-11-21 20:43:26'),
(50, 1, 0, 'A306', '35.5', '0.0158', '195000', '0', '0', '', 0, 21, '2023-09-09 20:04:43', 25, '2023-11-09 09:39:50'),
(52, 1, 0, 'A401', '35.5', '0.0158', '195264', '0', '0', '', 0, 21, '2023-09-09 20:06:27', 25, '2023-11-09 09:39:50'),
(53, 1, 1, 'P22', '7.3', '0.0033', '40730', '0', '0', '', 0, 21, '2023-09-09 20:06:55', 25, '2023-11-09 09:39:50'),
(54, 1, 2, 'U19', '1.3', '0.0006', '7406', '0', '0', '', 0, 21, '2023-09-09 20:07:14', 24, '2023-11-09 09:39:50'),
(55, 1, 0, 'A402', '49.5', '0.0221', '272591', '0', '0', '', 0, 21, '2023-09-09 20:07:47', 25, '2023-11-09 09:39:50'),
(56, 1, 1, 'P1', '6.85', '0.0031', '38264', '0', '0', '', 0, 21, '2023-09-09 20:08:03', 24, '2023-11-21 20:44:36'),
(57, 1, 2, 'U4', '1', '0.0004', '4945', '0', '0', '', 0, 21, '2023-09-09 20:08:19', 25, '2023-11-09 09:39:50'),
(58, 1, 0, 'A403', '51.05', '0.0228', '281200', '0', '0', '', 0, 21, '2023-09-09 20:08:40', 25, '2023-11-09 09:39:50'),
(59, 1, 1, 'P2', '6.63', '0.0030', '37029', '0', '0', '', 0, 21, '2023-09-09 20:09:14', 21, '2023-11-09 09:39:50'),
(60, 1, 2, 'U5', '1.05', '0.0005', '6171', '0', '0', '', 0, 21, '2023-09-09 20:09:31', 21, '2023-11-09 09:39:50'),
(61, 1, 0, 'A404', '47.15', '0.0210', '259200', '0', '0', '', 0, 21, '2023-09-09 20:10:15', 25, '2023-11-09 09:39:50'),
(62, 1, 0, 'A405', '35.25', '0.0157', '193842', '0', '0', 'LE RESTE .25 AQRA QUE DE 100 LAS AREAS. MIRQAR CON ADOLFO. ESTO ES TEMPORAL.', 0, 21, '2023-09-09 20:10:57', 24, '2023-11-27 03:34:16'),
(63, 1, 1, 'P28', '6.45', '0.0029', '35796', '0', '0', '', 0, 21, '2023-09-09 20:11:11', 24, '2023-11-09 09:39:50'),
(64, 1, 2, 'U21', '1.3', '0.0006', '7405', '0', '0', '', 0, 21, '2023-09-09 20:11:24', 24, '2023-11-21 20:49:03'),
(65, 1, 0, 'A406', '35.3', '0.0157', '195000', '0', '0', '', 0, 21, '2023-09-09 20:12:23', 25, '2023-11-09 09:39:50'),
(66, 1, 0, 'A501', '35.5', '0.0158', '195234', '0', '0', '', 0, 21, '2023-09-09 20:12:50', 25, '2023-11-09 09:39:50'),
(67, 1, 1, 'P14', '6.63', '0.0030', '37029', '0', '0', '', 0, 21, '2023-09-09 20:13:17', 21, '2023-11-09 09:39:50'),
(68, 1, 2, 'U35', '1', '0.0004', '4937', '0', '0', '', 0, 21, '2023-09-09 20:13:45', 24, '2023-11-21 20:49:42'),
(69, 1, 0, 'A502', '49.5', '0.0221', '272862', '0', '0', '', 0, 21, '2023-09-09 20:14:41', 25, '2023-11-09 09:39:50'),
(70, 1, 2, 'U34', '0.98', '0.0004', '4938', '0', '0', '', 0, 21, '2023-09-09 20:15:35', 21, '2023-11-09 09:39:50'),
(71, 1, 0, 'A503', '51.05', '0.0228', '281562', '0', '0', '', 0, 21, '2023-09-09 20:17:02', 25, '2023-11-09 09:39:50'),
(73, 1, 0, 'A504', '47.15', '0.0210', '256758', '0', '0', '', 0, 21, '2023-09-09 20:17:47', 24, '2023-11-21 20:55:25'),
(74, 1, 2, 'U13', '1', '0.0004', '4938', '0', '0', '', 0, 21, '2023-09-09 20:18:10', 21, '2023-11-09 09:39:50'),
(75, 1, 2, 'U6', '1.35', '0.0006', '7406', '0', '0', '', 0, 21, '2023-09-09 20:18:33', 21, '2023-11-09 09:39:50'),
(76, 1, 0, 'A505', '35.5', '0.0158', '195170', '0', '0', '', 0, 21, '2023-09-09 20:19:25', 25, '2023-11-09 09:39:50'),
(77, 1, 1, 'P29', '5.75', '0.0026', '32092', '0', '0', '', 0, 21, '2023-09-09 20:19:47', 21, '2023-11-09 09:39:50'),
(78, 1, 2, 'U3', '1', '0.0004', '4938', '0', '0', '', 0, 21, '2023-09-09 20:20:06', 21, '2023-11-09 09:39:50'),
(79, 1, 0, 'A506', '35.5', '0.0158', '195000', '0', '0', '', 0, 21, '2023-09-09 20:22:58', 24, '2023-11-21 20:58:16'),
(80, 1, 0, 'A601', '35.5', '0.0158', '195095', '0', '0', '', 0, 21, '2023-09-09 20:23:23', 24, '2023-11-21 20:58:55'),
(81, 1, 1, 'P25', '7.65', '0.0034', '41967', '0', '0', '', 0, 21, '2023-09-09 20:23:38', 21, '2023-11-09 09:39:50'),
(82, 1, 2, 'U27', '1', '0.0004', '4938', '0', '0', '', 0, 21, '2023-09-09 20:23:55', 24, '2023-11-09 09:39:50'),
(83, 1, 0, 'A602', '49.5', '0.0221', '272782', '0', '0', '', 0, 21, '2023-09-09 20:24:18', 25, '2023-11-09 09:39:50'),
(84, 1, 1, 'P24', '7.65', '0.0034', '41918', '0', '0', '', 0, 21, '2023-09-09 20:24:33', 24, '2023-11-21 21:00:48'),
(85, 1, 0, 'A603', '51.05', '0.0228', '281262', '0', '0', '', 0, 21, '2023-09-09 20:25:01', 25, '2023-11-09 09:39:50'),
(86, 1, 1, 'P8', '7.3', '0.0033', '40732', '0', '0', '', 0, 21, '2023-09-09 20:25:14', 21, '2023-11-09 09:39:50'),
(87, 1, 2, 'U8', '1.3', '0.0006', '7406', '0', '0', '', 0, 21, '2023-09-09 20:25:28', 21, '2023-11-09 09:39:50'),
(88, 1, 0, 'A604', '47.15', '0.0210', '259098', '0', '0', '', 0, 21, '2023-09-09 20:25:54', 25, '2023-11-09 09:39:50'),
(89, 1, 1, 'P36', '6.45', '0.0029', '35796', '0', '0', '', 0, 21, '2023-09-09 20:26:12', 21, '2023-11-09 09:39:50'),
(90, 1, 2, 'U29', '1.3', '0.0006', '7406', '0', '0', '', 0, 21, '2023-09-09 20:26:40', 21, '2023-11-09 09:39:50'),
(91, 1, 0, 'A605', '35.5', '0.0158', '194991', '0', '0', '', 0, 21, '2023-09-09 20:27:03', 25, '2023-11-09 09:39:50'),
(92, 1, 2, 'U32', '2.1', '0.0009', '11109', '0', '0', '', 0, 21, '2023-09-09 20:27:22', 21, '2023-11-09 09:39:50'),
(93, 1, 0, 'A606', '35.5', '0.0158', '196000', '0', '0', '', 0, 21, '2023-09-09 20:27:46', 24, '2023-11-21 21:05:11'),
(94, 1, 1, 'P15', '6.63', '0.0030', '37029', '0', '0', '', 0, 21, '2023-09-09 20:28:06', 21, '2023-11-09 09:39:50'),
(95, 1, 2, 'U14', '1.05', '0.0005', '6171', '0', '0', '', 0, 21, '2023-09-09 20:28:20', 21, '2023-11-09 09:39:50'),
(96, 1, 0, 'A701', '35.5', '0.0158', '195168', '0', '0', '', 0, 21, '2023-09-09 20:28:40', 25, '2023-11-09 09:39:50'),
(97, 1, 1, 'P30', '6.15', '0.0027', '33327', '0', '0', '', 0, 21, '2023-09-09 20:28:53', 21, '2023-11-09 09:39:50'),
(98, 1, 2, 'U22', '1.35', '0.0006', '7405', '0', '0', '', 0, 21, '2023-09-09 20:29:04', 24, '2023-11-21 22:17:46'),
(99, 1, 0, 'A702', '49.5', '0.0221', '272662', '0', '0', '', 0, 21, '2023-09-09 20:29:18', 25, '2023-11-09 09:39:50'),
(100, 1, 1, 'P27', '7.35', '0.0033', '40732', '0', '0', '', 0, 21, '2023-09-09 20:29:48', 21, '2023-11-09 09:39:50'),
(101, 1, 2, 'U20', '1.3', '0.0006', '7406', '0', '0', '', 0, 21, '2023-09-09 20:30:01', 21, '2023-11-09 09:39:50'),
(102, 1, 0, 'A703', '51.05', '0.0228', '281262', '0', '0', '', 0, 21, '2023-09-09 20:30:22', 25, '2023-11-09 09:39:50'),
(103, 1, 1, 'P21', '7.3', '0.0033', '40732', '0', '0', '', 0, 21, '2023-09-09 20:30:43', 21, '2023-11-09 09:39:50'),
(104, 1, 2, 'U18', '1.3', '0.0006', '7406', '0', '0', '', 0, 21, '2023-09-09 20:30:59', 21, '2023-11-09 09:39:50'),
(105, 1, 0, 'A704', '47.15', '0.0210', '259200', '0', '0', '', 0, 21, '2023-09-09 20:31:15', 25, '2023-11-09 09:39:50'),
(106, 1, 0, 'A705', '39.25', '0.0175', '214900', '0', '0', '', 0, 21, '2023-09-09 20:31:56', 24, '2023-11-21 22:20:14'),
(107, 1, 0, 'A706', '39.25', '0.0175', '214900', '0', '0', '', 0, 21, '2023-09-09 20:32:48', 24, '2023-11-21 22:53:33'),
(108, 1, 0, 'A803', '51.05', '0.0228', '281239', '0', '0', '', 0, 21, '2023-09-09 20:33:09', 24, '2023-11-21 22:54:32'),
(109, 1, 0, 'A804', '47.15', '0.0210', '258028', '0', '0', '', 0, 21, '2023-09-09 20:34:46', 25, '2023-11-09 09:39:50'),
(110, 1, 1, 'P17', '6.18', '0.0028', '34561', '0', '0', '', 0, 21, '2023-09-09 20:36:16', 21, '2023-11-09 09:39:50'),
(111, 1, 1, 'P3', '6.63', '0.0030', '37029', '0', '0', '', 0, 21, '2023-09-09 20:37:11', 21, '2023-11-09 09:39:50'),
(113, 1, 0, 'A806', '39.25', '0.0175', '214496', '0', '0', '', 0, 21, '2023-09-09 20:37:54', 25, '2023-11-09 09:39:50'),
(114, 1, 1, 'P26', '7.55', '0.0034', '41967', '0', '0', '', 0, 21, '2023-09-09 20:38:09', 21, '2023-11-09 09:39:50'),
(115, 1, 2, 'U12', '1', '0.0004', '4937', '0', '0', '', 0, 21, '2023-09-09 20:38:26', 24, '2023-11-21 22:55:47'),
(116, 1, 0, 'A903', '63.1', '0.0281', '346863', '0', '0', '', 0, 21, '2023-09-09 20:39:21', 25, '2023-11-09 09:39:50'),
(117, 1, 1, 'P19', '7.3', '0.0033', '40731', '0', '0', '', 0, 21, '2023-09-09 20:48:27', 24, '2023-11-21 22:56:45'),
(118, 1, 2, 'U16', '1.3', '0.0006', '7406', '0', '0', '', 0, 21, '2023-09-09 20:48:42', 21, '2023-11-09 09:39:50'),
(119, 1, 0, 'A904', '57.4', '0.0256', '315963', '0', '0', '', 0, 21, '2023-09-09 20:49:37', 25, '2023-11-09 09:39:50'),
(120, 1, 1, 'P10', '7.3', '0.0033', '40732', '0', '0', '', 0, 21, '2023-09-09 20:49:53', 21, '2023-11-09 09:39:50'),
(121, 1, 2, 'U10', '1.3', '0.0006', '7405', '0', '0', '', 0, 21, '2023-09-09 20:50:10', 24, '2023-11-21 22:57:29'),
(122, 1, 2, 'U33', '2.15', '0.0010', '12343', '0', '0', '', 0, 21, '2023-09-09 20:52:34', 21, '2023-11-09 09:39:50'),
(123, 1, 0, 'A805', '39.25', '0.0175', '214493', '0', '0', '', 0, 21, '2023-09-09 20:53:05', 24, '2023-11-22 16:29:46'),
(124, 1, 1, 'P12', '7.8', '0.0035', '43201', '0', '0', '', 0, 21, '2023-09-09 20:53:18', 21, '2023-11-09 09:39:50'),
(125, 1, 2, 'U23', '1.28', '0.0006', '7406', '0', '0', '', 0, 21, '2023-09-09 20:53:33', 21, '2023-11-09 09:39:50'),
(126, 1, 0, 'A905', '42.2', '0.0188', '230763', '0', '0', '', 0, 21, '2023-09-09 20:54:55', 25, '2023-11-09 09:39:50'),
(127, 1, 1, 'P20', '7.3', '0.0033', '40732', '0', '0', '', 0, 21, '2023-09-09 20:55:06', 24, '2023-11-09 09:39:50'),
(128, 1, 2, 'U17', '1.3', '0.0006', '7405', '0', '0', '', 0, 21, '2023-09-09 20:55:23', 24, '2023-11-21 22:58:11'),
(129, 1, 0, 'A906', '42.2', '0.0188', '230528', '0', '0', '', 0, 21, '2023-09-09 20:55:48', 25, '2023-11-09 09:39:50'),
(130, 1, 1, 'P18', '7.55', '0.0034', '41967', '0', '0', '', 0, 21, '2023-09-09 20:56:00', 24, '2023-11-09 09:39:50'),
(131, 1, 2, 'U15', '1.35', '0.0006', '7405', '0', '0', '', 0, 21, '2023-09-09 20:56:11', 25, '2023-11-21 16:13:48'),
(132, 1, 1, 'P16', '7.43', '0.0033', '40762', '0', '0', '', 0, 21, '2023-09-09 20:56:53', 25, '2023-11-09 09:39:50'),
(133, 1, 2, 'U11', '0.8', '0.0004', '4938', '0', '0', '', 0, 21, '2023-09-09 20:57:17', 24, '2023-11-09 09:39:50'),
(134, 1, 1, 'P23', '7.58', '0.0034', '41563', '0', '0', '', 0, 21, '2023-09-09 20:58:44', 25, '2023-11-09 09:39:50'),
(135, 1, 2, 'U26', '0.98', '0.0004', '4937', '0', '0', '', 0, 21, '2023-09-09 20:59:55', 25, '2023-11-21 16:12:38'),
(136, 1, 1, 'P34', '7.55', '0.0034', '40657', '0', '0', '', 0, 21, '2023-09-09 21:00:13', 24, '2023-11-21 23:23:27'),
(137, 1, 2, 'U25', '2.15', '0.0010', '12343', '0', '0', '', 0, 21, '2023-09-09 21:00:28', 25, '2023-11-09 09:39:50'),
(138, 1, 1, 'P11', '7.65', '0.0034', '42000', '0', '0', '', 0, 21, '2023-09-09 21:01:04', 25, '2023-11-09 09:39:50'),
(139, 1, 1, 'P13', '6.85', '0.0031', '42000', '0', '0', '', 0, 21, '2023-09-09 21:01:59', 24, '2023-11-21 23:12:07'),
(140, 1, 1, 'P31', '7.58', '0.0034', '48300', '0', '0', '', 0, 21, '2023-09-09 21:02:21', 25, '2023-11-09 09:39:50'),
(141, 1, 1, 'P32', '7.65', '0.0034', '42000', '0', '0', '', 0, 21, '2023-09-09 21:02:43', 25, '2023-11-09 09:39:50'),
(142, 1, 1, 'P35', '7.2', '0.0032', '39500', '0', '0', '', 0, 21, '2023-09-09 21:03:09', 25, '2023-11-09 09:39:50'),
(143, 1, 1, 'P37', '5.75', '0.0026', '39600', '0', '0', '', 0, 21, '2023-09-09 21:03:58', 24, '2023-11-21 23:15:21'),
(144, 1, 2, 'U31', '1.28', '0.0006', '0', '0', '0', '', 0, 21, '2023-09-09 21:04:45', 25, '2023-11-25 00:04:49'),
(145, 1, 2, 'U24', '2.1', '0.0009', '11100', '0', '0', '', 0, 21, '2023-09-09 21:05:15', 4, '2023-11-09 09:39:50'),
(146, 1, 1, 'P6', '8', '0.0036', '44436', '0', '0', '', 0, 21, '2023-09-11 05:54:25', 4, '2023-11-09 09:39:50'),
(147, 1, 0, 'a1', '10', '0.0045', '55544', '0', '0', '', 1, 25, '2023-10-29 01:05:24', 25, '2023-11-09 09:39:50'),
(148, 1, 0, '1', '1', '0.0004', '4938', '1', '1', '1', 1, NULL, '2023-11-06 20:59:00', NULL, '2023-11-09 09:39:50');

-- --------------------------------------------------------

--
-- Table structure for table `inmueble_mascotas`
--

CREATE TABLE `inmueble_mascotas` (
  `id` int NOT NULL,
  `id_inmueble` int NOT NULL,
  `tipo` int NOT NULL DEFAULT '2' COMMENT '0 - CANINO, 1 - FELINO, 2 - OTRO',
  `nombre` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `observacion` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inmueble_mascotas`
--

INSERT INTO `inmueble_mascotas` (`id`, `id_inmueble`, `tipo`, `nombre`, `avatar`, `observacion`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(4, 96, 0, 'KATIUSKA', '1701082146334-cbc79d7f4e6284dc33e52bff953e31da6f79a9af7966538f7c659fbc1718a76e.jpg', '', '2023-11-27 10:48:14', 21, '2023-11-27 10:49:06', 21);

-- --------------------------------------------------------

--
-- Table structure for table `inmueble_personas_admon`
--

CREATE TABLE `inmueble_personas_admon` (
  `id` int NOT NULL,
  `id_inmueble` int NOT NULL,
  `id_persona` int DEFAULT NULL,
  `tipo` tinyint NOT NULL DEFAULT '0' COMMENT '0 - PROPIETARIO, 1 - INQUILINO',
  `porcentaje_administracion` varchar(50) NOT NULL DEFAULT '0',
  `paga_administracion` tinyint NOT NULL DEFAULT '0' COMMENT '0 - NO, 1 - SI',
  `importado` tinyint DEFAULT '0',
  `enviar_notificaciones` tinyint NOT NULL DEFAULT '0' COMMENT '0 - NO, 1 - SI',
  `enviar_notificaciones_mail` int NOT NULL DEFAULT '0',
  `enviar_notificaciones_fisica` int NOT NULL DEFAULT '0',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inmueble_personas_admon`
--

INSERT INTO `inmueble_personas_admon` (`id`, `id_inmueble`, `id_persona`, `tipo`, `porcentaje_administracion`, `paga_administracion`, `importado`, `enviar_notificaciones`, `enviar_notificaciones_mail`, `enviar_notificaciones_fisica`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(26, 25, 52, 0, '100', 1, 0, 1, 0, 1, 21, '2023-09-08 13:06:45', 21, '2023-09-08 14:49:32'),
(28, 26, 53, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 02:11:43', NULL, NULL),
(29, 27, 110, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 02:15:37', 25, '2023-10-19 22:03:53'),
(30, 28, 110, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 02:18:59', 25, '2023-10-19 22:03:14'),
(31, 29, 110, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 02:19:47', 25, '2023-10-19 22:04:46'),
(32, 30, 54, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 02:21:32', NULL, NULL),
(33, 31, 55, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 02:22:26', NULL, NULL),
(34, 32, 56, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 02:26:11', NULL, NULL),
(35, 33, 57, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 02:27:08', NULL, NULL),
(36, 34, 55, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 02:27:57', NULL, NULL),
(37, 35, 56, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 02:29:05', NULL, NULL),
(38, 36, 55, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 02:30:07', NULL, NULL),
(39, 37, 56, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 02:35:02', NULL, NULL),
(40, 40, 58, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 19:14:38', NULL, NULL),
(41, 39, 58, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 19:15:03', NULL, NULL),
(42, 38, 58, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 19:15:43', NULL, NULL),
(43, 43, 59, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 19:17:41', NULL, NULL),
(44, 42, 59, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 19:18:05', NULL, NULL),
(45, 41, 59, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 19:18:22', NULL, NULL),
(46, 46, 60, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 19:21:09', NULL, NULL),
(47, 45, 60, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 19:21:29', NULL, NULL),
(48, 44, 60, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-09 19:21:57', NULL, NULL),
(53, 115, 90, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 02:44:36', NULL, NULL),
(54, 114, 90, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 02:45:14', NULL, NULL),
(55, 113, 90, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 02:45:48', NULL, NULL),
(56, 145, 93, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 02:55:48', 25, '2023-10-03 01:33:37'),
(57, 143, 94, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 02:58:31', NULL, NULL),
(58, 144, 94, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 02:58:54', NULL, NULL),
(59, 142, 108, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 03:27:33', 25, '2023-11-02 22:05:08'),
(60, 141, 95, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:08:49', NULL, NULL),
(61, 140, 96, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:12:20', NULL, NULL),
(62, 139, 98, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:14:47', NULL, NULL),
(63, 138, 97, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:15:30', NULL, NULL),
(64, 137, 109, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:17:13', 25, '2023-10-24 20:35:05'),
(65, 136, 109, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:17:41', 25, '2023-10-24 20:34:03'),
(66, 135, 99, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:20:01', NULL, NULL),
(67, 134, 99, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:20:23', NULL, NULL),
(68, 133, 100, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:22:15', NULL, NULL),
(69, 132, 100, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:22:40', NULL, NULL),
(70, 131, 101, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:25:07', NULL, NULL),
(71, 130, 101, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:25:29', NULL, NULL),
(72, 129, 101, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:34:36', NULL, NULL),
(73, 128, 102, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:35:56', NULL, NULL),
(74, 127, 102, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:36:21', NULL, NULL),
(75, 126, 102, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:36:42', NULL, NULL),
(76, 125, 89, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:42:13', NULL, NULL),
(77, 124, 89, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:42:37', NULL, NULL),
(78, 123, 89, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:43:30', NULL, NULL),
(79, 122, 88, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:49:29', NULL, NULL),
(80, 111, 88, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:50:17', NULL, NULL),
(81, 109, 88, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:50:54', NULL, NULL),
(82, 110, 87, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:53:00', NULL, NULL),
(83, 108, 87, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 17:53:44', NULL, NULL),
(84, 58, 65, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 18:18:54', NULL, NULL),
(85, 59, 65, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 18:20:01', NULL, NULL),
(86, 60, 65, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 18:20:37', NULL, NULL),
(87, 119, 92, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 18:21:32', NULL, NULL),
(88, 120, 92, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 18:22:03', NULL, NULL),
(89, 121, 92, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 18:22:39', NULL, NULL),
(90, 116, 91, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 18:25:01', NULL, NULL),
(91, 117, 91, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 18:25:32', NULL, NULL),
(92, 118, 91, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 18:26:09', NULL, NULL),
(93, 66, 69, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 18:27:09', NULL, NULL),
(94, 68, 69, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 18:27:42', NULL, NULL),
(95, 107, 86, 0, '100', 1, 0, 1, 1, 1, 21, '2023-09-10 20:06:24', 25, '2023-09-19 22:04:41'),
(96, 106, 85, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 20:08:52', NULL, NULL),
(97, 97, 81, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 20:10:57', NULL, NULL),
(98, 98, 81, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 20:12:34', NULL, NULL),
(99, 96, 81, 0, '100', 1, 0, 1, 1, 1, 21, '2023-09-10 20:13:02', 25, '2023-09-13 03:26:05'),
(100, 100, 82, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 20:14:31', NULL, NULL),
(101, 101, 82, 0, '100', 1, 0, 0, 0, 1, 21, '2023-09-10 20:16:11', 21, '2023-09-10 20:16:25'),
(102, 99, 82, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-10 20:16:58', NULL, NULL),
(103, 103, 83, 0, '100', 1, 0, 1, 0, 1, 21, '2023-09-10 20:19:02', 21, '2023-09-10 20:19:11'),
(104, 47, 61, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 00:06:31', NULL, NULL),
(105, 105, 84, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 00:09:57', NULL, NULL),
(106, 104, 83, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 00:11:46', 25, '2023-10-25 03:25:22'),
(107, 102, 83, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 00:13:05', 25, '2023-10-25 03:20:57'),
(108, 85, 77, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 04:59:48', NULL, NULL),
(109, 86, 77, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:00:36', NULL, NULL),
(110, 87, 77, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:01:09', NULL, NULL),
(111, 95, 80, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:04:27', NULL, NULL),
(112, 94, 80, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:04:55', NULL, NULL),
(113, 93, 80, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:05:32', NULL, NULL),
(114, 50, 62, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:08:30', NULL, NULL),
(115, 92, 79, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:09:30', NULL, NULL),
(116, 91, 79, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:10:16', NULL, NULL),
(117, 90, 78, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:11:57', NULL, NULL),
(118, 88, 78, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:13:13', NULL, NULL),
(119, 89, 78, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:14:48', NULL, NULL),
(120, 84, 76, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:15:40', NULL, NULL),
(121, 83, 76, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:16:10', 25, '2023-11-02 22:02:47'),
(122, 82, 75, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:17:12', NULL, NULL),
(123, 81, 75, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:18:12', NULL, NULL),
(124, 80, 75, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:18:31', NULL, NULL),
(125, 49, 60, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:19:14', NULL, NULL),
(126, 48, 60, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:19:47', NULL, NULL),
(127, 146, 72, 0, '100', 1, 0, 1, 0, 0, 21, '2023-09-11 05:55:04', 25, '2023-09-21 03:01:22'),
(128, 75, 72, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 05:55:50', NULL, NULL),
(130, 77, 73, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 06:13:13', NULL, NULL),
(131, 78, 73, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 06:15:06', NULL, NULL),
(132, 76, 73, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 06:15:33', NULL, NULL),
(133, 70, 70, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 06:18:49', NULL, NULL),
(134, 69, 70, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 06:19:41', NULL, NULL),
(135, 74, 71, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 06:21:24', NULL, NULL),
(136, 71, 71, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 06:21:50', NULL, NULL),
(137, 73, 72, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 06:25:17', NULL, NULL),
(138, 52, 63, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 06:26:20', NULL, NULL),
(139, 53, 63, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 06:27:18', NULL, NULL),
(140, 67, 69, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 15:11:01', NULL, NULL),
(141, 65, 68, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 15:12:00', NULL, NULL),
(142, 64, 67, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 15:12:46', NULL, NULL),
(143, 63, 67, 0, '100', 1, 0, 1, 1, 1, 21, '2023-09-11 15:13:23', 25, '2023-09-21 19:27:23'),
(144, 62, 67, 0, '100', 1, 0, 1, 1, 1, 21, '2023-09-11 15:14:14', 25, '2023-09-19 21:54:31'),
(145, 57, 64, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 15:15:50', NULL, NULL),
(146, 56, 64, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 15:16:18', NULL, NULL),
(147, 55, 64, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 15:16:41', NULL, NULL),
(148, 61, 66, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 15:25:31', NULL, NULL),
(149, 54, 63, 0, '100', 1, 0, 0, 0, 0, 21, '2023-09-11 15:26:44', NULL, NULL),
(156, 79, 74, 0, '100', 1, 0, 0, 0, 0, 25, '2023-11-24 15:42:51', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `inmueble_personas_visitantes`
--

CREATE TABLE `inmueble_personas_visitantes` (
  `id` int NOT NULL,
  `id_inmueble` int NOT NULL,
  `id_persona_autoriza` int NOT NULL,
  `persona_visitante` varchar(500) DEFAULT NULL,
  `persona_visitante_avatar` varchar(150) DEFAULT NULL,
  `dias_autorizados` int NOT NULL DEFAULT '0' COMMENT '1 - Lunes, 2 - Martes, 4 - Miércoles, 8 - Jueves, 16 - Viernes, 32 - Sábado, 64 - Domingo',
  `fecha_autoriza` longtext,
  `observacion` text,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inmueble_personas_visitantes`
--

INSERT INTO `inmueble_personas_visitantes` (`id`, `id_inmueble`, `id_persona_autoriza`, `persona_visitante`, `persona_visitante_avatar`, `dias_autorizados`, `fecha_autoriza`, `observacion`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(20, 96, 81, 'CLAUDIA', NULL, 0, '2023-09-11', '', 21, '2023-09-11 15:34:09', 21, '2023-09-11 15:36:53'),
(22, 62, 67, 'luis carlos acevedo', '1694575306597-3c54e287102aa8e812168dc9bd801f8f72c0c8ef5d5c6bbe327bdc68827997da.jpg', 0, '2023-09-26', 'JARDINERO PRIVADO', 25, '2023-09-13 01:39:06', 4, '2023-09-27 00:43:25'),
(23, 62, 67, 'luis fernando garces', '1694575353511-48a8d9ca65d4ffed5d24d09cde13ef76320e7d4ebf468bcfcb5c4a17f87785a9.jpg', 19, NULL, 'SEÑOR DE EDAD', 25, '2023-09-13 03:22:17', 4, '2023-09-27 00:44:15'),
(24, 62, 67, 'conductor', '1694575392745-0380db97ec507816cb2435f11d56f1bfe151dea2ae25a75859e9b2f0417dda5b.jpg', 63, NULL, 'VIENE EN MOTO', 25, '2023-09-13 03:23:04', 25, '2023-09-13 03:23:12'),
(25, 62, 67, 'mis hijos, carlota y simon', '1694575442697-816a1b99ac43d3afcb36c23c4a2243f56b42fd26155feaabd07683cdaf42f05a.jpg', 127, NULL, 'DE 10 Y 12 AÑOS', 25, '2023-09-13 03:23:54', 25, '2023-09-13 03:24:02'),
(26, 62, 67, 'jorge hernandez', '1694575482301-449af8a0bdec00c5d8d26693c53895895f7e7d42ac9e04e036ab25695dcc52cd.avif', 127, NULL, 'MI ESPOSO', 25, '2023-09-13 03:24:34', 25, '2023-09-13 03:24:42'),
(27, 62, 67, 'paco', '1694629090042-d4e8973e04e657a4c6166748380356dcecd142b56137bd3a9e6d0d75744a1482.jpg', 127, NULL, 'GATICO', 25, '2023-09-13 18:17:24', 25, '2023-09-13 18:18:10'),
(28, 62, 67, 'PULTERMAN', '1694629082231-8fc9c94f022d84cf039b70ae22bc104792906a105462e9765dd6d86aa345d4b0.png', 127, NULL, 'MINIATURA', 25, '2023-09-13 18:17:52', 25, '2023-09-13 18:18:02'),
(30, 106, 85, 'Norberto', NULL, 7, NULL, 'QUIROPRÁCTICO ', 22, '2023-09-20 22:58:19', NULL, NULL),
(31, 96, 81, 'juan carlos velez', NULL, 0, '2023-09-20', 'VIENE SOLO', 21, '2023-09-21 01:04:03', NULL, NULL),
(32, 96, 81, 'Jose beccera', '1695617120647-fe46bd16c878a634e9456f1cacb241fb98bb642759db0fc3141facf422a715e3.jpg', 0, '2023-09-23', 'VIEJE BICI', 21, '2023-09-23 15:51:08', 21, '2023-09-25 04:45:20'),
(34, 106, 85, 'TEST', NULL, 0, '2023-09-24', 'VIENE EN BICICLETAS', 22, '2023-09-24 09:19:15', NULL, NULL),
(35, 106, 85, 'Juan guillermo', NULL, 0, '2023-10-06', 'DOMICILIO ', 22, '2023-10-06 21:47:34', 22, '2023-10-06 21:55:18'),
(36, 96, 81, 'Alicia ', '1696990904113-0b32496f5790fdc884f25ecb8e5f001f536e5fd590b260205723df3fcc20b25f.jpg', 0, '2023-10-10', 'TIENE LLAVES DE LA CASA ', 21, '2023-10-11 02:11:29', 21, '2023-10-11 02:21:44'),
(38, 96, 81, 'CARLOS BENJUMEA', NULL, 4, NULL, 'TRAE UN PARQUETE DE PORCELAN Y DE NAVIDAD', 21, '2023-11-22 20:41:09', 21, '2023-11-22 20:42:25');

-- --------------------------------------------------------

--
-- Table structure for table `inmueble_vehiculos`
--

CREATE TABLE `inmueble_vehiculos` (
  `id` int NOT NULL,
  `id_inmueble` int NOT NULL,
  `id_tipo_vehiculo` int NOT NULL,
  `id_persona_autoriza` int NOT NULL,
  `placa` varchar(50) DEFAULT NULL,
  `dias_autorizados` int NOT NULL DEFAULT '0' COMMENT '1 - Lunes, 2 - Martes, 4 - Miércoles, 8 - Jueves, 16 - Viernes, 32 - Sábado, 64 - Domingo',
  `fecha_autoriza` longtext,
  `observacion` text,
  `avatar` varchar(500) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inmueble_vehiculos`
--

INSERT INTO `inmueble_vehiculos` (`id`, `id_inmueble`, `id_tipo_vehiculo`, `id_persona_autoriza`, `placa`, `dias_autorizados`, `fecha_autoriza`, `observacion`, `avatar`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(16, 106, 8, 85, 'Qpw12q', 0, '2023-09-19', 'JASINTO', NULL, 22, '2023-09-19 18:25:56', NULL, NULL),
(17, 96, 14, 81, 'Qwp123', 0, '2023-09-19', 'CALICHE', NULL, 21, '2023-09-19 18:37:47', NULL, NULL),
(18, 106, 14, 85, 'Asf765', 112, NULL, 'RECOGER PAQUETES ', NULL, 22, '2023-09-20 22:59:25', NULL, NULL),
(19, 63, 14, 67, 'kpv265', 127, NULL, 'PROPIO', NULL, 25, '2023-09-21 19:29:31', NULL, NULL),
(20, 146, 8, 72, 'ETH', 0, '2023-09-24', '', '1695575422803-f3239a2b9474400b1a430cec1e828c02ec1efbd20378f4a095452212682d4e38.jpeg', 4, '2023-09-24 16:00:14', 4, '2023-09-24 17:10:23'),
(21, 25, 8, 52, 'ETH', 0, '2023-09-24', '', '1695575726475-f3239a2b9474400b1a430cec1e828c02ec1efbd20378f4a095452212682d4e38.jpeg', 4, '2023-09-24 17:15:16', 4, '2023-09-24 17:15:27');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` int NOT NULL,
  `id_modulo` int NOT NULL,
  `tipo_operacion` varchar(25) NOT NULL COMMENT '0 - CREATE, 1 - UPDATE, 2 - DELETE, 3 - LOGIN, 4 - LOGOUT',
  `descripcion` varchar(255) DEFAULT NULL,
  `detalle_json` longtext,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`id`, `id_modulo`, `tipo_operacion`, `descripcion`, `detalle_json`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(3, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO U31 ACTUALIZADO POR jhondoe2@mail.com', '{\"created_at\":\"2023-09-10T02:04:45.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-07T14:39:55.000Z\"}', 4, '2023-11-07 09:39:56', NULL, NULL),
(4, 2, 'DELETE', 'INMUEBLE CON CÓDIGO 1 ELIMINADO POR jhondoe2@mail.com', '{\"id\":148,\"id_inmueble_zona\":1,\"tipo\":0,\"numero_interno_unidad\":\"1\",\"area\":\"1\",\"coeficiente\":\"0.0004\",\"valor_total_administracion\":\"4572\",\"numero_perros\":\"1\",\"numero_gatos\":\"1\",\"observaciones\":\"1\",\"eliminado\":1,\"created_by\":null,\"created_at\":\"2023-11-07T01:59:00.000Z\",\"updated_by\":null,\"updated_at\":\"2023-11-07T14:40:03.000Z\"}', 4, '2023-11-07 09:40:04', NULL, NULL),
(5, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO P6 ACTUALIZADO POR jhondoe2@mail.com', '{\"area\":\"8\",\"coeficiente\":\"0.0036\",\"valor_total_administracion\":\"41144\",\"created_at\":\"2023-09-11T05:54:25.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-07T21:02:45.000Z\"}', 4, '2023-11-07 21:02:45', NULL, NULL),
(6, 3, 'CREATE', 'PERSONA CON DOCUMENTO 123 CREADA POR jhondoe2@mail.com', '{\"id\":112,\"id_tercero_erp\":null,\"id_ciudad_erp\":null,\"tipo_documento\":0,\"numero_documento\":\"123\",\"primer_nombre\":\"123\",\"segundo_nombre\":\"\",\"primer_apellido\":\"\",\"segundo_apellido\":\"\",\"telefono\":\"\",\"celular\":\"\",\"email\":\"\",\"direccion\":\"\",\"fecha_nacimiento\":null,\"sexo\":0,\"avatar\":\"\",\"importado\":0,\"eliminado\":0,\"created_by\":4,\"created_at\":\"2023-11-08T05:30:46.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-08 00:30:47', NULL, NULL),
(7, 3, 'UPDATE', 'PERSONA CON NÚMERO DE DOCUMENTO 123 ACTUALIZADO POR jhondoe2@mail.com', '{\"primer_nombre\":\"1234\",\"segundo_nombre\":\"5\",\"fecha_nacimiento\":\"1970-01-01T05:00:00.000Z\",\"created_at\":\"2023-11-08T05:30:46.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T05:32:31.000Z\"}', 4, '2023-11-08 00:32:33', NULL, NULL),
(8, 3, 'DELETE', 'PERSONA CON NÚMERO DE DOCUMENTO 123 ELIMINADA POR jhondoe2@mail.com', '{\"id\":112,\"id_tercero_erp\":null,\"id_ciudad_erp\":null,\"tipo_documento\":0,\"numero_documento\":\"123\",\"primer_nombre\":\"1234\",\"segundo_nombre\":\"5\",\"primer_apellido\":\"\",\"segundo_apellido\":\"\",\"telefono\":\"\",\"celular\":\"\",\"email\":\"\",\"direccion\":\"\",\"fecha_nacimiento\":\"1970-01-01T05:00:00.000Z\",\"sexo\":0,\"avatar\":\"\",\"importado\":0,\"eliminado\":1,\"created_by\":4,\"created_at\":\"2023-11-08T05:30:46.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T05:32:51.000Z\"}', 4, '2023-11-08 00:32:52', NULL, NULL),
(9, 4, 'UPDATE', 'PROVEEDOR CON NOMBRE JUAN GUILLERMO CADAVID ARANGO  ACTUALIZADO POR jhondoe2@mail.com', '{\"id_actividad\":17,\"created_at\":\"2023-11-08T06:15:36.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T06:16:58.000Z\"}', 4, '2023-11-08 01:16:58', NULL, NULL),
(10, 4, 'DELETE', 'PROVEEDOR CON NOMBRE TEST ELIMINADA POR jhondoe2@mail.com', '{\"id\":10,\"id_persona\":40,\"id_actividad\":17,\"nombre_negocio\":\"TEST\",\"observacion\":\"TEST\",\"created_by\":4,\"created_at\":\"2023-11-08T06:15:36.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T06:16:58.000Z\"}', 4, '2023-11-08 01:17:12', NULL, NULL),
(11, 30, 'CREATE', 'ZONA CON NOMBRE TEST CREADA POR jhondoe2@mail.com', '{\"id\":10,\"nombre\":\"TEST\",\"tipo\":0,\"id_centro_costos_erp\":1,\"created_by\":4,\"created_at\":\"2023-11-08T06:22:02.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-08 01:22:02', NULL, NULL),
(12, 30, 'UPDATE', 'ZONA CON NOMBRE TEST1 ACTUALIZADA POR jhondoe2@mail.com', '{\"nombre\":\"TEST1\",\"created_at\":\"2023-11-08T06:22:02.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T06:22:13.000Z\"}', 4, '2023-11-08 01:22:13', NULL, NULL),
(13, 30, 'DELETE', 'ZONA CON NOMBRE TEST1 ELIMINADA POR jhondoe2@mail.com', '{\"id\":10,\"nombre\":\"TEST1\",\"tipo\":0,\"id_centro_costos_erp\":1,\"created_by\":4,\"created_at\":\"2023-11-08T06:22:02.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T06:22:13.000Z\"}', 4, '2023-11-08 01:22:22', NULL, NULL),
(14, 31, 'CREATE', 'CONCEPTO DE FACTURACIÓN CON NOMBRE TEST CREADO POR jhondoe2@mail.com', '{\"id\":12,\"id_cuenta_ingreso_erp\":19938,\"id_cuenta_interes_erp\":null,\"id_cuenta_iva_erp\":null,\"id_cuenta_por_cobrar\":19824,\"nombre\":\"TEST\",\"intereses\":0,\"valor\":\"112\",\"eliminado\":0,\"created_by\":4,\"created_at\":\"2023-11-08T06:30:00.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-08 01:30:00', NULL, NULL),
(15, 31, 'UPDATE', 'CONCEPTO DE FACTURACIÓN CON NOMBRE TEST ACTUALIZADO POR jhondoe2@mail.com', '{\"nombre\":\"TEST  2\",\"created_at\":\"2023-11-08T06:30:00.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T06:30:12.000Z\"}', 4, '2023-11-08 01:30:12', NULL, NULL),
(16, 31, 'DELETE', 'CONCEPTO DE FACTURACIÓN CON NOMBRE TEST  2 ELIMINADO POR jhondoe2@mail.com', '{\"id\":12,\"id_cuenta_ingreso_erp\":19938,\"id_cuenta_interes_erp\":null,\"id_cuenta_iva_erp\":null,\"id_cuenta_por_cobrar\":19824,\"nombre\":\"TEST  2\",\"intereses\":0,\"valor\":\"112\",\"eliminado\":0,\"created_by\":4,\"created_at\":\"2023-11-08T06:30:00.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T06:30:12.000Z\"}', 4, '2023-11-08 01:30:25', NULL, NULL),
(17, 32, 'CREATE', 'CONCEPTO DE GASTO CON NOMBRE TEST CREADO POR jhondoe2@mail.com', '{\"id\":6,\"id_cuenta_gasto_erp\":19977,\"id_cuenta_iva_erp\":null,\"porcentaje_iva\":19,\"id_cuenta_rete_fuente_erp\":null,\"base_rete_fuente\":null,\"porcentaje_rete_fuente\":null,\"id_cuenta_por_pagar_erp\":19824,\"nombre\":\"TEST\",\"eliminado\":0,\"created_by\":4,\"created_at\":\"2023-11-08T06:39:43.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-08 01:39:43', NULL, NULL),
(18, 32, 'UPDATE', 'CONCEPTO DE GASTO CON NOMBRE TEST EDITADO POR jhondoe2@mail.com', '{\"nombre\":\"TEST 1\",\"created_at\":\"2023-11-08T06:39:43.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T06:39:53.000Z\"}', 4, '2023-11-08 01:39:53', NULL, NULL),
(19, 32, 'DELETE', 'CONCEPTO DE GASTO CON NOMBRE TEST 1 ELIMINADO POR jhondoe2@mail.com', '{\"id\":6,\"id_cuenta_gasto_erp\":19977,\"id_cuenta_iva_erp\":null,\"porcentaje_iva\":19,\"id_cuenta_rete_fuente_erp\":null,\"base_rete_fuente\":null,\"porcentaje_rete_fuente\":null,\"id_cuenta_por_pagar_erp\":19824,\"nombre\":\"TEST 1\",\"eliminado\":0,\"created_by\":4,\"created_at\":\"2023-11-08T06:39:43.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T06:39:53.000Z\"}', 4, '2023-11-08 01:40:01', NULL, NULL),
(20, 33, 'CREATE', 'CONCEPTO DE VISITA CON NOMBRE TEST CREADO POR jhondoe2@mail.com', '{\"id\":28,\"tipo\":3,\"nombre\":\"TEST\",\"descripcion\":null,\"eliminado\":0,\"created_by\":4,\"created_at\":\"2023-11-08T06:44:53.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-08 01:44:53', NULL, NULL),
(21, 33, 'UPDATE', 'CONCEPTO DE VISITA CON NOMBRE TEST ACTUALIZADO POR jhondoe2@mail.com', '{\"nombre\":\"TEST 1\",\"created_at\":\"2023-11-08T06:44:53.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T06:45:04.000Z\"}', 4, '2023-11-08 01:45:04', NULL, NULL),
(22, 33, 'DELETE', 'CONCEPTO DE VISITA CON NOMBRE TEST 1 ELIMINADO POR jhondoe2@mail.com', '{\"id\":28,\"tipo\":3,\"nombre\":\"TEST 1\",\"descripcion\":null,\"eliminado\":0,\"created_by\":4,\"created_at\":\"2023-11-08T06:44:53.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T06:45:04.000Z\"}', 4, '2023-11-08 01:45:15', NULL, '2023-11-08 01:45:41'),
(23, 34, 'CREATE', 'TIPO DE TAREA CON NOMBRE TEST 1 CREADO POR jhondoe2@mail.com', '{\"id\":29,\"tipo\":4,\"nombre\":\"TEST 1\",\"descripcion\":\"TEST 2\",\"eliminado\":0,\"created_by\":4,\"created_at\":\"2023-11-08T06:50:44.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-08 01:50:44', NULL, NULL),
(24, 34, 'UPDATE', 'TIPO DE TAREA CON NOMBRE TEST 1 ACTUALIZADO POR jhondoe2@mail.com', '{\"nombre\":\"TEST 15\",\"created_at\":\"2023-11-08T06:50:44.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T06:50:55.000Z\"}', 4, '2023-11-08 01:50:56', NULL, NULL),
(25, 34, 'DELETE', 'TIPO DE TAREA CON NOMBRE TEST 15 ELIMINADO POR jhondoe2@mail.com', '{\"id\":29,\"tipo\":4,\"nombre\":\"TEST 15\",\"descripcion\":\"TEST 2\",\"eliminado\":0,\"created_by\":4,\"created_at\":\"2023-11-08T06:50:44.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T06:50:55.000Z\"}', 4, '2023-11-08 01:51:09', NULL, NULL),
(26, 35, 'CREATE', 'TIPO DE PROVEEDOR CON NOMBRE TEST CREADO POR jhondoe2@mail.com', '{\"id\":30,\"tipo\":1,\"nombre\":\"TEST\",\"descripcion\":null,\"eliminado\":0,\"created_by\":4,\"created_at\":\"2023-11-08T06:57:32.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-08 01:57:32', NULL, NULL),
(27, 35, 'UPDATE', 'TIPO DE PROVEEDOR CON NOMBRE TEST ACTUALIZADO POR jhondoe2@mail.com', '{\"nombre\":\"TEST 1\",\"created_at\":\"2023-11-08T06:57:32.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T06:57:49.000Z\"}', 4, '2023-11-08 01:57:50', NULL, NULL),
(28, 35, 'DELETE', 'TIPO DE PROVEEDOR CON NOMBRE TEST 1 ELIMINADO POR jhondoe2@mail.com', '{\"id\":30,\"tipo\":1,\"nombre\":\"TEST 1\",\"descripcion\":null,\"eliminado\":0,\"created_by\":4,\"created_at\":\"2023-11-08T06:57:32.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T06:57:49.000Z\"}', 4, '2023-11-08 01:58:01', NULL, NULL),
(29, 36, 'CREATE', 'TIPO DE VEHICULO CON NOMBRE TEST CREADO POR jhondoe2@mail.com', '{\"id\":31,\"tipo\":2,\"nombre\":\"TEST\",\"descripcion\":null,\"eliminado\":0,\"created_by\":4,\"created_at\":\"2023-11-08T07:06:10.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-08 02:06:11', NULL, NULL),
(30, 36, 'UPDATE', 'TIPO DE VEHICULO CON NOMBRE TEST 1 ACTUALIZADO POR jhondoe2@mail.com', '{\"nombre\":\"TEST 1\",\"created_at\":\"2023-11-08T07:06:10.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T07:06:19.000Z\"}', 4, '2023-11-08 02:06:19', NULL, NULL),
(31, 36, 'DELETE', 'TIPO DE VEHICULO CON NOMBRE TEST 1 ELIMINADO POR jhondoe2@mail.com', '{\"id\":31,\"tipo\":2,\"nombre\":\"TEST 1\",\"descripcion\":null,\"eliminado\":0,\"created_by\":4,\"created_at\":\"2023-11-08T07:06:10.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T07:06:19.000Z\"}', 4, '2023-11-08 02:06:26', NULL, NULL),
(32, 5, 'CREATE', 'CONTROL DE INGRESO CREADO POR jhondoe2@mail.com', '{\"id\":22,\"id_persona_autoriza\":26,\"id_inmueble\":25,\"id_inmueble_zona\":1,\"id_concepto_visita\":15,\"id_tipo_vehiculo\":null,\"persona_visita\":\"AQ\",\"placa\":\"\",\"fecha_ingreso\":\"2023-11-08T07:14:01.000Z\",\"fecha_salida\":null,\"observacion_visita_previa\":null,\"observacion\":\"AQ\",\"url_foto_visitante\":null,\"roles_notificados\":null,\"created_by\":4,\"created_at\":\"2023-11-08T07:14:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-08 02:14:01', NULL, NULL),
(33, 5, 'UPDATE', 'CONTROL DE INGRESO ACTUALIZADO POR jhondoe2@mail.com', '{\"fecha_ingreso\":\"2023-11-08T07:14:01.000Z\",\"observacion\":\"AQW\",\"created_at\":\"2023-11-08T07:14:01.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T07:14:32.000Z\"}', 4, '2023-11-08 02:14:33', NULL, NULL),
(34, 5, 'DELETE', 'CONTROL DE INGRESO ELIMINADO POR jhondoe2@mail.com', '{\"id\":22,\"id_persona_autoriza\":26,\"id_inmueble\":25,\"id_inmueble_zona\":1,\"id_concepto_visita\":15,\"id_tipo_vehiculo\":null,\"persona_visita\":\"AQ\",\"placa\":\"\",\"fecha_ingreso\":\"2023-11-08T07:14:01.000Z\",\"fecha_salida\":null,\"observacion_visita_previa\":null,\"observacion\":\"AQW\",\"url_foto_visitante\":null,\"roles_notificados\":null,\"created_by\":4,\"created_at\":\"2023-11-08T07:14:01.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-08T07:14:32.000Z\"}', 4, '2023-11-08 02:14:56', NULL, NULL),
(35, 3, 'UPDATE', 'PERSONA CON NÚMERO DE DOCUMENTO 11214 ACTUALIZADO POR paulina9@gmail.com', '{\"id_ciudad_erp\":3554,\"primer_apellido\":\"PENDIENTE \",\"celular\":\"313\",\"email\":\"MEMO@HOTMAIL.COM\",\"fecha_nacimiento\":\"2023-07-06T00:00:00.000Z\",\"created_at\":\"2023-10-18T14:01:30.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-08T11:53:59.000Z\"}', 24, '2023-11-08 11:54:00', NULL, NULL),
(36, 3, 'UPDATE', 'PERSONA CON NÚMERO DE DOCUMENTO 9856769500 ACTUALIZADO POR paulina9@gmail.com', '{\"segundo_apellido\":\"A203,P4,U1\",\"fecha_nacimiento\":\"1970-01-01T00:00:00.000Z\",\"created_at\":\"2023-10-19T22:00:02.000Z\",\"updated_at\":\"2023-11-09T02:03:28.000Z\"}', 24, '2023-11-09 02:03:28', NULL, NULL),
(37, 8, 'CREATE', 'RECIBO DE CAJA 9 CREADO POR adolfomc2745@gmail.com', '{\"id\":77,\"consecutivo\":9,\"id_persona\":52,\"fecha_recibo\":\"2023-10-15T00:00:00.000Z\",\"valor_recibo\":211000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A201-1023 ABONO: 211.000\",\"token_erp\":\"b498ff8cd5e86ae4431ea52e1c1d18cbf66c1aca01858752ead98463ea886c47\",\"created_at\":\"2023-11-09T16:47:23.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-09 16:47:23', NULL, NULL),
(38, 8, 'CREATE', 'RECIBO DE CAJA 10 CREADO POR adolfomc2745@gmail.com', '{\"id\":78,\"consecutivo\":10,\"id_persona\":54,\"fecha_recibo\":\"2023-10-15T00:00:00.000Z\",\"valor_recibo\":800000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: 00000001 ABONO: 800.000\",\"token_erp\":\"ac1a78006ae0ba6bcb148eea13de47efb5e35a401d19dda9bb10df3d1fe0ff92\",\"created_at\":\"2023-11-09T16:50:24.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-09 16:50:24', NULL, NULL),
(39, 31, 'UPDATE', 'CONCEPTO DE FACTURACIÓN CON NOMBRE ADMINISTRACION ACTUALIZADO POR paulina9@gmail.com', '{\"nombre\":\"ADMON APARTAMENTO\",\"created_at\":\"2023-04-30T15:03:09.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-09T16:56:54.000Z\"}', 24, '2023-11-09 16:56:54', NULL, NULL),
(40, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO U28 ACTUALIZADO POR jhondoe2@mail.com', '{\"valor_total_administracion\":\"7405\",\"created_at\":\"2023-09-09T02:29:37.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-09T17:16:33.000Z\"}', 4, '2023-11-09 17:16:33', NULL, NULL),
(41, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO U28 ACTUALIZADO POR jhondoe2@mail.com', '{\"valor_total_administracion\":\"7406\",\"created_at\":\"2023-09-09T02:29:37.000Z\",\"updated_at\":\"2023-11-09T17:16:44.000Z\"}', 4, '2023-11-09 17:16:44', NULL, NULL),
(42, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO P33 ACTUALIZADO POR jhondoe2@mail.com', '{\"valor_total_administracion\":\"41966\",\"created_at\":\"2023-09-09T02:27:40.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-09T17:16:53.000Z\"}', 4, '2023-11-09 17:16:53', NULL, NULL),
(43, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO P33 ACTUALIZADO POR jhondoe2@mail.com', '{\"valor_total_administracion\":\"41967\",\"created_at\":\"2023-09-09T02:27:40.000Z\",\"updated_at\":\"2023-11-09T17:17:01.000Z\"}', 4, '2023-11-09 17:17:01', NULL, NULL),
(44, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO A205 ACTUALIZADO POR jhondoe2@mail.com', '{\"valor_total_administracion\":\"211226\",\"created_at\":\"2023-09-09T02:21:53.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-09T17:18:02.000Z\"}', 4, '2023-11-09 17:18:02', NULL, NULL),
(45, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO A205 ACTUALIZADO POR jhondoe2@mail.com', '{\"valor_total_administracion\":\"211227\",\"created_at\":\"2023-09-09T02:21:53.000Z\",\"updated_at\":\"2023-11-09T17:18:10.000Z\"}', 4, '2023-11-09 17:18:10', NULL, NULL),
(46, 31, 'CREATE', 'CONCEPTO DE FACTURACIÓN CON NOMBRE ADMON PARQUEDARO CREADO POR paulina9@gmail.com', '{\"id\":13,\"id_cuenta_ingreso_erp\":22157,\"id_cuenta_interes_erp\":null,\"id_cuenta_iva_erp\":null,\"id_cuenta_por_cobrar\":21189,\"nombre\":\"ADMON PARQUEDARO\",\"intereses\":1,\"valor\":\"\",\"eliminado\":0,\"created_by\":24,\"created_at\":\"2023-11-09T17:33:30.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-09 17:33:30', NULL, NULL),
(47, 31, 'CREATE', 'CONCEPTO DE FACTURACIÓN CON NOMBRE ADMON CUARTO UTIL CREADO POR paulina9@gmail.com', '{\"id\":14,\"id_cuenta_ingreso_erp\":22156,\"id_cuenta_interes_erp\":null,\"id_cuenta_iva_erp\":null,\"id_cuenta_por_cobrar\":21188,\"nombre\":\"ADMON CUARTO UTIL\",\"intereses\":1,\"valor\":\"\",\"eliminado\":0,\"created_by\":24,\"created_at\":\"2023-11-09T17:34:31.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-09 17:34:31', NULL, NULL),
(48, 31, 'UPDATE', 'CONCEPTO DE FACTURACIÓN CON NOMBRE ADMON APARTAMENTO ACTUALIZADO POR paulina9@gmail.com', '{\"id_cuenta_ingreso_erp\":20117,\"created_at\":\"2023-04-30T15:03:09.000Z\",\"updated_at\":\"2023-11-09T17:34:49.000Z\"}', 24, '2023-11-09 17:34:49', NULL, NULL),
(49, 8, 'CREATE', 'RECIBO DE CAJA 11 CREADO POR paulina9@gmail.com', '{\"id\":79,\"consecutivo\":11,\"id_persona\":81,\"fecha_recibo\":\"2023-11-09T00:00:00.000Z\",\"valor_recibo\":60000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A701-1023 ABONO: 60.000\",\"token_erp\":\"95dcfa70a4942e73521c924cee06e7215e34babc36f791386773fbd3cffe61c2\",\"created_at\":\"2023-11-10T02:38:51.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-10 02:38:51', NULL, NULL),
(50, 8, 'CREATE', 'RECIBO DE CAJA 12 CREADO POR paulina9@gmail.com', '{\"id\":80,\"consecutivo\":12,\"id_persona\":64,\"fecha_recibo\":\"2023-11-09T00:00:00.000Z\",\"valor_recibo\":438984,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: 00000001 ABONO: 120.800 | DOC. REF: 0U4-1023 ABONO: 4945 | DOC. REF: 0P1-1023 ABONO: 38.232 | DOC. REF: A402-1023 ABONO: 272.591 | DOC. REF: A402-1023 ABONO: 2416\",\"token_erp\":\"e507905239d6777152359b8074c0e9c9149981b1b4404042817fb8b0f6e18430\",\"created_at\":\"2023-11-10T02:40:27.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-10 02:40:27', NULL, NULL),
(51, 8, 'CREATE', 'RECIBO DE CAJA 13 CREADO POR paulina9@gmail.com', '{\"id\":81,\"consecutivo\":13,\"id_persona\":81,\"fecha_recibo\":\"2023-11-09T00:00:00.000Z\",\"valor_recibo\":175946,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A701-1023 ABONO: 135.168 | DOC. REF: U22-1023 ABONO: 7406 | DOC. REF: P30-1023 ABONO: 33.372\",\"token_erp\":\"655120d48d68d87032b823f1684d53240cc5d37dd84fffed2d3a4cf7fb7fb798\",\"created_at\":\"2023-11-10T02:43:00.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-10 02:43:00', NULL, NULL),
(52, 8, 'UPDATE', 'RECIBO DE CAJA 11 ANULADO POR paulina9@gmail.com', '{\"fecha_recibo\":\"2023-11-09T00:00:00.000Z\",\"estado\":0,\"created_at\":\"2023-11-10T02:38:51.000Z\",\"updated_at\":\"2023-11-10T02:44:33.000Z\"}', 24, '2023-11-10 02:44:34', NULL, NULL),
(53, 8, 'DELETE', 'RECIBO DE CAJA 13 ELIMINADO POR paulina9@gmail.com', '{\"id\":81,\"consecutivo\":13,\"id_persona\":81,\"fecha_recibo\":\"2023-11-09T00:00:00.000Z\",\"valor_recibo\":175946,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A701-1023 ABONO: 135.168 | DOC. REF: U22-1023 ABONO: 7406 | DOC. REF: P30-1023 ABONO: 33.372\",\"token_erp\":\"655120d48d68d87032b823f1684d53240cc5d37dd84fffed2d3a4cf7fb7fb798\",\"created_at\":\"2023-11-10T02:43:00.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-10 13:42:23', NULL, NULL),
(54, 8, 'DELETE', 'RECIBO DE CAJA 12 ELIMINADO POR paulina9@gmail.com', '{\"id\":80,\"consecutivo\":12,\"id_persona\":64,\"fecha_recibo\":\"2023-11-09T00:00:00.000Z\",\"valor_recibo\":438984,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: 00000001 ABONO: 120.800 | DOC. REF: 0U4-1023 ABONO: 4945 | DOC. REF: 0P1-1023 ABONO: 38.232 | DOC. REF: A402-1023 ABONO: 272.591 | DOC. REF: A402-1023 ABONO: 2416\",\"token_erp\":\"e507905239d6777152359b8074c0e9c9149981b1b4404042817fb8b0f6e18430\",\"created_at\":\"2023-11-10T02:40:27.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-10 13:42:30', NULL, NULL),
(55, 8, 'CREATE', 'RECIBO DE CAJA 14 CREADO POR paulina9@gmail.com', '{\"id\":82,\"consecutivo\":14,\"id_persona\":81,\"fecha_recibo\":\"2023-11-10T00:00:00.000Z\",\"valor_recibo\":140000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A701-1023 ABONO: 135.168 | DOC. REF: U22-1023 ABONO: 4832\",\"token_erp\":\"f916a21cfef7b18cf4a158302223276b4a20a5ff9aa5a166e03fc38613c7fb76\",\"created_at\":\"2023-11-10T14:04:23.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-10 14:04:23', NULL, NULL),
(56, 8, 'CREATE', 'RECIBO DE CAJA 15 CREADO POR paulina9@gmail.com', '{\"id\":83,\"consecutivo\":15,\"id_persona\":81,\"fecha_recibo\":\"2023-11-10T00:00:00.000Z\",\"valor_recibo\":35901,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: U22-1023 ABONO: 2574 | DOC. REF: P30-1023 ABONO: 33.327\",\"token_erp\":\"b90b9308ed71f09b897805051c0c1cf28ff7ce2b3071e2418730edb10a89fd67\",\"created_at\":\"2023-11-10T14:05:56.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-10 14:05:56', NULL, NULL),
(57, 8, 'DELETE', 'RECIBO DE CAJA 15 ELIMINADO POR paulina9@gmail.com', '{\"id\":83,\"consecutivo\":15,\"id_persona\":81,\"fecha_recibo\":\"2023-11-10T00:00:00.000Z\",\"valor_recibo\":35901,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: U22-1023 ABONO: 2574 | DOC. REF: P30-1023 ABONO: 33.327\",\"token_erp\":\"b90b9308ed71f09b897805051c0c1cf28ff7ce2b3071e2418730edb10a89fd67\",\"created_at\":\"2023-11-10T14:05:56.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-10 14:14:56', NULL, NULL),
(58, 41, 'CREATE', 'MENSAJE CON TÍTULO TITULO ENVIADO POR jhondoe2@mail.com', '{\"id\":2,\"id_zona\":1,\"id_persona\":null,\"id_rol_persona\":null,\"titulo\":\"TITULO\",\"descripcion\":\"DESC\",\"notificacion_push\":1,\"created_by\":4,\"created_at\":\"2023-11-11T15:36:12.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-11 10:36:13', NULL, NULL),
(59, 41, 'CREATE', 'MENSAJE CON TÍTULO TITULO ENVIADO POR jhondoe2@mail.com', '{\"id\":3,\"id_zona\":1,\"id_persona\":null,\"id_rol_persona\":null,\"titulo\":\"TITULO\",\"descripcion\":\"DESC\",\"notificacion_push\":1,\"created_by\":4,\"created_at\":\"2023-11-11T15:36:25.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-11 10:36:26', NULL, NULL),
(60, 41, 'CREATE', 'MENSAJE CON TÍTULO asas ENVIADO POR jhondoe2@mail.com', '{\"id\":4,\"id_zona\":1,\"id_persona\":null,\"id_rol_persona\":null,\"titulo\":\"asas\",\"descripcion\":\"asas\",\"notificacion_push\":0,\"created_by\":4,\"created_at\":\"2023-11-11T15:41:39.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-11 10:41:40', NULL, NULL),
(61, 41, 'CREATE', 'MENSAJE CON TÍTULO TITULO ENVIADO POR jhondoe2@mail.com', '{\"id\":5,\"id_zona\":1,\"id_persona\":54,\"id_rol_persona\":24,\"titulo\":\"TITULO\",\"descripcion\":\"MENSAJE\",\"notificacion_push\":1,\"created_by\":4,\"created_at\":\"2023-11-11T15:42:38.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-11 10:42:38', NULL, NULL),
(62, 30, 'UPDATE', 'ZONA CON NOMBRE TORRE#1 ACTUALIZADA POR paulina9@gmail.com', '{\"nombre\":\"TORRE#1\",\"tipo\":0,\"created_at\":\"2023-04-30T21:47:27.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-12T04:36:16.000Z\"}', 24, '2023-11-12 04:36:16', NULL, NULL),
(63, 41, 'CREATE', 'MENSAJE CON TÍTULO TITULO ENVIADO POR jhondoe2@mail.com', '{\"id\":6,\"id_zona\":null,\"id_persona\":40,\"id_rol_persona\":null,\"titulo\":\"TITULO\",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"611t5\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":4,\"created_at\":\"2023-11-12T20:05:06.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-12 15:05:06', NULL, NULL),
(64, 41, 'CREATE', 'MENSAJE CON TÍTULO TITULO ENVIADO POR jhondoe2@mail.com', '{\"id\":7,\"id_zona\":null,\"id_persona\":40,\"id_rol_persona\":null,\"titulo\":\"TITULO\",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"9e6mn\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":4,\"created_at\":\"2023-11-12T20:08:11.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-12 15:08:11', NULL, NULL),
(65, 41, 'CREATE', 'MENSAJE CON TÍTULO TITULO ENVIADO POR jhondoe2@mail.com', '{\"id\":8,\"id_zona\":null,\"id_persona\":null,\"id_rol_persona\":null,\"titulo\":\"TITULO\",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"9e6mn\\\",\\\"text\\\":\\\"PRUEBA DE INGRESO\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":17,\\\"style\\\":\\\"fontsize-24\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":4,\"created_at\":\"2023-11-12T20:08:37.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-12 15:08:37', NULL, NULL),
(66, 41, 'CREATE', 'MENSAJE CON TÍTULO TITULO ENVIADO POR jhondoe2@mail.com', '{\"id\":9,\"id_zona\":null,\"id_persona\":null,\"id_rol_persona\":null,\"titulo\":\"TITULO\",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"1po2o\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":4,\"created_at\":\"2023-11-13T06:20:54.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-13 01:20:54', NULL, NULL),
(67, 41, 'CREATE', 'MENSAJE CON TÍTULO TITULO ENVIADO POR jhondoe2@mail.com', '{\"id\":10,\"id_zona\":null,\"id_persona\":null,\"id_rol_persona\":null,\"titulo\":\"TITULO\",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"66mjr\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":4,\"created_at\":\"2023-11-13T14:23:29.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-13 09:23:29', NULL, NULL),
(68, 41, 'CREATE', 'MENSAJE CON TÍTULO TITULO X 12 ENVIADO POR jhondoe2@mail.com', '{\"id\":11,\"id_zona\":null,\"id_persona\":null,\"id_rol_persona\":null,\"titulo\":\"TITULO X 12\",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"66mjr\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":4,\"created_at\":\"2023-11-13T14:24:52.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-13 09:24:52', NULL, NULL),
(69, 41, 'CREATE', 'MENSAJE CON TÍTULO TITULO ENVIADO POR jhondoe2@mail.com', '{\"id\":12,\"id_zona\":null,\"id_persona\":null,\"id_rol_persona\":null,\"titulo\":\"TITULO\",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"1nmf\\\",\\\"text\\\":\\\"Lorem ipsum \\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":12,\\\"style\\\":\\\"BOLD\\\"},{\\\"offset\\\":0,\\\"length\\\":12,\\\"style\\\":\\\"fontsize-24\\\"},{\\\"offset\\\":0,\\\"length\\\":12,\\\"style\\\":\\\"UNDERLINE\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}},{\\\"key\\\":\\\"7b1ej\\\",\\\"text\\\":\\\"dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"justify\\\"}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":4,\"created_at\":\"2023-11-13T14:27:45.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-13 09:27:45', NULL, NULL),
(70, 41, 'CREATE', 'MENSAJE CON TÍTULO MENSAJE ADMON ENVIADO POR jhondoe2@mail.com', '{\"id\":13,\"id_zona\":null,\"id_persona\":null,\"id_rol_persona\":1,\"titulo\":\"MENSAJE ADMON\",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2vfep\\\",\\\"text\\\":\\\"MENSAJE ADMON\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":13,\\\"style\\\":\\\"fontsize-24\\\"},{\\\"offset\\\":0,\\\"length\\\":13,\\\"style\\\":\\\"BOLD\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":4,\"created_at\":\"2023-11-13T15:18:00.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-13 10:18:01', NULL, NULL),
(71, 41, 'CREATE', 'MENSAJE CON TÍTULO MENSAJE PROPIETARIO ENVIADO POR jhondoe2@mail.com', '{\"id\":14,\"id_zona\":null,\"id_persona\":null,\"id_rol_persona\":24,\"titulo\":\"MENSAJE PROPIETARIO\",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"4fk0g\\\",\\\"text\\\":\\\"PROPIETARIO\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":11,\\\"style\\\":\\\"fontsize-24\\\"},{\\\"offset\\\":0,\\\"length\\\":11,\\\"style\\\":\\\"BOLD\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":4,\"created_at\":\"2023-11-13T15:19:26.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-13 10:19:27', NULL, NULL),
(72, 30, 'CREATE', 'ZONA CON NOMBRE TORRE#2 CREADA POR paulina9@gmail.com', '{\"id\":11,\"nombre\":\"TORRE#2\",\"tipo\":1,\"id_centro_costos_erp\":13285,\"created_by\":24,\"created_at\":\"2023-11-14T01:01:38.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-14 01:01:38', NULL, NULL),
(73, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":1,\"id_tipo_tarea\":4,\"fecha_programada\":\"2023-11-14T05:00:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"id_usuario_responsable\":4,\"id_inmueble\":25,\"id_inmueble_zona\":1,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"f3snv\\\",\\\"text\\\":\\\"BBBBBBBBB\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":9,\\\"style\\\":\\\"fontsize-30\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-14T16:00:21.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-14 11:00:21', NULL, NULL),
(74, 43, 'DELETE', 'TAREA 1 ELIMINADA POR jhondoe2@mail.com', '{\"id\":1,\"id_tipo_tarea\":4,\"fecha_programada\":\"2023-11-14T05:00:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"id_usuario_responsable\":4,\"id_inmueble\":25,\"id_inmueble_zona\":1,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"f3snv\\\",\\\"text\\\":\\\"BBBBBBBBB\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":9,\\\"style\\\":\\\"fontsize-30\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-14T16:00:21.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-14 11:02:57', NULL, NULL),
(75, 41, 'CREATE', 'MENSAJE CON TÍTULO RESPUESTA PQRSF: BASURA EN EL SUELO - 2023-11-14 14:36  ENVIADO POR paulina9@gmail.com', '{\"id\":15,\"id_zona\":null,\"id_persona\":81,\"id_rol_persona\":null,\"titulo\":\"RESPUESTA PQRSF: BASURA EN EL SUELO - 2023-11-14 14:36 \",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"8hura\\\",\\\"text\\\":\\\"pues la verdad es la primera vez  de esto evLuanks y le estaremos contando, \\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":24,\"created_at\":\"2023-11-14T14:38:37.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-14 14:38:37', NULL, NULL),
(76, 30, 'CREATE', 'ZONA CON NOMBRE URBANIZACION CREADA POR paulina9@gmail.com', '{\"id\":12,\"nombre\":\"URBANIZACION\",\"tipo\":1,\"id_centro_costos_erp\":1,\"created_by\":24,\"created_at\":\"2023-11-14T16:14:52.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-14 16:14:52', NULL, NULL),
(77, 41, 'CREATE', 'MENSAJE CON TÍTULO SUSPENSION DE LUZ ENVIADO POR paulina9@gmail.com', '{\"id\":16,\"id_zona\":12,\"id_persona\":null,\"id_rol_persona\":null,\"titulo\":\"SUSPENSION DE LUZ\",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"aimvo\\\",\\\"text\\\":\\\"EL PROXIMO SABADO DESDE LAS 5 A LAS 7 AM NO HABRA SERVIOCIS DE LUZ.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":24,\"created_at\":\"2023-11-14T16:15:42.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-14 16:15:42', NULL, NULL),
(78, 41, 'CREATE', 'MENSAJE CON TÍTULO RESPUESTA PQRSF: BASURA EN EL SUELO - 2023-11-14 14:36  ENVIADO POR paulina9@gmail.com', '{\"id\":17,\"id_zona\":null,\"id_persona\":81,\"id_rol_persona\":null,\"titulo\":\"RESPUESTA PQRSF: BASURA EN EL SUELO - 2023-11-14 14:36 \",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"f3sj5\\\",\\\"text\\\":\\\"ESTO SE VA PARA EL LANDING DEL PROPIETAERIO\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":24,\"created_at\":\"2023-11-14T16:17:04.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-14 16:17:04', NULL, NULL),
(79, 41, 'CREATE', 'MENSAJE CON TÍTULO RESPUESTA PQRSF: DINERO MULLTA - 2023-11-14 16:25  ENVIADO POR paulina9@gmail.com', '{\"id\":18,\"id_zona\":null,\"id_persona\":81,\"id_rol_persona\":null,\"titulo\":\"RESPUESTA PQRSF: DINERO MULLTA - 2023-11-14 16:25 \",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"7j1l0\\\",\\\"text\\\":\\\"LO DE LA CUOTA DOBLE YA LA PERDIO, DEMALAS PARCERO.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":24,\"created_at\":\"2023-11-14T16:26:37.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-14 16:26:37', NULL, NULL),
(80, 8, 'DELETE', 'RECIBO DE CAJA 14 ELIMINADO POR jhondoe2@mail.com', '{\"id\":82,\"consecutivo\":14,\"id_persona\":81,\"fecha_recibo\":\"2023-11-10T05:00:00.000Z\",\"valor_recibo\":140000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A701-1023 ABONO: 135.168 | DOC. REF: U22-1023 ABONO: 4832\",\"token_erp\":\"f916a21cfef7b18cf4a158302223276b4a20a5ff9aa5a166e03fc38613c7fb76\",\"created_at\":\"2023-11-10T19:04:23.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 4, '2023-11-15 10:03:47', NULL, NULL),
(81, 8, 'DELETE', 'RECIBO DE CAJA 11 ELIMINADO POR jhondoe2@mail.com', '{\"id\":79,\"consecutivo\":11,\"id_persona\":81,\"fecha_recibo\":\"2023-11-09T05:00:00.000Z\",\"valor_recibo\":60000,\"estado\":0,\"observacion\":\" DETALLE: DOC. REF: A701-1023 ABONO: 60.000\",\"token_erp\":\"95dcfa70a4942e73521c924cee06e7215e34babc36f791386773fbd3cffe61c2\",\"created_at\":\"2023-11-10T07:38:51.000Z\",\"created_by\":24,\"updated_at\":\"2023-11-10T07:44:33.000Z\",\"updated_by\":null}', 4, '2023-11-15 10:03:59', NULL, NULL),
(82, 8, 'DELETE', 'RECIBO DE CAJA 3 ELIMINADO POR jhondoe2@mail.com', '{\"id\":71,\"consecutivo\":3,\"id_persona\":81,\"fecha_recibo\":\"2023-01-29T05:00:00.000Z\",\"valor_recibo\":168000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A701-0123 ABONO: 130.958 | DOC. REF: U22-0123 ABONO: 6857 | DOC. REF: P30-0123 ABONO: 30.185\",\"token_erp\":\"63a7789caafa2602702cbb374ef221f1f633bf8f4ed696c2dd2ed4691a707f31\",\"created_at\":\"2023-11-03T03:50:10.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 4, '2023-11-15 10:04:10', NULL, NULL),
(83, 8, 'DELETE', 'RECIBO DE CAJA 2 ELIMINADO POR jhondoe2@mail.com', '{\"id\":70,\"consecutivo\":2,\"id_persona\":81,\"fecha_recibo\":\"2023-01-20T05:00:00.000Z\",\"valor_recibo\":50000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A701-0123 ABONO: 50.000\",\"token_erp\":\"43fae5dcbf43b44bcf279e0a11a75ea57dfa612ec9c3e99ace3d60589336e919\",\"created_at\":\"2023-11-03T03:47:56.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 4, '2023-11-15 10:04:20', NULL, NULL),
(84, 3, 'UPDATE', 'PERSONA CON NÚMERO DE DOCUMENTO 82383148 ACTUALIZADO POR jhondoe2@mail.com', '{\"email\":\"PROPIETARIO@MAIL.COM\",\"fecha_nacimiento\":\"1970-01-01T05:00:00.000Z\",\"avatar\":\"\",\"created_at\":\"2023-09-07T21:35:24.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-15T15:22:18.000Z\"}', 4, '2023-11-15 10:22:20', NULL, NULL),
(85, 8, 'CREATE', 'RECIBO DE CAJA 16 CREADO POR propietario@mail.com', '{\"id\":84,\"consecutivo\":16,\"id_persona\":53,\"fecha_recibo\":\"2023-11-15T05:00:00.000Z\",\"valor_recibo\":10000,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: 00000001 ABONO: 10.000\",\"token_erp\":\"3a258cf09b6e5c674e28e3a6a5105b76b632ae985e0259abfbff1dd3be7fe05a\",\"created_at\":\"2023-11-15T16:17:09.000Z\",\"created_by\":19,\"updated_at\":null,\"updated_by\":null}', 19, '2023-11-15 11:17:09', NULL, NULL),
(86, 8, 'CREATE', 'RECIBO DE CAJA 17 CREADO POR propietario@mail.com', '{\"id\":85,\"consecutivo\":17,\"id_persona\":53,\"fecha_recibo\":\"2023-11-15T05:00:00.000Z\",\"valor_recibo\":10000,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: 00000001 ABONO: 10.000\",\"token_erp\":\"b094d0694bc872702d0938fcbc979b825d89c4e2a543b4442b2ef53ee4ddc1b7\",\"created_at\":\"2023-11-15T16:18:33.000Z\",\"created_by\":19,\"updated_at\":null,\"updated_by\":null}', 19, '2023-11-15 11:18:33', NULL, NULL),
(87, 8, 'CREATE', 'RECIBO DE CAJA 18 CREADO POR propietario@mail.com', '{\"id\":86,\"consecutivo\":18,\"id_persona\":53,\"fecha_recibo\":\"2023-11-15T00:00:00.000Z\",\"valor_recibo\":10000,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: 00000001 ABONO: 10.000\",\"token_erp\":\"698daf84f9fff76599a18b623afdaeb00275e8ae38e01ccb2e89206655ef9e6f\",\"created_at\":\"2023-11-15T11:23:04.000Z\",\"created_by\":19,\"updated_at\":null,\"updated_by\":null}', 19, '2023-11-15 11:23:04', NULL, NULL),
(88, 8, 'CREATE', 'RECIBO DE CAJA 19 CREADO POR juanguillermomacp@gmail.com', '{\"id\":87,\"consecutivo\":19,\"id_persona\":81,\"fecha_recibo\":\"2023-11-15T00:00:00.000Z\",\"valor_recibo\":200000,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: A701-1123 ABONO: 195.168 | DOC. REF: U22-1123 ABONO: 4832\",\"token_erp\":\"3b85ccfe83f7a1013415f0c7a5b602bba0d5846a9cb35906742bcb1e807bc1a5\",\"created_at\":\"2023-11-15T12:14:36.000Z\",\"created_by\":21,\"updated_at\":null,\"updated_by\":null}', 21, '2023-11-15 12:14:36', NULL, NULL),
(89, 8, 'CREATE', 'RECIBO DE CAJA 20 CREADO POR juanguillermomacp@gmail.com', '{\"id\":88,\"consecutivo\":20,\"id_persona\":81,\"fecha_recibo\":\"2023-11-15T00:00:00.000Z\",\"valor_recibo\":35901,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: U22-1123 ABONO: 2574 | DOC. REF: P30-1123 ABONO: 33.327\",\"token_erp\":\"4214b20f10d8e7cc8ea6df68bee33e510e73e9a7f53bae05ef9c930b4dbcc5c1\",\"created_at\":\"2023-11-15T12:17:14.000Z\",\"created_by\":21,\"updated_at\":null,\"updated_by\":null}', 21, '2023-11-15 12:17:14', NULL, NULL),
(90, 8, 'DELETE', 'RECIBO DE CAJA 19 ELIMINADO POR paulina9@gmail.com', '{\"id\":87,\"consecutivo\":19,\"id_persona\":81,\"fecha_recibo\":\"2023-11-15T00:00:00.000Z\",\"valor_recibo\":200000,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: A701-1123 ABONO: 195.168 | DOC. REF: U22-1123 ABONO: 4832\",\"token_erp\":\"3b85ccfe83f7a1013415f0c7a5b602bba0d5846a9cb35906742bcb1e807bc1a5\",\"created_at\":\"2023-11-15T12:14:36.000Z\",\"created_by\":21,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-15 16:29:27', NULL, NULL),
(91, 8, 'DELETE', 'RECIBO DE CAJA 20 ELIMINADO POR paulina9@gmail.com', '{\"id\":88,\"consecutivo\":20,\"id_persona\":81,\"fecha_recibo\":\"2023-11-15T00:00:00.000Z\",\"valor_recibo\":35901,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: U22-1123 ABONO: 2574 | DOC. REF: P30-1123 ABONO: 33.327\",\"token_erp\":\"4214b20f10d8e7cc8ea6df68bee33e510e73e9a7f53bae05ef9c930b4dbcc5c1\",\"created_at\":\"2023-11-15T12:17:14.000Z\",\"created_by\":21,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-15 16:29:33', NULL, NULL),
(92, 8, 'CREATE', 'RECIBO DE CAJA 21 CREADO POR paulina9@gmail.com', '{\"id\":89,\"consecutivo\":21,\"id_persona\":81,\"fecha_recibo\":\"2023-11-15T00:00:00.000Z\",\"valor_recibo\":95168,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A701-1123 ABONO: 95.168\",\"token_erp\":\"c004002ff099027b5fdbbeac280c78b975f8252c7dcd0750fe806322fed47890\",\"created_at\":\"2023-11-15T16:54:11.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-15 16:54:11', NULL, NULL),
(93, 8, 'CREATE', 'RECIBO DE CAJA 22 CREADO POR juanguillermomacp@gmail.com', '{\"id\":90,\"consecutivo\":22,\"id_persona\":81,\"fecha_recibo\":\"2023-11-15T00:00:00.000Z\",\"valor_recibo\":140733,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: A701-1123 ABONO: 100.000 | DOC. REF: U22-1123 ABONO: 7406 | DOC. REF: P30-1123 ABONO: 33.327\",\"token_erp\":\"869a8f49921dd08742c5620ecb9f49477da249d2d466d01393e96d5bed1f0a2e\",\"created_at\":\"2023-11-15T16:56:07.000Z\",\"created_by\":21,\"updated_at\":null,\"updated_by\":null}', 21, '2023-11-15 16:56:07', NULL, NULL),
(94, 8, 'DELETE', 'RECIBO DE CAJA 22 ELIMINADO POR paulina9@gmail.com', '{\"id\":90,\"consecutivo\":22,\"id_persona\":81,\"fecha_recibo\":\"2023-11-15T00:00:00.000Z\",\"valor_recibo\":140733,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: A701-1123 ABONO: 100.000 | DOC. REF: U22-1123 ABONO: 7406 | DOC. REF: P30-1123 ABONO: 33.327\",\"token_erp\":\"869a8f49921dd08742c5620ecb9f49477da249d2d466d01393e96d5bed1f0a2e\",\"created_at\":\"2023-11-15T16:56:07.000Z\",\"created_by\":21,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-15 17:00:00', NULL, NULL),
(95, 41, 'CREATE', 'MENSAJE CON TÍTULO EPM ENVIADO POR paulina9@gmail.com', '{\"id\":19,\"id_zona\":1,\"id_persona\":null,\"id_rol_persona\":null,\"titulo\":\"EPM\",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"8b0d4\\\",\\\"text\\\":\\\"SE INFORMA A TODAS LOS INQUILINOS QUE MAÑANA LUNES NO HABRA LUZ DESDE LAS 10AM HASTA 12AM\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":1,\"created_by\":24,\"created_at\":\"2023-11-16T01:24:30.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-16 01:24:30', NULL, NULL),
(96, 41, 'CREATE', 'MENSAJE CON TÍTULO PILAS PUES ENVIADO POR paulina9@gmail.com', '{\"id\":20,\"id_zona\":null,\"id_persona\":81,\"id_rol_persona\":null,\"titulo\":\"PILAS PUES\",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"f71ct\\\",\\\"text\\\":\\\"BASURA EN B OLSAS.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":24,\"created_at\":\"2023-11-16T01:26:43.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-16 01:26:43', NULL, NULL),
(97, 41, 'CREATE', 'MENSAJE CON TÍTULO RESPUESTA PQRSF: PERRO VECINO - 2023-11-16 01:48  ENVIADO POR paulina9@gmail.com', '{\"id\":21,\"id_zona\":null,\"id_persona\":85,\"id_rol_persona\":null,\"titulo\":\"RESPUESTA PQRSF: PERRO VECINO - 2023-11-16 01:48 \",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"bqk2t\\\",\\\"text\\\":\\\"SI SEÑORA, ESTA NOCHE VAMOS A VERLO PERSONALMENTE Y SI ES VERDAD LO SACAMOS DE LA UINDAD.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":24,\"created_at\":\"2023-11-16T01:50:02.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-16 01:50:02', NULL, NULL),
(98, 41, 'CREATE', 'MENSAJE CON TÍTULO RESPUESTA PQRSF: ASUNTO F - 2023-11-13 16:52  ENVIADO POR paulina9@gmail.com', '{\"id\":22,\"id_zona\":null,\"id_persona\":81,\"id_rol_persona\":null,\"titulo\":\"RESPUESTA PQRSF: ASUNTO F - 2023-11-13 16:52 \",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"8ohdk\\\",\\\"text\\\":\\\"TITULO IMPORTANTE: Se  deb e reconocer el problema desde el principio.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":19,\\\"style\\\":\\\"BOLD\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{}},{\\\"key\\\":\\\"bhvjh\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}},{\\\"key\\\":\\\"2sj6b\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":24,\"created_at\":\"2023-11-16T01:57:46.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-16 01:57:46', NULL, NULL),
(99, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":2,\"id_tipo_tarea\":4,\"fecha_programada\":\"2023-11-17T05:00:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"id_usuario_responsable\":4,\"id_inmueble\":25,\"id_inmueble_zona\":1,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"rljd\\\",\\\"text\\\":\\\"texto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":5,\\\"style\\\":\\\"fontsize-30\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-17T14:41:53.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-17 09:41:54', NULL, NULL),
(100, 43, 'UPDATE', 'TAREA MTTO. PISCINA ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada\":\"2023-11-17T05:00:00.000Z\",\"created_at\":\"2023-11-17T14:41:53.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-17T14:59:21.000Z\"}', 4, '2023-11-17 09:59:22', NULL, NULL),
(101, 43, 'UPDATE', 'TAREA MANTENIMIENTO DE ASESORES  ACTUALIZADA POR jhondoe2@mail.com', '{\"id_tipo_tarea\":26,\"fecha_programada\":\"2023-11-19T05:00:00.000Z\",\"id_usuario_responsable\":21,\"id_inmueble\":26,\"id_inmueble_zona\":6,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"rljd\\\",\\\"text\\\":\\\"texto wwwww\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":11,\\\"style\\\":\\\"fontsize-30\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-17T14:41:53.000Z\",\"updated_at\":\"2023-11-17T15:04:27.000Z\"}', 4, '2023-11-17 10:04:28', NULL, NULL),
(102, 43, 'UPDATE', 'TAREA MANTENIMIENTO DE ASESORES  ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada\":\"2023-11-19T05:00:00.000Z\",\"estado\":1,\"created_at\":\"2023-11-17T14:41:53.000Z\",\"updated_at\":\"2023-11-17T15:42:32.000Z\"}', 4, '2023-11-17 10:42:32', NULL, NULL),
(103, 43, 'DELETE', 'TAREA 2 ELIMINADA POR jhondoe2@mail.com', '{\"id\":2,\"id_tipo_tarea\":26,\"fecha_programada\":\"2023-11-19T05:00:00.000Z\",\"fecha_completada\":null,\"estado\":1,\"id_usuario_responsable\":21,\"id_inmueble\":26,\"id_inmueble_zona\":6,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"rljd\\\",\\\"text\\\":\\\"texto wwwww\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":11,\\\"style\\\":\\\"fontsize-30\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-17T14:41:53.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-17T15:42:32.000Z\"}', 4, '2023-11-17 10:43:09', NULL, NULL),
(104, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":3,\"id_tipo_tarea\":4,\"fecha_programada\":\"2023-11-17T05:00:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":1,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"1350o\\\",\\\"text\\\":\\\"asasasasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-17T15:46:33.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-17 10:46:34', NULL, NULL),
(105, 43, 'CREATE', 'TAREA MANTENIMIENTO DE ASESORES  CREADA POR jhondoe2@mail.com', '{\"id\":4,\"id_tipo_tarea\":26,\"fecha_programada\":\"2023-11-17T05:00:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"id_usuario_responsable\":4,\"id_inmueble\":25,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2inf1\\\",\\\"text\\\":\\\"NUEVA TAREA\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":11,\\\"style\\\":\\\"BOLD\\\"},{\\\"offset\\\":0,\\\"length\\\":11,\\\"style\\\":\\\"fontsize-24\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-17T15:48:16.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-17 10:48:17', NULL, NULL);
INSERT INTO `logs` (`id`, `id_modulo`, `tipo_operacion`, `descripcion`, `detalle_json`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(106, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MANTENIMIENTO DE ASESORES  ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada\":\"2023-11-17T05:00:00.000Z\",\"observacion_completada\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"1q5of\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-17T15:48:16.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-17T16:19:15.000Z\"}', 4, '2023-11-17 11:19:15', NULL, NULL),
(107, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MANTENIMIENTO DE ASESORES  ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada\":\"2023-11-17T05:00:00.000Z\",\"created_at\":\"2023-11-17T15:48:16.000Z\",\"updated_at\":\"2023-11-17T16:19:16.000Z\"}', 4, '2023-11-17 11:19:16', NULL, NULL),
(108, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MANTENIMIENTO DE ASESORES  ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada\":\"2023-11-17T05:00:00.000Z\",\"created_at\":\"2023-11-17T15:48:16.000Z\",\"updated_at\":\"2023-11-17T16:19:16.000Z\"}', 4, '2023-11-17 11:19:16', NULL, NULL),
(109, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MANTENIMIENTO DE ASESORES  ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada\":\"2023-11-17T05:00:00.000Z\",\"created_at\":\"2023-11-17T15:48:16.000Z\",\"updated_at\":\"2023-11-17T16:19:16.000Z\"}', 4, '2023-11-17 11:19:16', NULL, NULL),
(110, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MANTENIMIENTO DE ASESORES  ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada\":\"2023-11-17T05:00:00.000Z\",\"observacion_completada\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"1q5of\\\",\\\"text\\\":\\\"SEGUIMIENTO\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":11,\\\"style\\\":\\\"fontsize-30\\\"},{\\\"offset\\\":0,\\\"length\\\":11,\\\"style\\\":\\\"BOLD\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-17T15:48:16.000Z\",\"updated_at\":\"2023-11-17T16:24:58.000Z\"}', 4, '2023-11-17 11:24:58', NULL, NULL),
(111, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MANTENIMIENTO DE ASESORES  ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada\":\"2023-11-17T05:00:00.000Z\",\"observacion_completada\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"1q5of\\\",\\\"text\\\":\\\"SEGUIMIENTO ------\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":18,\\\"style\\\":\\\"fontsize-30\\\"},{\\\"offset\\\":0,\\\"length\\\":18,\\\"style\\\":\\\"BOLD\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-17T15:48:16.000Z\",\"updated_at\":\"2023-11-17T16:25:11.000Z\"}', 4, '2023-11-17 11:25:11', NULL, NULL),
(112, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MANTENIMIENTO DE ASESORES  ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada\":\"2023-11-17T05:00:00.000Z\",\"estado\":1,\"created_at\":\"2023-11-17T15:48:16.000Z\",\"updated_at\":\"2023-11-17T17:31:12.000Z\"}', 4, '2023-11-17 12:31:12', NULL, NULL),
(113, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MANTENIMIENTO DE ASESORES  ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada\":\"2023-11-17T05:00:00.000Z\",\"fecha_completada\":\"2023-11-18T05:00:00.000Z\",\"created_at\":\"2023-11-17T15:48:16.000Z\",\"updated_at\":\"2023-11-17T17:36:08.000Z\"}', 4, '2023-11-17 12:36:08', NULL, NULL),
(114, 43, 'UPDATE', 'TAREA MTTO. PISCINA ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada\":\"2023-11-17T00:00:00.000Z\",\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"1350o\\\",\\\"text\\\":\\\"asasasasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":10,\\\"style\\\":\\\"BOLD\\\"},{\\\"offset\\\":0,\\\"length\\\":10,\\\"style\\\":\\\"fontsize-60\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-17T10:46:33.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-17T12:58:48.000Z\"}', 4, '2023-11-17 12:58:48', NULL, NULL),
(115, 8, 'DELETE', 'RECIBO DE CAJA 1 ELIMINADO POR paulina9@gmail.com', '{\"id\":69,\"consecutivo\":1,\"id_persona\":53,\"fecha_recibo\":\"2023-01-19T00:00:00.000Z\",\"valor_recibo\":1000000,\"estado\":1,\"observacion\":\"EL REST LO PAGACONE EL CANCE SJE DETALLE: DOC. REF: 31122022 ABONO: 1.000.000\",\"token_erp\":\"6c98e5f58c536e9cba4172059922753c269e3d6b63b73d1350b8ef1c4989b362\",\"created_at\":\"2023-11-02T22:34:57.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-17 17:48:10', NULL, NULL),
(116, 8, 'DELETE', 'RECIBO DE CAJA 17 ELIMINADO POR paulina9@gmail.com', '{\"id\":85,\"consecutivo\":17,\"id_persona\":53,\"fecha_recibo\":\"2023-11-15T00:00:00.000Z\",\"valor_recibo\":10000,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: 00000001 ABONO: 10.000\",\"token_erp\":\"b094d0694bc872702d0938fcbc979b825d89c4e2a543b4442b2ef53ee4ddc1b7\",\"created_at\":\"2023-11-15T11:18:33.000Z\",\"created_by\":19,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-17 17:48:14', NULL, NULL),
(117, 8, 'DELETE', 'RECIBO DE CAJA 21 ELIMINADO POR paulina9@gmail.com', '{\"id\":89,\"consecutivo\":21,\"id_persona\":81,\"fecha_recibo\":\"2023-11-15T00:00:00.000Z\",\"valor_recibo\":95168,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A701-1123 ABONO: 95.168\",\"token_erp\":\"c004002ff099027b5fdbbeac280c78b975f8252c7dcd0750fe806322fed47890\",\"created_at\":\"2023-11-15T16:54:11.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-17 17:52:26', NULL, NULL),
(118, 8, 'DELETE', 'RECIBO DE CAJA 18 ELIMINADO POR paulina9@gmail.com', '{\"id\":86,\"consecutivo\":18,\"id_persona\":53,\"fecha_recibo\":\"2023-11-15T00:00:00.000Z\",\"valor_recibo\":10000,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: 00000001 ABONO: 10.000\",\"token_erp\":\"698daf84f9fff76599a18b623afdaeb00275e8ae38e01ccb2e89206655ef9e6f\",\"created_at\":\"2023-11-15T11:23:04.000Z\",\"created_by\":19,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-17 17:52:35', NULL, NULL),
(119, 8, 'DELETE', 'RECIBO DE CAJA 16 ELIMINADO POR paulina9@gmail.com', '{\"id\":84,\"consecutivo\":16,\"id_persona\":53,\"fecha_recibo\":\"2023-11-15T00:00:00.000Z\",\"valor_recibo\":10000,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: 00000001 ABONO: 10.000\",\"token_erp\":\"3a258cf09b6e5c674e28e3a6a5105b76b632ae985e0259abfbff1dd3be7fe05a\",\"created_at\":\"2023-11-15T11:17:09.000Z\",\"created_by\":19,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-17 17:52:44', NULL, NULL),
(120, 8, 'DELETE', 'RECIBO DE CAJA 10 ELIMINADO POR paulina9@gmail.com', '{\"id\":78,\"consecutivo\":10,\"id_persona\":54,\"fecha_recibo\":\"2023-10-15T00:00:00.000Z\",\"valor_recibo\":800000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: 00000001 ABONO: 800.000\",\"token_erp\":\"ac1a78006ae0ba6bcb148eea13de47efb5e35a401d19dda9bb10df3d1fe0ff92\",\"created_at\":\"2023-11-09T16:50:24.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-17 17:52:49', NULL, NULL),
(121, 8, 'DELETE', 'RECIBO DE CAJA 9 ELIMINADO POR paulina9@gmail.com', '{\"id\":77,\"consecutivo\":9,\"id_persona\":52,\"fecha_recibo\":\"2023-10-15T00:00:00.000Z\",\"valor_recibo\":211000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A201-1023 ABONO: 211.000\",\"token_erp\":\"b498ff8cd5e86ae4431ea52e1c1d18cbf66c1aca01858752ead98463ea886c47\",\"created_at\":\"2023-11-09T16:47:23.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-17 17:52:54', NULL, NULL),
(122, 41, 'CREATE', 'MENSAJE CON TÍTULO UNO ENVIADO POR paulina9@gmail.com', '{\"id\":23,\"id_zona\":null,\"id_persona\":null,\"id_rol_persona\":24,\"titulo\":\"UNO\",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"30tv3\\\",\\\"text\\\":\\\"DOS\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":1,\"created_by\":24,\"created_at\":\"2023-11-20T16:40:02.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-20 16:40:02', NULL, NULL),
(123, 3, 'UPDATE', 'PERSONA CON NÚMERO DE DOCUMENTO 32516067 ACTUALIZADO POR adolfomc2745@gmail.com', '{\"email\":\"PELUZAFDEZ@GMAIL.COM\",\"fecha_nacimiento\":\"1970-01-01T00:00:00.000Z\",\"avatar\":\"\",\"created_at\":\"2023-09-07T23:31:14.000Z\",\"updated_by\":25,\"updated_at\":\"2023-11-21T14:26:37.000Z\"}', 25, '2023-11-21 14:26:37', NULL, NULL),
(124, 8, 'CREATE', 'RECIBO DE CAJA 23 CREADO POR peluzafdez@gmail.com', '{\"id\":91,\"consecutivo\":23,\"id_persona\":83,\"fecha_recibo\":\"2023-11-21T00:00:00.000Z\",\"valor_recibo\":329400,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: A703-1123 ABONO: 281.262 | DOC. REF: U18-1123 ABONO: 7406 | DOC. REF: P21-1123 ABONO: 40.732\",\"token_erp\":\"ef145cec3807c19a06d81680217f8d8589925e09553999228cbb4c2dfdad5be2\",\"created_at\":\"2023-11-21T14:28:06.000Z\",\"created_by\":31,\"updated_at\":null,\"updated_by\":null}', 31, '2023-11-21 14:28:06', NULL, NULL),
(125, 8, 'DELETE', 'RECIBO DE CAJA 23 ELIMINADO POR adolfomc2745@gmail.com', '{\"id\":91,\"consecutivo\":23,\"id_persona\":83,\"fecha_recibo\":\"2023-11-21T00:00:00.000Z\",\"valor_recibo\":329400,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: A703-1123 ABONO: 281.262 | DOC. REF: U18-1123 ABONO: 7406 | DOC. REF: P21-1123 ABONO: 40.732\",\"token_erp\":\"ef145cec3807c19a06d81680217f8d8589925e09553999228cbb4c2dfdad5be2\",\"created_at\":\"2023-11-21T14:28:06.000Z\",\"created_by\":31,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-21 14:36:09', NULL, NULL),
(126, 8, 'CREATE', 'RECIBO DE CAJA 24 CREADO POR adolfomc2745@gmail.com', '{\"id\":92,\"consecutivo\":24,\"id_persona\":83,\"fecha_recibo\":\"2023-11-21T00:00:00.000Z\",\"valor_recibo\":329400,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A703-1123 ABONO: 281.262 | DOC. REF: U18-1123 ABONO: 7406 | DOC. REF: P21-1123 ABONO: 40.732\",\"token_erp\":\"773c18c07f882a65f7c1c3cb8f4d81b334e049f085768ea11bca7cd645c649de\",\"created_at\":\"2023-11-21T15:42:52.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-21 15:42:52', NULL, NULL),
(127, 8, 'DELETE', 'RECIBO DE CAJA 24 ELIMINADO POR adolfomc2745@gmail.com', '{\"id\":92,\"consecutivo\":24,\"id_persona\":83,\"fecha_recibo\":\"2023-11-21T00:00:00.000Z\",\"valor_recibo\":329400,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A703-1123 ABONO: 281.262 | DOC. REF: U18-1123 ABONO: 7406 | DOC. REF: P21-1123 ABONO: 40.732\",\"token_erp\":\"773c18c07f882a65f7c1c3cb8f4d81b334e049f085768ea11bca7cd645c649de\",\"created_at\":\"2023-11-21T15:42:52.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-21 15:44:00', NULL, NULL),
(128, 8, 'CREATE', 'RECIBO DE CAJA 25 CREADO POR adolfomc2745@gmail.com', '{\"id\":93,\"consecutivo\":25,\"id_persona\":83,\"fecha_recibo\":\"2023-11-21T00:00:00.000Z\",\"valor_recibo\":200000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A703-1123 ABONO: 200.000\",\"token_erp\":\"d8e2b6b89013136a8f5393b76cd1879ddc085a1f882cffb1d6b223e3fd6c05e2\",\"created_at\":\"2023-11-21T15:44:49.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-21 15:44:49', NULL, NULL),
(129, 8, 'CREATE', 'RECIBO DE CAJA 26 CREADO POR peluzafdez@gmail.com', '{\"id\":94,\"consecutivo\":26,\"id_persona\":83,\"fecha_recibo\":\"2023-11-21T00:00:00.000Z\",\"valor_recibo\":129000,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: A703-1123 ABONO: 81.262 | DOC. REF: U18-1123 ABONO: 7406 | DOC. REF: P21-1123 ABONO: 40.332\",\"token_erp\":\"1ee2079459b11770c0cf2f5be6d372a8c8747defda50af4885c45e6c1f6b1d08\",\"created_at\":\"2023-11-21T15:47:17.000Z\",\"created_by\":31,\"updated_at\":null,\"updated_by\":null}', 31, '2023-11-21 15:47:17', NULL, NULL),
(130, 8, 'DELETE', 'RECIBO DE CAJA 26 ELIMINADO POR adolfomc2745@gmail.com', '{\"id\":94,\"consecutivo\":26,\"id_persona\":83,\"fecha_recibo\":\"2023-11-21T00:00:00.000Z\",\"valor_recibo\":129000,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: A703-1123 ABONO: 81.262 | DOC. REF: U18-1123 ABONO: 7406 | DOC. REF: P21-1123 ABONO: 40.332\",\"token_erp\":\"1ee2079459b11770c0cf2f5be6d372a8c8747defda50af4885c45e6c1f6b1d08\",\"created_at\":\"2023-11-21T15:47:17.000Z\",\"created_by\":31,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-21 15:51:16', NULL, NULL),
(131, 8, 'DELETE', 'RECIBO DE CAJA 25 ELIMINADO POR adolfomc2745@gmail.com', '{\"id\":93,\"consecutivo\":25,\"id_persona\":83,\"fecha_recibo\":\"2023-11-21T00:00:00.000Z\",\"valor_recibo\":200000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A703-1123 ABONO: 200.000\",\"token_erp\":\"d8e2b6b89013136a8f5393b76cd1879ddc085a1f882cffb1d6b223e3fd6c05e2\",\"created_at\":\"2023-11-21T15:44:49.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-21 15:51:39', NULL, NULL),
(132, 8, 'CREATE', 'RECIBO DE CAJA 27 CREADO POR adolfomc2745@gmail.com', '{\"id\":95,\"consecutivo\":27,\"id_persona\":83,\"fecha_recibo\":\"2023-11-21T00:00:00.000Z\",\"valor_recibo\":329400,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A703-1123 ABONO: 281.262 | DOC. REF: U18-1123 ABONO: 7406 | DOC. REF: P21-1123 ABONO: 40.732\",\"token_erp\":\"bc60def29d1476803037568c9d3ab5d2288500a1b18d8ee65f8fab61bee30abd\",\"created_at\":\"2023-11-21T15:53:55.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-21 15:53:55', NULL, NULL),
(133, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO U26 ACTUALIZADO POR adolfomc2745@gmail.com', '{\"valor_total_administracion\":\"4937\",\"created_at\":\"2023-09-09T20:59:55.000Z\",\"updated_by\":25,\"updated_at\":\"2023-11-21T16:12:38.000Z\"}', 25, '2023-11-21 16:12:38', NULL, NULL),
(134, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO U15 ACTUALIZADO POR adolfomc2745@gmail.com', '{\"valor_total_administracion\":\"7405\",\"created_at\":\"2023-09-09T20:56:11.000Z\",\"updated_by\":25,\"updated_at\":\"2023-11-21T16:13:48.000Z\"}', 25, '2023-11-21 16:13:48', NULL, NULL),
(135, 3, 'CREATE', 'PERSONA CON DOCUMENTO 901008556 CREADA POR adolfomc2745@gmail.com', '{\"id\":113,\"id_tercero_erp\":1535,\"id_ciudad_erp\":3599,\"tipo_documento\":1,\"numero_documento\":\"901008556\",\"primer_nombre\":\"TECNOTRONICK\",\"segundo_nombre\":\"\",\"primer_apellido\":\"\",\"segundo_apellido\":\"\",\"telefono\":\"\",\"celular\":\"3177858848\",\"email\":\"ASCENSORESTECNOTRONICK@GMAIL.COM\",\"direccion\":\"CR 63 42 21\",\"fecha_nacimiento\":null,\"sexo\":0,\"avatar\":\"\",\"importado\":0,\"eliminado\":0,\"created_by\":25,\"created_at\":\"2023-11-21T16:34:55.000Z\",\"updated_by\":null,\"updated_at\":\"2023-11-21T16:34:55.000Z\"}', 25, '2023-11-21 16:34:55', NULL, NULL),
(136, 32, 'UPDATE', 'CONCEPTO DE GASTO CON NOMBRE SERVICIOS EDITADO POR adolfomc2745@gmail.com', '{\"id_cuenta_iva_erp\":19896,\"created_at\":\"2023-10-31T22:41:01.000Z\",\"updated_by\":25,\"updated_at\":\"2023-11-21T16:47:25.000Z\"}', 25, '2023-11-21 16:47:25', NULL, NULL),
(137, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO P4 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"34596\",\"created_at\":\"2023-09-09T02:17:01.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T20:33:07.000Z\"}', 24, '2023-11-21 20:33:07', NULL, NULL),
(138, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO U30 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"7405\",\"created_at\":\"2023-09-09T02:30:46.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T20:38:20.000Z\"}', 24, '2023-11-21 20:38:20', NULL, NULL),
(139, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO P7 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"40731\",\"created_at\":\"2023-09-09T20:03:56.000Z\",\"updated_at\":\"2023-11-21T20:43:26.000Z\"}', 24, '2023-11-21 20:43:26', NULL, NULL),
(140, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO P1 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"38264\",\"created_at\":\"2023-09-09T20:08:03.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T20:44:36.000Z\"}', 24, '2023-11-21 20:44:36', NULL, NULL),
(141, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO U21 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"7405\",\"created_at\":\"2023-09-09T20:11:24.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T20:49:03.000Z\"}', 24, '2023-11-21 20:49:03', NULL, NULL),
(142, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO U35 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"4937\",\"created_at\":\"2023-09-09T20:13:45.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T20:49:42.000Z\"}', 24, '2023-11-21 20:49:42', NULL, NULL),
(143, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO A504 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"256758\",\"created_at\":\"2023-09-09T20:17:47.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T20:55:25.000Z\"}', 24, '2023-11-21 20:55:25', NULL, NULL),
(144, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO A506 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"195000\",\"created_at\":\"2023-09-09T20:22:58.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T20:58:16.000Z\"}', 24, '2023-11-21 20:58:16', NULL, NULL),
(145, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO A601 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"195095\",\"created_at\":\"2023-09-09T20:23:23.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T20:58:55.000Z\"}', 24, '2023-11-21 20:58:55', NULL, NULL),
(146, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO P24 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"41918\",\"created_at\":\"2023-09-09T20:24:33.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T21:00:48.000Z\"}', 24, '2023-11-21 21:00:48', NULL, NULL),
(147, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO A606 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"196000\",\"created_at\":\"2023-09-09T20:27:46.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T21:05:11.000Z\"}', 24, '2023-11-21 21:05:11', NULL, NULL),
(148, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO U22 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"7405\",\"created_at\":\"2023-09-09T20:29:04.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T22:17:46.000Z\"}', 24, '2023-11-21 22:17:46', NULL, NULL),
(149, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO A705 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"214900\",\"created_at\":\"2023-09-09T20:31:56.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T22:20:14.000Z\"}', 24, '2023-11-21 22:20:14', NULL, NULL),
(150, 5, 'CREATE', 'CONTROL DE INGRESO CREADO POR paulina9@gmail.com', '{\"id\":23,\"id_persona_autoriza\":null,\"id_inmueble\":null,\"id_inmueble_zona\":6,\"id_concepto_visita\":15,\"id_tipo_vehiculo\":null,\"persona_visita\":\"luis fernando \",\"placa\":\"\",\"fecha_ingreso\":\"2023-11-21T22:41:46.000Z\",\"fecha_salida\":null,\"observacion_visita_previa\":null,\"observacion\":\"ENTREVISTA DE TRABAJO\",\"url_foto_visitante\":null,\"roles_notificados\":null,\"created_by\":24,\"created_at\":\"2023-11-21T22:41:46.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-21 22:41:46', NULL, NULL),
(151, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO A706 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"214900\",\"created_at\":\"2023-09-09T20:32:48.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T22:53:33.000Z\"}', 24, '2023-11-21 22:53:33', NULL, NULL),
(152, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO A803 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"281239\",\"created_at\":\"2023-09-09T20:33:09.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T22:54:32.000Z\"}', 24, '2023-11-21 22:54:32', NULL, NULL),
(153, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO U12 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"4937\",\"created_at\":\"2023-09-09T20:38:26.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T22:55:47.000Z\"}', 24, '2023-11-21 22:55:47', NULL, NULL),
(154, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO P19 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"40731\",\"created_at\":\"2023-09-09T20:48:27.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T22:56:45.000Z\"}', 24, '2023-11-21 22:56:45', NULL, NULL),
(155, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO U10 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"7405\",\"created_at\":\"2023-09-09T20:50:10.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T22:57:29.000Z\"}', 24, '2023-11-21 22:57:29', NULL, NULL),
(156, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO U17 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"7405\",\"created_at\":\"2023-09-09T20:55:23.000Z\",\"updated_at\":\"2023-11-21T22:58:11.000Z\"}', 24, '2023-11-21 22:58:11', NULL, NULL),
(157, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO P13 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"42000\",\"created_at\":\"2023-09-09T21:01:59.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T23:12:07.000Z\"}', 24, '2023-11-21 23:12:07', NULL, NULL),
(158, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO P34 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"53000\",\"created_at\":\"2023-09-09T21:00:13.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T23:13:22.000Z\"}', 24, '2023-11-21 23:13:22', NULL, NULL),
(159, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO P37 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"39600\",\"created_at\":\"2023-09-09T21:03:58.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-21T23:15:21.000Z\"}', 24, '2023-11-21 23:15:21', NULL, NULL),
(160, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO P34 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"40657\",\"created_at\":\"2023-09-09T21:00:13.000Z\",\"updated_at\":\"2023-11-21T23:23:27.000Z\"}', 24, '2023-11-21 23:23:27', NULL, NULL),
(161, 3, 'CREATE', 'PERSONA CON DOCUMENTO 999404 CREADA POR paulina9@gmail.com', '{\"id\":114,\"id_tercero_erp\":1583,\"id_ciudad_erp\":3599,\"tipo_documento\":0,\"numero_documento\":\"999404\",\"primer_nombre\":\"MARINA\",\"segundo_nombre\":\"\",\"primer_apellido\":\"PALACIO\",\"segundo_apellido\":\"\",\"telefono\":\"\",\"celular\":\"\",\"email\":\"PENDIENTE@GMAIL.COM\",\"direccion\":\"\",\"fecha_nacimiento\":null,\"sexo\":1,\"avatar\":\"\",\"importado\":0,\"eliminado\":0,\"created_by\":24,\"created_at\":\"2023-11-21T23:35:35.000Z\",\"updated_by\":null,\"updated_at\":\"2023-11-21T23:35:35.000Z\"}', 24, '2023-11-21 23:35:35', NULL, NULL),
(162, 3, 'CREATE', 'PERSONA CON DOCUMENTO 90099404 CREADA POR jhondoe2@mail.com', '{\"id\":115,\"id_tercero_erp\":1584,\"id_ciudad_erp\":3599,\"tipo_documento\":0,\"numero_documento\":\"90099404\",\"primer_nombre\":\"MARINA\",\"segundo_nombre\":\"\",\"primer_apellido\":\"PALACIOS\",\"segundo_apellido\":\"\",\"telefono\":\"\",\"celular\":\"\",\"email\":\"PENDIENTE90099404@GMAIL.COM\",\"direccion\":\"\",\"fecha_nacimiento\":null,\"sexo\":1,\"avatar\":\"\",\"importado\":0,\"eliminado\":0,\"created_by\":4,\"created_at\":\"2023-11-21T23:53:49.000Z\",\"updated_by\":null,\"updated_at\":\"2023-11-21T23:53:49.000Z\"}', 4, '2023-11-21 23:53:49', NULL, NULL),
(163, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":5,\"id_tipo_tarea\":4,\"fecha_programada\":\"2023-11-21T00:00:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"id_usuario_responsable\":4,\"id_inmueble\":null,\"id_inmueble_zona\":1,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"emfet\\\",\\\"text\\\":\\\"asasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":6,\\\"style\\\":\\\"BOLD\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-22T00:13:50.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-22 00:13:50', NULL, NULL),
(164, 43, 'DELETE', 'TAREA 5 ELIMINADA POR jhondoe2@mail.com', '{\"id\":5,\"id_tipo_tarea\":4,\"fecha_programada\":\"2023-11-21T00:00:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"id_usuario_responsable\":4,\"id_inmueble\":null,\"id_inmueble_zona\":1,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"emfet\\\",\\\"text\\\":\\\"asasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":6,\\\"style\\\":\\\"BOLD\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-22T00:13:50.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-22 00:14:48', NULL, NULL),
(165, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":6,\"id_tipo_tarea\":4,\"fecha_programada\":\"2023-11-22T00:00:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"id_usuario_responsable\":4,\"id_inmueble\":null,\"id_inmueble_zona\":1,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"eoond\\\",\\\"text\\\":\\\"asasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":6,\\\"style\\\":\\\"BOLD\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-22T00:23:52.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-22 00:23:52', NULL, NULL),
(166, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MTTO. PISCINA ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada\":\"2023-11-22T00:00:00.000Z\",\"fecha_completada\":\"2023-11-21T00:00:00.000Z\",\"estado\":1,\"observacion_completada\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"al2oi\\\",\\\"text\\\":\\\"COMPLETADA\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":10,\\\"style\\\":\\\"BOLD\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-22T00:23:52.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-22T00:24:31.000Z\"}', 4, '2023-11-22 00:24:31', NULL, NULL),
(167, 9, 'DELETE', 'GASTO 5 ELIMINADO POR jhondoe2@mail.com', '{\"id\":28,\"id_persona_proveedor\":40,\"id_cuenta_x_pagar_egreso_gasto_erp\":null,\"consecutivo\":5,\"valor_total_iva\":\"399160\",\"porcentaje_retencion\":\"2.5\",\"valor_total_retencion\":\"52.521\",\"valor_total\":\"2500000\",\"token_erp\":\"6b316acda8c4fcfc0b9b3fef585153bbdadfe2a2764aef075b23d311f59decc7\",\"url_comprobante_gasto\":\"\",\"fecha_documento\":\"2023-11-21T00:00:00.000Z\",\"observacion\":\"\",\"anulado\":0,\"created_by\":4,\"created_at\":\"2023-11-22T00:32:59.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-22T00:35:44.000Z\"}', 4, '2023-11-22 10:23:49', NULL, NULL),
(168, 9, 'DELETE', 'GASTO 6 ELIMINADO POR jhondoe2@mail.com', '{\"id\":29,\"id_persona_proveedor\":40,\"id_cuenta_x_pagar_egreso_gasto_erp\":19866,\"consecutivo\":6,\"valor_total_iva\":\"15966\",\"porcentaje_retencion\":\"2.5\",\"valor_total_retencion\":\"2101\",\"valor_total\":\"100000\",\"token_erp\":\"568bb1d240bf947472773dd48c6749d66c7eaf286ef54f47119e2e239fd17cb9\",\"url_comprobante_gasto\":\"\",\"fecha_documento\":\"2023-11-22T00:00:00.000Z\",\"observacion\":\"\",\"anulado\":0,\"created_by\":4,\"created_at\":\"2023-11-22T10:24:10.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-22 10:25:15', NULL, NULL),
(169, 9, 'DELETE', 'GASTO 7 ELIMINADO POR jhondoe2@mail.com', '{\"id\":30,\"id_persona_proveedor\":40,\"id_cuenta_x_pagar_egreso_gasto_erp\":19866,\"consecutivo\":7,\"valor_total_iva\":\"15966\",\"porcentaje_retencion\":\"2.5\",\"valor_total_retencion\":\"2101\",\"valor_total\":\"100000\",\"token_erp\":\"7f7f4028c930a9a0b3a8a0378617d1be4b54eb223f49551fba1bd1c2cc431e2e\",\"url_comprobante_gasto\":\"\",\"fecha_documento\":\"2023-11-22T00:00:00.000Z\",\"observacion\":\"\",\"anulado\":0,\"created_by\":4,\"created_at\":\"2023-11-22T10:24:21.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-22 10:25:19', NULL, NULL),
(170, 9, 'DELETE', 'GASTO 8 ELIMINADO POR jhondoe2@mail.com', '{\"id\":31,\"id_persona_proveedor\":40,\"id_cuenta_x_pagar_egreso_gasto_erp\":19866,\"consecutivo\":8,\"valor_total_iva\":\"15966\",\"porcentaje_retencion\":\"2.5\",\"valor_total_retencion\":\"2101\",\"valor_total\":\"100000\",\"token_erp\":\"49f2e7d7a07d9a0cbdd58de24adde52e904cb3f3e5153aadb9f753eacac69c12\",\"url_comprobante_gasto\":\"\",\"fecha_documento\":\"2023-11-22T00:00:00.000Z\",\"observacion\":\"ASAS\",\"anulado\":0,\"created_by\":4,\"created_at\":\"2023-11-22T10:24:38.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-22 10:25:22', NULL, NULL),
(171, 9, 'DELETE', 'GASTO 9 ELIMINADO POR jhondoe2@mail.com', '{\"id\":32,\"id_persona_proveedor\":40,\"id_cuenta_x_pagar_egreso_gasto_erp\":19825,\"consecutivo\":9,\"valor_total_iva\":\"15966\",\"porcentaje_retencion\":\"2.5\",\"valor_total_retencion\":\"2101\",\"valor_total\":\"100000\",\"token_erp\":\"443b7ca7eecfae7d0427288385c3c381f333c532f66ea505f66d230b3b2c7271\",\"url_comprobante_gasto\":\"\",\"fecha_documento\":\"2023-11-22T00:00:00.000Z\",\"observacion\":\"ASAS\",\"anulado\":0,\"created_by\":4,\"created_at\":\"2023-11-22T10:24:41.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-22 10:25:27', NULL, NULL),
(172, 9, 'DELETE', 'GASTO 10 ELIMINADO POR jhondoe2@mail.com', '{\"id\":33,\"id_persona_proveedor\":40,\"id_cuenta_x_pagar_egreso_gasto_erp\":null,\"consecutivo\":10,\"valor_total_iva\":\"399160\",\"porcentaje_retencion\":\"3\",\"valor_total_retencion\":\"63.025\",\"valor_total\":\"2500000\",\"token_erp\":\"6974861c90164ee94053467387eba0c91e29840d3fd63a4d2d3683a56372c6e9\",\"url_comprobante_gasto\":\"\",\"fecha_documento\":\"2023-11-22T00:00:00.000Z\",\"observacion\":\"121212\",\"anulado\":0,\"created_by\":4,\"created_at\":\"2023-11-22T10:31:01.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-22T10:31:25.000Z\"}', 4, '2023-11-22 10:32:38', NULL, NULL),
(173, 10, 'CREATE', 'PAGO 4 CREADO POR jhondoe2@mail.com', '{\"id\":8,\"consecutivo\":4,\"id_persona\":113,\"fecha_pago\":\"2023-11-22T00:00:00.000Z\",\"valor_pago\":40000,\"estado\":1,\"observacion\":\"ASAS DETALLE: DOC. REF: 00000004 ABONO: 40.000\",\"token_erp\":\"4d2f33463eff52d7fbc0b479f90292d4fd90515e10ce262a06d1f80dd6045fba\",\"created_at\":\"2023-11-22T10:36:48.000Z\",\"created_by\":4,\"updated_at\":null,\"updated_by\":null}', 4, '2023-11-22 10:36:48', NULL, NULL),
(174, 10, 'DELETE', 'PAGO 3 ELIMINADO POR jhondoe2@mail.com', '{\"id\":7,\"consecutivo\":3,\"id_persona\":113,\"fecha_pago\":\"2023-11-22T00:00:00.000Z\",\"valor_pago\":40000,\"estado\":1,\"observacion\":\"ASAS DETALLE: DOC. REF: 00000004 ABONO: 40.000\",\"token_erp\":\"d88f827ff72909102bde6fe941d7d36cb49893dae9c7dc39255b12b1d9df5a37\",\"created_at\":\"2023-11-22T10:32:59.000Z\",\"created_by\":4,\"updated_at\":null,\"updated_by\":null}', 4, '2023-11-22 10:37:00', NULL, NULL),
(175, 10, 'DELETE', 'PAGO 4 ELIMINADO POR jhondoe2@mail.com', '{\"id\":8,\"consecutivo\":4,\"id_persona\":113,\"fecha_pago\":\"2023-11-22T00:00:00.000Z\",\"valor_pago\":40000,\"estado\":1,\"observacion\":\"ASAS DETALLE: DOC. REF: 00000004 ABONO: 40.000\",\"token_erp\":\"4d2f33463eff52d7fbc0b479f90292d4fd90515e10ce262a06d1f80dd6045fba\",\"created_at\":\"2023-11-22T10:36:48.000Z\",\"created_by\":4,\"updated_at\":null,\"updated_by\":null}', 4, '2023-11-22 10:37:04', NULL, NULL),
(176, 5, 'DELETE', 'CONTROL DE INGRESO ELIMINADO POR jhondoe2@mail.com', '{\"id\":4,\"id_persona_autoriza\":13,\"id_inmueble\":7,\"id_inmueble_zona\":1,\"id_concepto_visita\":15,\"id_tipo_vehiculo\":null,\"persona_visita\":\"Fernando \",\"placa\":\"\",\"fecha_ingreso\":\"2023-08-27T18:33:14.000Z\",\"fecha_salida\":null,\"observacion_visita_previa\":null,\"observacion\":\"Bicicleta \",\"url_foto_visitante\":null,\"roles_notificados\":null,\"created_by\":21,\"created_at\":\"2023-08-27T18:33:14.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-22 10:37:29', NULL, NULL),
(177, 5, 'DELETE', 'CONTROL DE INGRESO ELIMINADO POR jhondoe2@mail.com', '{\"id\":23,\"id_persona_autoriza\":null,\"id_inmueble\":null,\"id_inmueble_zona\":6,\"id_concepto_visita\":15,\"id_tipo_vehiculo\":null,\"persona_visita\":\"luis fernando \",\"placa\":\"\",\"fecha_ingreso\":\"2023-11-21T22:41:46.000Z\",\"fecha_salida\":null,\"observacion_visita_previa\":null,\"observacion\":\"ENTREVISTA DE TRABAJO\",\"url_foto_visitante\":null,\"roles_notificados\":null,\"created_by\":24,\"created_at\":\"2023-11-21T22:41:46.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-22 10:37:34', NULL, NULL),
(178, 43, 'DELETE', 'TAREA 6 ELIMINADA POR jhondoe2@mail.com', '{\"id\":6,\"id_tipo_tarea\":4,\"fecha_programada\":\"2023-11-22T00:00:00.000Z\",\"fecha_completada\":\"2023-11-21T00:00:00.000Z\",\"estado\":1,\"id_usuario_responsable\":4,\"id_inmueble\":null,\"id_inmueble_zona\":1,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"eoond\\\",\\\"text\\\":\\\"asasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":6,\\\"style\\\":\\\"BOLD\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"al2oi\\\",\\\"text\\\":\\\"COMPLETADA\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":10,\\\"style\\\":\\\"BOLD\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-22T00:23:52.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-22T00:24:31.000Z\"}', 4, '2023-11-22 10:38:02', NULL, NULL),
(179, 9, 'DELETE', 'GASTO 11 ELIMINADO POR jhondoe2@mail.com', '{\"id\":34,\"id_persona_proveedor\":40,\"id_cuenta_x_pagar_egreso_gasto_erp\":19824,\"consecutivo\":11,\"valor_total_iva\":\"195145\",\"porcentaje_retencion\":\"0\",\"valor_total_retencion\":\"0\",\"valor_total\":\"1222222\",\"token_erp\":\"3a0a163831df561515933f3df1ba17d303ef915d176a85be759afe31286b16ec\",\"url_comprobante_gasto\":\"\",\"fecha_documento\":\"2023-11-22T00:00:00.000Z\",\"observacion\":\"12\",\"anulado\":0,\"created_by\":4,\"created_at\":\"2023-11-22T10:39:03.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-22 10:39:10', NULL, NULL),
(180, 3, 'DELETE', 'PERSONA CON NÚMERO DE DOCUMENTO 999404 ELIMINADA POR jhondoe2@mail.com', '{\"id\":114,\"id_tercero_erp\":1583,\"id_ciudad_erp\":3599,\"tipo_documento\":0,\"numero_documento\":\"999404\",\"primer_nombre\":\"MARINA\",\"segundo_nombre\":\"\",\"primer_apellido\":\"PALACIO\",\"segundo_apellido\":\"\",\"telefono\":\"\",\"celular\":\"\",\"email\":\"PENDIENTE@GMAIL.COM\",\"direccion\":\"\",\"fecha_nacimiento\":null,\"sexo\":1,\"avatar\":\"\",\"importado\":0,\"eliminado\":1,\"created_by\":24,\"created_at\":\"2023-11-21T23:35:35.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-22T10:44:09.000Z\"}', 4, '2023-11-22 10:44:09', NULL, NULL),
(181, 10, 'CREATE', 'PAGO 5 CREADO POR jhondoe2@mail.com', '{\"id\":9,\"consecutivo\":5,\"id_persona\":113,\"fecha_pago\":\"2023-11-22T00:00:00.000Z\",\"valor_pago\":40000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: 00000004 ABONO: 40.000\",\"token_erp\":\"fe8e2ebe8240f9319857edde506529a090d09e70be92e197e8212c574618e860\",\"created_at\":\"2023-11-22T10:48:58.000Z\",\"created_by\":4,\"updated_at\":null,\"updated_by\":null}', 4, '2023-11-22 10:48:58', NULL, NULL),
(182, 10, 'DELETE', 'PAGO 5 ELIMINADO POR jhondoe2@mail.com', '{\"id\":9,\"consecutivo\":5,\"id_persona\":113,\"fecha_pago\":\"2023-11-22T00:00:00.000Z\",\"valor_pago\":40000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: 00000004 ABONO: 40.000\",\"token_erp\":\"fe8e2ebe8240f9319857edde506529a090d09e70be92e197e8212c574618e860\",\"created_at\":\"2023-11-22T10:48:58.000Z\",\"created_by\":4,\"updated_at\":null,\"updated_by\":null}', 4, '2023-11-22 10:49:03', NULL, NULL),
(183, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO A805 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"214490\",\"created_at\":\"2023-09-09T20:53:05.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-22T16:28:45.000Z\"}', 24, '2023-11-22 16:28:45', NULL, NULL),
(184, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO A805 ACTUALIZADO POR paulina9@gmail.com', '{\"valor_total_administracion\":\"214493\",\"created_at\":\"2023-09-09T20:53:05.000Z\",\"updated_at\":\"2023-11-22T16:29:46.000Z\"}', 24, '2023-11-22 16:29:46', NULL, NULL),
(185, 31, 'UPDATE', 'CONCEPTO DE FACTURACIÓN CON NOMBRE INTERESES ACTUALIZADO POR paulina9@gmail.com', '{\"id_cuenta_por_cobrar\":21135,\"created_at\":\"2023-10-01T14:52:37.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-22T18:06:45.000Z\"}', 24, '2023-11-22 18:06:45', NULL, NULL),
(186, 31, 'UPDATE', 'CONCEPTO DE FACTURACIÓN CON NOMBRE INTERESES ACTUALIZADO POR paulina9@gmail.com', '{\"id_cuenta_ingreso_erp\":19962,\"created_at\":\"2023-10-01T14:52:37.000Z\",\"updated_at\":\"2023-11-22T18:20:07.000Z\"}', 24, '2023-11-22 18:20:07', NULL, NULL),
(187, 3, 'UPDATE', 'PERSONA CON NÚMERO DE DOCUMENTO 32434608 ACTUALIZADO POR paulina9@gmail.com', '{\"id_ciudad_erp\":3599,\"primer_nombre\":\"JUAN\",\"segundo_nombre\":\"CAMILO\",\"primer_apellido\":\"CADAVID\",\"segundo_apellido\":\"ZULETA\",\"email\":\"JCAMILOC9@GMAIL.COM\",\"fecha_nacimiento\":\"1970-01-01T00:00:00.000Z\",\"sexo\":0,\"created_at\":\"2023-09-10T17:21:42.000Z\",\"updated_at\":\"2023-11-22T20:04:47.000Z\"}', 24, '2023-11-22 20:04:47', NULL, NULL),
(188, 8, 'CREATE', 'RECIBO DE CAJA 28 CREADO POR JCAMILOC9@GMAIL.COM', '{\"id\":96,\"consecutivo\":28,\"id_persona\":100,\"fecha_recibo\":\"2023-11-22T00:00:00.000Z\",\"valor_recibo\":30000,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: U11-1123 ABONO: 4938 | DOC. REF: P16-1123 ABONO: 25.062\",\"token_erp\":\"5f013bfdda0a7f350a60a416d2071b278c7ae9e587e0c64c79ae196ad5b2ff13\",\"created_at\":\"2023-11-22T20:19:21.000Z\",\"created_by\":32,\"updated_at\":null,\"updated_by\":null}', 32, '2023-11-22 20:19:21', NULL, NULL),
(189, 8, 'CREATE', 'RECIBO DE CAJA 29 CREADO POR paulina9@gmail.com', '{\"id\":97,\"consecutivo\":29,\"id_persona\":100,\"fecha_recibo\":\"2023-11-22T00:00:00.000Z\",\"valor_recibo\":10000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: P16-1123 ABONO: 10.000\",\"token_erp\":\"cbf1fdc6fc7f198e0e60fab9cb33309a1b802b5b7e04ab587f291f27566a54e6\",\"created_at\":\"2023-11-22T20:23:45.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-22 20:23:45', NULL, NULL),
(190, 5, 'CREATE', 'CONTROL DE INGRESO CREADO POR paulina9@gmail.com', '{\"id\":24,\"id_persona_autoriza\":99,\"id_inmueble\":96,\"id_inmueble_zona\":1,\"id_concepto_visita\":15,\"id_tipo_vehiculo\":null,\"persona_visita\":\"CARLOS BENJUMEA\",\"placa\":\"\",\"fecha_ingreso\":\"2023-11-22T20:45:28.000Z\",\"fecha_salida\":null,\"observacion_visita_previa\":\"TRAE UN PARQUETE DE PORCELAN Y DE NAVIDAD\",\"observacion\":\"CALOSBENEA FAF V\",\"url_foto_visitante\":null,\"roles_notificados\":null,\"created_by\":24,\"created_at\":\"2023-11-22T20:45:28.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-22 20:45:28', NULL, NULL),
(191, 5, 'DELETE', 'CONTROL DE INGRESO ELIMINADO POR paulina9@gmail.com', '{\"id\":24,\"id_persona_autoriza\":99,\"id_inmueble\":96,\"id_inmueble_zona\":1,\"id_concepto_visita\":15,\"id_tipo_vehiculo\":null,\"persona_visita\":\"CARLOS BENJUMEA\",\"placa\":\"\",\"fecha_ingreso\":\"2023-11-22T20:45:28.000Z\",\"fecha_salida\":null,\"observacion_visita_previa\":\"TRAE UN PARQUETE DE PORCELAN Y DE NAVIDAD\",\"observacion\":\"CALOSBENEA FAF V\",\"url_foto_visitante\":null,\"roles_notificados\":null,\"created_by\":24,\"created_at\":\"2023-11-22T20:45:28.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-22 20:51:05', NULL, NULL),
(192, 3, 'CREATE', 'PERSONA CON DOCUMENTO 32106362 CREADA POR adolfomc2745@gmail.com', '{\"id\":116,\"id_tercero_erp\":1585,\"id_ciudad_erp\":3599,\"tipo_documento\":1,\"numero_documento\":\"32106362\",\"primer_nombre\":\"NARANJA JURIDICA\",\"segundo_nombre\":\"\",\"primer_apellido\":\"\",\"segundo_apellido\":\"\",\"telefono\":\"\",\"celular\":\"4443049\",\"email\":\"PREJURIDICA2@GMAIL.COM\",\"direccion\":\"CR 43 A 19 A 57 OFIC 203\",\"fecha_nacimiento\":\"2023-11-01T00:00:00.000Z\",\"sexo\":0,\"avatar\":\"\",\"importado\":0,\"eliminado\":0,\"created_by\":25,\"created_at\":\"2023-11-23T00:43:35.000Z\",\"updated_by\":null,\"updated_at\":\"2023-11-23T00:43:36.000Z\"}', 25, '2023-11-23 00:43:36', NULL, NULL),
(193, 3, 'CREATE', 'PERSONA CON DOCUMENTO 900967679 CREADA POR adolfomc2745@gmail.com', '{\"id\":117,\"id_tercero_erp\":1533,\"id_ciudad_erp\":3599,\"tipo_documento\":1,\"numero_documento\":\"900967679\",\"primer_nombre\":\"UNIVERSO SEGURIDAD TTDA\",\"segundo_nombre\":\"\",\"primer_apellido\":\"\",\"segundo_apellido\":\"\",\"telefono\":\"\",\"celular\":\"3168233385\",\"email\":\"SEGURIDADUNIVERSO@GMAIL.COM\",\"direccion\":\"CL 17 SUR 11 B 17\",\"fecha_nacimiento\":\"2023-11-01T00:00:00.000Z\",\"sexo\":0,\"avatar\":\"\",\"importado\":0,\"eliminado\":0,\"created_by\":25,\"created_at\":\"2023-11-23T00:52:13.000Z\",\"updated_by\":null,\"updated_at\":\"2023-11-23T00:52:13.000Z\"}', 25, '2023-11-23 00:52:13', NULL, NULL),
(194, 3, 'CREATE', 'PERSONA CON DOCUMENTO 901727981 CREADA POR adolfomc2745@gmail.com', '{\"id\":118,\"id_tercero_erp\":1544,\"id_ciudad_erp\":3599,\"tipo_documento\":1,\"numero_documento\":\"901727981\",\"primer_nombre\":\"KODEZATELITE S.A.S\",\"segundo_nombre\":\"\",\"primer_apellido\":\"\",\"segundo_apellido\":\"\",\"telefono\":\"\",\"celular\":\"2179816\",\"email\":\"KODEZATELITE@GMAIL.COM\",\"direccion\":\"CL 50 38 78 OFIC 201\",\"fecha_nacimiento\":\"2023-11-01T00:00:00.000Z\",\"sexo\":0,\"avatar\":\"\",\"importado\":0,\"eliminado\":0,\"created_by\":25,\"created_at\":\"2023-11-23T00:59:52.000Z\",\"updated_by\":null,\"updated_at\":\"2023-11-23T00:59:53.000Z\"}', 25, '2023-11-23 00:59:53', NULL, NULL),
(195, 3, 'CREATE', 'PERSONA CON DOCUMENTO 71636951 CREADA POR adolfomc2745@gmail.com', '{\"id\":119,\"id_tercero_erp\":1542,\"id_ciudad_erp\":null,\"tipo_documento\":0,\"numero_documento\":\"71636951\",\"primer_nombre\":\"FREDY\",\"segundo_nombre\":\"ESTEBAN\",\"primer_apellido\":\"\",\"segundo_apellido\":\"\",\"telefono\":\"\",\"celular\":\"\",\"email\":\"\",\"direccion\":\"\",\"fecha_nacimiento\":\"2023-11-01T00:00:00.000Z\",\"sexo\":0,\"avatar\":\"\",\"importado\":0,\"eliminado\":0,\"created_by\":25,\"created_at\":\"2023-11-23T01:01:12.000Z\",\"updated_by\":null,\"updated_at\":\"2023-11-23T01:01:12.000Z\"}', 25, '2023-11-23 01:01:12', NULL, NULL),
(196, 3, 'UPDATE', 'PERSONA CON NÚMERO DE DOCUMENTO 71636951 ACTUALIZADO POR adolfomc2745@gmail.com', '{\"id_ciudad_erp\":3599,\"primer_apellido\":\"VELASQUEZ\",\"segundo_apellido\":\"LOPEZ\",\"celular\":\"3137886546\",\"fecha_nacimiento\":\"2023-11-01T00:00:00.000Z\",\"created_at\":\"2023-11-23T01:01:12.000Z\",\"updated_by\":25,\"updated_at\":\"2023-11-23T01:02:27.000Z\"}', 25, '2023-11-23 01:02:27', NULL, NULL),
(197, 8, 'CREATE', 'RECIBO DE CAJA 30 CREADO POR adolfomc2745@gmail.com', '{\"id\":98,\"consecutivo\":30,\"id_persona\":77,\"fecha_recibo\":\"2023-11-22T00:00:00.000Z\",\"valor_recibo\":329400,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A603-1123 ABONO: 281.262 | DOC. REF: 0U8-1123 ABONO: 7406 | DOC. REF: 0P8-1123 ABONO: 40.732\",\"token_erp\":\"b0e88b2be8856bef0057ad36e03989e4df5feb8e5ef69512e740e8db604f04ff\",\"created_at\":\"2023-11-23T01:09:13.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-23 01:09:13', NULL, NULL),
(198, 8, 'CREATE', 'RECIBO DE CAJA 31 CREADO POR adolfomc2745@gmail.com', '{\"id\":99,\"consecutivo\":31,\"id_persona\":95,\"fecha_recibo\":\"2023-11-22T00:00:00.000Z\",\"valor_recibo\":42000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: P32-1123 ABONO: 42.000\",\"token_erp\":\"bce68d49f7ca1af3711cd5c58890d42c219eb9aae54ff1a200a29909f28fceb3\",\"created_at\":\"2023-11-23T01:10:02.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-23 01:10:02', NULL, NULL),
(199, 8, 'CREATE', 'RECIBO DE CAJA 32 CREADO POR adolfomc2745@gmail.com', '{\"id\":100,\"consecutivo\":32,\"id_persona\":69,\"fecha_recibo\":\"2023-11-22T00:00:00.000Z\",\"valor_recibo\":237200,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A501-1123 ABONO: 195.234 | DOC. REF: U35-1123 ABONO: 4937 | DOC. REF: P14-1123 ABONO: 37.029\",\"token_erp\":\"2657f73f82e0693ae79b2f769d68089645a19495220fc78f21cdbf6d7537076f\",\"created_at\":\"2023-11-23T01:11:02.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-23 01:11:02', NULL, NULL),
(200, 8, 'CREATE', 'RECIBO DE CAJA 33 CREADO POR adolfomc2745@gmail.com', '{\"id\":101,\"consecutivo\":33,\"id_persona\":99,\"fecha_recibo\":\"2023-11-22T00:00:00.000Z\",\"valor_recibo\":46500,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: U26-1123 ABONO: 4937 | DOC. REF: P23-1123 ABONO: 41.563\",\"token_erp\":\"84b489dc1e999160912a37985b5171338043ffafa83e3eaa410efaf68fd614bb\",\"created_at\":\"2023-11-23T01:11:49.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-23 01:11:49', NULL, NULL),
(201, 8, 'CREATE', 'RECIBO DE CAJA 34 CREADO POR adolfomc2745@gmail.com', '{\"id\":102,\"consecutivo\":34,\"id_persona\":101,\"fecha_recibo\":\"2023-11-22T00:00:00.000Z\",\"valor_recibo\":279900,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A906-1123 ABONO: 230.528 | DOC. REF: U15-1123 ABONO: 7405 | DOC. REF: P18-1123 ABONO: 41.967\",\"token_erp\":\"2556eddb20fcf5393bc4e8892741d7639bb900efaa85b7047fe06e4912ec571c\",\"created_at\":\"2023-11-23T01:12:23.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-23 01:12:23', NULL, NULL),
(202, 8, 'CREATE', 'RECIBO DE CAJA 35 CREADO POR adolfomc2745@gmail.com', '{\"id\":103,\"consecutivo\":35,\"id_persona\":76,\"fecha_recibo\":\"2023-11-22T00:00:00.000Z\",\"valor_recibo\":314700,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A203-1123 ABONO: 281.448 | DOC. REF: A602-1123 ABONO: 33.252\",\"token_erp\":\"24967a2968433163b1c1872925bbd71897292c9b9b86d694e70a394e12e04f1d\",\"created_at\":\"2023-11-23T01:13:35.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-23 01:13:35', NULL, NULL),
(203, 8, 'CREATE', 'RECIBO DE CAJA 36 CREADO POR adolfomc2745@gmail.com', '{\"id\":104,\"consecutivo\":36,\"id_persona\":64,\"fecha_recibo\":\"2023-11-22T00:00:00.000Z\",\"valor_recibo\":315800,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A402-1123 ABONO: 272.591 | DOC. REF: 0U4-1123 ABONO: 4945 | DOC. REF: 0P1-1123 ABONO: 38.264\",\"token_erp\":\"c06d0b756d12f28ca92e9a478317211e89286c571b473f9f4cb902a30e05f22c\",\"created_at\":\"2023-11-23T01:14:08.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-23 01:14:08', NULL, NULL),
(204, 8, 'CREATE', 'RECIBO DE CAJA 37 CREADO POR adolfomc2745@gmail.com', '{\"id\":105,\"consecutivo\":37,\"id_persona\":88,\"fecha_recibo\":\"2023-11-22T00:00:00.000Z\",\"valor_recibo\":307400,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A804-1123 ABONO: 258.028 | DOC. REF: U33-1123 ABONO: 12.343 | DOC. REF: 0P3-1123 ABONO: 37.029\",\"token_erp\":\"866e21b94216fd8ae7e27561fb229a69bff050881e7b1b99d8c5690a252541b2\",\"created_at\":\"2023-11-23T01:14:47.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-23 01:14:47', NULL, NULL),
(205, 8, 'CREATE', 'RECIBO DE CAJA 38 CREADO POR adolfomc2745@gmail.com', '{\"id\":106,\"consecutivo\":38,\"id_persona\":55,\"fecha_recibo\":\"2023-11-22T00:00:00.000Z\",\"valor_recibo\":260600,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A205-1123 ABONO: 211.227 | DOC. REF: U28-1123 ABONO: 7406 | DOC. REF: P33-1123 ABONO: 41.967\",\"token_erp\":\"a7749dd338588160b6153bf32f158bdf915b209cdf4ac0a756bbb2e274107100\",\"created_at\":\"2023-11-23T01:15:37.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-23 01:15:37', NULL, NULL),
(206, 8, 'CREATE', 'RECIBO DE CAJA 39 CREADO POR adolfomc2745@gmail.com', '{\"id\":107,\"consecutivo\":39,\"id_persona\":110,\"fecha_recibo\":\"2023-11-22T00:00:00.000Z\",\"valor_recibo\":322200,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A602-1123 ABONO: 239.530 | DOC. REF: 0U1-1123 ABONO: 6156 | DOC. REF: 0P4-1123 ABONO: 34.596 | DOC. REF: P24-1123 ABONO: 41.918\",\"token_erp\":\"255c5cf728d6fef17bfc18d113424592053f102b5fbb0ec57e64f2eb1c07838d\",\"created_at\":\"2023-11-23T01:16:39.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-23 01:16:39', NULL, NULL),
(207, 8, 'CREATE', 'RECIBO DE CAJA 40 CREADO POR adolfomc2745@gmail.com', '{\"id\":108,\"consecutivo\":40,\"id_persona\":90,\"fecha_recibo\":\"2023-11-22T00:00:00.000Z\",\"valor_recibo\":261400,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A806-1123 ABONO: 214.496 | DOC. REF: U12-1123 ABONO: 4937 | DOC. REF: P26-1123 ABONO: 41.967\",\"token_erp\":\"d91fd7b64ce2d9fc649f22e4ae6b42206cbbf4643565e04fe2f46d84826f92f7\",\"created_at\":\"2023-11-23T01:20:00.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-23 01:20:00', NULL, NULL),
(208, 8, 'CREATE', 'RECIBO DE CAJA 41 CREADO POR adolfomc2745@gmail.com', '{\"id\":109,\"consecutivo\":41,\"id_persona\":70,\"fecha_recibo\":\"2023-11-22T00:00:00.000Z\",\"valor_recibo\":290800,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A502-1123 ABONO: 18.742 | DOC. REF: 00000001 ABONO: 272.058\",\"token_erp\":\"4900aaf1057bf8bc1cca914120b47a3a580dd0a3dc8a032fe510996573f87e99\",\"created_at\":\"2023-11-23T01:22:40.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-23 01:22:40', NULL, NULL);
INSERT INTO `logs` (`id`, `id_modulo`, `tipo_operacion`, `descripcion`, `detalle_json`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(209, 8, 'CREATE', 'RECIBO DE CAJA 42 CREADO POR adolfomc2745@gmail.com', '{\"id\":110,\"consecutivo\":42,\"id_persona\":62,\"fecha_recibo\":\"2023-11-22T00:00:00.000Z\",\"valor_recibo\":195000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A306-1123 ABONO: 195.000\",\"token_erp\":\"4ab7306adcf0c785fb486f39e65aeb5ceebb2858ef1885f98b44af7c0882361d\",\"created_at\":\"2023-11-23T01:24:05.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-23 01:24:05', NULL, NULL),
(210, 10, 'CREATE', 'PAGO 6 CREADO POR paulina9@gmail.com', '{\"id\":10,\"consecutivo\":6,\"id_persona\":113,\"fecha_pago\":\"2023-11-23T00:00:00.000Z\",\"valor_pago\":100000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: 00000004 ABONO: 100.000\",\"token_erp\":\"8d4943608e20127108f4da7e99c2d53ffec48342a6a7331abd3fa9313864c1f8\",\"created_at\":\"2023-11-23T16:36:47.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-23 16:36:47', NULL, NULL),
(211, 5, 'CREATE', 'CONTROL DE INGRESO CREADO POR paulina9@gmail.com', '{\"id\":25,\"id_persona_autoriza\":144,\"id_inmueble\":62,\"id_inmueble_zona\":1,\"id_concepto_visita\":15,\"id_tipo_vehiculo\":null,\"persona_visita\":\"luis carlos acevedo\",\"placa\":\"\",\"fecha_ingreso\":\"2023-11-23T17:48:36.000Z\",\"fecha_salida\":null,\"observacion_visita_previa\":\"JARDINERO PRIVADO\",\"observacion\":\"LLAME A DON FERNANDO Y AUTORIZO LA ENTRADA\",\"url_foto_visitante\":null,\"roles_notificados\":null,\"created_by\":24,\"created_at\":\"2023-11-23T17:48:36.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-23 17:48:36', NULL, NULL),
(212, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":7,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-24T09:50:00.000Z\",\"fecha_programada_final\":\"2023-11-24T14:00:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"328ia\\\",\\\"text\\\":\\\"asasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":6,\\\"style\\\":\\\"BOLD\\\"},{\\\"offset\\\":0,\\\"length\\\":6,\\\"style\\\":\\\"fontsize-30\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-24T14:55:21.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-24 09:55:21', NULL, NULL),
(213, 43, 'UPDATE', 'TAREA MTTO. PISCINA ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada_inicial\":\"2023-11-24T09:07:00.000Z\",\"fecha_programada_final\":\"2023-11-24T15:05:00.000Z\",\"created_at\":\"2023-11-24T14:55:21.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-24T15:00:23.000Z\"}', 4, '2023-11-24 10:00:23', NULL, NULL),
(214, 43, 'UPDATE', 'TAREA MTTO. PISCINA ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada_inicial\":\"2023-11-24T09:07:00.000Z\",\"fecha_programada_final\":\"2023-11-24T15:05:00.000Z\",\"id_usuario_responsable\":4,\"created_at\":\"2023-11-24T14:55:21.000Z\",\"updated_at\":\"2023-11-24T15:12:41.000Z\"}', 4, '2023-11-24 10:12:41', NULL, NULL),
(215, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MTTO. PISCINA ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada_inicial\":\"2023-11-24T09:07:00.000Z\",\"fecha_programada_final\":\"2023-11-24T15:05:00.000Z\",\"fecha_completada\":\"2023-11-24T10:26:00.000Z\",\"estado\":1,\"observacion_completada\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"dqlde\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-24T14:55:21.000Z\",\"updated_at\":\"2023-11-24T15:20:08.000Z\"}', 4, '2023-11-24 10:20:08', NULL, NULL),
(216, 43, 'UPDATE', 'TAREA MTTO. PISCINA ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada_inicial\":\"2023-11-24T09:07:00.000Z\",\"fecha_programada_final\":\"2023-11-24T15:05:00.000Z\",\"fecha_completada\":\"2023-11-24T10:26:00.000Z\",\"estado\":0,\"created_at\":\"2023-11-24T14:55:21.000Z\",\"updated_at\":\"2023-11-24T15:20:21.000Z\"}', 4, '2023-11-24 10:20:21', NULL, NULL),
(217, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MTTO. PISCINA ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada_inicial\":\"2023-11-24T09:07:00.000Z\",\"fecha_programada_final\":\"2023-11-24T15:05:00.000Z\",\"fecha_completada\":\"2023-11-24T10:30:00.000Z\",\"created_at\":\"2023-11-24T14:55:21.000Z\",\"updated_at\":\"2023-11-24T15:20:36.000Z\"}', 4, '2023-11-24 10:20:37', NULL, NULL),
(218, 43, 'UPDATE', 'TAREA MTTO. PISCINA ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada_inicial\":\"2023-11-24T09:07:00.000Z\",\"fecha_programada_final\":\"2023-11-24T09:10:00.000Z\",\"fecha_completada\":\"2023-11-24T10:30:00.000Z\",\"created_at\":\"2023-11-24T14:55:21.000Z\",\"updated_at\":\"2023-11-24T15:34:38.000Z\"}', 4, '2023-11-24 10:34:38', NULL, NULL),
(219, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MTTO. PISCINA ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada_inicial\":\"2023-11-24T09:07:00.000Z\",\"fecha_programada_final\":\"2023-11-24T09:10:00.000Z\",\"fecha_completada\":null,\"created_at\":\"2023-11-24T14:55:21.000Z\",\"updated_at\":\"2023-11-24T15:34:57.000Z\"}', 4, '2023-11-24 10:34:58', NULL, NULL),
(220, 43, 'UPDATE', 'TAREA MTTO. PISCINA ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada_inicial\":\"2023-11-24T09:07:00.000Z\",\"fecha_programada_final\":\"2023-11-24T14:10:00.000Z\",\"created_at\":\"2023-11-24T14:55:21.000Z\",\"updated_at\":\"2023-11-24T15:39:04.000Z\"}', 4, '2023-11-24 10:39:05', NULL, NULL),
(221, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MTTO. PISCINA ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada_inicial\":\"2023-11-24T09:07:00.000Z\",\"fecha_programada_final\":\"2023-11-24T14:10:00.000Z\",\"fecha_completada\":\"2023-11-24T10:41:00.000Z\",\"estado\":1,\"created_at\":\"2023-11-24T14:55:21.000Z\",\"updated_at\":\"2023-11-24T15:42:03.000Z\"}', 4, '2023-11-24 10:42:04', NULL, NULL),
(222, 43, 'UPDATE', 'TAREA MTTO. PISCINA ACTUALIZADA POR paulina9@gmail.com', '{\"fecha_programada_inicial\":\"2023-11-24T04:07:00.000Z\",\"fecha_programada_final\":\"2023-11-24T09:10:00.000Z\",\"fecha_completada\":\"2023-11-24T05:41:00.000Z\",\"estado\":0,\"created_at\":\"2023-11-24T09:55:21.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-24T20:17:36.000Z\"}', 24, '2023-11-24 20:17:36', NULL, NULL),
(223, 43, 'CREATE', 'TAREA MANTENIMIENTO DE ASESORES  CREADA POR paulina9@gmail.com', '{\"id\":8,\"id_tipo_tarea\":26,\"fecha_programada_inicial\":\"2023-11-24T15:18:00.000Z\",\"fecha_programada_final\":\"2023-11-25T06:20:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":24,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2sjqr\\\",\\\"text\\\":\\\"ytrabajar duro esta seman a\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":24,\"created_at\":\"2023-11-24T20:18:42.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-24 20:18:42', NULL, NULL),
(224, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MANTENIMIENTO DE ASESORES  ACTUALIZADA POR paulina9@gmail.com', '{\"fecha_programada_inicial\":\"2023-11-24T15:18:00.000Z\",\"fecha_programada_final\":\"2023-11-25T06:20:00.000Z\",\"fecha_completada\":\"2023-11-24T19:18:00.000Z\",\"estado\":1,\"observacion_completada\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"b6knj\\\",\\\"text\\\":\\\"deberia ver ela imagne de una. pero bueno. que mas se va a hacer.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-24T20:18:42.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-24T20:20:06.000Z\"}', 24, '2023-11-24 20:20:06', NULL, NULL),
(225, 43, 'UPDATE', 'TAREA MANTENIMIENTO DE ASESORES  ACTUALIZADA POR paulina9@gmail.com', '{\"fecha_programada_inicial\":\"2023-11-24T15:18:00.000Z\",\"fecha_programada_final\":\"2023-11-25T06:20:00.000Z\",\"fecha_completada\":\"2023-11-24T19:18:00.000Z\",\"estado\":0,\"created_at\":\"2023-11-24T20:18:42.000Z\",\"updated_at\":\"2023-11-24T20:20:41.000Z\"}', 24, '2023-11-24 20:20:41', NULL, NULL),
(226, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MANTENIMIENTO DE ASESORES  ACTUALIZADA POR paulina9@gmail.com', '{\"fecha_programada_inicial\":\"2023-11-24T15:18:00.000Z\",\"fecha_programada_final\":\"2023-11-25T06:20:00.000Z\",\"fecha_completada\":\"2023-11-24T19:18:00.000Z\",\"estado\":1,\"created_at\":\"2023-11-24T20:18:42.000Z\",\"updated_at\":\"2023-11-24T20:21:00.000Z\"}', 24, '2023-11-24 20:21:00', NULL, NULL),
(227, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR paulina9@gmail.com', '{\"id\":9,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-24T15:21:00.000Z\",\"fecha_programada_final\":\"2023-11-24T15:22:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":3,\"id_usuario_responsable\":24,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"8750h\\\",\\\"text\\\":\\\"tareas muy mal hecha\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":24,\"created_at\":\"2023-11-24T20:22:23.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-24 20:22:23', NULL, NULL),
(228, 43, 'UPDATE', 'TAREA MTTO. PISCINA ACTUALIZADA POR paulina9@gmail.com', '{\"fecha_programada_inicial\":\"2023-11-24T15:21:00.000Z\",\"fecha_programada_final\":\"2023-11-24T17:22:00.000Z\",\"created_at\":\"2023-11-24T20:22:23.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-24T20:24:03.000Z\"}', 24, '2023-11-24 20:24:03', NULL, NULL),
(229, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MTTO. PISCINA ACTUALIZADA POR paulina9@gmail.com', '{\"fecha_programada_inicial\":\"2023-11-24T15:21:00.000Z\",\"fecha_programada_final\":\"2023-11-24T17:22:00.000Z\",\"fecha_completada\":\"2023-11-25T15:24:00.000Z\",\"estado\":1,\"observacion_completada\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c45nh\\\",\\\"text\\\":\\\"yo si estuvbe vbien, a lo que pasa qes que a ustedew no le gusta mi trabajo.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-24T20:22:23.000Z\",\"updated_at\":\"2023-11-24T20:24:51.000Z\"}', 24, '2023-11-24 20:24:51', NULL, NULL),
(230, 43, 'CREATE', 'TAREA MANTENIMIENTO DE ASESORES  CREADA POR paulina9@gmail.com', '{\"id\":10,\"id_tipo_tarea\":26,\"fecha_programada_inicial\":\"2023-11-24T15:25:00.000Z\",\"fecha_programada_final\":\"2023-11-24T15:26:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":24,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"ak53r\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":24,\"created_at\":\"2023-11-24T20:25:47.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-24 20:25:47', NULL, NULL),
(231, 43, 'UPDATE', 'TAREA MANTENIMIENTO DE ASESORES  ACTUALIZADA POR paulina9@gmail.com', '{\"fecha_programada_inicial\":\"2023-11-24T15:25:00.000Z\",\"fecha_programada_final\":\"2023-11-24T15:26:00.000Z\",\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"ak53r\\\",\\\"text\\\":\\\"esta grabando de una y no me deja ingrear el texto, tiene que exgir texto.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-24T20:25:47.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-24T20:26:13.000Z\"}', 24, '2023-11-24 20:26:13', NULL, NULL),
(232, 43, 'UPDATE', 'TAREA MANTENIMIENTO DE ASESORES  ACTUALIZADA POR paulina9@gmail.com', '{\"fecha_programada_inicial\":\"2023-11-24T15:18:00.000Z\",\"fecha_programada_final\":\"2023-11-25T06:20:00.000Z\",\"fecha_completada\":\"2023-11-24T19:18:00.000Z\",\"estado\":2,\"created_at\":\"2023-11-24T20:18:42.000Z\",\"updated_at\":\"2023-11-24T20:30:29.000Z\"}', 24, '2023-11-24 20:30:29', NULL, NULL),
(233, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MANTENIMIENTO DE ASESORES  ACTUALIZADA POR paulina9@gmail.com', '{\"fecha_programada_inicial\":\"2023-11-24T15:25:00.000Z\",\"fecha_programada_final\":\"2023-11-24T15:26:00.000Z\",\"observacion_completada\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"4bql2\\\",\\\"text\\\":\\\"hola\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-24T20:25:47.000Z\",\"updated_at\":\"2023-11-24T20:35:52.000Z\"}', 24, '2023-11-24 20:35:52', NULL, NULL),
(234, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MANTENIMIENTO DE ASESORES  ACTUALIZADA POR paulina9@gmail.com', '{\"fecha_programada_inicial\":\"2023-11-24T15:25:00.000Z\",\"fecha_programada_final\":\"2023-11-24T15:26:00.000Z\",\"observacion_completada\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"4bql2\\\",\\\"text\\\":\\\"hola, vendi tres gaseossa.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}},{\\\"key\\\":\\\"epeqs\\\",\\\"text\\\":\\\"ya pase revista en los ultjmo pisos\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}},{\\\"key\\\":\\\"etlit\\\",\\\"text\\\":\\\"don carlos del 701 dejo paquete y dinero en porteria.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}},{\\\"key\\\":\\\"885am\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}},{\\\"key\\\":\\\"2cb9l\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-24T20:25:47.000Z\",\"updated_at\":\"2023-11-24T20:36:32.000Z\"}', 24, '2023-11-24 20:36:32', NULL, NULL),
(235, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MANTENIMIENTO DE ASESORES  ACTUALIZADA POR paulina9@gmail.com', '{\"fecha_programada_inicial\":\"2023-11-24T15:25:00.000Z\",\"fecha_programada_final\":\"2023-11-24T15:26:00.000Z\",\"fecha_completada\":\"2023-11-24T15:39:00.000Z\",\"estado\":1,\"created_at\":\"2023-11-24T20:25:47.000Z\",\"updated_at\":\"2023-11-24T20:39:48.000Z\"}', 24, '2023-11-24 20:39:48', NULL, NULL),
(236, 43, 'CREATE', 'TAREA MANTENIMIENTO DE ASESORES  CREADA POR paulina9@gmail.com', '{\"id\":11,\"id_tipo_tarea\":26,\"fecha_programada_inicial\":\"2023-11-24T15:40:00.000Z\",\"fecha_programada_final\":\"2023-11-24T15:40:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":24,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"1ekp6\\\",\\\"text\\\":\\\"si señor\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":24,\"created_at\":\"2023-11-24T20:40:47.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-24 20:40:47', NULL, NULL),
(237, 43, 'UPDATE', 'TAREA MANTENIMIENTO DE ASESORES  ACTUALIZADA POR paulina9@gmail.com', '{\"fecha_programada_inicial\":\"2023-11-24T15:40:00.000Z\",\"fecha_programada_final\":\"2023-11-24T15:41:00.000Z\",\"created_at\":\"2023-11-24T20:40:47.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-24T20:41:01.000Z\"}', 24, '2023-11-24 20:41:01', NULL, NULL),
(238, 43, 'UPDATE', 'TAREA MANTENIMIENTO DE ASESORES  ACTUALIZADA POR paulina9@gmail.com', '{\"fecha_programada_inicial\":\"2023-11-24T15:40:00.000Z\",\"fecha_programada_final\":\"2023-11-24T15:43:00.000Z\",\"created_at\":\"2023-11-24T20:40:47.000Z\",\"updated_at\":\"2023-11-24T20:41:11.000Z\"}', 24, '2023-11-24 20:41:11', NULL, NULL),
(239, 41, 'CREATE', 'MENSAJE CON TÍTULO RESPUESTA PQRSF: QUEJA - 2023-11-24 20:49  ENVIADO POR paulina9@gmail.com', '{\"id\":24,\"id_zona\":null,\"id_persona\":81,\"id_rol_persona\":null,\"titulo\":\"RESPUESTA PQRSF: QUEJA - 2023-11-24 20:49 \",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"cg44b\\\",\\\"text\\\":\\\"PUES ACUSTECE A DORMIR Y LISTO.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":24,\"created_at\":\"2023-11-24T20:51:54.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-24 20:51:54', NULL, NULL),
(240, 41, 'CREATE', 'MENSAJE CON TÍTULO EMPRESAS PUBLICAS ENVIADO POR paulina9@gmail.com', '{\"id\":25,\"id_zona\":null,\"id_persona\":null,\"id_rol_persona\":24,\"titulo\":\"EMPRESAS PUBLICAS\",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"cfor\\\",\\\"text\\\":\\\"NO SE SABE PERO QUE SE VA LA LUZ SE VA.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":1,\"created_by\":24,\"created_at\":\"2023-11-24T20:56:00.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-24 20:56:00', NULL, NULL),
(241, 41, 'CREATE', 'MENSAJE CON TÍTULO BASURA ENVIADO POR paulina9@gmail.com', '{\"id\":26,\"id_zona\":null,\"id_persona\":81,\"id_rol_persona\":null,\"titulo\":\"BASURA\",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"4kl9m\\\",\\\"text\\\":\\\"HOY NO PASA LA BUSARA, Y EL SHUT ESTA LLENO, NO LLEVE MAS BILSAS.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":1,\"created_by\":24,\"created_at\":\"2023-11-24T20:57:19.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-24 20:57:19', NULL, NULL),
(242, 41, 'CREATE', 'MENSAJE CON TÍTULO TERCER MENSAJE  ENVIADO POR paulina9@gmail.com', '{\"id\":27,\"id_zona\":1,\"id_persona\":null,\"id_rol_persona\":null,\"titulo\":\"TERCER MENSAJE \",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"7nj05\\\",\\\"text\\\":\\\"mir a ver si llega este mensaje.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":1,\"created_by\":24,\"created_at\":\"2023-11-24T20:58:04.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-24 20:58:04', NULL, NULL),
(243, 43, 'DELETE', 'TAREA 11 ELIMINADA POR paulina9@gmail.com', '{\"id\":11,\"id_tipo_tarea\":26,\"fecha_programada_inicial\":\"2023-11-24T15:40:00.000Z\",\"fecha_programada_final\":\"2023-11-24T15:43:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":24,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"1ekp6\\\",\\\"text\\\":\\\"si señor\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":24,\"created_at\":\"2023-11-24T20:40:47.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-24T20:41:11.000Z\"}', 24, '2023-11-24 21:19:36', NULL, NULL),
(244, 43, 'DELETE', 'TAREA 9 ELIMINADA POR paulina9@gmail.com', '{\"id\":9,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-24T15:21:00.000Z\",\"fecha_programada_final\":\"2023-11-24T17:22:00.000Z\",\"fecha_completada\":\"2023-11-25T15:24:00.000Z\",\"estado\":1,\"prioridad\":3,\"id_usuario_responsable\":24,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"8750h\\\",\\\"text\\\":\\\"tareas muy mal hecha\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c45nh\\\",\\\"text\\\":\\\"yo si estuvbe vbien, a lo que pasa qes que a ustedew no le gusta mi trabajo.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificar_encargado\":0,\"created_by\":24,\"created_at\":\"2023-11-24T20:22:23.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-24T20:24:51.000Z\"}', 24, '2023-11-24 21:19:41', NULL, NULL),
(245, 43, 'DELETE', 'TAREA 8 ELIMINADA POR paulina9@gmail.com', '{\"id\":8,\"id_tipo_tarea\":26,\"fecha_programada_inicial\":\"2023-11-24T15:18:00.000Z\",\"fecha_programada_final\":\"2023-11-25T06:20:00.000Z\",\"fecha_completada\":\"2023-11-24T19:18:00.000Z\",\"estado\":2,\"prioridad\":0,\"id_usuario_responsable\":24,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2sjqr\\\",\\\"text\\\":\\\"ytrabajar duro esta seman a\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"b6knj\\\",\\\"text\\\":\\\"deberia ver ela imagne de una. pero bueno. que mas se va a hacer.\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificar_encargado\":0,\"created_by\":24,\"created_at\":\"2023-11-24T20:18:42.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-24T20:30:29.000Z\"}', 24, '2023-11-24 21:19:44', NULL, NULL),
(246, 34, 'CREATE', 'TIPO DE TAREA CON NOMBRE SERVICIOS GENERALES CREADO POR paulina9@gmail.com', '{\"id\":32,\"tipo\":4,\"nombre\":\"SERVICIOS GENERALES\",\"descripcion\":\"VARIOS\",\"eliminado\":0,\"created_by\":24,\"created_at\":\"2023-11-24T21:23:16.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-24 21:23:16', NULL, NULL),
(247, 3, 'DELETE', 'PERSONA CON NÚMERO DE DOCUMENTO 90099404 ELIMINADA POR adolfomc2745@gmail.com', '{\"id\":115,\"id_tercero_erp\":1584,\"id_ciudad_erp\":3599,\"tipo_documento\":0,\"numero_documento\":\"90099404\",\"primer_nombre\":\"MARINA\",\"segundo_nombre\":\"\",\"primer_apellido\":\"PALACIOS\",\"segundo_apellido\":\"\",\"telefono\":\"\",\"celular\":\"\",\"email\":\"PENDIENTE90099404@GMAIL.COM\",\"direccion\":\"\",\"fecha_nacimiento\":null,\"sexo\":1,\"avatar\":\"\",\"importado\":0,\"eliminado\":1,\"created_by\":4,\"created_at\":\"2023-11-21T23:53:49.000Z\",\"updated_by\":25,\"updated_at\":\"2023-11-24T22:56:08.000Z\"}', 25, '2023-11-24 22:56:08', NULL, NULL),
(248, 3, 'DELETE', 'PERSONA CON NÚMERO DE DOCUMENTO 11214 ELIMINADA POR adolfomc2745@gmail.com', '{\"id\":106,\"id_tercero_erp\":1530,\"id_ciudad_erp\":3554,\"tipo_documento\":1,\"numero_documento\":\"11214\",\"primer_nombre\":\"PRUEBA\",\"segundo_nombre\":\"PRUEBA\",\"primer_apellido\":\"PENDIENTE \",\"segundo_apellido\":\"\",\"telefono\":\"\",\"celular\":\"313\",\"email\":\"MEMO@HOTMAIL.COM\",\"direccion\":\"\",\"fecha_nacimiento\":\"2023-07-06T00:00:00.000Z\",\"sexo\":0,\"avatar\":\"\",\"importado\":0,\"eliminado\":1,\"created_by\":25,\"created_at\":\"2023-10-18T14:01:30.000Z\",\"updated_by\":25,\"updated_at\":\"2023-11-24T22:56:37.000Z\"}', 25, '2023-11-24 22:56:37', NULL, NULL),
(249, 3, 'CREATE', 'PERSONA CON DOCUMENTO 890904996 CREADA POR adolfomc2745@gmail.com', '{\"id\":120,\"id_tercero_erp\":1546,\"id_ciudad_erp\":3599,\"tipo_documento\":1,\"numero_documento\":\"890904996\",\"primer_nombre\":\"EPM\",\"segundo_nombre\":\"\",\"primer_apellido\":\"\",\"segundo_apellido\":\"\",\"telefono\":\"\",\"celular\":\"3808080\",\"email\":\"\",\"direccion\":\"CR 58 42 125\",\"fecha_nacimiento\":\"2023-11-01T00:00:00.000Z\",\"sexo\":0,\"avatar\":\"\",\"importado\":0,\"eliminado\":0,\"created_by\":25,\"created_at\":\"2023-11-24T23:01:11.000Z\",\"updated_by\":null,\"updated_at\":\"2023-11-24T23:01:12.000Z\"}', 25, '2023-11-24 23:01:12', NULL, NULL),
(250, 3, 'UPDATE', 'PERSONA CON NÚMERO DE DOCUMENTO 32434608 ACTUALIZADO POR paulina9@gmail.com', '{\"primer_nombre\":\"CELINA\",\"segundo_nombre\":\"\",\"primer_apellido\":\"QUINTERO\",\"segundo_apellido\":\"\",\"fecha_nacimiento\":\"1970-01-01T00:00:00.000Z\",\"sexo\":1,\"created_at\":\"2023-09-10T17:21:42.000Z\",\"updated_at\":\"2023-11-25T00:04:35.000Z\"}', 24, '2023-11-25 00:04:35', NULL, NULL),
(251, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO U31 ACTUALIZADO POR adolfomc2745@gmail.com', '{\"valor_total_administracion\":\"0\",\"created_at\":\"2023-09-09T21:04:45.000Z\",\"updated_by\":25,\"updated_at\":\"2023-11-25T00:04:49.000Z\"}', 25, '2023-11-25 00:04:49', NULL, NULL),
(252, 3, 'UPDATE', 'PERSONA CON NÚMERO DE DOCUMENTO 32434608 ACTUALIZADO POR paulina9@gmail.com', '{\"email\":\"PENDIENE@GMAIL.COM\",\"fecha_nacimiento\":\"1970-01-01T00:00:00.000Z\",\"created_at\":\"2023-09-10T17:21:42.000Z\",\"updated_at\":\"2023-11-25T00:04:58.000Z\"}', 24, '2023-11-25 00:04:58', NULL, NULL),
(253, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":12,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-25T11:04:00.000Z\",\"fecha_programada_final\":\"2023-11-30T12:05:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"8b4a7\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T15:03:21.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 10:03:22', NULL, NULL),
(254, 43, 'DELETE', 'TAREA 12 ELIMINADA POR jhondoe2@mail.com', '{\"id\":12,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-25T11:04:00.000Z\",\"fecha_programada_final\":\"2023-11-30T12:05:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"8b4a7\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T15:03:21.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 10:03:35', NULL, NULL),
(255, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":13,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-24T10:47:00.000Z\",\"fecha_programada_final\":\"2023-11-26T10:47:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"9ufub\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T15:48:24.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 10:48:24', NULL, NULL),
(256, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":14,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-23T10:59:00.000Z\",\"fecha_programada_final\":\"2023-11-23T11:59:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":4,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2dcnd\\\",\\\"text\\\":\\\"aasasa\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":6,\\\"style\\\":\\\"BOLD\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T15:59:16.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 10:59:17', NULL, NULL),
(257, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":15,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-20T10:59:00.000Z\",\"fecha_programada_final\":\"2023-11-20T11:59:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":4,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2dcnd\\\",\\\"text\\\":\\\"aasasa\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":6,\\\"style\\\":\\\"BOLD\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T15:59:16.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 10:59:17', NULL, NULL),
(258, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":16,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-26T10:59:00.000Z\",\"fecha_programada_final\":\"2023-11-26T11:59:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":4,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2dcnd\\\",\\\"text\\\":\\\"aasasa\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":6,\\\"style\\\":\\\"BOLD\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T15:59:16.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 10:59:17', NULL, NULL),
(259, 43, 'DELETE', 'TAREA 13 ELIMINADA POR jhondoe2@mail.com', '{\"id\":13,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-24T10:47:00.000Z\",\"fecha_programada_final\":\"2023-11-26T10:47:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"9ufub\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T15:48:24.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 10:59:59', NULL, NULL),
(260, 43, 'DELETE', 'TAREA 14 ELIMINADA POR jhondoe2@mail.com', '{\"id\":14,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-23T10:59:00.000Z\",\"fecha_programada_final\":\"2023-11-23T11:59:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":4,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2dcnd\\\",\\\"text\\\":\\\"aasasa\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":6,\\\"style\\\":\\\"BOLD\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T15:59:16.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:16:23', NULL, NULL),
(261, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":17,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-20T11:22:00.000Z\",\"fecha_programada_final\":\"2023-11-20T12:22:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":4,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"a7f1j\\\",\\\"text\\\":\\\"asasasasasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T16:22:10.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:22:10', NULL, NULL),
(262, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":18,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-26T11:22:00.000Z\",\"fecha_programada_final\":\"2023-11-26T12:22:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":4,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"a7f1j\\\",\\\"text\\\":\\\"asasasasasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T16:22:10.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:22:10', NULL, NULL),
(263, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":19,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-23T11:22:00.000Z\",\"fecha_programada_final\":\"2023-11-23T12:22:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":4,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"a7f1j\\\",\\\"text\\\":\\\"asasasasasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T16:22:10.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:22:10', NULL, NULL),
(264, 43, 'DELETE', 'TAREAS ELIMINADAS MASIVAMENTE POR jhondoe2@mail.com - FECHA: 2023-11-25 - TIPO: 4 - USUARIO: 4', NULL, 4, '2023-11-25 11:23:00', NULL, NULL),
(265, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":20,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-23T11:23:00.000Z\",\"fecha_programada_final\":\"2023-11-23T12:23:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":20,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"68esf\\\",\\\"text\\\":\\\"asasasasasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T16:23:56.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:23:56', NULL, NULL),
(266, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":22,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-26T11:23:00.000Z\",\"fecha_programada_final\":\"2023-11-26T12:23:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":20,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"68esf\\\",\\\"text\\\":\\\"asasasasasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T16:23:56.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:23:56', NULL, NULL),
(267, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":21,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-20T11:23:00.000Z\",\"fecha_programada_final\":\"2023-11-20T12:23:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":20,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"68esf\\\",\\\"text\\\":\\\"asasasasasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T16:23:56.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:23:56', NULL, NULL),
(268, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":25,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-26T11:24:00.000Z\",\"fecha_programada_final\":\"2023-11-26T12:24:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"ff3pj\\\",\\\"text\\\":\\\"asasasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T16:24:44.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:24:44', NULL, NULL),
(269, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":24,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-23T11:24:00.000Z\",\"fecha_programada_final\":\"2023-11-23T12:24:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"ff3pj\\\",\\\"text\\\":\\\"asasasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T16:24:44.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:24:44', NULL, NULL),
(270, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":23,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-20T11:24:00.000Z\",\"fecha_programada_final\":\"2023-11-20T12:24:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"ff3pj\\\",\\\"text\\\":\\\"asasasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"center\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T16:24:44.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:24:44', NULL, NULL),
(271, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":26,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-26T11:25:00.000Z\",\"fecha_programada_final\":\"2023-11-26T12:25:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"4pcvl\\\",\\\"text\\\":\\\"asasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T16:25:36.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:25:37', NULL, NULL),
(272, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":27,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-23T11:25:00.000Z\",\"fecha_programada_final\":\"2023-11-23T12:25:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"4pcvl\\\",\\\"text\\\":\\\"asasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T16:25:36.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:25:37', NULL, NULL),
(273, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":28,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-20T11:25:00.000Z\",\"fecha_programada_final\":\"2023-11-20T12:25:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"4pcvl\\\",\\\"text\\\":\\\"asasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T16:25:36.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:25:37', NULL, NULL),
(274, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":29,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-26T11:26:00.000Z\",\"fecha_programada_final\":\"2023-11-26T12:26:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"e10cm\\\",\\\"text\\\":\\\"asas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T16:26:14.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:26:14', NULL, NULL),
(275, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":30,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-23T11:26:00.000Z\",\"fecha_programada_final\":\"2023-11-23T12:26:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"e10cm\\\",\\\"text\\\":\\\"asas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T16:26:14.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:26:14', NULL, NULL),
(276, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":31,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-20T11:26:00.000Z\",\"fecha_programada_final\":\"2023-11-20T12:26:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"e10cm\\\",\\\"text\\\":\\\"asas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T16:26:14.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:26:14', NULL, NULL),
(277, 43, 'DELETE', 'TAREAS ELIMINADAS MASIVAMENTE POR jhondoe2@mail.com - FECHA: 2023-11-25 - TIPO: 4 - USUARIO: 19', NULL, 4, '2023-11-25 11:26:27', NULL, NULL),
(278, 43, 'DELETE', 'TAREAS ELIMINADAS MASIVAMENTE POR jhondoe2@mail.com - FECHA: 2023-11-25 - TIPO: 4 - USUARIO: 20', NULL, 4, '2023-11-25 11:26:40', NULL, NULL),
(279, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":33,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-06T06:31:00.000Z\",\"fecha_programada_final\":\"2023-11-06T07:31:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2ait7\\\",\\\"text\\\":\\\"ASASASAS\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"left\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T11:31:18.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:31:18', NULL, NULL),
(280, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":32,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-05T06:31:00.000Z\",\"fecha_programada_final\":\"2023-11-05T07:31:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2ait7\\\",\\\"text\\\":\\\"ASASASAS\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"left\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T11:31:18.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:31:18', NULL, NULL),
(281, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":34,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-07T06:31:00.000Z\",\"fecha_programada_final\":\"2023-11-07T07:31:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2ait7\\\",\\\"text\\\":\\\"ASASASAS\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"left\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T11:31:18.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:31:18', NULL, NULL),
(282, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":37,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-14T06:31:00.000Z\",\"fecha_programada_final\":\"2023-11-14T07:31:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2ait7\\\",\\\"text\\\":\\\"ASASASAS\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"left\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T11:31:18.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:31:18', NULL, NULL),
(283, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":36,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-13T06:31:00.000Z\",\"fecha_programada_final\":\"2023-11-13T07:31:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2ait7\\\",\\\"text\\\":\\\"ASASASAS\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"left\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T11:31:18.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:31:18', NULL, NULL),
(284, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":35,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-12T06:31:00.000Z\",\"fecha_programada_final\":\"2023-11-12T07:31:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2ait7\\\",\\\"text\\\":\\\"ASASASAS\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"left\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T11:31:18.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:31:18', NULL, NULL);
INSERT INTO `logs` (`id`, `id_modulo`, `tipo_operacion`, `descripcion`, `detalle_json`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(285, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":38,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-19T06:31:00.000Z\",\"fecha_programada_final\":\"2023-11-19T07:31:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2ait7\\\",\\\"text\\\":\\\"ASASASAS\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"left\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T11:31:18.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:31:18', NULL, NULL),
(286, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":41,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-26T06:31:00.000Z\",\"fecha_programada_final\":\"2023-11-26T07:31:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2ait7\\\",\\\"text\\\":\\\"ASASASAS\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"left\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T11:31:18.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:31:18', NULL, NULL),
(287, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":39,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-21T06:31:00.000Z\",\"fecha_programada_final\":\"2023-11-21T07:31:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2ait7\\\",\\\"text\\\":\\\"ASASASAS\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"left\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T11:31:18.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:31:18', NULL, NULL),
(288, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":43,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-28T06:31:00.000Z\",\"fecha_programada_final\":\"2023-11-28T07:31:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2ait7\\\",\\\"text\\\":\\\"ASASASAS\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"left\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T11:31:18.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:31:18', NULL, NULL),
(289, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":40,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-27T06:31:00.000Z\",\"fecha_programada_final\":\"2023-11-27T07:31:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2ait7\\\",\\\"text\\\":\\\"ASASASAS\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"left\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T11:31:18.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:31:18', NULL, NULL),
(290, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR jhondoe2@mail.com', '{\"id\":42,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-20T06:31:00.000Z\",\"fecha_programada_final\":\"2023-11-20T07:31:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"2ait7\\\",\\\"text\\\":\\\"ASASASAS\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{\\\"text-align\\\":\\\"left\\\"}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":4,\"created_at\":\"2023-11-25T11:31:18.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-11-25 11:31:18', NULL, NULL),
(291, 43, 'DELETE', 'TAREAS ELIMINADAS MASIVAMENTE POR jhondoe2@mail.com - FECHA: 2023-11-25 - TIPO: 4 - USUARIO: 19', NULL, 4, '2023-11-25 11:31:36', NULL, NULL),
(292, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":44,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-11-25T11:20:00.000Z\",\"fecha_programada_final\":\"2023-11-25T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(293, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":57,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-12-27T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-27T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(294, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":51,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-12-20T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-20T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(295, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":46,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-12-09T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-09T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(296, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":54,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-12-17T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-17T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(297, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":49,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-12-10T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-10T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(298, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":50,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-12-16T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-16T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(299, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":45,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-11-26T11:20:00.000Z\",\"fecha_programada_final\":\"2023-11-26T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(300, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":52,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-12-02T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-02T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(301, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":48,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-12-06T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-06T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(302, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":47,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-11-29T11:20:00.000Z\",\"fecha_programada_final\":\"2023-11-29T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(303, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":56,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-12-30T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-30T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(304, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":55,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-12-13T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-13T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(305, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":53,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-12-03T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-03T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(306, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":58,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-12-24T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-24T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(307, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":59,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-12-31T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-31T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(308, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR adolfomc2745@gmail.com', '{\"id\":60,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-12-23T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-23T14:38:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":1,\"id_usuario_responsable\":21,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":25,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":null,\"updated_at\":null}', 25, '2023-11-25 12:24:01', NULL, NULL),
(309, 43, 'UPDATE', 'TAREA SERVICIOS GENERALES ACTUALIZADA POR adolfomc2745@gmail.com', '{\"fecha_programada_inicial\":\"2023-12-02T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-02T14:38:00.000Z\",\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto, yo quisiera quhoy haga otras cosas más. e\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":25,\"updated_at\":\"2023-11-25T12:26:10.000Z\"}', 25, '2023-11-25 12:26:10', NULL, NULL),
(310, 43, 'UPDATE', 'TAREA SERVICIOS GENERALES ACTUALIZADA POR adolfomc2745@gmail.com', '{\"fecha_programada_inicial\":\"2023-12-24T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-24T14:38:00.000Z\",\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones pisofffffff alto, pero como así que lavar la oisicna\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":25,\"updated_at\":\"2023-11-25T12:27:57.000Z\"}', 25, '2023-11-25 12:27:57', NULL, NULL),
(311, 43, 'CREATE', 'TAREA MTTO. PISCINA CREADA POR paulina9@gmail.com', '{\"id\":61,\"id_tipo_tarea\":4,\"fecha_programada_inicial\":\"2023-11-25T08:04:00.000Z\",\"fecha_programada_final\":\"2023-11-29T12:04:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":33,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"5dqme\\\",\\\"text\\\":\\\"cortar césped ybarrerlo\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":24,\"created_at\":\"2023-11-25T13:05:18.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-25 13:05:18', NULL, NULL),
(312, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MTTO. PISCINA ACTUALIZADA POR juan@gmail.com', '{\"fecha_programada_inicial\":\"2023-11-25T08:04:00.000Z\",\"fecha_programada_final\":\"2023-11-29T12:04:00.000Z\",\"fecha_completada\":\"2023-11-25T09:13:00.000Z\",\"estado\":1,\"observacion_completada\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"7rls7\\\",\\\"text\\\":\\\"hola, jjffbb\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-25T13:05:18.000Z\",\"updated_by\":33,\"updated_at\":\"2023-11-25T13:16:49.000Z\"}', 33, '2023-11-25 13:16:49', NULL, NULL),
(313, 8, 'CREATE', 'RECIBO DE CAJA 43 CREADO POR jhondoe2@mail.com', '{\"id\":111,\"consecutivo\":43,\"id_persona\":53,\"fecha_recibo\":\"2023-11-25T05:00:00.000Z\",\"valor_recibo\":100000,\"estado\":1,\"observacion\":\"VALIDACIÓN COMPROBANTE # 1 DETALLE: DOC. REF: A202-1123 ABONO: 100.000\",\"token_erp\":\"1189245e67cc31f16042c2f41b55ecd1876935165af5d6c8144feab5547e71d1\",\"created_at\":\"2023-11-26T16:15:32.000Z\",\"created_by\":4,\"updated_at\":null,\"updated_by\":null}', 4, '2023-11-26 11:15:32', NULL, NULL),
(314, 8, 'DELETE', 'RECIBO DE CAJA 43 ELIMINADO POR jhondoe2@mail.com', '{\"id\":111,\"consecutivo\":43,\"id_persona\":53,\"fecha_recibo\":\"2023-11-25T05:00:00.000Z\",\"valor_recibo\":100000,\"estado\":1,\"observacion\":\"VALIDACIÓN COMPROBANTE # 1 DETALLE: DOC. REF: A202-1123 ABONO: 100.000\",\"token_erp\":\"1189245e67cc31f16042c2f41b55ecd1876935165af5d6c8144feab5547e71d1\",\"created_at\":\"2023-11-26T16:15:32.000Z\",\"created_by\":4,\"updated_at\":null,\"updated_by\":null}', 4, '2023-11-26 11:19:25', NULL, NULL),
(315, 43, 'UPDATE', 'TAREA CAMBIO ESTADO MTTO. PISCINA ACTUALIZADA POR jhondoe2@mail.com', '{\"fecha_programada_inicial\":\"2023-11-24T09:07:00.000Z\",\"fecha_programada_final\":\"2023-11-24T14:10:00.000Z\",\"fecha_completada\":\"2023-11-24T10:41:00.000Z\",\"observacion_completada\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"dqlde\\\",\\\"text\\\":\\\"asas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}},{\\\"key\\\":\\\"6i668\\\",\\\"text\\\":\\\"asasas\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}},{\\\"key\\\":\\\"6uoqp\\\",\\\"text\\\":\\\"asas NOTA AGREGADA EL: 2023-11-27 01:12:06.\\\\n\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[{\\\"offset\\\":0,\\\"length\\\":4,\\\"style\\\":\\\"BOLD\\\"}],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-24T14:55:21.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-27T06:12:06.000Z\"}', 4, '2023-11-27 01:12:06', NULL, NULL),
(316, 2, 'UPDATE', 'INMUEBLE CON CÓDIGO A405 ACTUALIZADO POR paulina9@gmail.com', '{\"area\":\"35.25\",\"coeficiente\":\"0.0157\",\"valor_total_administracion\":\"193842\",\"observaciones\":\"LE RESTE .25 AQRA QUE DE 100 LAS AREAS. MIRQAR CON ADOLFO. ESTO ES TEMPORAL.\",\"created_at\":\"2023-09-09T20:10:57.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-27T03:34:16.000Z\"}', 24, '2023-11-27 03:34:16', NULL, NULL),
(317, 8, 'CREATE', 'RECIBO DE CAJA 44 CREADO POR jhondoe2@mail.com', '{\"id\":112,\"consecutivo\":44,\"id_persona\":53,\"fecha_recibo\":\"2023-11-27T00:00:00.000Z\",\"valor_recibo\":100000,\"estado\":1,\"observacion\":\"VALIDACIÓN COMPROBANTE # 4 DETALLE: DOC. REF: A202-1123 ABONO: 100.000\",\"token_erp\":\"72919e85a714b0a0b84b0a70fb1b845415b3f2f7b7f658a58d7427e4c3dfbb44\",\"created_at\":\"2023-11-27T10:06:53.000Z\",\"created_by\":4,\"updated_at\":null,\"updated_by\":null}', 4, '2023-11-27 10:06:53', NULL, NULL),
(318, 8, 'DELETE', 'RECIBO DE CAJA 44 ELIMINADO POR jhondoe2@mail.com', '{\"id\":112,\"consecutivo\":44,\"id_persona\":53,\"fecha_recibo\":\"2023-11-27T00:00:00.000Z\",\"valor_recibo\":100000,\"estado\":1,\"observacion\":\"VALIDACIÓN COMPROBANTE # 4 DETALLE: DOC. REF: A202-1123 ABONO: 100.000\",\"token_erp\":\"72919e85a714b0a0b84b0a70fb1b845415b3f2f7b7f658a58d7427e4c3dfbb44\",\"created_at\":\"2023-11-27T10:06:53.000Z\",\"created_by\":4,\"updated_at\":null,\"updated_by\":null}', 4, '2023-11-27 10:07:10', NULL, NULL),
(319, 43, 'UPDATE', 'TAREA SERVICIOS GENERALES ACTUALIZADA POR paulina9@gmail.com', '{\"fecha_programada_inicial\":\"2023-12-27T11:20:00.000Z\",\"fecha_programada_final\":\"2023-12-27T14:38:00.000Z\",\"estado\":1,\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-27T10:37:27.000Z\"}', 24, '2023-11-27 10:37:27', NULL, NULL),
(320, 43, 'UPDATE', 'TAREA SERVICIOS GENERALES ACTUALIZADA POR paulina9@gmail.com', '{\"fecha_programada_inicial\":\"2023-11-29T11:20:00.000Z\",\"fecha_programada_final\":\"2023-11-29T14:38:00.000Z\",\"estado\":1,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"c4er2\\\",\\\"text\\\":\\\"subvenciones piso alto, todo bien \\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"created_at\":\"2023-11-25T12:24:01.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-27T10:39:45.000Z\"}', 24, '2023-11-27 10:39:45', NULL, NULL),
(321, 9, 'DELETE', 'GASTO 4 ELIMINADO POR paulina9@gmail.com', '{\"id\":27,\"id_persona_proveedor\":113,\"id_cuenta_x_pagar_egreso_gasto_erp\":19866,\"consecutivo\":4,\"valor_total_iva\":\"38319\",\"porcentaje_retencion\":\"0\",\"valor_total_retencion\":\"0\",\"valor_total\":\"240000\",\"token_erp\":\"ebd7996ad2e528f5f1e69b6c6a45352acdfb63c610ddb43fe106e76f10f981ac\",\"url_comprobante_gasto\":\"\",\"fecha_documento\":\"2023-11-10T00:00:00.000Z\",\"observacion\":\"\",\"anulado\":0,\"created_by\":25,\"created_at\":\"2023-11-21T16:49:48.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-27 21:24:29', NULL, NULL),
(322, 9, 'DELETE', 'GASTO 3 ELIMINADO POR paulina9@gmail.com', '{\"id\":26,\"id_persona_proveedor\":113,\"id_cuenta_x_pagar_egreso_gasto_erp\":null,\"consecutivo\":3,\"valor_total_iva\":\"45600\",\"porcentaje_retencion\":\"0\",\"valor_total_retencion\":\"0\",\"valor_total\":\"285600\",\"token_erp\":\"e90fdea38210f7a6c67788cb2107c1b6830952ea43879798d16de8a46faadd92\",\"url_comprobante_gasto\":\"\",\"fecha_documento\":\"2023-11-10T00:00:00.000Z\",\"observacion\":\"\",\"anulado\":0,\"created_by\":25,\"created_at\":\"2023-11-21T16:40:42.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-27 21:24:36', NULL, NULL),
(323, 9, 'DELETE', 'GASTO 2 ELIMINADO POR paulina9@gmail.com', '{\"id\":25,\"id_persona_proveedor\":40,\"id_cuenta_x_pagar_egreso_gasto_erp\":19866,\"consecutivo\":2,\"valor_total_iva\":\"197744\",\"porcentaje_retencion\":\"0\",\"valor_total_retencion\":\"0\",\"valor_total\":\"1238500\",\"token_erp\":\"3bfabf6867c6db012a99afe19b499dbf8924eeb06000f693a84758bea173dad2\",\"url_comprobante_gasto\":\"\",\"fecha_documento\":\"2023-11-05T00:00:00.000Z\",\"observacion\":\"HOMBRE\",\"anulado\":0,\"created_by\":24,\"created_at\":\"2023-11-05T07:49:28.000Z\",\"updated_by\":4,\"updated_at\":\"2023-11-22T10:49:50.000Z\"}', 24, '2023-11-27 21:24:39', NULL, NULL),
(324, 5, 'CREATE', 'CONTROL DE INGRESO CREADO POR paulina9@gmail.com', '{\"id\":26,\"id_persona_autoriza\":48,\"id_inmueble\":44,\"id_inmueble_zona\":1,\"id_concepto_visita\":15,\"id_tipo_vehiculo\":8,\"persona_visita\":\"Amanda\",\"placa\":\"Gh\",\"fecha_ingreso\":\"2023-11-28T15:43:35.000Z\",\"fecha_salida\":null,\"observacion_visita_previa\":null,\"observacion\":\"A LAS 4\",\"url_foto_visitante\":null,\"roles_notificados\":null,\"created_by\":24,\"created_at\":\"2023-11-28T15:43:35.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-28 15:43:35', NULL, NULL),
(325, 5, 'UPDATE', 'CONTROL DE INGRESO ACTUALIZADO POR paulina9@gmail.com', '{\"fecha_ingreso\":\"2023-11-23T17:48:36.000Z\",\"observacion_visita_previa\":null,\"created_at\":\"2023-11-23T17:48:36.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-28T15:43:48.000Z\"}', 24, '2023-11-28 15:43:48', NULL, NULL),
(326, 3, 'DELETE', 'PERSONA CON NÚMERO DE DOCUMENTO 151515 ELIMINADA POR paulina9@gmail.com', '{\"id\":121,\"id_tercero_erp\":null,\"id_ciudad_erp\":null,\"tipo_documento\":0,\"numero_documento\":\"151515\",\"primer_nombre\":\"NUBIA\",\"segundo_nombre\":\"ESTELLA\",\"primer_apellido\":\"CARDOINA\",\"segundo_apellido\":\"PEREZ\",\"telefono\":\"3135250101\",\"celular\":\"3135250101\",\"email\":\"SINCORREO@GMAIL.COM\",\"direccion\":\"SIN DIRECCION\",\"fecha_nacimiento\":null,\"sexo\":0,\"avatar\":null,\"importado\":1,\"eliminado\":1,\"created_by\":24,\"created_at\":\"2023-11-29T03:18:40.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-29T03:35:17.000Z\"}', 24, '2023-11-29 03:35:17', NULL, NULL),
(327, 8, 'CREATE', 'RECIBO DE CAJA 45 CREADO POR paulina9@gmail.com', '{\"id\":113,\"consecutivo\":45,\"id_persona\":81,\"fecha_recibo\":\"2023-11-28T00:00:00.000Z\",\"valor_recibo\":200000,\"estado\":1,\"observacion\":\"VALIDACIÓN COMPROBANTE # 5 DETALLE: DOC. REF: A701-1123 ABONO: 195.168 | DOC. REF: U22-1123 ABONO: 4832\",\"token_erp\":\"f278391f8f37940e633cb5d2e27a7c1c76ffc33f57f83b944551f5535aa34f0a\",\"created_at\":\"2023-11-29T03:47:42.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-29 03:47:42', NULL, NULL),
(328, 8, 'DELETE', 'RECIBO DE CAJA 45 ELIMINADO POR paulina9@gmail.com', '{\"id\":113,\"consecutivo\":45,\"id_persona\":81,\"fecha_recibo\":\"2023-11-28T00:00:00.000Z\",\"valor_recibo\":200000,\"estado\":1,\"observacion\":\"VALIDACIÓN COMPROBANTE # 5 DETALLE: DOC. REF: A701-1123 ABONO: 195.168 | DOC. REF: U22-1123 ABONO: 4832\",\"token_erp\":\"f278391f8f37940e633cb5d2e27a7c1c76ffc33f57f83b944551f5535aa34f0a\",\"created_at\":\"2023-11-29T03:47:42.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-29 03:49:23', NULL, NULL),
(329, 5, 'DELETE', 'CONTROL DE INGRESO ELIMINADO POR paulina9@gmail.com', '{\"id\":26,\"id_persona_autoriza\":48,\"id_inmueble\":44,\"id_inmueble_zona\":1,\"id_concepto_visita\":15,\"id_tipo_vehiculo\":8,\"persona_visita\":\"Amanda\",\"placa\":\"Gh\",\"fecha_ingreso\":\"2023-11-28T15:43:35.000Z\",\"fecha_salida\":null,\"observacion_visita_previa\":null,\"observacion\":\"A LAS 4\",\"url_foto_visitante\":null,\"roles_notificados\":null,\"created_by\":24,\"created_at\":\"2023-11-28T15:43:35.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-29 19:54:45', NULL, NULL),
(330, 43, 'CREATE', 'TAREA MANTENIMIENTO DE ASESORES  CREADA POR paulina9@gmail.com', '{\"id\":62,\"id_tipo_tarea\":26,\"fecha_programada_inicial\":\"2023-11-29T14:57:00.000Z\",\"fecha_programada_final\":\"2023-11-29T16:00:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":29,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"engtf\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":24,\"created_at\":\"2023-11-29T19:58:34.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-29 19:58:34', NULL, NULL),
(331, 43, 'CREATE', 'TAREA LIMPIEZA DE TANQUES DE AGUA CREADA POR paulina9@gmail.com', '{\"id\":63,\"id_tipo_tarea\":27,\"fecha_programada_inicial\":\"2023-11-29T15:01:00.000Z\",\"fecha_programada_final\":\"2023-11-29T15:01:00.000Z\",\"fecha_completada\":null,\"estado\":0,\"prioridad\":0,\"id_usuario_responsable\":19,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"88b7h\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":24,\"created_at\":\"2023-11-29T20:02:05.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-29 20:02:05', NULL, NULL),
(332, 43, 'CREATE', 'TAREA SERVICIOS GENERALES CREADA POR paulina9@gmail.com', '{\"id\":64,\"id_tipo_tarea\":32,\"fecha_programada_inicial\":\"2023-11-29T15:02:00.000Z\",\"fecha_programada_final\":\"2023-11-29T15:02:00.000Z\",\"fecha_completada\":null,\"estado\":1,\"prioridad\":0,\"id_usuario_responsable\":24,\"id_inmueble\":null,\"id_inmueble_zona\":null,\"descripcion_tarea\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"frrdj\\\",\\\"text\\\":\\\"\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"observacion_completada\":null,\"notificar_encargado\":0,\"created_by\":24,\"created_at\":\"2023-11-29T20:02:49.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-29 20:02:49', NULL, NULL),
(333, 8, 'CREATE', 'RECIBO DE CAJA 46 CREADO POR alejacg2728@gmail.com', '{\"id\":114,\"consecutivo\":46,\"id_persona\":85,\"fecha_recibo\":\"2023-11-29T00:00:00.000Z\",\"valor_recibo\":200000,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: A705-1123 ABONO: 200.000\",\"token_erp\":\"f7e2cc747ab1631010ecbf0b38e4dce7d61952bf082e58a12534c0831bbeb136\",\"created_at\":\"2023-11-29T20:12:53.000Z\",\"created_by\":22,\"updated_at\":null,\"updated_by\":null}', 22, '2023-11-29 20:12:53', NULL, NULL),
(334, 41, 'CREATE', 'MENSAJE CON TÍTULO RESPUESTA PQRSF: MUCHA BULLA - 2023-11-29 20:15  ENVIADO POR paulina9@gmail.com', '{\"id\":28,\"id_zona\":null,\"id_persona\":85,\"id_rol_persona\":null,\"titulo\":\"RESPUESTA PQRSF: MUCHA BULLA - 2023-11-29 20:15 \",\"descripcion\":\"{\\\"blocks\\\":[{\\\"key\\\":\\\"auogo\\\",\\\"text\\\":\\\"Voy a buscar una solucion\\\",\\\"type\\\":\\\"unstyled\\\",\\\"depth\\\":0,\\\"inlineStyleRanges\\\":[],\\\"entityRanges\\\":[],\\\"data\\\":{}}],\\\"entityMap\\\":{}}\",\"notificacion_push\":0,\"created_by\":24,\"created_at\":\"2023-11-29T20:18:45.000Z\",\"updated_by\":null,\"updated_at\":null}', 24, '2023-11-29 20:18:45', NULL, NULL),
(335, 31, 'UPDATE', 'CONCEPTO DE FACTURACIÓN CON NOMBRE ADMON CUARTO UTIL ACTUALIZADO POR paulina9@gmail.com', '{\"id_cuenta_iva_erp\":19895,\"valor\":\"0\",\"created_at\":\"2023-11-09T17:34:31.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-29T20:38:38.000Z\"}', 24, '2023-11-29 20:38:38', NULL, NULL),
(336, 8, 'CREATE', 'RECIBO DE CAJA 47 CREADO POR adolfomc2745@gmail.com', '{\"id\":115,\"consecutivo\":47,\"id_persona\":81,\"fecha_recibo\":\"2023-11-29T00:00:00.000Z\",\"valor_recibo\":235900,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A701-1123 ABONO: 195.168 | DOC. REF: U22-1123 ABONO: 7405 | DOC. REF: P30-1123 ABONO: 33.327\",\"token_erp\":\"60e0a1ae27ef853343361d383024eea2e2afb5a418f2a624fec6fb89e041e2a6\",\"created_at\":\"2023-11-30T00:06:46.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 25, '2023-11-30 00:06:46', NULL, NULL),
(337, 3, 'UPDATE', 'PERSONA CON NÚMERO DE DOCUMENTO 70033968 ACTUALIZADO POR paulina9@gmail.com', '{\"email\":\"GUSTAVOVELAZQUEZ951@GMAIL.COM\",\"fecha_nacimiento\":\"1970-01-01T00:00:00.000Z\",\"created_at\":\"2023-09-07T23:26:49.000Z\",\"updated_by\":24,\"updated_at\":\"2023-11-30T02:11:14.000Z\"}', 24, '2023-11-30 02:11:14', NULL, NULL),
(338, 8, 'DELETE', 'RECIBO DE CAJA 47 ELIMINADO POR paulina9@gmail.com', '{\"id\":115,\"consecutivo\":47,\"id_persona\":81,\"fecha_recibo\":\"2023-11-29T00:00:00.000Z\",\"valor_recibo\":235900,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: A701-1123 ABONO: 195.168 | DOC. REF: U22-1123 ABONO: 7405 | DOC. REF: P30-1123 ABONO: 33.327\",\"token_erp\":\"60e0a1ae27ef853343361d383024eea2e2afb5a418f2a624fec6fb89e041e2a6\",\"created_at\":\"2023-11-30T00:06:46.000Z\",\"created_by\":25,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-30 02:21:48', NULL, NULL),
(339, 8, 'CREATE', 'RECIBO DE CAJA 48 CREADO POR paulina9@gmail.com', '{\"id\":116,\"consecutivo\":48,\"id_persona\":53,\"fecha_recibo\":\"2023-11-29T00:00:00.000Z\",\"valor_recibo\":2500000,\"estado\":1,\"observacion\":\"EL DICE QUE EL 31 CANCELA EL RESTO DETALLE: DOC. REF: A202-1123 ABONO: 113.172 | DOC. REF: 00000001 ABONO: 2.386.828\",\"token_erp\":\"9cd23cfc7111404dbdd3eb08cf3c69ed4fc0e13777e8924062ef54ccc6c0d3a9\",\"created_at\":\"2023-11-30T02:28:18.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-30 02:28:18', NULL, NULL),
(340, 8, 'CREATE', 'RECIBO DE CAJA 49 CREADO POR paulina9@gmail.com', '{\"id\":117,\"consecutivo\":49,\"id_persona\":53,\"fecha_recibo\":\"2023-11-29T00:00:00.000Z\",\"valor_recibo\":850000,\"estado\":1,\"observacion\":\"SE GANO UN CHANCE Y ABONO DETALLE: DOC. REF: 00000001 ABONO: 850.000\",\"token_erp\":\"e10ea152b1ba9559ccd1bff6f7202a6d7f022050045467f4e50533738d960f1f\",\"created_at\":\"2023-11-30T02:29:39.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-30 02:29:39', NULL, NULL),
(341, 8, 'DELETE', 'RECIBO DE CAJA 49 ELIMINADO POR paulina9@gmail.com', '{\"id\":117,\"consecutivo\":49,\"id_persona\":53,\"fecha_recibo\":\"2023-11-29T00:00:00.000Z\",\"valor_recibo\":850000,\"estado\":1,\"observacion\":\"SE GANO UN CHANCE Y ABONO DETALLE: DOC. REF: 00000001 ABONO: 850.000\",\"token_erp\":\"e10ea152b1ba9559ccd1bff6f7202a6d7f022050045467f4e50533738d960f1f\",\"created_at\":\"2023-11-30T02:29:39.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-30 02:30:03', NULL, NULL),
(342, 8, 'DELETE', 'RECIBO DE CAJA 48 ELIMINADO POR paulina9@gmail.com', '{\"id\":116,\"consecutivo\":48,\"id_persona\":53,\"fecha_recibo\":\"2023-11-29T00:00:00.000Z\",\"valor_recibo\":2500000,\"estado\":1,\"observacion\":\"EL DICE QUE EL 31 CANCELA EL RESTO DETALLE: DOC. REF: A202-1123 ABONO: 113.172 | DOC. REF: 00000001 ABONO: 2.386.828\",\"token_erp\":\"9cd23cfc7111404dbdd3eb08cf3c69ed4fc0e13777e8924062ef54ccc6c0d3a9\",\"created_at\":\"2023-11-30T02:28:18.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-30 02:30:11', NULL, NULL),
(343, 8, 'CREATE', 'RECIBO DE CAJA 50 CREADO POR gustavovelazquez951@gmail.com', '{\"id\":118,\"consecutivo\":50,\"id_persona\":81,\"fecha_recibo\":\"2023-11-29T00:00:00.000Z\",\"valor_recibo\":35900,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: A701-1123 ABONO: 35.900\",\"token_erp\":\"c1e64d7cfdaab710482b0a934a8bb615b4c737286853a981a8d0c41d43afb7b2\",\"created_at\":\"2023-11-30T02:31:32.000Z\",\"created_by\":36,\"updated_at\":null,\"updated_by\":null}', 36, '2023-11-30 02:31:32', NULL, NULL),
(344, 8, 'CREATE', 'RECIBO DE CAJA 51 CREADO POR paulina9@gmail.com', '{\"id\":119,\"consecutivo\":51,\"id_persona\":81,\"fecha_recibo\":\"2023-11-21T00:00:00.000Z\",\"valor_recibo\":160000,\"estado\":1,\"observacion\":\"VALIDACIÓN COMPROBANTE # 6 DETALLE: DOC. REF: A701-1123 ABONO: 159.268 | DOC. REF: U22-1123 ABONO: 732\",\"token_erp\":\"33d5a232aee7a6db72d0ba0e0447c30a8d990b9d9fdf04aafb8dfe3b00af1d7b\",\"created_at\":\"2023-11-30T02:37:14.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-30 02:37:14', NULL, NULL),
(345, 8, 'CREATE', 'RECIBO DE CAJA 52 CREADO POR paulina9@gmail.com', '{\"id\":120,\"consecutivo\":52,\"id_persona\":81,\"fecha_recibo\":\"2023-11-29T00:00:00.000Z\",\"valor_recibo\":40000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: U22-1123 ABONO: 6673 | DOC. REF: P30-1123 ABONO: 33.327\",\"token_erp\":\"4e769717cd673b441a4913bf9ed5c524137e05bfa6bb56420eaa18cd4d0cc284\",\"created_at\":\"2023-11-30T02:38:03.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-30 02:38:03', NULL, NULL),
(346, 8, 'DELETE', 'RECIBO DE CAJA 52 ELIMINADO POR paulina9@gmail.com', '{\"id\":120,\"consecutivo\":52,\"id_persona\":81,\"fecha_recibo\":\"2023-11-29T00:00:00.000Z\",\"valor_recibo\":40000,\"estado\":1,\"observacion\":\" DETALLE: DOC. REF: U22-1123 ABONO: 6673 | DOC. REF: P30-1123 ABONO: 33.327\",\"token_erp\":\"4e769717cd673b441a4913bf9ed5c524137e05bfa6bb56420eaa18cd4d0cc284\",\"created_at\":\"2023-11-30T02:38:03.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-30 02:39:52', NULL, NULL),
(347, 8, 'DELETE', 'RECIBO DE CAJA 51 ELIMINADO POR paulina9@gmail.com', '{\"id\":119,\"consecutivo\":51,\"id_persona\":81,\"fecha_recibo\":\"2023-11-21T00:00:00.000Z\",\"valor_recibo\":160000,\"estado\":1,\"observacion\":\"VALIDACIÓN COMPROBANTE # 6 DETALLE: DOC. REF: A701-1123 ABONO: 159.268 | DOC. REF: U22-1123 ABONO: 732\",\"token_erp\":\"33d5a232aee7a6db72d0ba0e0447c30a8d990b9d9fdf04aafb8dfe3b00af1d7b\",\"created_at\":\"2023-11-30T02:37:14.000Z\",\"created_by\":24,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-30 02:40:01', NULL, NULL),
(348, 8, 'DELETE', 'RECIBO DE CAJA 50 ELIMINADO POR paulina9@gmail.com', '{\"id\":118,\"consecutivo\":50,\"id_persona\":81,\"fecha_recibo\":\"2023-11-29T00:00:00.000Z\",\"valor_recibo\":35900,\"estado\":1,\"observacion\":\"PASARELA DE PAGOS DETALLE: DOC. REF: A701-1123 ABONO: 35.900\",\"token_erp\":\"c1e64d7cfdaab710482b0a934a8bb615b4c737286853a981a8d0c41d43afb7b2\",\"created_at\":\"2023-11-30T02:31:32.000Z\",\"created_by\":36,\"updated_at\":null,\"updated_by\":null}', 24, '2023-11-30 02:40:15', NULL, NULL),
(349, 5, 'UPDATE', 'CONTROL DE INGRESO ACTUALIZADO POR paulina9@gmail.com', '{\"fecha_ingreso\":\"2023-11-23T17:48:36.000Z\",\"created_at\":\"2023-11-23T17:48:36.000Z\",\"updated_at\":\"2023-11-28T15:43:48.000Z\"}', 24, '2023-11-30 18:11:21', NULL, NULL),
(350, 33, 'UPDATE', 'CONCEPTO DE VISITA CON NOMBRE JARDINERO ACTUALIZADO POR paulina9@gmail.com', '{\"nombre\":\"EMPRESAS PUBLICAS\",\"created_at\":\"2023-09-13T22:09:13.000Z\",\"updated_by\":24,\"updated_at\":\"2023-12-01T02:36:33.000Z\"}', 24, '2023-12-01 02:36:33', NULL, NULL),
(351, 33, 'UPDATE', 'CONCEPTO DE VISITA CON NOMBRE EMPRESAS PUBLICAS ACTUALIZADO POR paulina9@gmail.com', '{\"nombre\":\"EMPRESAS PUBLICAS EPM\",\"created_at\":\"2023-09-13T22:09:13.000Z\",\"updated_at\":\"2023-12-01T02:36:47.000Z\"}', 24, '2023-12-01 02:36:47', NULL, NULL),
(352, 33, 'DELETE', 'CONCEPTO DE VISITA CON NOMBRE RECIBO DE  PAQUETES ELIMINADO POR paulina9@gmail.com', '{\"id\":22,\"tipo\":3,\"nombre\":\"RECIBO DE  PAQUETES\",\"descripcion\":null,\"eliminado\":0,\"created_by\":21,\"created_at\":\"2023-08-30T00:14:04.000Z\",\"updated_by\":25,\"updated_at\":\"2023-10-14T03:25:12.000Z\"}', 24, '2023-12-01 02:36:59', NULL, NULL),
(353, 33, 'UPDATE', 'CONCEPTO DE VISITA CON NOMBRE VISITA PORTERIA ACTUALIZADO POR paulina9@gmail.com', '{\"nombre\":\"VISITA ADMINISTRACION\",\"created_at\":\"2023-09-06T22:39:19.000Z\",\"updated_by\":24,\"updated_at\":\"2023-12-01T02:37:18.000Z\"}', 24, '2023-12-01 02:37:18', NULL, NULL),
(354, 32, 'UPDATE', 'CONCEPTO DE GASTO CON NOMBRE SERVICIOS EDITADO POR paulina9@gmail.com', '{\"id_cuenta_rete_fuente_erp\":19885,\"created_at\":\"2023-10-31T22:41:01.000Z\",\"updated_by\":24,\"updated_at\":\"2023-12-01T22:02:12.000Z\"}', 24, '2023-12-01 22:02:12', NULL, NULL),
(355, 32, 'UPDATE', 'CONCEPTO DE GASTO CON NOMBRE ASEO Y CAFETERIA EDITADO POR paulina9@gmail.com', '{\"id_cuenta_iva_erp\":19896,\"id_cuenta_rete_fuente_erp\":19885,\"created_at\":\"2023-04-30T15:36:53.000Z\",\"updated_at\":\"2023-12-01T22:02:29.000Z\"}', 24, '2023-12-01 22:02:29', NULL, NULL),
(356, 32, 'UPDATE', 'CONCEPTO DE GASTO CON NOMBRE SERVICIOS EDITADO POR jhondoe2@mail.com', '{\"nombre\":\"SERVICIOS 1\",\"created_at\":\"2023-11-01T03:41:01.000Z\",\"updated_by\":4,\"updated_at\":\"2023-12-02T16:50:13.000Z\"}', 4, '2023-12-02 11:50:13', NULL, NULL),
(357, 32, 'UPDATE', 'CONCEPTO DE GASTO CON NOMBRE SERVICIOS 1 EDITADO POR jhondoe2@mail.com', '{\"nombre\":\"SERVICIOS\",\"created_at\":\"2023-11-01T03:41:01.000Z\",\"updated_at\":\"2023-12-02T16:50:19.000Z\"}', 4, '2023-12-02 11:50:19', NULL, NULL),
(358, 32, 'CREATE', 'CONCEPTO DE GASTO CON NOMBRE SERVICIOS 1 CREADO POR jhondoe2@mail.com', '{\"id\":11,\"id_cuenta_gasto_erp\":19977,\"id_cuenta_iva_erp\":19897,\"porcentaje_iva\":19,\"id_cuenta_rete_fuente_erp\":19837,\"base_rete_fuente\":null,\"porcentaje_rete_fuente\":null,\"id_cuenta_por_pagar_erp\":null,\"nombre\":\"SERVICIOS 1\",\"eliminado\":0,\"created_by\":4,\"created_at\":\"2023-12-03T00:15:11.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-12-02 19:15:12', NULL, NULL),
(359, 32, 'DELETE', 'CONCEPTO DE GASTO CON NOMBRE SERVICIOS 1 ELIMINADO POR jhondoe2@mail.com', '{\"id\":11,\"id_cuenta_gasto_erp\":19977,\"id_cuenta_iva_erp\":19897,\"porcentaje_iva\":19,\"id_cuenta_rete_fuente_erp\":19837,\"base_rete_fuente\":null,\"porcentaje_rete_fuente\":null,\"id_cuenta_por_pagar_erp\":null,\"nombre\":\"SERVICIOS 1\",\"eliminado\":0,\"created_by\":4,\"created_at\":\"2023-12-03T00:15:11.000Z\",\"updated_by\":null,\"updated_at\":null}', 4, '2023-12-02 19:15:17', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `maestras_base`
--

CREATE TABLE `maestras_base` (
  `id` int NOT NULL,
  `tipo` int NOT NULL DEFAULT '0' COMMENT '0 - ROL, 1 - ACTIVIDAD PROVEEDOR, 2 - TIPO VEHICULO, 3 - CONCEPTO VISITA, 4 - TIPO TAREA, 5 - MODULO',
  `nombre` varchar(50) NOT NULL,
  `descripcion` text,
  `eliminado` tinyint NOT NULL DEFAULT '0',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `maestras_base`
--

INSERT INTO `maestras_base` (`id`, `tipo`, `nombre`, `descripcion`, `eliminado`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 0, 'ADMINISTRADOR', 'ADMINISTRADOR', 0, NULL, '2023-04-08 19:23:55', NULL, '0000-00-00 00:00:00'),
(2, 3, 'TEST 500 31', NULL, 1, 4, '2023-04-29 18:58:22', 4, '2023-07-02 21:13:56'),
(4, 4, 'MTTO. PISCINA', 'FILTRAR Y ASPIRAR PISCINA', 0, 4, '2023-04-29 21:47:10', 25, '2023-09-19 18:18:01'),
(6, 1, 'SUPER MERCADO', NULL, 0, 4, '2023-04-30 05:41:28', 21, '2023-08-28 01:29:38'),
(8, 2, 'MOTO', NULL, 0, 4, '2023-04-30 06:22:15', 4, '2023-05-07 03:51:19'),
(14, 2, 'CARRO', NULL, 0, 4, '2023-04-30 06:22:15', 4, '2023-07-02 22:23:12'),
(15, 3, 'VISITA INMUEBLE', NULL, 0, 4, '2023-07-02 20:59:42', 4, '2023-08-21 10:19:53'),
(16, 4, 'TEST 2', '', 1, 4, '2023-07-02 21:34:34', NULL, '2023-07-02 21:41:12'),
(17, 1, 'FARMACIAS', NULL, 0, 4, '2023-07-02 22:52:14', 21, '2023-08-28 01:29:28'),
(18, 1, 'CARNICERIAS', NULL, 0, 21, '2023-08-28 01:29:45', NULL, '0000-00-00 00:00:00'),
(19, 1, 'RESTAURANTES', NULL, 0, 21, '2023-08-28 01:30:07', 21, '2023-08-28 01:30:23'),
(20, 3, 'MANTENIMIENTO PISCINA', NULL, 0, 21, '2023-08-28 04:01:13', NULL, '0000-00-00 00:00:00'),
(21, 3, 'MANTENIMIENTO ASCENSORES', NULL, 0, 21, '2023-08-28 04:01:38', 25, '2023-10-14 03:25:26'),
(22, 3, 'RECIBO DE  PAQUETES', NULL, 1, 21, '2023-08-30 00:14:04', 25, '2023-12-01 02:36:59'),
(23, 3, 'VISITA ADMINISTRACION', NULL, 0, 21, '2023-09-06 22:39:19', 24, '2023-12-01 02:37:18'),
(24, 3, 'EMPRESAS PUBLICAS EPM', NULL, 0, 25, '2023-09-13 22:09:13', 24, '2023-12-01 02:36:47'),
(25, 3, 'ASEO UNIDAD', NULL, 0, 25, '2023-09-20 21:14:13', NULL, '0000-00-00 00:00:00'),
(26, 4, 'MANTENIMIENTO DE ASESORES ', 'NO SE PUEDE UTILIZAR POR 1 HORA', 0, 25, '2023-10-01 03:54:57', NULL, '0000-00-00 00:00:00'),
(27, 4, 'LIMPIEZA DE TANQUES DE AGUA', 'SE VA EL AGUA DE 8 AM A 3PM  ', 0, 24, '2023-10-13 04:00:31', NULL, '0000-00-00 00:00:00'),
(28, 3, 'TEST 1', NULL, 1, 4, '2023-11-08 01:44:53', 4, '2023-11-08 01:45:15'),
(29, 4, 'TEST 15', 'TEST 2', 1, 4, '2023-11-08 01:50:44', 4, '2023-11-08 01:51:09'),
(32, 4, 'SERVICIOS GENERALES', 'VARIOS', 0, 24, '2023-11-24 21:23:16', NULL, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `mensajes`
--

CREATE TABLE `mensajes` (
  `id` int NOT NULL,
  `id_zona` int DEFAULT NULL,
  `id_persona` int DEFAULT NULL,
  `id_rol_persona` int DEFAULT NULL,
  `titulo` varchar(150) NOT NULL,
  `descripcion` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `notificacion_push` tinyint NOT NULL DEFAULT '0' COMMENT '0 - NO, 1 - SI',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mensajes`
--

INSERT INTO `mensajes` (`id`, `id_zona`, `id_persona`, `id_rol_persona`, `titulo`, `descripcion`, `notificacion_push`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(24, NULL, 81, NULL, 'RESPUESTA PQRSF: QUEJA - 2023-11-24 20:49 ', '{\"blocks\":[{\"key\":\"cg44b\",\"text\":\"PUES ACUSTECE A DORMIR Y LISTO.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', 0, 24, '2023-11-24 20:51:54', NULL, NULL),
(25, NULL, NULL, 24, 'EMPRESAS PUBLICAS', '{\"blocks\":[{\"key\":\"cfor\",\"text\":\"NO SE SABE PERO QUE SE VA LA LUZ SE VA.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', 1, 24, '2023-11-24 20:56:00', NULL, NULL),
(26, NULL, 81, NULL, 'BASURA', '{\"blocks\":[{\"key\":\"4kl9m\",\"text\":\"HOY NO PASA LA BUSARA, Y EL SHUT ESTA LLENO, NO LLEVE MAS BILSAS.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', 1, 24, '2023-11-24 20:57:19', NULL, NULL),
(27, 1, NULL, NULL, 'TERCER MENSAJE ', '{\"blocks\":[{\"key\":\"7nj05\",\"text\":\"mir a ver si llega este mensaje.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', 1, 24, '2023-11-24 20:58:04', NULL, NULL),
(28, NULL, 85, NULL, 'RESPUESTA PQRSF: MUCHA BULLA - 2023-11-29 20:15 ', '{\"blocks\":[{\"key\":\"auogo\",\"text\":\"Voy a buscar una solucion\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', 0, 24, '2023-11-29 20:18:45', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mensajes_historico`
--

CREATE TABLE `mensajes_historico` (
  `id` int NOT NULL,
  `id_persona_notificada` int DEFAULT NULL,
  `id_rol_notificado` int DEFAULT NULL,
  `id_inmueble_zona` int DEFAULT NULL,
  `id_inmueble` int DEFAULT NULL,
  `push` int NOT NULL DEFAULT '0' COMMENT '0 - NO, 1 - SI',
  `titulo` int NOT NULL,
  `descripcion` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `mensajes_push_historia`
--

CREATE TABLE `mensajes_push_historia` (
  `id` int NOT NULL,
  `id_usuario_notificado` int NOT NULL,
  `titulo` varchar(250) NOT NULL,
  `vista` tinyint NOT NULL COMMENT '0 - NO, 1 - SI',
  `descripcion` text,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mensajes_push_historia`
--

INSERT INTO `mensajes_push_historia` (`id`, `id_usuario_notificado`, `titulo`, `vista`, `descripcion`, `created_at`, `created_by`, `updated_at`, `updated_by`) VALUES
(314, 21, 'Nueva cuenta de cobro 401', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 14:49:01', NULL, NULL, NULL),
(315, 22, 'Nueva cuenta de cobro 405', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 14:49:01', NULL, NULL, NULL),
(316, 26, 'Nueva cuenta de cobro 440', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 14:52:44', NULL, NULL, NULL),
(317, 22, 'Nueva cuenta de cobro 458', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 14:52:44', NULL, NULL, NULL),
(318, 21, 'Nueva cuenta de cobro 454', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 14:52:44', NULL, NULL, NULL),
(319, 26, 'Nueva cuenta de cobro 493', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 14:55:18', NULL, NULL, NULL),
(320, 21, 'Nueva cuenta de cobro 507', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 14:55:18', NULL, NULL, NULL),
(321, 22, 'Nueva cuenta de cobro 511', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 14:55:19', NULL, NULL, NULL),
(322, 26, 'Nueva cuenta de cobro 546', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 14:55:42', NULL, NULL, NULL),
(323, 22, 'Nueva cuenta de cobro 564', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 14:55:42', NULL, NULL, NULL),
(324, 21, 'Nueva cuenta de cobro 560', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 14:55:42', NULL, NULL, NULL),
(325, 21, 'Nueva cuenta de cobro 613', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 14:58:24', NULL, NULL, NULL),
(326, 22, 'Nueva cuenta de cobro 617', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 14:58:24', NULL, NULL, NULL),
(327, 26, 'Nueva cuenta de cobro 16', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 15:01:35', NULL, NULL, NULL),
(328, 21, 'Nueva cuenta de cobro 30', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 15:01:35', NULL, NULL, NULL),
(329, 22, 'Nueva cuenta de cobro 34', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 15:01:35', NULL, NULL, NULL),
(330, 22, 'Nueva cuenta de cobro 87', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 15:19:51', NULL, NULL, NULL),
(331, 21, 'Nueva cuenta de cobro 83', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 15:19:51', NULL, NULL, NULL),
(332, 26, 'Nueva cuenta de cobro 69', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 15:19:51', NULL, NULL, NULL),
(333, 22, 'Nueva cuenta de cobro 140', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 15:30:46', NULL, NULL, NULL),
(334, 21, 'Nueva cuenta de cobro 136', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 15:30:46', NULL, NULL, NULL),
(335, 26, 'Nueva cuenta de cobro 122', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 15:30:46', NULL, NULL, NULL),
(336, 22, 'Nueva cuenta de cobro 193', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 16:40:17', NULL, NULL, NULL),
(337, 21, 'Nueva cuenta de cobro 189', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 16:40:17', NULL, NULL, NULL),
(338, 26, 'Nueva cuenta de cobro 175', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 16:40:17', NULL, NULL, NULL),
(339, 26, 'Nueva cuenta de cobro 228', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 16:48:51', NULL, NULL, NULL),
(340, 21, 'Nueva cuenta de cobro 242', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 16:48:51', NULL, NULL, NULL),
(341, 22, 'Nueva cuenta de cobro 246', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-20 16:48:53', NULL, NULL, NULL),
(342, 26, 'Nueva cuenta de cobro 281', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 05:07:56', NULL, NULL, NULL),
(343, 22, 'Nueva cuenta de cobro 299', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 05:07:58', NULL, NULL, NULL),
(344, 26, 'Nueva cuenta de cobro 334', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 11:19:24', NULL, NULL, NULL),
(345, 22, 'Nueva cuenta de cobro 352', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 11:19:27', NULL, NULL, NULL),
(346, 26, 'Nueva cuenta de cobro 387', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 11:20:35', NULL, NULL, NULL),
(347, 22, 'Nueva cuenta de cobro 405', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 11:20:38', NULL, NULL, NULL),
(348, 26, 'Nueva cuenta de cobro 440', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 11:23:38', NULL, NULL, NULL),
(349, 22, 'Nueva cuenta de cobro 458', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 11:23:39', NULL, NULL, NULL),
(350, 21, 'Nueva cuenta de cobro 454', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 11:23:40', NULL, NULL, NULL),
(351, 26, 'Nueva cuenta de cobro 493', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 20:42:28', NULL, NULL, NULL),
(352, 22, 'Nueva cuenta de cobro 511', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 20:42:28', NULL, NULL, NULL),
(353, 21, 'Nueva cuenta de cobro 507', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 20:42:28', NULL, NULL, NULL),
(354, 26, 'Nueva cuenta de cobro 547', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 20:57:00', NULL, NULL, NULL),
(355, 22, 'Nueva cuenta de cobro 565', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 20:57:00', NULL, NULL, NULL),
(356, 21, 'Nueva cuenta de cobro 561', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 20:57:05', NULL, NULL, NULL),
(357, 26, 'Nueva cuenta de cobro 601', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 21:08:20', NULL, NULL, NULL),
(358, 21, 'Nueva cuenta de cobro 615', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 21:08:20', NULL, NULL, NULL),
(359, 22, 'Nueva cuenta de cobro 619', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 21:08:25', NULL, NULL, NULL),
(360, 26, 'Nueva cuenta de cobro 655', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 21:10:31', NULL, NULL, NULL),
(361, 22, 'Nueva cuenta de cobro 673', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 21:10:31', NULL, NULL, NULL),
(362, 21, 'Nueva cuenta de cobro 669', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-24 21:10:31', NULL, NULL, NULL),
(363, 26, 'Nueva cuenta de cobro 709', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-26 17:29:02', NULL, NULL, NULL),
(364, 21, 'Nueva cuenta de cobro 723', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-26 17:29:02', NULL, NULL, NULL),
(365, 22, 'Nueva cuenta de cobro 727', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-26 17:29:06', NULL, NULL, NULL),
(366, 21, 'Nueva cuenta de cobro 777', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-27 02:23:19', NULL, NULL, NULL),
(367, 22, 'Nueva cuenta de cobro 781', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-27 02:23:20', NULL, NULL, NULL),
(368, 21, 'Nueva cuenta de cobro 831', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-27 02:36:20', NULL, NULL, NULL),
(369, 22, 'Nueva cuenta de cobro 835', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-27 02:36:20', NULL, NULL, NULL),
(370, 22, 'Nueva cuenta de cobro 889', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-10-28 23:03:36', NULL, NULL, NULL),
(371, 22, 'Nueva cuenta de cobro 34', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-02 20:56:18', NULL, NULL, NULL),
(372, 22, 'Nueva cuenta de cobro 88', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-02 21:05:24', NULL, NULL, NULL),
(373, 22, 'Nueva cuenta de cobro 142', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-02 22:28:27', NULL, NULL, NULL),
(374, 22, 'Nueva cuenta de cobro 196', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-02 22:32:01', NULL, NULL, NULL),
(375, 22, 'Nueva cuenta de cobro 250', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-07 20:39:30', NULL, NULL, NULL),
(376, 22, 'Nueva cuenta de cobro 304', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-09 16:35:10', NULL, NULL, NULL),
(377, 22, 'Nueva cuenta de cobro 358', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-09 17:43:04', NULL, NULL, NULL),
(378, 21, 'Nueva cuenta de cobro 409', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-10 11:22:49', NULL, NULL, NULL),
(379, 22, 'Nueva cuenta de cobro 412', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-10 11:22:49', NULL, NULL, NULL),
(380, 22, 'Nueva cuenta de cobro 465', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-10 11:24:25', NULL, NULL, NULL),
(381, 21, 'Nueva cuenta de cobro 462', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-10 11:24:28', NULL, NULL, NULL),
(382, 21, 'Nueva cuenta de cobro 515', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-10 11:26:32', NULL, NULL, NULL),
(383, 22, 'Nueva cuenta de cobro 518', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-10 11:26:35', NULL, NULL, NULL),
(384, 21, 'Nueva cuenta de cobro 568', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-10 11:29:10', NULL, NULL, NULL),
(385, 22, 'Nueva cuenta de cobro 571', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-10 11:29:12', NULL, NULL, NULL),
(386, 21, 'Nueva cuenta de cobro 375', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-10 13:37:56', NULL, NULL, NULL),
(387, 22, 'Nueva cuenta de cobro 378', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-10 13:38:00', NULL, NULL, NULL),
(388, 21, 'Nueva cuenta de cobro 428', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-15 12:12:14', NULL, NULL, NULL),
(389, 22, 'Nueva cuenta de cobro 431', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-15 12:12:15', NULL, NULL, NULL),
(390, 22, 'Nueva cuenta de cobro 484', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-22 14:14:56', NULL, NULL, NULL),
(391, 21, 'Nueva cuenta de cobro 481', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-22 14:14:59', NULL, NULL, NULL),
(392, 31, 'Nueva cuenta de cobro 483', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-22 14:15:00', NULL, NULL, NULL),
(393, 22, 'Nueva cuenta de cobro 537', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-22 18:17:51', NULL, NULL, NULL),
(394, 21, 'Nueva cuenta de cobro 534', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-22 18:17:53', NULL, NULL, NULL),
(395, 31, 'Nueva cuenta de cobro 536', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-22 18:17:56', NULL, NULL, NULL),
(396, 31, 'Nueva cuenta de cobro 589', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-22 18:21:13', NULL, NULL, NULL),
(397, 21, 'Nueva cuenta de cobro 587', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-22 18:21:13', NULL, NULL, NULL),
(398, 22, 'Nueva cuenta de cobro 590', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-22 18:21:14', NULL, NULL, NULL),
(399, 31, 'Nueva cuenta de cobro 642', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-22 20:15:10', NULL, NULL, NULL),
(400, 21, 'Nueva cuenta de cobro 640', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-22 20:15:12', NULL, NULL, NULL),
(401, 32, 'Nueva cuenta de cobro 654', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-22 20:15:14', NULL, NULL, NULL),
(402, 22, 'Nueva cuenta de cobro 643', 0, 'Se te ha generado una nueva cuenta de cobro', '2023-11-22 20:15:14', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `multimedia`
--

CREATE TABLE `multimedia` (
  `id` int NOT NULL,
  `tipo` int NOT NULL COMMENT '0 - PERSONAS, 1 - PERSONAS VISITANTES, 2 - VEHICULOS, 3 - PQRSF, 4 - TAREAS, 5 - COMPROBANTE RECIBO CAJA, 6 - MASCOTAS',
  `id_registro` int NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `peso` varchar(50) NOT NULL,
  `tipo_multimedia` varchar(50) NOT NULL,
  `created_by` int NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `multimedia`
--

INSERT INTO `multimedia` (`id`, `tipo`, `id_registro`, `nombre`, `peso`, `tipo_multimedia`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(26, 0, 53, '1694309246070-4a0697468b882b29a9a0aadad4427c8c7295132c2b458b07be66ae7218b84803.jpg', '19023', 'image/jpeg', 21, '2023-09-10 01:27:26', NULL, NULL),
(27, 0, 86, '1694376478516-6206c228c84dd0e2b3392bb9d2eae9fef5cba0d0b9c272103aa35bdc02fbcb5b.webp', '38284', 'image/webp', 21, '2023-09-10 20:07:58', NULL, NULL),
(28, 0, 85, '1694376616466-022048416559900818330fac467c7a56f43441c4ad10d0d0df64742c8fddd244.jpeg', '8855', 'image/jpeg', 21, '2023-09-10 20:10:16', NULL, NULL),
(30, 0, 82, '1694376915516-48666084e35a5a5cdedbdadc7e2c6d1f1e57903bdc0f11e467b824cd214b3c10.jpg', '15563', 'image/jpeg', 21, '2023-09-10 20:15:15', NULL, NULL),
(31, 0, 83, '1694377161276-a7a62a77bd7dd66009d0d3b763343f600ac1cf7d51b6b19204ee70904fb03ca2.jpeg', '10685', 'image/jpeg', 21, '2023-09-10 20:19:21', NULL, NULL),
(32, 1, 22, '1694575306597-3c54e287102aa8e812168dc9bd801f8f72c0c8ef5d5c6bbe327bdc68827997da.jpg', '142903', 'image/jpeg', 25, '2023-09-13 03:21:46', NULL, NULL),
(33, 1, 23, '1694575353511-48a8d9ca65d4ffed5d24d09cde13ef76320e7d4ebf468bcfcb5c4a17f87785a9.jpg', '118227', 'image/jpeg', 25, '2023-09-13 03:22:33', NULL, NULL),
(34, 1, 24, '1694575392745-0380db97ec507816cb2435f11d56f1bfe151dea2ae25a75859e9b2f0417dda5b.jpg', '227855', 'image/jpeg', 25, '2023-09-13 03:23:12', NULL, NULL),
(35, 1, 25, '1694575442697-816a1b99ac43d3afcb36c23c4a2243f56b42fd26155feaabd07683cdaf42f05a.jpg', '104412', 'image/jpeg', 25, '2023-09-13 03:24:02', NULL, NULL),
(36, 1, 26, '1694575482301-449af8a0bdec00c5d8d26693c53895895f7e7d42ac9e04e036ab25695dcc52cd.avif', '16924', 'image/avif', 25, '2023-09-13 03:24:42', NULL, NULL),
(38, 0, 67, '1694628974913-74a78766f0ef7ba1a0d60709ce8ae0926cad7b5f29cc7d8abd9da784a784cd4d.jpg', '70687', 'image/jpeg', 25, '2023-09-13 18:16:14', NULL, NULL),
(39, 1, 28, '1694629082231-8fc9c94f022d84cf039b70ae22bc104792906a105462e9765dd6d86aa345d4b0.png', '102737', 'image/png', 25, '2023-09-13 18:18:02', NULL, NULL),
(40, 1, 27, '1694629090042-d4e8973e04e657a4c6166748380356dcecd142b56137bd3a9e6d0d75744a1482.jpg', '160765', 'image/jpeg', 25, '2023-09-13 18:18:10', NULL, NULL),
(41, 0, 81, '1695265334755-b8402e58d4590c2ef82791a352e8da722ccd7fb92a13b51238150cc7104bc414.jpeg', '155017', 'image/jpeg', 25, '2023-09-21 03:02:14', NULL, NULL),
(43, 2, 20, '1695575422803-f3239a2b9474400b1a430cec1e828c02ec1efbd20378f4a095452212682d4e38.jpeg', '4916', 'image/jpeg', 4, '2023-09-24 17:10:23', NULL, NULL),
(44, 0, 72, '1695575442439-6a55b7999da6a6d42a99435fbc69d02add7e66b1b630e694a8d6feaf91ebe579.jpg', '16436', 'image/jpeg', 4, '2023-09-24 17:10:43', NULL, NULL),
(45, 2, 21, '1695575726475-f3239a2b9474400b1a430cec1e828c02ec1efbd20378f4a095452212682d4e38.jpeg', '4916', 'image/jpeg', 4, '2023-09-24 17:15:27', NULL, NULL),
(46, 0, 52, '1695576239370-5f1c579c0c507a2d7df31386cd10b401a5d5cf88a365aaa9d299099dd49cca30.jpg', '39422', 'image/jpeg', 4, '2023-09-24 17:24:00', NULL, NULL),
(47, 1, 32, '1695617120647-fe46bd16c878a634e9456f1cacb241fb98bb642759db0fc3141facf422a715e3.jpg', '65312', 'image/jpeg', 21, '2023-09-25 04:45:20', NULL, NULL),
(48, 1, 36, '1696990904113-0b32496f5790fdc884f25ecb8e5f001f536e5fd590b260205723df3fcc20b25f.jpg', '319256', 'image/jpeg', 21, '2023-10-11 02:21:44', NULL, NULL),
(49, 1, 37, '1696991012163-afa994cf087f7e3b4230f6d3feadd231032c211caf136939656620aad634f30b.jpg', '106448', 'image/jpeg', 22, '2023-10-11 02:23:32', NULL, NULL),
(50, 0, 93, '1698813773091-a7a62a77bd7dd66009d0d3b763343f600ac1cf7d51b6b19204ee70904fb03ca2.jpeg', '10685', 'image/jpeg', 24, '2023-11-01 04:42:53', NULL, NULL),
(51, 3, 3, '1699894334521-6a55b7999da6a6d42a99435fbc69d02add7e66b1b630e694a8d6feaf91ebe579.jpg', '0', 'image/jpeg', 21, '2023-11-13 16:52:15', NULL, NULL),
(52, 3, 4, '1699972612236-87d3b9ce32ce9cd102d9366d6c27bb594ea77170f6ac54f76a8c5738c5edb263.jpg', '0', 'image/jpeg', 21, '2023-11-14 14:36:52', NULL, NULL),
(53, 3, 5, '1699979140372-f9979e9719efa30396cbd67ac02ae7e7fea0ba32e33841ba7b02ee97c7358715.jpg', '0', 'image/jpeg', 21, '2023-11-14 16:25:40', NULL, NULL),
(54, 3, 6, '1700098240043-3c62f08128790e3fc069468e5eae8fe6c5f2748131483aa1ed14df5b281f51b7.jpg', '0', 'image/jpeg', 21, '2023-11-16 01:30:40', NULL, NULL),
(55, 3, 7, '1700099305636-1d9ea7b7538852b2de3f8f605e020592391ea2fe6c337c132a2064c5167ac8fd.jpg', '0', 'image/jpeg', 22, '2023-11-16 01:48:25', NULL, NULL),
(56, 4, 4, '1700224567696-f3239a2b9474400b1a430cec1e828c02ec1efbd20378f4a095452212682d4e38.jpeg', '0', 'image/jpeg', 4, '2023-11-17 12:36:08', NULL, NULL),
(57, 4, 6, '1700612671346-6a55b7999da6a6d42a99435fbc69d02add7e66b1b630e694a8d6feaf91ebe579.jpg', '0', 'image/jpeg', 4, '2023-11-22 00:24:31', NULL, NULL),
(58, 4, 8, '1700857206628-f9979e9719efa30396cbd67ac02ae7e7fea0ba32e33841ba7b02ee97c7358715.jpg', '0', 'image/jpeg', 24, '2023-11-24 20:20:06', NULL, NULL),
(59, 4, 8, '1700857260320-4a0697468b882b29a9a0aadad4427c8c7295132c2b458b07be66ae7218b84803.jpg', '0', 'image/jpeg', 24, '2023-11-24 20:21:00', NULL, NULL),
(60, 4, 9, '1700857491292-91d69ddcbeafa8a506de814f46df98cbb58aabe5b2331c53a04088dedb10db00.jpg', '0', 'image/jpeg', 24, '2023-11-24 20:24:51', NULL, NULL),
(61, 4, 61, '1700918209294-959ceb9f9c0d1c9e16f22934d5eacd6c213689ac6581af9543dd204569e4fc50.jpg', '0', 'image/jpeg', 33, '2023-11-25 13:16:49', NULL, NULL),
(62, 5, 1, '1700926490123-6a55b7999da6a6d42a99435fbc69d02add7e66b1b630e694a8d6feaf91ebe579.jpg', '0', 'image/jpeg', 19, '2023-11-25 15:34:50', NULL, NULL),
(63, 5, 2, '1700997602332-6a55b7999da6a6d42a99435fbc69d02add7e66b1b630e694a8d6feaf91ebe579.jpg', '0', 'image/jpeg', 19, '2023-11-26 11:20:02', NULL, NULL),
(64, 5, 3, '1700997822741-6a55b7999da6a6d42a99435fbc69d02add7e66b1b630e694a8d6feaf91ebe579.jpg', '0', 'image/jpeg', 19, '2023-11-26 11:23:43', NULL, NULL),
(65, 6, 2, '1701033564001-f3239a2b9474400b1a430cec1e828c02ec1efbd20378f4a095452212682d4e38.jpeg', '4916', 'image/jpeg', 4, '2023-11-26 21:19:24', NULL, NULL),
(66, 5, 4, '1701079561070-f3239a2b9474400b1a430cec1e828c02ec1efbd20378f4a095452212682d4e38.jpeg', '0', 'image/jpeg', 19, '2023-11-27 10:06:01', NULL, NULL),
(67, 6, 3, '1701079687470-f3239a2b9474400b1a430cec1e828c02ec1efbd20378f4a095452212682d4e38.jpeg', '4916', 'image/jpeg', 4, '2023-11-27 10:08:07', NULL, NULL),
(68, 6, 4, '1701082146334-cbc79d7f4e6284dc33e52bff953e31da6f79a9af7966538f7c659fbc1718a76e.jpg', '141898', 'image/jpeg', 21, '2023-11-27 10:49:06', NULL, NULL),
(69, 5, 5, '1701229494520-d4e8973e04e657a4c6166748380356dcecd142b56137bd3a9e6d0d75744a1482.jpg', '0', 'image/jpeg', 21, '2023-11-29 03:44:54', NULL, NULL),
(70, 5, 6, '1701311580258-f3239a2b9474400b1a430cec1e828c02ec1efbd20378f4a095452212682d4e38.jpg', '0', 'image/jpeg', 36, '2023-11-30 02:33:00', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `personas`
--

CREATE TABLE `personas` (
  `id` int NOT NULL,
  `id_tercero_erp` int DEFAULT NULL,
  `id_ciudad_erp` int DEFAULT NULL,
  `tipo_documento` int NOT NULL DEFAULT '0' COMMENT '0 - CÉDULA 1 - NIT',
  `numero_documento` varchar(50) DEFAULT NULL,
  `primer_nombre` varchar(50) NOT NULL,
  `segundo_nombre` varchar(50) DEFAULT NULL,
  `primer_apellido` varchar(50) NOT NULL,
  `segundo_apellido` varchar(50) DEFAULT NULL,
  `telefono` varchar(50) DEFAULT NULL,
  `celular` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `direccion` varchar(500) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `sexo` int DEFAULT NULL COMMENT '0 - Masculino, 1 Femenino',
  `avatar` varchar(100) DEFAULT NULL,
  `importado` tinyint DEFAULT '0',
  `eliminado` tinyint NOT NULL DEFAULT '0' COMMENT '0 - NO, 1 - SI',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `personas`
--

INSERT INTO `personas` (`id`, `id_tercero_erp`, `id_ciudad_erp`, `tipo_documento`, `numero_documento`, `primer_nombre`, `segundo_nombre`, `primer_apellido`, `segundo_apellido`, `telefono`, `celular`, `email`, `direccion`, `fecha_nacimiento`, `sexo`, `avatar`, `importado`, `eliminado`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(40, 1470, 3576, 0, '15428685', 'JUAN', 'GUILLERMO', 'CADAVID', 'ARANGO', '', '3508973619', 'JUAN@GMAIL.COM', 'CL 35', '1964-04-04', 0, '', 0, 0, 21, '2023-08-24 23:16:06', 21, '2023-09-13 09:44:47'),
(42, 1471, 3576, 0, '43897360', 'ALEJANDRA', '', 'CADAVID', 'GAVIRIA', '', '321854125', 'ALEJA@GMAIL.COM', 'CR 65 89 01 APTO 7/', '1970-07-26', 1, '', 0, 0, 21, '2023-08-24 23:23:42', 21, '2023-09-13 09:44:47'),
(49, NULL, 3599, 0, '4300185', 'CARLOS', 'EMILO', 'GALAN', 'PEREZ', '', '3115498785', 'GALANP@GMAIL.COM', 'CR 20 65 84', '1865-12-18', 0, '', 0, 1, 21, '2023-09-07 14:34:39', 21, '2023-09-07 14:53:49'),
(50, NULL, 3576, 1, '9001498792', 'LA VAQUITA', '', '', '', '', '31026597', 'LACAQUITA@GMAIL.COM', 'CR 40 23 54', NULL, 0, '', 0, 1, 21, '2023-09-07 14:41:25', 21, '2023-09-07 14:53:43'),
(51, NULL, 3546, 0, '43526211', 'LUZ', 'MARINA', 'GAVIRIA', 'RAMOS', '', '3012750323', 'LUZMARINAGAVIRIARAMO@GMAIL.COM', 'DG 59 35 74', '1884-11-18', 1, '', 0, 1, 21, '2023-09-07 14:44:45', 21, '2023-09-07 14:53:35'),
(52, 1472, 3599, 0, '11789327', 'CARLOS ', '', 'PALOMEQUE', '', '', '3103904827', '', 'CL 54 36A 54', '1970-01-01', 0, '1695576239370-5f1c579c0c507a2d7df31386cd10b401a5d5cf88a365aaa9d299099dd49cca30.jpg', 0, 0, 21, '2023-09-07 16:24:01', 4, '2023-09-24 17:24:00'),
(53, 1473, 3599, 0, '82383148', 'HERNAN', '', 'RENTERIA', '', '', '3117426063', 'PROPIETARIO@MAIL.COM', 'CL 54 36A 54', '1970-01-01', 0, '', 0, 0, 21, '2023-09-07 16:35:24', 4, '2023-11-15 10:22:18'),
(54, 1474, NULL, 0, '32103053', 'TERESITA', '', 'MUÑOZ', 'ARANGO', '', '3122395368', '', 'CL 54 36A 54', NULL, 0, '', 0, 0, 21, '2023-09-07 16:43:07', NULL, '2023-09-13 09:44:47'),
(55, 1475, 3599, 0, '43061008', 'NORA ', 'ELENA', 'PATIÑO', 'RESTREPO', '', '3005034706', '', 'CL 54 36A 54', '1970-01-01', 1, '', 0, 0, 21, '2023-09-07 16:44:15', 21, '2023-09-13 09:44:47'),
(56, 1476, 3599, 0, '32542602', 'MARTHA', 'ELENA', 'MEDINA', '', '', '3173458774', '', 'CL 54 36A 54', NULL, 1, '', 0, 0, 21, '2023-09-07 16:45:58', NULL, '2023-09-13 09:44:47'),
(57, 1477, NULL, 0, '39176421', 'SANDRA', 'MILENA', 'RIVERA', '', '', '3178650396', '', 'CL 54 36A 54', NULL, 1, '', 0, 0, 21, '2023-09-07 17:14:58', NULL, '2023-09-13 09:44:47'),
(58, 1478, 3599, 0, '43817031', 'YAZMIN', '', 'CASTRILLON', '', '', '3173724804', '', 'CL 54 36A 54', '1970-01-01', 1, '', 0, 0, 21, '2023-09-07 17:24:15', 21, '2023-09-13 09:44:47'),
(59, 1479, 3599, 0, '3303754', 'JOSE', '', 'OLMEDO', 'RAMIREZ', '', '3003662420', '', 'CL 54 36A 54', '1970-01-01', 0, '', 0, 0, 21, '2023-09-07 17:26:06', 21, '2023-09-13 09:44:48'),
(60, 1480, 3599, 0, '43023145', 'LUCIA', '', 'GAVIRIA', '', '', '3216381854', '', 'CL 54 36A 54', NULL, 1, '', 0, 0, 21, '2023-09-07 17:27:28', NULL, '2023-09-13 09:44:48'),
(61, 1481, 3599, 0, '43077781', 'LUZ', 'BIBIANA', 'SILVA', '', '', '3178440955', '', 'CL 54 36A 54', NULL, 1, '', 0, 0, 21, '2023-09-07 17:28:30', NULL, '2023-09-13 09:44:48'),
(62, 1482, 3599, 0, '21368953', 'MARIA', 'IDALY', 'GIL', '', '', '3148816004', '', 'CL 54 36A 54', NULL, 1, '', 0, 0, 21, '2023-09-07 20:52:09', NULL, '2023-09-13 09:44:48'),
(63, 1483, 3599, 0, '32205661', 'MARTHA', 'CECILIA', 'VARGAS', '', '', '3014629403', '', 'CL 54 36A 54', NULL, 1, '', 0, 0, 21, '2023-09-07 20:53:49', NULL, '2023-09-13 09:44:48'),
(64, 1484, 3599, 0, '70108553', 'OMAR ', '', 'OCAMPO', '', '', '3108440384', '', 'CL 54 36A 54', NULL, 0, '', 0, 0, 21, '2023-09-07 20:54:34', NULL, '2023-09-13 09:44:48'),
(65, 1485, NULL, 0, '21776552', 'GABRIELA ', '', 'QUINTERO', '', '', '3113209365', '', 'CL 54 36A 54', NULL, 0, '', 0, 0, 21, '2023-09-07 20:55:40', NULL, '2023-09-13 09:44:48'),
(66, 1486, 3599, 0, '8400551', 'FRANCISCO ', 'JAVIER', 'PALACIO', '', '', '3137655033', '', 'CL 54 36A 54', NULL, 0, '', 0, 0, 21, '2023-09-07 20:56:35', NULL, '2023-09-13 09:44:48'),
(67, 1487, 3599, 0, '43083662', 'DIANA', 'PATRICIA', 'MADRID', 'CARDENAS', '', '3113248575', 'DIANAMADRID167@GMAIL.COM', 'CL 54 36A 54 (405)', '1965-01-28', 1, '', 0, 0, 21, '2023-09-07 20:57:35', 25, '2023-09-13 19:34:47'),
(68, 1488, 3599, 0, '2903889', 'JAIME ', '', 'CELIS', '', '', '3146020150', '', 'CL 54 36A 54', NULL, 0, '', 0, 0, 21, '2023-09-07 20:58:46', NULL, '2023-09-13 09:44:49'),
(69, 1489, 3599, 0, '43984823', 'MARICEL', 'CRISTINA', 'RAMIREZ', '', '', '3183515692', '', 'CL 54 36A 54', NULL, 1, '', 0, 0, 21, '2023-09-07 20:59:55', NULL, '2023-09-13 09:44:49'),
(70, 1490, 3599, 0, '70098699', 'JORGE ', 'ALBERTO', 'HOYOS', '', '', '3012012216', '', 'CL 54 36A 54', NULL, 0, '', 0, 0, 21, '2023-09-07 21:01:05', NULL, '2023-09-13 09:44:49'),
(71, 1491, 3599, 0, '43514205', 'INES', '', 'MEJIA', 'OCHOA', '', '3128970163', '', 'CL 54 36A 54 A701', '1970-01-01', 0, '', 0, 0, 21, '2023-09-07 21:24:54', 25, '2023-10-09 14:33:42'),
(72, 1492, NULL, 0, '43050415', 'MARIA', 'TERESA', 'RAMIREZ', '', '', '3016430001', '', 'CL 54 36A 54', NULL, 1, '1695575442439-6a55b7999da6a6d42a99435fbc69d02add7e66b1b630e694a8d6feaf91ebe579.jpg', 0, 0, 21, '2023-09-07 21:25:53', 4, '2023-09-24 17:10:43'),
(73, 1493, 3599, 0, '22114813', 'LIGIA', '', 'ARBELAEZ', '', '', '3006200491', '', 'CL 54 36A 54', NULL, 1, '', 0, 0, 21, '2023-09-07 21:26:41', NULL, '2023-09-13 09:44:49'),
(74, 1494, 3599, 0, '32465321', 'LEONILA', 'LOPEZ', 'GALLEGO', '', '', '', '', 'CL 54 36A 54', NULL, 1, '', 0, 0, 21, '2023-09-07 21:27:18', NULL, '2023-09-13 09:44:49'),
(75, 1495, 3599, 0, '70099184', 'JAVIER', '', 'TANGARIFE', '', '', '3104266899', '', 'CL 54 36A 54', NULL, 0, '', 0, 0, 21, '2023-09-07 21:28:04', NULL, '2023-09-13 09:44:50'),
(76, 1496, 3599, 0, '98567695', 'CARLOS', 'MARIO', 'PATIÑO', 'RAMIREZ A602,P24', '', '3005034706', '', 'CL 54 36A 54', '1970-01-01', 0, '', 0, 0, 21, '2023-09-07 21:28:53', 25, '2023-11-02 22:02:10'),
(77, 1497, 3599, 0, '71597171', 'CARLOS ', '', 'CARDONA', '', '', '3007839195', '', 'CL 54 36A 54', NULL, 0, '', 0, 0, 21, '2023-09-07 21:29:52', NULL, '2023-09-13 09:44:50'),
(78, 1498, 3599, 0, '21386040', 'MARTHA', 'LUCIA', 'LOPERA', '', '', '3042866780', '', 'CL 54 36A 54', NULL, 0, '', 0, 0, 21, '2023-09-07 21:30:32', NULL, '2023-09-13 09:44:50'),
(79, 1499, 3599, 0, '1017138782', 'LUISA', '', 'HINCAPIE', '', '', '3204650540', '', 'CL 54 36A 54', NULL, 1, '', 0, 0, 21, '2023-09-07 21:31:18', NULL, '2023-09-13 09:44:50'),
(80, 1500, 3599, 0, '43546435', 'GLADYS', 'RAMIREZ', '', '', '', '3206323812', '', 'CL 54 36A 54', NULL, 1, '', 0, 0, 21, '2023-09-07 21:32:10', NULL, '2023-09-13 09:44:50'),
(81, 1501, 3599, 0, '70033968', 'GUSTAVO', '', 'VELASQUEZ', 'MADRID', '', '3137519944', 'GUSTAVOVELAZQUEZ951@GMAIL.COM', 'EDIFICIO', '1970-01-01', 0, '', 0, 0, 21, '2023-09-07 23:26:49', 24, '2023-11-30 02:11:14'),
(82, 1502, 3599, 0, '70782485', 'HECTOR ', '', 'VILLEGAS', '', '', '3006562996', '', 'CL 54 36A 54', NULL, 0, '1694376915516-48666084e35a5a5cdedbdadc7e2c6d1f1e57903bdc0f11e467b824cd214b3c10.jpg', 0, 0, 21, '2023-09-07 23:27:38', 21, '2023-09-13 09:44:50'),
(83, 1503, 3599, 0, '32516067', 'LUZ', 'AMERICANA', 'FERNANDEZ', '', '', '3155132185', 'PELUZAFDEZ@GMAIL.COM', 'CL 54 36A 54', '1970-01-01', 1, '', 0, 0, 21, '2023-09-07 23:31:14', 25, '2023-11-21 14:26:37'),
(84, 1504, 3599, 0, '42994967', 'GLORIA ', 'VIRGINIA', 'LOPEZ', 'OSPINA', '', '3193750766', '', 'CL 54 36A 54', NULL, 0, '', 0, 0, 21, '2023-09-07 23:32:05', NULL, '2023-09-13 09:44:51'),
(85, 1505, 3599, 0, '32525711', 'MARTHA', '', 'OCHOA', '', '', '3147767425', 'ALEJACG2728@GMAIL.COM', 'CL 54 36A 54', '1970-01-01', 1, '', 0, 0, 21, '2023-09-07 23:36:10', 21, '2023-09-13 09:44:51'),
(86, 1506, NULL, 0, '43970206', 'NATALIA', '', 'LOPEZ', '', '', '3013682427', '', 'CL 54 36A 54', NULL, 1, '1694376478516-6206c228c84dd0e2b3392bb9d2eae9fef5cba0d0b9c272103aa35bdc02fbcb5b.webp', 0, 0, 21, '2023-09-09 19:54:25', 21, '2023-09-13 09:44:51'),
(87, 1507, 3599, 0, '43972193', 'ISABEL', '', 'CASTAÑO', '', '', '3128551280', '', 'CL 54 36A 54', NULL, 1, '', 0, 0, 21, '2023-09-09 21:16:08', NULL, '2023-09-13 09:44:51'),
(88, 1508, 3599, 0, '22174032', 'MARTHA ', '', 'RESTREPO', '', '', '3132356777', '', 'CL 54 36A 54', NULL, 1, '', 0, 0, 21, '2023-09-09 21:17:11', NULL, '2023-09-13 09:44:51'),
(89, 1509, 3599, 0, '43300048', 'GLORIA', '', 'PALACIO', '', '', '3136369759', '', 'CL 54 36A 54', NULL, 1, '', 0, 0, 21, '2023-09-09 21:18:41', NULL, '2023-09-13 09:44:51'),
(90, 1510, 3599, 0, '21332942', 'FANY', '', 'AGUIRRE', 'RODRIGUEZ', '', '3108452507', '', 'CL 54 36A 54', NULL, 0, '', 0, 0, 21, '2023-09-09 21:20:49', NULL, '2023-09-13 09:44:51'),
(91, 1511, 3599, 0, '80150812', 'DARWIN', '', 'CARDONA', 'RAMIREZ', '', '3202365040', '', 'CL 54 36A 54', NULL, 0, '', 0, 0, 21, '2023-09-09 21:21:35', NULL, '2023-09-13 09:44:51'),
(92, 1512, NULL, 0, '3352828', 'RODRIGO ', '', 'GIRALDO', '', '', '', '', '', NULL, 0, '', 0, 0, 21, '2023-09-09 21:52:18', NULL, '2023-09-13 09:44:52'),
(93, 1513, NULL, 0, '43097993', 'GLADYS', '', 'CARDONA', '', '', '3127889354', '', '', NULL, 1, '1698813773091-a7a62a77bd7dd66009d0d3b763343f600ac1cf7d51b6b19204ee70904fb03ca2.jpeg', 0, 0, 21, '2023-09-10 02:55:18', 24, '2023-11-01 04:42:53'),
(94, 1514, NULL, 0, '71720242', 'DAVID', 'A', 'OCHO', 'ZAPATA', '', '', '', '', NULL, 0, '', 0, 0, 21, '2023-09-10 02:57:45', NULL, '2023-09-13 09:44:52'),
(95, 1515, NULL, 0, '43208100', 'MARIA', 'EUGENIA', 'ARRUBLA', '', '', '3007846066', '', '', NULL, 1, '', 0, 0, 21, '2023-09-10 17:08:27', NULL, '2023-09-13 09:44:52'),
(96, 1516, NULL, 0, '1152206971', 'ALEJANDRO', '', 'ROJAS', 'ZAPATA', '', '3003144461', '', '', NULL, 0, '', 0, 0, 21, '2023-09-10 17:10:23', NULL, '2023-09-13 09:44:52'),
(97, 1517, NULL, 0, '43546249', 'BEATRIZ', '', 'RIOS', '', '', '3013773342', '', '', '1970-01-01', 1, '', 0, 0, 21, '2023-09-10 17:11:26', 21, '2023-09-13 09:44:52'),
(98, 1518, NULL, 0, '70091911', 'CARLOS', 'ARTURO', 'ESCOBAR', '', '', '3012012685', '', '', NULL, 0, '', 0, 0, 21, '2023-09-10 17:14:23', NULL, '2023-09-13 09:44:52'),
(99, 1519, NULL, 0, '70564832', 'SERGIO', '', 'ESCUDERO', '', '', '3003178526', '', '', NULL, 0, '', 0, 0, 21, '2023-09-10 17:19:23', NULL, '2023-09-13 09:44:52'),
(100, 1520, 3599, 0, '32434608', 'CELINA', '', 'QUINTERO', '', '', '3154801370', 'PENDIENE@GMAIL.COM', '', '1970-01-01', 1, '', 0, 0, 21, '2023-09-10 17:21:42', 24, '2023-11-25 00:04:58'),
(101, 1521, NULL, 0, '43095495', 'ZORAIDA', 'MARIA', 'DAVILA', '', '', '3015733645', '', '', NULL, 0, '', 0, 0, 21, '2023-09-10 17:24:30', NULL, '2023-09-13 09:44:53'),
(102, 1522, NULL, 0, '21407034', 'LUZ', 'DARY', 'MEJIA', '', '', '3006535158', '', '', NULL, 1, '', 0, 0, 21, '2023-09-10 17:35:29', NULL, '2023-09-13 09:44:53'),
(103, 1532, 3599, 0, '524111', 'JORGE', 'IVAN', 'MADRID', '', '', '3113248575', 'JORGEIMADRID2745@GMAIL.COM', 'CL 54 36A 54', '1932-11-13', 0, '', 0, 0, 25, '2023-09-14 19:45:19', NULL, '2023-10-25 19:26:55'),
(104, 1531, 3599, 0, '72592910', 'ADOLFO', 'ALFREDO', 'MADRID', 'CARDENAS', '', '3113248575', 'ADOLFOMC2745@GMAIL.COM', 'CL 54 36A 54 (405)', '1960-11-20', 0, '', 0, 0, 25, '2023-09-21 19:10:18', NULL, '2023-10-25 19:26:49'),
(105, NULL, NULL, 0, '151515', 'NGHGJH', '', '', '', '', '', '', '', '2012-01-01', 0, '', 0, 1, 25, '2023-10-03 01:42:43', 25, '2023-10-09 14:38:31'),
(106, 1530, 3554, 1, '11214', 'PRUEBA', 'PRUEBA', 'PENDIENTE ', '', '', '313', 'MEMO@HOTMAIL.COM', '', '2023-07-06', 0, '', 0, 1, 25, '2023-10-18 14:01:30', 25, '2023-11-24 22:56:37'),
(107, NULL, 3599, 0, '98567696', 'CARLOS', 'MARIO', 'PATIÑO', 'RAMIREZ', '', '3005034706', '', '', NULL, 0, '', 0, 1, 25, '2023-10-19 21:19:14', 25, '2023-10-19 21:24:48'),
(108, 1527, 3599, 0, '9856769599', 'CARLOS', 'MARIO', 'PATIÑO', 'RAMIREZ P35', '', '360111222333', '', 'CL', '1966-01-01', 0, '', 0, 0, 25, '2023-10-19 21:27:03', 25, '2023-11-02 22:04:37'),
(109, 1529, 3599, 0, '9856769598', 'CARLOS', 'MARIO', 'PATIÑO', 'P34,U25', '', '', '', 'CCCC', '1970-01-01', 0, '', 0, 0, 25, '2023-10-19 21:32:33', 4, '2023-10-25 11:11:08'),
(110, 1496, 3599, 0, '9856769500', 'CARLOS', 'MARIO', 'PATIÑO', 'A203,P4,U1', '', '', '', 'CL23335', '1970-01-01', 0, '', 0, 0, 25, '2023-10-19 22:00:02', 24, '2023-11-09 02:03:28'),
(111, NULL, NULL, 0, '11', '1', '2', '3', '4', '6', '6', '7', '5', NULL, 0, NULL, 1, 1, NULL, '2023-11-07 08:23:30', 4, '2023-11-07 08:23:45'),
(112, NULL, NULL, 0, '123', '1234', '5', '', '', '', '', '', '', '1970-01-01', 0, '', 0, 1, 4, '2023-11-08 00:30:46', 4, '2023-11-08 00:32:51'),
(113, 1535, 3599, 1, '901008556', 'TECNOTRONICK', '', '', '', '', '3177858848', 'ASCENSORESTECNOTRONICK@GMAIL.COM', 'CR 63 42 21', NULL, 0, '', 0, 0, 25, '2023-11-21 16:34:55', NULL, '2023-11-21 16:34:55'),
(114, 1583, 3599, 0, '999404', 'MARINA', '', 'PALACIO', '', '', '', 'PENDIENTE@GMAIL.COM', '', NULL, 1, '', 0, 1, 24, '2023-11-21 23:35:35', 4, '2023-11-22 10:44:09'),
(115, 1584, 3599, 0, '90099404', 'MARINA', '', 'PALACIOS', '', '', '', 'PENDIENTE90099404@GMAIL.COM', '', NULL, 1, '', 0, 1, 4, '2023-11-21 23:53:49', 25, '2023-11-24 22:56:08'),
(116, 1585, 3599, 1, '32106362', 'NARANJA JURIDICA', '', '', '', '', '4443049', 'PREJURIDICA2@GMAIL.COM', 'CR 43 A 19 A 57 OFIC 203', '2023-11-01', 0, '', 0, 0, 25, '2023-11-23 00:43:35', NULL, '2023-11-23 00:43:36'),
(117, 1533, 3599, 1, '900967679', 'UNIVERSO SEGURIDAD TTDA', '', '', '', '', '3168233385', 'SEGURIDADUNIVERSO@GMAIL.COM', 'CL 17 SUR 11 B 17', '2023-11-01', 0, '', 0, 0, 25, '2023-11-23 00:52:13', NULL, '2023-11-23 00:52:13'),
(118, 1544, 3599, 1, '901727981', 'KODEZATELITE S.A.S', '', '', '', '', '2179816', 'KODEZATELITE@GMAIL.COM', 'CL 50 38 78 OFIC 201', '2023-11-01', 0, '', 0, 0, 25, '2023-11-23 00:59:52', NULL, '2023-11-23 00:59:53'),
(119, 1542, 3599, 0, '71636951', 'FREDY', 'ESTEBAN', 'VELASQUEZ', 'LOPEZ', '', '3137886546', '', '', '2023-11-01', 0, '', 0, 0, 25, '2023-11-23 01:01:12', 25, '2023-11-23 01:02:27'),
(120, 1546, 3599, 1, '890904996', 'EPM', '', '', '', '', '3808080', '', 'CR 58 42 125', '2023-11-01', 0, '', 0, 0, 25, '2023-11-24 23:01:11', NULL, '2023-11-24 23:01:12'),
(121, NULL, NULL, 0, '151515', 'NUBIA', 'ESTELLA', 'CARDOINA', 'PEREZ', '3135250101', '3135250101', 'SINCORREO@GMAIL.COM', 'SIN DIRECCION', NULL, 0, NULL, 1, 1, 24, '2023-11-29 03:18:40', 24, '2023-11-29 03:35:17');

-- --------------------------------------------------------

--
-- Table structure for table `personas_roles`
--

CREATE TABLE `personas_roles` (
  `id` int NOT NULL,
  `id_persona` int NOT NULL,
  `id_rol` int NOT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `personas_roles`
--

INSERT INTO `personas_roles` (`id`, `id_persona`, `id_rol`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 1, 1, NULL, '2023-04-09 08:25:00', NULL, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `pqrsf`
--

CREATE TABLE `pqrsf` (
  `id` int NOT NULL,
  `id_inmueble` int DEFAULT NULL,
  `id_persona` int DEFAULT NULL,
  `tipo` tinyint NOT NULL COMMENT '0 - Pregunta, 1 - Queja, 2 - Reclamo, 3 - Solicitud, 4 - Felicitacion',
  `asunto` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `descripcion` longtext,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pqrsf`
--

INSERT INTO `pqrsf` (`id`, `id_inmueble`, `id_persona`, `tipo`, `asunto`, `descripcion`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(8, 96, 81, 1, 'QUEJA', '{\"blocks\":[{\"key\":\"fomr6\",\"text\":\"la vecina escucha música muy duro\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', 21, '2023-11-24 20:49:41', NULL, NULL),
(9, 96, 81, 1, 'TG', '{\"blocks\":[{\"key\":\"99s9g\",\"text\":\"gdg\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', 21, '2023-11-24 20:54:27', NULL, NULL),
(10, 106, 85, 4, 'FIESTA DE NAVIDAD', '{\"blocks\":[{\"key\":\"enhh2\",\"text\":\"Toda la decoracion \",\"type\":\"unordered-list-item\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{\"text-align\":\"left\"}},{\"key\":\"443k0\",\"text\":\"Los dulces\",\"type\":\"unordered-list-item\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"5m3be\",\"text\":\"M\",\"type\":\"unordered-list-item\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"fa6ls\",\"text\":\"\",\"type\":\"unordered-list-item\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', 22, '2023-11-28 15:26:57', NULL, NULL),
(11, 106, 85, 1, 'MUCHA BULLA', '{\"blocks\":[{\"key\":\"e6pjj\",\"text\":\"Los perros ladran mucho\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', 22, '2023-11-29 20:15:53', NULL, NULL),
(12, 96, 81, 3, 'ABONO FACTURA', '{\"blocks\":[{\"key\":\"36v32\",\"text\":\"ADJUNTE EL PAGO DE NOVIEMBRE. FUE UN ABONO, EL RESTO LO PAGO EL FIN DE MES.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', 36, '2023-11-30 02:34:54', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `presupuesto_anual`
--

CREATE TABLE `presupuesto_anual` (
  `id` int NOT NULL,
  `year` varchar(100) DEFAULT NULL,
  `valor_presupuesto` varchar(150) DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `proveedores`
--

CREATE TABLE `proveedores` (
  `id` int NOT NULL,
  `id_persona` int DEFAULT NULL,
  `id_actividad` int DEFAULT NULL,
  `nombre_negocio` varchar(250) NOT NULL,
  `observacion` text,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `proveedores`
--

INSERT INTO `proveedores` (`id`, `id_persona`, `id_actividad`, `nombre_negocio`, `observacion`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(5, 44, 17, 'FARMACIA CESPEDES', 'SOLO DOMICILIOS EN ENVIGADO', 21, '2023-08-28 01:32:48', 21, '2023-08-28 01:34:43'),
(6, 45, 19, 'JYC DELICIAS', 'SOLO EDIFICIOS CERCANOS ', 21, '2023-08-31 04:11:26', 21, '2023-09-07 14:38:33'),
(7, 50, 6, 'LA VAQUITA', 'SOLO ENVIGADO Y SABANETA ', 21, '2023-09-07 14:37:09', 21, '2023-09-07 14:41:38'),
(8, 42, 18, 'LA ESQUINA ', 'CARNICERÍA ', 25, '2023-09-21 20:17:52', NULL, NULL),
(9, NULL, 6, 'EURO', 'DOMICILIOS HASTA LAS 11:00PM ', 24, '2023-11-01 04:47:19', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tareas`
--

CREATE TABLE `tareas` (
  `id` int NOT NULL,
  `id_tipo_tarea` int NOT NULL,
  `fecha_programada_inicial` datetime DEFAULT NULL,
  `fecha_programada_final` datetime DEFAULT NULL,
  `fecha_completada` datetime DEFAULT NULL,
  `estado` int NOT NULL DEFAULT '0' COMMENT '0 -PEDNIENTE, 1 - COMPLETADA, 2 - CANCELADA',
  `prioridad` int NOT NULL DEFAULT '0' COMMENT '0 - BAJA, 1 - MEDIA, 2 - ALTA',
  `id_usuario_responsable` int DEFAULT NULL,
  `id_inmueble` int DEFAULT NULL,
  `id_inmueble_zona` int DEFAULT NULL,
  `descripcion_tarea` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `observacion_completada` longtext CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  `notificar_encargado` tinyint DEFAULT '0',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tareas`
--

INSERT INTO `tareas` (`id`, `id_tipo_tarea`, `fecha_programada_inicial`, `fecha_programada_final`, `fecha_completada`, `estado`, `prioridad`, `id_usuario_responsable`, `id_inmueble`, `id_inmueble_zona`, `descripcion_tarea`, `observacion_completada`, `notificar_encargado`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(7, 4, '2023-11-24 04:07:00', '2023-11-24 09:10:00', '2023-11-24 05:41:00', 0, 0, 4, NULL, NULL, '{\"blocks\":[{\"key\":\"328ia\",\"text\":\"asasas\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":6,\"style\":\"BOLD\"},{\"offset\":0,\"length\":6,\"style\":\"fontsize-30\"}],\"entityRanges\":[],\"data\":{\"text-align\":\"center\"}}],\"entityMap\":{}}', '{\"blocks\":[{\"key\":\"dqlde\",\"text\":\"asas\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"6i668\",\"text\":\"asasas\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"6uoqp\",\"text\":\"asas NOTA AGREGADA EL: 2023-11-27 01:12:06.\\n\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[{\"offset\":0,\"length\":4,\"style\":\"BOLD\"}],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', 0, 4, '2023-11-24 09:55:21', 4, '2023-11-27 01:12:06'),
(10, 26, '2023-11-24 15:25:00', '2023-11-24 15:26:00', '2023-11-24 15:39:00', 1, 0, 24, NULL, NULL, '{\"blocks\":[{\"key\":\"ak53r\",\"text\":\"esta grabando de una y no me deja ingrear el texto, tiene que exgir texto.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', '{\"blocks\":[{\"key\":\"4bql2\",\"text\":\"hola, vendi tres gaseossa.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"epeqs\",\"text\":\"ya pase revista en los ultjmo pisos\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"etlit\",\"text\":\"don carlos del 701 dejo paquete y dinero en porteria.\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"885am\",\"text\":\"\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}},{\"key\":\"2cb9l\",\"text\":\"\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', 0, 24, '2023-11-24 20:25:47', 24, '2023-11-24 20:39:48'),
(44, 32, '2023-11-25 11:20:00', '2023-11-25 14:38:00', NULL, 0, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones piso alto\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', NULL, NULL),
(45, 32, '2023-11-26 11:20:00', '2023-11-26 14:38:00', NULL, 0, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones piso alto\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', NULL, NULL),
(46, 32, '2023-12-09 11:20:00', '2023-12-09 14:38:00', NULL, 0, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones piso alto\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', NULL, NULL),
(47, 32, '2023-11-29 11:20:00', '2023-11-29 14:38:00', NULL, 1, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones piso alto, todo bien \",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', 24, '2023-11-27 10:39:45'),
(48, 32, '2023-12-06 11:20:00', '2023-12-06 14:38:00', NULL, 0, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones piso alto\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', NULL, NULL),
(49, 32, '2023-12-10 11:20:00', '2023-12-10 14:38:00', NULL, 0, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones piso alto\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', NULL, NULL),
(50, 32, '2023-12-16 11:20:00', '2023-12-16 14:38:00', NULL, 0, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones piso alto\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', NULL, NULL),
(51, 32, '2023-12-20 11:20:00', '2023-12-20 14:38:00', NULL, 0, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones piso alto\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', NULL, NULL),
(52, 32, '2023-12-02 11:20:00', '2023-12-02 14:38:00', NULL, 0, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones piso alto, yo quisiera quhoy haga otras cosas más. e\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', 25, '2023-11-25 12:26:10'),
(53, 32, '2023-12-03 11:20:00', '2023-12-03 14:38:00', NULL, 0, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones piso alto\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', NULL, NULL),
(54, 32, '2023-12-17 11:20:00', '2023-12-17 14:38:00', NULL, 0, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones piso alto\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', NULL, NULL),
(55, 32, '2023-12-13 11:20:00', '2023-12-13 14:38:00', NULL, 0, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones piso alto\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', NULL, NULL),
(56, 32, '2023-12-30 11:20:00', '2023-12-30 14:38:00', NULL, 0, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones piso alto\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', NULL, NULL),
(57, 32, '2023-12-27 11:20:00', '2023-12-27 14:38:00', NULL, 1, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones piso alto\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', 24, '2023-11-27 10:37:27'),
(58, 32, '2023-12-24 11:20:00', '2023-12-24 14:38:00', NULL, 0, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones pisofffffff alto, pero como así que lavar la oisicna\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', 25, '2023-11-25 12:27:57'),
(59, 32, '2023-12-31 11:20:00', '2023-12-31 14:38:00', NULL, 0, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones piso alto\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', NULL, NULL),
(60, 32, '2023-12-23 11:20:00', '2023-12-23 14:38:00', NULL, 0, 1, 21, NULL, NULL, '{\"blocks\":[{\"key\":\"c4er2\",\"text\":\"subvenciones piso alto\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 25, '2023-11-25 12:24:01', NULL, NULL),
(61, 4, '2023-11-25 08:04:00', '2023-11-29 12:04:00', '2023-11-25 09:13:00', 1, 0, 33, NULL, NULL, '{\"blocks\":[{\"key\":\"5dqme\",\"text\":\"cortar césped ybarrerlo\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', '{\"blocks\":[{\"key\":\"7rls7\",\"text\":\"hola, jjffbb\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', 0, 24, '2023-11-25 13:05:18', 33, '2023-11-25 13:16:49'),
(62, 26, '2023-11-29 14:57:00', '2023-11-29 16:00:00', NULL, 0, 0, 29, NULL, NULL, '{\"blocks\":[{\"key\":\"engtf\",\"text\":\"\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 24, '2023-11-29 19:58:34', NULL, NULL),
(63, 27, '2023-11-29 15:01:00', '2023-11-29 15:01:00', NULL, 0, 0, 19, NULL, NULL, '{\"blocks\":[{\"key\":\"88b7h\",\"text\":\"\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 24, '2023-11-29 20:02:05', NULL, NULL),
(64, 32, '2023-11-29 15:02:00', '2023-11-29 15:02:00', NULL, 1, 0, 24, NULL, NULL, '{\"blocks\":[{\"key\":\"frrdj\",\"text\":\"\",\"type\":\"unstyled\",\"depth\":0,\"inlineStyleRanges\":[],\"entityRanges\":[],\"data\":{}}],\"entityMap\":{}}', NULL, 0, 24, '2023-11-29 20:02:49', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `zonas`
--

CREATE TABLE `zonas` (
  `id` int NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `tipo` int NOT NULL DEFAULT '0' COMMENT '0-Uso común, 1-Inmueble, 2-Porteria',
  `id_centro_costos_erp` int DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `zonas`
--

INSERT INTO `zonas` (`id`, `nombre`, `tipo`, `id_centro_costos_erp`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 'TORRE#1', 1, 13284, 4, '2023-04-30 21:47:27', 24, '2023-11-13 09:30:31'),
(6, 'PORTERIA', 0, 1, 21, '2023-09-06 22:38:19', 4, '2023-10-16 10:29:30'),
(9, 'CANCHA DE TENIS ', 0, 1, 24, '2023-11-01 04:48:33', NULL, '0000-00-00 00:00:00'),
(11, 'TORRE#2', 1, 13285, 24, '2023-11-14 01:01:38', NULL, '0000-00-00 00:00:00'),
(12, 'URBANIZACION', 1, 1, 24, '2023-11-14 16:14:52', NULL, '0000-00-00 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activos_fijos`
--
ALTER TABLE `activos_fijos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_inmueble_zona` (`id_inmueble_zona`);

--
-- Indexes for table `conceptos_facturacion`
--
ALTER TABLE `conceptos_facturacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_cuenta_ingreso_erp` (`id_cuenta_ingreso_erp`),
  ADD KEY `id_cuenta_interes_erp` (`id_cuenta_interes_erp`),
  ADD KEY `id_cuenta_iva_erp` (`id_cuenta_iva_erp`),
  ADD KEY `id_cuenta_por_cobrar` (`id_cuenta_por_cobrar`);

--
-- Indexes for table `conceptos_gastos`
--
ALTER TABLE `conceptos_gastos`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `control_ingresos`
--
ALTER TABLE `control_ingresos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_persona_autoriza` (`id_persona_autoriza`),
  ADD KEY `id_inmueble` (`id_inmueble`),
  ADD KEY `id_inmueble_zona` (`id_inmueble_zona`),
  ADD KEY `id_concepto_visita` (`id_concepto_visita`),
  ADD KEY `id_tipo_vehiculo` (`id_tipo_vehiculo`);

--
-- Indexes for table `correos_enviados`
--
ALTER TABLE `correos_enviados`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `entorno`
--
ALTER TABLE `entorno`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `erp_maestras`
--
ALTER TABLE `erp_maestras`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tipo` (`tipo`,`id_erp`),
  ADD UNIQUE KEY `tipo_2` (`tipo`,`codigo`),
  ADD UNIQUE KEY `tipo_3` (`tipo`,`id_erp`);

--
-- Indexes for table `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_persona` (`id_persona`);

--
-- Indexes for table `facturas_ciclica`
--
ALTER TABLE `facturas_ciclica`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_persona` (`id_inmueble`);

--
-- Indexes for table `factura_ciclica_detalles`
--
ALTER TABLE `factura_ciclica_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_factura_ciclica` (`id_factura_ciclica`),
  ADD KEY `id_concepto_factura` (`id_concepto_factura`);

--
-- Indexes for table `factura_ciclica_historial`
--
ALTER TABLE `factura_ciclica_historial`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `factura_ciclica_historial_detalle`
--
ALTER TABLE `factura_ciclica_historial_detalle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_factura_ciclica` (`id_factura_ciclica`),
  ADD KEY `id_factura` (`id_factura`);

--
-- Indexes for table `factura_detalles`
--
ALTER TABLE `factura_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_factura` (`id_factura`),
  ADD KEY `id_concepto_factura` (`id_concepto_factura`);

--
-- Indexes for table `factura_recibos_caja`
--
ALTER TABLE `factura_recibos_caja`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `factura_recibo_caja_comprobante`
--
ALTER TABLE `factura_recibo_caja_comprobante`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gastos`
--
ALTER TABLE `gastos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_persona` (`id_persona_proveedor`);

--
-- Indexes for table `gasto_detalle`
--
ALTER TABLE `gasto_detalle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_gasto` (`id_gasto`),
  ADD KEY `id_concepto_gasto` (`id_concepto_gasto`);

--
-- Indexes for table `gasto_pagos`
--
ALTER TABLE `gasto_pagos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`);

--
-- Indexes for table `importador_historia`
--
ALTER TABLE `importador_historia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_modulo` (`id_modulo`);

--
-- Indexes for table `inmuebles`
--
ALTER TABLE `inmuebles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_inmueble_zona` (`id_inmueble_zona`);

--
-- Indexes for table `inmueble_mascotas`
--
ALTER TABLE `inmueble_mascotas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_id_inmueble` (`id_inmueble`);

--
-- Indexes for table `inmueble_personas_admon`
--
ALTER TABLE `inmueble_personas_admon`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_inmueble` (`id_inmueble`);

--
-- Indexes for table `inmueble_personas_visitantes`
--
ALTER TABLE `inmueble_personas_visitantes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_inmueble` (`id_inmueble`),
  ADD KEY `id_persona_autoriza` (`id_persona_autoriza`);

--
-- Indexes for table `inmueble_vehiculos`
--
ALTER TABLE `inmueble_vehiculos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_inmueble` (`id_inmueble`),
  ADD KEY `id_tipo_vehiculo` (`id_tipo_vehiculo`),
  ADD KEY `id_persona_autoriza` (`id_persona_autoriza`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_modulo` (`id_modulo`);

--
-- Indexes for table `maestras_base`
--
ALTER TABLE `maestras_base`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mensajes`
--
ALTER TABLE `mensajes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mensajes_historico`
--
ALTER TABLE `mensajes_historico`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_persona_notificada` (`id_persona_notificada`),
  ADD KEY `id_rol_notificado` (`id_rol_notificado`),
  ADD KEY `id_inmueble_zona` (`id_inmueble_zona`),
  ADD KEY `id_inmueble` (`id_inmueble`);

--
-- Indexes for table `mensajes_push_historia`
--
ALTER TABLE `mensajes_push_historia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_persona_notificada` (`id_usuario_notificado`);

--
-- Indexes for table `multimedia`
--
ALTER TABLE `multimedia`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personas_roles`
--
ALTER TABLE `personas_roles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_rol` (`id_rol`),
  ADD KEY `id_persona` (`id_persona`);

--
-- Indexes for table `pqrsf`
--
ALTER TABLE `pqrsf`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_UNIQUE` (`id`),
  ADD KEY `id_INDEX` (`id`);

--
-- Indexes for table `presupuesto_anual`
--
ALTER TABLE `presupuesto_anual`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `proveedores`
--
ALTER TABLE `proveedores`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_persona` (`id_persona`),
  ADD KEY `id_actividad` (`id_actividad`);

--
-- Indexes for table `tareas`
--
ALTER TABLE `tareas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_tipo_tarea` (`id_tipo_tarea`),
  ADD KEY `id_persona_responsable` (`id_usuario_responsable`),
  ADD KEY `id_inmueble` (`id_inmueble`),
  ADD KEY `id_inmueble_zona` (`id_inmueble_zona`);

--
-- Indexes for table `zonas`
--
ALTER TABLE `zonas`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activos_fijos`
--
ALTER TABLE `activos_fijos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conceptos_facturacion`
--
ALTER TABLE `conceptos_facturacion`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `conceptos_gastos`
--
ALTER TABLE `conceptos_gastos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `control_ingresos`
--
ALTER TABLE `control_ingresos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `correos_enviados`
--
ALTER TABLE `correos_enviados`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `entorno`
--
ALTER TABLE `entorno`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `erp_maestras`
--
ALTER TABLE `erp_maestras`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26048;

--
-- AUTO_INCREMENT for table `facturas`
--
ALTER TABLE `facturas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9630;

--
-- AUTO_INCREMENT for table `facturas_ciclica`
--
ALTER TABLE `facturas_ciclica`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8831;

--
-- AUTO_INCREMENT for table `factura_ciclica_detalles`
--
ALTER TABLE `factura_ciclica_detalles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8825;

--
-- AUTO_INCREMENT for table `factura_ciclica_historial`
--
ALTER TABLE `factura_ciclica_historial`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=182;

--
-- AUTO_INCREMENT for table `factura_ciclica_historial_detalle`
--
ALTER TABLE `factura_ciclica_historial_detalle`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9153;

--
-- AUTO_INCREMENT for table `factura_detalles`
--
ALTER TABLE `factura_detalles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28154;

--
-- AUTO_INCREMENT for table `factura_recibos_caja`
--
ALTER TABLE `factura_recibos_caja`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=121;

--
-- AUTO_INCREMENT for table `factura_recibo_caja_comprobante`
--
ALTER TABLE `factura_recibo_caja_comprobante`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `gastos`
--
ALTER TABLE `gastos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `gasto_detalle`
--
ALTER TABLE `gasto_detalle`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `gasto_pagos`
--
ALTER TABLE `gasto_pagos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `importador_historia`
--
ALTER TABLE `importador_historia`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inmuebles`
--
ALTER TABLE `inmuebles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=149;

--
-- AUTO_INCREMENT for table `inmueble_mascotas`
--
ALTER TABLE `inmueble_mascotas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `inmueble_personas_admon`
--
ALTER TABLE `inmueble_personas_admon`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=158;

--
-- AUTO_INCREMENT for table `inmueble_personas_visitantes`
--
ALTER TABLE `inmueble_personas_visitantes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `inmueble_vehiculos`
--
ALTER TABLE `inmueble_vehiculos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=360;

--
-- AUTO_INCREMENT for table `maestras_base`
--
ALTER TABLE `maestras_base`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `mensajes_historico`
--
ALTER TABLE `mensajes_historico`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mensajes_push_historia`
--
ALTER TABLE `mensajes_push_historia`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=403;

--
-- AUTO_INCREMENT for table `multimedia`
--
ALTER TABLE `multimedia`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT for table `personas`
--
ALTER TABLE `personas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;

--
-- AUTO_INCREMENT for table `personas_roles`
--
ALTER TABLE `personas_roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pqrsf`
--
ALTER TABLE `pqrsf`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `presupuesto_anual`
--
ALTER TABLE `presupuesto_anual`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `tareas`
--
ALTER TABLE `tareas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT for table `zonas`
--
ALTER TABLE `zonas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
