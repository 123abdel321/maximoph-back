-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 67.207.83.69
-- Generation Time: Dec 10, 2023 at 07:05 PM
-- Server version: 8.0.35-0ubuntu0.23.04.1
-- PHP Version: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cli_maximo_ph_template`
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
  `id_cuenta_por_pagar_erp` int NOT NULL,
  `nombre` varchar(150) DEFAULT NULL,
  `eliminado` tinyint NOT NULL DEFAULT '0',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
(1, 'id_comprobante_ventas_erp', '', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:34:10'),
(2, 'consecutivo_ventas', '1', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:34:15'),
(3, 'id_comprobante_gastos_erp', '', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:34:18'),
(4, 'consecutivo_gastos', '1', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:34:20'),
(5, 'id_comprobante_recibos_caja_erp', '', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:34:23'),
(6, 'consecutivo_recibos_caja', '1', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:34:26'),
(7, 'id_cuenta_intereses_erp', '', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:34:35'),
(8, 'porcentaje_intereses_mora', '2', NULL, '2023-05-20 17:33:23', NULL, '2023-10-24 20:56:18'),
(9, 'api_key_erp', '', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:34:37'),
(10, 'area_total_m2', '0', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:34:40'),
(11, 'numero_total_unidades', '0', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:34:44'),
(12, 'valor_total_presupuesto_year_actual', '0', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:34:47'),
(13, 'id_concepto_administracion', '1', NULL, '2023-05-20 17:33:23', NULL, '2023-06-25 12:00:17'),
(14, 'razon_social', '', NULL, '2023-07-03 15:13:29', NULL, '2023-12-02 13:34:56'),
(15, 'nit', '', NULL, '2023-07-03 15:13:29', NULL, '2023-12-02 13:34:59'),
(16, 'direccion', '', NULL, '2023-07-03 15:13:29', NULL, '2023-12-02 13:35:02'),
(17, 'telefono', '', NULL, '2023-07-03 15:13:29', NULL, '2023-12-02 13:35:04'),
(18, 'email', '', NULL, '2023-07-03 15:13:29', NULL, '2023-12-02 13:35:07'),
(19, 'texto_cuenta_cobro', '', NULL, '2023-07-03 15:13:29', NULL, '2023-12-02 13:35:10'),
(20, 'validacion_estricta_area', '0', NULL, '2023-07-03 15:13:29', NULL, '2023-10-03 18:56:36'),
(21, 'id_concepto_visita', '0', NULL, '2023-07-03 15:13:29', NULL, '2023-12-02 13:35:14'),
(22, 'id_concepto_intereses', '8', NULL, '2023-07-03 15:13:29', NULL, '2023-10-20 16:48:26'),
(23, 'redondeo_conceptos', '0', NULL, '2023-07-03 15:13:29', NULL, '2023-10-24 21:09:56'),
(24, 'periodo_facturacion', '', NULL, '2023-07-03 15:13:29', NULL, '2023-12-02 13:35:20'),
(25, 'agrupar_cuenta_cobro', '0', NULL, '2023-07-03 15:13:29', NULL, '2023-10-19 20:54:21'),
(27, 'dia_limite_pago_sin_interes', '', NULL, '2023-07-03 15:13:29', NULL, '2023-12-02 13:35:54'),
(28, 'dia_limite_descuento_pronto_pago', '', NULL, '2023-07-03 15:13:29', NULL, '2023-12-02 13:35:52'),
(29, 'porcentaje_descuento_pronto_pago', '0', NULL, '2023-07-03 15:13:29', NULL, '2023-10-24 20:56:18'),
(30, 'id_cuenta_descuento_erp', '', NULL, '2023-10-23 11:18:48', NULL, '2023-12-02 13:35:49'),
(31, 'editar_valor_admon_inmueble', '0', NULL, '2023-10-23 11:18:48', NULL, '2023-12-02 13:35:35'),
(32, 'id_comprobante_pagos_erp', '', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:35:47'),
(33, 'consecutivo_pagos', '1', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:35:40'),
(34, 'id_cuenta_ingreso_recibos_caja_erp', '', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:35:44'),
(35, 'id_cuenta_egreso_pagos_erp', '', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:35:58'),
(36, 'id_concepto_administracion_cuarto_util', '', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:36:03'),
(37, 'id_concepto_administracion_parqueadero', '', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:36:05'),
(38, 'id_cuenta_ingreso_pasarela_erp', '', NULL, '2023-05-20 17:33:23', NULL, '2023-12-02 13:36:08');

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
  `observacion_administrador` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int NOT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `numero_factura_proveedor` varchar(150) DEFAULT NULL,
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
  `descripcion` longtext,
  `notificacion_push` tinyint NOT NULL DEFAULT '0' COMMENT '0 - NO, 1 - SI',
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `asunto` varchar(150) NOT NULL,
  `descripcion` longtext,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  `estado` int NOT NULL DEFAULT '0' COMMENT '0 -PEDNIENTE, 1 - COMPLETADA, 2 - CANCELADA, 3 - INICIADA',
  `prioridad` int NOT NULL DEFAULT '0' COMMENT '0 - BAJA, 1 - MEDIA, 2 - ALTA',
  `id_usuario_responsable` int DEFAULT NULL,
  `id_inmueble` int DEFAULT NULL,
  `id_inmueble_zona` int DEFAULT NULL,
  `descripcion_tarea` longtext NOT NULL,
  `observacion_completada` longtext,
  `notificar_encargado` tinyint DEFAULT '0',
  `started_at` datetime DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `conceptos_gastos`
--
ALTER TABLE `conceptos_gastos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `control_ingresos`
--
ALTER TABLE `control_ingresos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `facturas`
--
ALTER TABLE `facturas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `facturas_ciclica`
--
ALTER TABLE `facturas_ciclica`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factura_ciclica_detalles`
--
ALTER TABLE `factura_ciclica_detalles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factura_ciclica_historial`
--
ALTER TABLE `factura_ciclica_historial`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factura_ciclica_historial_detalle`
--
ALTER TABLE `factura_ciclica_historial_detalle`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factura_detalles`
--
ALTER TABLE `factura_detalles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factura_recibos_caja`
--
ALTER TABLE `factura_recibos_caja`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `factura_recibo_caja_comprobante`
--
ALTER TABLE `factura_recibo_caja_comprobante`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gastos`
--
ALTER TABLE `gastos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gasto_detalle`
--
ALTER TABLE `gasto_detalle`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `gasto_pagos`
--
ALTER TABLE `gasto_pagos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `importador_historia`
--
ALTER TABLE `importador_historia`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inmuebles`
--
ALTER TABLE `inmuebles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inmueble_mascotas`
--
ALTER TABLE `inmueble_mascotas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inmueble_personas_admon`
--
ALTER TABLE `inmueble_personas_admon`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inmueble_personas_visitantes`
--
ALTER TABLE `inmueble_personas_visitantes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `inmueble_vehiculos`
--
ALTER TABLE `inmueble_vehiculos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `maestras_base`
--
ALTER TABLE `maestras_base`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `mensajes`
--
ALTER TABLE `mensajes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mensajes_historico`
--
ALTER TABLE `mensajes_historico`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `mensajes_push_historia`
--
ALTER TABLE `mensajes_push_historia`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `multimedia`
--
ALTER TABLE `multimedia`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personas`
--
ALTER TABLE `personas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personas_roles`
--
ALTER TABLE `personas_roles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pqrsf`
--
ALTER TABLE `pqrsf`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `presupuesto_anual`
--
ALTER TABLE `presupuesto_anual`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proveedores`
--
ALTER TABLE `proveedores`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tareas`
--
ALTER TABLE `tareas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `zonas`
--
ALTER TABLE `zonas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
