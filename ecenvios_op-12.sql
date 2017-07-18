-- phpMyAdmin SQL Dump
-- version 3.5.8.2
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 07-01-2016 a las 18:04:23
-- Versión del servidor: 5.5.31
-- Versión de PHP: 5.2.17

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `ecenvios_op`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`ecenvios_op`@`localhost` PROCEDURE `cambiar_st`(IN `maes` INT, IN `sup` INT, IN `mov` VARCHAR(5))
    NO SQL
UPDATE `thguias` SET `St_HGuia` = mov 
WHERE `Maestro` = maes AND `Sup_Hguia` = sup$$

CREATE DEFINER=`ecenvios_op`@`localhost` PROCEDURE `get_guias_xD`(IN `guias` VARCHAR(20))
    NO SQL
SELECT A.ID_Guia, B.Descripcion, A.DateRecord, A.TimeRecord
FROM `tdguias` A, `define_state` B 
WHERE A.DefineState_Ds = B.Id_ds AND A.ID_Guia = guias 
ORDER BY A.Id_Cg$$

CREATE DEFINER=`ecenvios_op`@`localhost` PROCEDURE `ins_DGuias`(IN `stsdg` VARCHAR(5), IN `guia` VARCHAR(60), IN `sucur` VARCHAR(60), IN `des` VARCHAR(60), 
IN `estado` INT, IN `persona` VARCHAR(11), IN `importe` VARCHAR(11), IN `val` VARCHAR(2), 
IN `obs` VARCHAR(200), IN `datex` DATE, IN `timex` TIME, IN `userx` INT)
    NO SQL
INSERT INTO `tdguias` (`Id_Cg`, `St_Dg`, `ID_Guia`, `IdSurc_S`, `Des_Dg`, `DefineState_Ds`,
                      `personnelReceived`, `Importe_Dg`, `Validacion_Dg`,
                      `Osbservacions_Dg`, `DateRecord`, `TimeRecord`,
                      `idUsers`, `AutoRecord`)

VALUES ('', stsdg, guia, sucur, des, estado, persona, importe, val, obs, datex, timex,
       userx, CURRENT_TIMESTAMP)$$

CREATE DEFINER=`ecenvios_op`@`localhost` PROCEDURE `lol`(IN `guiah` VARCHAR(20))
    NO SQL
BEGIN

SELECT A.`Guia_Hguia`, B.Name_Cli, B.Empresa, A.`Origen_Hguia`, A.`Destino_Hguia` FROM `thguias` A, `clientes` B WHERE A.`Code_Cli` = B.`Code_Cli` AND `Guia_Hguia` = guiah;

SELECT A.`ID_Guia`, B.`Descripcion`, A.`DateRecord`, A.`TimeRecord` 
FROM `tdguias` A, `define_state` B 
WHERE A.DefineState_Ds = B.Id_ds AND `ID_Guia` = guiah;

END$$

CREATE DEFINER=`ecenvios_op`@`localhost` PROCEDURE `pepos`(IN `sts` VARCHAR(5), IN `codez` VARCHAR(60), 
IN `guia` VARCHAR(60), 
IN `recol` DATE, IN `ori` VARCHAR(20), IN `des` VARCHAR(20), IN `mas` INT, IN `sup` INT, IN `fxc` INT, 
IN `piez` INT, IN `peso` INT, IN `name` VARCHAR(60), IN `cons` VARCHAR(60), IN `dir` VARCHAR(120), 
IN `user1` INT)
    NO SQL
INSERT INTO `thguias` (`ID_Guia`, `St_Hguia`, `Code_Cli`, `Guia_Hguia`, `Date_Recolect`, 
`Origen_Hguia`, `Destino_Hguia`, `Maestro`, `Sup_Hguia`, `FXC_Hguia`, `Piezas_Hguia`, `Peso_Hguia`, 
`Name_Hguia`, `Consig_Hguia`,`Direccion_Hguia`, `idUser`, `DateTimeReceipt`)

VALUES ('', sts, codez, guia, recol, ori, des, mas, sup, fxc, piez, peso, name, cons, dir, user1, 
CURRENT_TIMESTAMP)$$

CREATE DEFINER=`ecenvios_op`@`localhost` PROCEDURE `xc`(IN `name` VARCHAR(60), IN `email` VARCHAR(120), IN `empresa` VARCHAR(120), IN `area` VARCHAR(120), IN `tel1` VARCHAR(10), IN `tel2` VARCHAR(10), IN `calle` VARCHAR(20), IN `numint` VARCHAR(10), IN `numext` VARCHAR(10), IN `col` VARCHAR(20), IN `cp` INT(10), IN `dis` VARCHAR(2), IN `userx` INT, IN `code` VARCHAR(60))
    NO SQL
begin

declare cuenta varchar(60);
DECLARE usery int;
insert into `clientes` (`Id_Cli`, `Code_Cli`, `Name_Cli`, `Email_Cli`,
                       `Empresa`, `Area`, `PhoneNumber1_Cli`,
                       `PhoneNumber2_Cli`, `idUsers`, `DateTimeRecord_Cli`)
values ('', code, name, email, empresa, area, tel1, tel2, userx, current_timestamp);

set cuenta = (select `Code_Cli` from `clientes` order by `Id_Cli` DESC LIMIT 1);
set usery = (SELECT `idUsers` FROM `clientes` ORDER BY `Id_Cli` DESC LIMIT 1);
insert into `tdclientes` (`Id_DC`, `Address_Destiny_stret_DC`,
                         `Address_Destiny_number_interior_DC`,
                         `Address_Destiny_number_xterior_DC`,
                         `Address_Destiny_Colony_DC`,
                         `Code_Cli`, `Id_Cp`,
                         `IdDisponible_DC`, `idUsers`,
                         `DateTimeRecord_DC`)
values ('', calle, numint, numext, col, cuenta, cp, dis, usery, current_timestamp);

end$$

CREATE DEFINER=`ecenvios_op`@`localhost` PROCEDURE `xdc`(IN `calle` VARCHAR(20), IN `numint` VARCHAR(10), IN `numext` VARCHAR(10), IN `col` VARCHAR(20), IN `codex` VARCHAR(60), IN `cp` VARCHAR(10), IN `dis` VARCHAR(2), IN `userx` INT)
    NO SQL
insert into `tdclientes` (`Id_DC`, `Address_Destiny_stret_DC`,
                         `Address_Destiny_number_interior_DC`,
                         `Address_Destiny_number_xterior_DC`,
                         `Address_Destiny_Colony_DC`,
                         `Code_Cli`, `Id_Cp`,
                         `IdDisponible_DC`, `idUsers`,
                         `DateTimeRecord_DC`)
values ('', calle, numint, numext, col, codex, cp, dis, userx, current_timestamp)$$

CREATE DEFINER=`ecenvios_op`@`localhost` PROCEDURE `xds`(IN `codes` VARCHAR(60), IN `des` VARCHAR(120))
    NO SQL
INSERT INTO `define_state` (`Id_ds`, `Code_DS`, `Descripcion`)

VALUES ('', codes,  des)$$

CREATE DEFINER=`ecenvios_op`@`localhost` PROCEDURE `xprofile`(IN `code` VARCHAR(10), IN `name` VARCHAR(10), IN `descrip` VARCHAR(250), IN `fecha` DATE, IN `st` SET('ENABLE','DISABLE'))
    NO SQL
INSERT INTO `profiles` (`idProfile`, `codeProfi`, `nameProfi`, `descProfi`, `dateProfi`, `statusPro`)
VALUES ('', code, name, descrip, fecha, st)$$

CREATE DEFINER=`ecenvios_op`@`localhost` PROCEDURE `xs`(IN `codex` VARCHAR(20), IN `name` VARCHAR(60), IN `st` CHAR(2))
    NO SQL
INSERT INTO `tsend` (`Id_Send`, `Code_Send`, `Name_Send`, `St_Send`)

VALUES ('', codex, name, st)$$

CREATE DEFINER=`ecenvios_op`@`localhost` PROCEDURE `xsucur`(IN `code` VARCHAR(20), IN `name` VARCHAR(60), 
IN `dir` VARCHAR(120), 
IN `st` CHAR(2))
    NO SQL
INSERT INTO `tsucur` (`Id_Sucur`, `Code_Sucur`, `Name_Sucur`, `Address_Sucur`, `St_Sucur`)

VALUES ('', code, name, dir, st)$$

CREATE DEFINER=`ecenvios_op`@`localhost` PROCEDURE `xusers`(IN `login` VARCHAR(15), IN `pass` VARCHAR(10), IN `name` VARCHAR(60), IN `email` VARCHAR(50), IN `sucur` INT, IN `profi` INT)
    NO SQL
INSERT INTO `users` (`idUsers`, `loginUsers`, `passUsers`, `NameUsers`, `emailUsers`, `Id_Sucur`, `idprofile`)

VALUES ('', login, pass, name, email, sucur, profi)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE IF NOT EXISTS `clientes` (
  `Id_Cli` int(11) NOT NULL AUTO_INCREMENT,
  `Code_Cli` varchar(60) NOT NULL,
  `Name_Cli` varchar(60) NOT NULL,
  `Email_Cli` varchar(120) NOT NULL,
  `Empresa` varchar(120) NOT NULL,
  `Area` varchar(120) NOT NULL,
  `PhoneNumber1_Cli` varchar(10) NOT NULL,
  `PhoneNumber2_Cli` varchar(10) NOT NULL,
  `idUsers` int(11) NOT NULL,
  `DateTimeRecord_Cli` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_Cli`),
  KEY `idUsers` (`idUsers`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=127 ;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`Id_Cli`, `Code_Cli`, `Name_Cli`, `Email_Cli`, `Empresa`, `Area`, `PhoneNumber1_Cli`, `PhoneNumber2_Cli`, `idUsers`, `DateTimeRecord_Cli`) VALUES
(37, '3000', 'interno', '', 'ec-envios', '', '8353416', '', 15, '2015-11-13 23:31:41'),
(38, '3001', 'cliente mostrador', '', '', '', '1440947', '', 15, '2015-11-13 23:32:21'),
(39, '3002', 'Fernando Euan', '', 'DIRECTO EXPRESS', '', '', '', 15, '2015-11-14 01:40:49'),
(40, '3002', 'Fernando Euan', '', 'DIRECTO EXPRESS', '', '', '', 15, '2015-11-14 01:40:49'),
(41, '3002', 'Fernando Euan', '', 'DIRECTO EXPRESS', '', '', '', 15, '2015-11-14 01:40:49'),
(42, '3002', 'Fernando Euan', '', 'DIRECTO EXPRESS', '', '', '', 15, '2015-11-14 01:40:49'),
(43, '3002', 'Fernando Euan', '', 'DIRECTO EXPRESS', '', '', '', 15, '2015-11-14 01:40:49'),
(44, '3002', 'Fernando Euan', '', 'DIRECTO EXPRESS', '', '', '', 15, '2015-11-14 01:40:49'),
(45, '1029', 'SAN FRANCISCO', '', 'SAN FRANCISCO DE ASIS S.A.DE C.V.', '', '9424400', '', 20, '2015-11-17 17:11:26'),
(46, '1063', 'AUTOSUR MID', 'david.lopez@vw_merida.com', 'AUTOSUR SA DE CV', '', '9118800', '', 20, '2015-11-17 20:27:55'),
(47, '1009', 'ARTLUX SA DE CV', 'vtuyub@artlux.com.mx', 'ARTLUX SA DE CV', 'ALMACEN', '2895064', '', 15, '2015-11-17 17:12:17'),
(48, '1016', 'ROBERTO GAMEROS', 'roberto_gamero@hotmail.lcom', 'AMERICAN FLASH', 'GERENCIA', '9263841', '', 15, '2015-11-17 17:15:54'),
(49, '1087', 'ARMANDO  PAREDES', '', 'ARMANDO PAREDES RAMIREZ', '', '857585', '', 20, '2015-11-17 17:18:59'),
(50, '1066', 'ANDRES OMAR GONZALEZ CANTO', 'andreamerida@live.com', 'ANDRES OMAR GONZALEZ CANTO', 'ADMINITRACION', '9991011356', '', 15, '2015-11-17 17:19:12'),
(51, '1047', 'COMERCIALIZADORA ANDRE-MUNDOVISION', '', 'COMERIALIZADORA ANDRE-MUNDOVISION', '', '9231138', '', 20, '2015-11-17 17:22:04'),
(52, '1012', 'ABRIL ENCALADA', 'sisepmerida@hotmail.com', 'ABRIL ENCALADA', 'GERENCIA', '9260571', '', 15, '2015-11-17 17:22:38'),
(53, '1048', 'COMPUFAX', 'caja@compufax.com.mx', 'COMPUFAX', '', '9201416', '', 20, '2015-11-17 17:25:16'),
(54, '1090', 'AUTOPARTES CAMARIOCA', '', 'AUTOPARTES', '', '2890302', '', 20, '2015-11-17 17:30:22'),
(55, '1036', 'ALBERTO MARFIL', '', 'ALBERTO MARFIL', '', '9861032567', '', 15, '2015-11-17 17:32:58'),
(56, '1023', 'DICIPA ', 'lorena.olan@dicipa.com.mx', 'DICIPA', '', '9201609', '', 20, '2015-11-17 17:35:32'),
(57, '1049', 'DICISA', 'giovany.us@dicisasureste.com.m', 'DISTRIBUCION CONTROL E ILUMINA', '', '9257695 EX', '', 20, '2015-11-17 17:44:57'),
(58, '3063', 'AEROFLASH', '', 'AEROFLASH', '', '9208230', '', 15, '2015-11-17 17:42:59'),
(59, '1071', 'DINAUTO', '', 'DINAUTO S DE RL', '', '', '', 20, '2015-11-17 17:48:15'),
(60, '1058', 'AUTOPARTES HIDALGO', '', 'AUTOPARTES HIDALGO', '', '2120235', '', 20, '2015-11-17 17:51:19'),
(61, '1024', 'MARICELA ESTRADA', 'seloste@gmail.com', 'SELOSTE', '', '9240359', '', 15, '2015-11-17 17:52:59'),
(62, '1050', 'EUROVISION', 'eurovision.adm2013@hotmail.com', 'EUROVISION', '', '9230677', '', 20, '2015-11-17 17:53:39'),
(63, '3126', 'MARICELA ESTRADA', '', 'SELOSTE', '', '', '', 15, '2015-11-18 01:06:04'),
(64, '1035', 'EYDER DAMAS', 'edamas@artlux.mx', 'ARTLUX', '', '', '', 20, '2015-11-17 17:58:53'),
(65, '3148', 'VIANEY MEDINA', '', 'VIANEY MEDINA', '', '', '', 15, '2015-11-17 20:29:36'),
(66, '1037', 'ENRIQUE DUARTE', '', 'ENRIQUE DUARTE', '', '', '', 20, '2015-11-17 18:00:22'),
(67, '1985', 'DAVID TORRES', 'torresdecorcioncancun@hotmail.com', 'TORRES DECORACION', '', '9981686299', '', 15, '2015-11-17 18:10:02'),
(68, '1051', 'ENRIQUE PARRA', 'lep@mliexpreso.com', 'ENRIQUE PARRA', '', '2409955', '', 20, '2015-11-17 18:15:38'),
(69, '1002', 'EVANS ', '', 'EVANS', '', '2120955', '', 20, '2015-11-17 20:29:19'),
(70, '1059', 'EISSA', 'antonio.djesus@live.com', 'EQUIPOS INDUSTRIALES DEL SURESTE', '', '92337290 E', '', 20, '2015-11-17 18:21:42'),
(71, '1043', 'EDITORIAL SANTILLAN', '', 'EDITORIAL  SANTILLAN', '', '', '', 20, '2015-11-17 20:30:19'),
(72, '1030', 'JOSE HERRERA', '', 'MAYA COURRIER', '', '9815279', '', 15, '2015-11-17 18:24:23'),
(73, '1060', 'FRANCISCO VALENCIA', '', 'FRANCISCO VALENCIA', '', '24752217', '', 20, '2015-11-17 18:24:39'),
(74, '1041', 'GLOBALLONS', '', 'GLOBALLONS', '', '', '', 20, '2015-11-17 18:25:45'),
(75, '1089', 'GLOBOS CACUN', '', 'GLOBOS CANCUN', '', '', '', 20, '2015-11-17 18:27:37'),
(76, '1031', 'MD DISTRIBUDORA OPTIC', '', 'MD DISTRIBUDORA OPTIC', '', '9233446', '', 15, '2015-11-17 18:28:07'),
(77, '1065', 'GUIMER ROSADO', '', 'GUIMER ROSADO', '', '', '', 20, '2015-11-17 18:28:18'),
(78, '1021', 'GREEN FARMA', '', 'GREEN FARMA', '', '9381550', '', 20, '2015-11-17 18:29:28'),
(79, '1032', 'RUBEN HERNANDEZ', '', 'RYE', '', '1661078', '', 15, '2015-11-17 18:30:26'),
(80, '1003', 'HABANA CIGARRETTE', '', 'HABANA CIGARRETTE', '', '9483821', '', 20, '2015-11-17 18:30:49'),
(81, '1038', 'HUNDAI', '', 'HUNDAI', '', '', '', 20, '2015-11-17 18:32:03'),
(82, '1028', 'REYTEK SA DE CV', 'ruben@reyteklab.com', 'REYTEK SA DE CV', '', '9 44 6160', '', 15, '2015-11-17 18:33:29'),
(83, '1067', 'IMPERPENINSULAR ', '', 'IMPERPENINSULAR SA DE CV', '', '9201212', '', 20, '2015-11-17 18:34:04'),
(84, '1001', 'IUSACELL', 'florcbaquedano@yahoo.com.mx', 'IUSACELL', '', '9999687498', '', 20, '2015-11-17 20:30:37'),
(85, '1074', 'JOHANA HERRARA POOL', '', 'JOHANA HERRERA POOL', '', '', '', 20, '2015-11-17 20:31:17'),
(86, '1056', 'JUAN LUIS ARAGON', '', 'GLOBAL CONSTRUCCIONES', '', '', '', 20, '2015-11-17 18:55:36'),
(87, '1033', 'KLASS', '', 'KLASS', '', '', '', 20, '2015-11-17 19:00:36'),
(88, '1011', 'KARLA GUADALUPE RAMIREZ', '', 'KARLAS GUADALUPE', '', '', '', 20, '2015-11-17 19:03:02'),
(89, '1084', 'LACIAM', 'laciam09@gmail.com', 'LACIAM SCP', '', '9207090', '', 20, '2015-11-17 19:05:24'),
(90, '1057 ', 'LUIS FELIPE LOPEZ', '', 'LUIS FELIPE LOPEZ', '', '', '', 20, '2015-11-17 19:06:51'),
(91, '1000', '', '', 'PARTICULAR', '', '', '', 20, '2015-11-26 05:19:42'),
(92, '1017', 'SURESTE COMUNICACIONES', '', 'SURESTE COMUNICACIONES', '', '9991170631', '', 20, '2015-11-17 20:27:15'),
(94, '1027', 'PEDRO GALINDO ', '', 'HENEQUEN ARTE', '', '9826856', '', 20, '2015-11-17 20:14:24'),
(95, '1005', 'NTA LOGISTICS', 'merida@ntalogistics.com', 'NTA LOGISTICS DE MEXICO', '', '9464797', '', 20, '2015-11-17 20:39:31'),
(96, '1008', 'ODM CME', '', 'ODM CME', '', '93 81 27 3', '', 20, '2015-11-17 20:45:48'),
(97, '1007', 'ODM CPE', '', 'ODM CPE', '', '981 15 6 3', '', 20, '2015-11-17 20:47:31'),
(98, '1010', 'ENRIQUE PEREZ', '', 'EC-VDL', '', '9851060377', '', 20, '2015-11-17 20:49:22'),
(99, '1104', 'TALLER OSES', '', 'TALLER OSES', '', '', '', 13, '2015-11-18 00:24:30'),
(100, '3064', '', '', '', '', '', '', 13, '2015-11-18 01:04:38'),
(101, '1014', 'SIMIL CUERO', '', 'SIMIL CUERO SA DE CV', '', '9245243', '', 20, '2015-11-18 16:46:52'),
(102, '1015', 'GRUPO O.G.', 'jose_poot@gistecno.com', 'GRUPO O. G. SA DE CV ', '', '9142711', '', 20, '2015-11-18 16:53:17'),
(103, '1019', 'SONIA MARIN', '', 'NEOVITA', '', '9831075524', '', 20, '2015-11-18 16:54:58'),
(104, '1022', 'PGC INT', 'marconisansores@pgcint.com', 'PGC INTERNACIONAL DE MEXICO DE RL DE CV', '', '2869482', '', 20, '2015-11-18 17:00:37'),
(105, '1025', 'ODM SURESTE', '', 'ODM SURESTE', '', '999 176 80', '', 20, '2015-11-18 17:09:07'),
(106, '1026', 'LUIS LOPEZ', '', 'PATIO MUEBLES', '', '9994070348', '9997401474', 20, '2015-11-18 17:23:50'),
(107, '1034', 'AUToSUR CME', 'esperanza.mendoza@vw_carmen.com', 'AUTOSUR SA CV (VW CD DEL CARMEN)', '', '1093838234', '', 20, '2015-11-18 17:30:44'),
(108, '1040', 'JOSE MATOS', '', 'MENSAJERIA PRONTO', '', '2874783', '9999961878', 20, '2015-11-18 17:31:54'),
(109, '1042', 'OPTICAS ESPADAS CUN', '', 'OPTICA ESPADAS DE MEXICO SA DE CV', '', '', '', 20, '2015-11-18 17:41:45'),
(110, '1044', 'FLOR MARIA', '', 'OPTICA NEW VISION', '', '', '', 20, '2015-11-18 17:45:15'),
(111, '1045', 'SNNIPER YUCATAN', '', 'SNNIPER YUCATAN', '', '9201457', '', 20, '2015-11-18 17:49:47'),
(112, '1052', 'VILLAREAL DIVISION EQUIPOS', 'embarques@vde.com.mx', 'VILLAREAL DIVISION EQUIPOS SA DE CV', '', '1666583', '', 20, '2015-11-18 17:54:06'),
(113, '1061', 'MAX COLOR', '', 'MAX COLOR TAK SA DE CV ', '', '9380448', '', 20, '2015-11-18 17:59:39'),
(114, '1062', 'BLANCA ROSA ROSADO', '', 'BLANCA ROSA ROSADO', '', '', '', 20, '2015-11-18 18:01:44'),
(115, '1064', 'PROFLEMSA', '', 'PROVEEDORA DE FLEJES Y EMPAQUES DE MERIDA SA DE CV', '', '9999243179', '', 20, '2015-11-18 18:09:10'),
(116, '1068', 'ADIEL GALERA', '', 'ADIEL GALERA', '', '', '', 20, '2015-11-18 18:14:04'),
(117, '1069', 'ABRISEL CABRALES', '', 'ABRISEL CABRALES', '', '', '', 20, '2015-11-18 18:18:23'),
(118, '1070', 'JOSE EVELIO', '', 'JOSE EVELIO ESCALANTE CORTES', '', '9992626536', '', 20, '2015-11-18 18:22:18'),
(119, '1072', 'CURACRETO MID', '', 'CURACRETO ', '', '99921235', '', 20, '2015-11-18 18:36:55'),
(120, '1073', 'DANIEL VERDEJO', '', 'DANIEL VERDEJO', '', '', '', 20, '2015-11-18 18:39:07'),
(121, '1073', 'DANIEL VERDEJO', '', 'DANIEL VERDEJO', '', '', '', 20, '2015-11-18 18:39:09'),
(122, '1076', 'AUTOSUR CPE', '', 'AUTOSUR CPE', '', '', '', 20, '2015-11-18 18:42:07'),
(123, '1077', 'MUEVETIERRA', '', 'NEUMATICOS MUEVETIERRA SA DE CV', '', '9462121', '', 20, '2015-11-18 18:50:48'),
(124, '1078', 'MIGUEL MARTINEZ', '', 'MIGUEL MARTINEZ', '', '', '', 20, '2015-11-18 18:55:37'),
(125, '1079', 'ALEJANDRO AGUILAR GONGORA', '', 'PROYECTOS TREGO SA ', '', '9991229795', '9993551493', 20, '2015-11-18 18:58:27'),
(126, '1080', 'XELIX', '', 'XELIX ESPUMAS FLEXIBLES SA DE CV', '', '9263944', '', 20, '2015-11-18 19:02:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `define_state`
--

CREATE TABLE IF NOT EXISTS `define_state` (
  `Id_ds` int(11) NOT NULL AUTO_INCREMENT,
  `Code_DS` varchar(60) NOT NULL,
  `Descripcion` varchar(120) NOT NULL,
  PRIMARY KEY (`Id_ds`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

--
-- Volcado de datos para la tabla `define_state`
--

INSERT INTO `define_state` (`Id_ds`, `Code_DS`, `Descripcion`) VALUES
(1, 'OK', 'Entregado'),
(2, 'Pendiente', 'P'),
(3, 'Trafico Terrestre', 'TT'),
(4, 'hecho', 'ok'),
(9, 'x', 'QQ'),
(10, 'aaaa', 'AA'),
(11, 'Estacion de Origen', 'EO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `profiles`
--

CREATE TABLE IF NOT EXISTS `profiles` (
  `idProfile` int(11) NOT NULL AUTO_INCREMENT,
  `codeProfi` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `nameProfi` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `descProfi` varchar(250) COLLATE utf8_spanish_ci DEFAULT NULL,
  `dateProfi` date DEFAULT NULL,
  `statusPro` set('ENABLE','DISABLE') COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`idProfile`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=11 ;

--
-- Volcado de datos para la tabla `profiles`
--

INSERT INTO `profiles` (`idProfile`, `codeProfi`, `nameProfi`, `descProfi`, `dateProfi`, `statusPro`) VALUES
(1, 'PRO1', 'Admin', 'Solo administradores', '2015-06-30', 'ENABLE'),
(10, 'emp', 'EMPLEADOS', 'trabajadores', '2015-10-22', 'ENABLE');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `status_guia`
--

CREATE TABLE IF NOT EXISTS `status_guia` (
  `Id_St` int(11) NOT NULL AUTO_INCREMENT,
  `Descripcion` varchar(60) NOT NULL,
  PRIMARY KEY (`Id_St`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tdclientes`
--

CREATE TABLE IF NOT EXISTS `tdclientes` (
  `Id_DC` int(11) NOT NULL AUTO_INCREMENT,
  `Address_Destiny_stret_DC` varchar(20) NOT NULL,
  `Address_Destiny_number_interior_DC` varchar(10) NOT NULL,
  `Address_Destiny_number_xterior_DC` varchar(10) NOT NULL,
  `Address_Destiny_Colony_DC` varchar(20) NOT NULL,
  `Code_Cli` varchar(60) NOT NULL,
  `Id_Cp` varchar(10) NOT NULL,
  `IdDisponible_DC` varchar(2) NOT NULL,
  `idUsers` int(11) NOT NULL,
  `DateTimeRecord_DC` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_DC`),
  KEY `Id_Cli` (`Code_Cli`),
  KEY `Id_Cp` (`Id_Cp`),
  KEY `idUsers` (`idUsers`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=140 ;

--
-- Volcado de datos para la tabla `tdclientes`
--

INSERT INTO `tdclientes` (`Id_DC`, `Address_Destiny_stret_DC`, `Address_Destiny_number_interior_DC`, `Address_Destiny_number_xterior_DC`, `Address_Destiny_Colony_DC`, `Code_Cli`, `Id_Cp`, `IdDisponible_DC`, `idUsers`, `DateTimeRecord_DC`) VALUES
(49, 'XXXX', 'XX', '12', '12', 'H239', '232', 'Si', 12, '2015-10-22 19:11:45'),
(50, 'eric paolo 461', 'residencia', '', '', '3000', '77039', 'Si', 15, '2015-11-13 23:31:41'),
(51, '', '', '', '', '3001', '0', 'Si', 15, '2015-11-13 23:32:21'),
(52, 'AV. NAPOLES 247', 'CENTRO', '267', '', '3002', '0', '--', 15, '2015-11-14 01:40:49'),
(53, 'AV. NAPOLES 247', 'CENTRO', '267', '', '3002', '0', '--', 15, '2015-11-14 01:40:49'),
(54, 'AV. NAPOLES 247', 'CENTRO', '267', '', '3002', '0', '--', 15, '2015-11-14 01:40:49'),
(55, 'AV. NAPOLES 247', 'CENTRO', '267', '', '3002', '0', '--', 15, '2015-11-14 01:40:49'),
(56, 'AV. NAPOLES 247', 'CENTRO', '267', '', '3002', '0', '--', 15, '2015-11-14 01:40:49'),
(57, 'AV. NAPOLES 247', 'CENTRO', '267', '', '3002', '0', '--', 15, '2015-11-14 01:40:49'),
(58, '21 POR 32 Y 34  MERI', 'BUENAVISTA', '', '130 A', '1265', '97127', 'Si', 20, '2015-11-17 17:02:50'),
(59, '7 POR 18 Y 20 MERIDA', 'ALTABRISA', '', '401', '1063', '0', '--', 20, '2015-11-17 17:09:52'),
(60, 'C 58-A X 25 Y 27', 'ITZIMNA', '', '487-A', '1009', '97000', 'Si', 15, '2015-11-17 17:12:17'),
(61, '22 X 19 Y 21 MERIDA,', 'FRACC MONT', '', '298', '1016', '97113', 'Si', 15, '2015-11-17 17:15:54'),
(62, '35 AV. SUR ESQ. CALL', 'INDEPENDEN', '', '900', '1087', '77660', 'Si', 20, '2015-11-17 17:18:59'),
(63, 'C40 X 26 Y 25 MERIDA', 'SAN LUIS C', '', '390-A', '1066', '97205', 'Si', 15, '2015-11-17 17:19:12'),
(64, '56  POR 55 Y 57 CENT', '', '', '480-A', '1047', '0', '--', 20, '2015-11-17 17:22:04'),
(65, 'C 30 X 35 Y 39 MERID', 'SAN LUIS', '', '173', '1012', '97140', 'Si', 15, '2015-11-17 17:22:38'),
(66, '33-B POR AV. REFORMA', 'REFORMA', '', '501-B', '1048', '0', '--', 20, '2015-11-17 17:25:16'),
(67, 'CARRETERA CANCUN LOT', '', '', '', '1090', '0', 'Si', 20, '2015-11-17 17:30:22'),
(68, 'C 26 X 49-A Y 49-B T', 'FRACC SAN ', '', '333', '1036', '0', 'Si', 15, '2015-11-17 17:32:58'),
(69, '28 POR 29', 'GARCIA GIN', '', '', '1023', '0', '--', 20, '2015-11-17 17:35:32'),
(70, '28 POR 29', 'GARCIA GIN', '', '', '1023', '0', '--', 20, '2015-11-17 17:35:56'),
(71, '', 'ROMA', '', '', '3063', '0', 'Si', 15, '2015-11-17 17:42:59'),
(72, '96 ', 'OBRERA', '', '877', '1071', '97260', 'Si', 20, '2015-11-17 17:48:15'),
(73, '35 POR 16 Y 16A  MER', 'SANTAMARIA', '', '271-C', '1058', '0', 'Si', 20, '2015-11-17 17:51:19'),
(74, 'C 4 TH Y TF , MERIDA', 'MONTECRIST', '', '111', '1024', '0', 'Si', 15, '2015-11-17 17:52:59'),
(75, '56 POR 57Y 59 CENTRO', '', '', '', '1050', '0', 'Si', 20, '2015-11-17 17:53:39'),
(76, '', '', '', '', '3146', '0', 'Si', 15, '2015-11-17 17:54:03'),
(77, 'DOMICILIO CONOCIDO', '', '', '', '1035', '', 'Si', 20, '2015-11-17 17:57:54'),
(78, '', '', '', '', '3148', '0', 'Si', 15, '2015-11-17 17:57:11'),
(79, '61 POR 14 Y 16 ', 'ESPERANZA', '', '', '1037', '0', 'Si', 20, '2015-11-17 18:00:22'),
(80, 'AV CHICHEN ITZ MZA 3', '', 'L.59', '14', '1985', '0', 'Si', 15, '2015-11-17 18:10:02'),
(81, '30 por 43 y 45  ', 'MONTEALBAN', '', '361', '1051', '0', 'Si', 20, '2015-11-17 18:15:38'),
(82, '', '', '', '', '1002', '0', 'Si', 20, '2015-11-17 18:17:37'),
(83, '', '', '', '', '1059', '0', 'Si', 20, '2015-11-17 18:21:42'),
(84, '', '', '', '', '1043', '0', 'Si', 20, '2015-11-17 18:22:53'),
(85, '', '', '', '', '1030', '0', 'Si', 15, '2015-11-17 18:24:23'),
(86, '31 POR 14 Y 16 ', 'MEXICO', '', '173', '1060', '0', 'Si', 20, '2015-11-17 18:24:39'),
(87, '', '', '', '', '1041', '0', 'Si', 20, '2015-11-17 18:25:45'),
(88, '', '', '', '', '1089', '0', 'Si', 20, '2015-11-17 18:27:37'),
(89, 'C 56 X 59 Y 57 MERID', 'CENTRO', '', '485', '1031', '97000', 'Si', 15, '2015-11-17 18:28:07'),
(90, '', '', '', '', '1065', '0', 'Si', 20, '2015-11-17 18:28:18'),
(91, '', '', '', '', '1021', '0', 'Si', 20, '2015-11-17 18:29:28'),
(92, 'C 73 X 62 Y 64 MERID', 'SAN ANTONI', '', '255', '1032', '97195', '--', 15, '2015-11-17 18:30:26'),
(93, '', '', '', '', '1003', '0', 'Si', 20, '2015-11-17 18:30:49'),
(94, '', '', '', '', '1038', '0', 'Si', 20, '2015-11-17 18:32:03'),
(95, 'C 22 X 11 Y 13 MERID', 'MEXICO NOR', '', '61', '1028', '97128', 'Si', 15, '2015-11-17 18:33:29'),
(96, '21 POR 50 Y 52   MER', 'ROMA', '', '310-B', '1067', '0', 'Si', 20, '2015-11-17 18:34:04'),
(97, '', '', '', '', '1001', '0', 'Si', 20, '2015-11-17 18:36:12'),
(98, '', '', '', '', '1074', '0', 'Si', 20, '2015-11-17 18:48:07'),
(99, '', '', '', '', '1056', '0', 'Si', 20, '2015-11-17 18:55:36'),
(100, '', '', '', '', '1033', '0', 'Si', 20, '2015-11-17 19:00:36'),
(101, '58', '', '', '', '1011', '0', 'Si', 20, '2015-11-17 19:03:02'),
(102, '', '', '', '', '1084', '0', 'Si', 20, '2015-11-17 19:05:24'),
(103, '', '', '', '', '1057 ', '0', 'Si', 20, '2015-11-17 19:06:51'),
(104, '', '', '', '', '1000', '0', 'Si', 20, '2015-11-17 19:07:31'),
(105, '7 POR 12 Y 14 ', 'MONTECRIST', '', '', '1017', '0', 'Si', 20, '2015-11-17 19:09:43'),
(106, 'OFICINA', '', '', '', '1000', '0', 'Si', 15, '2015-11-17 20:12:18'),
(107, '51 POR 2 Y PERIFERIC', 'FCO. VILLA', '', '384', '1027', '0', 'Si', 20, '2015-11-17 20:14:24'),
(108, '8-B  MERIDA,YUCATAN', 'CENTRO', '', '535-A', '1005', '0', 'Si', 20, '2015-11-17 20:39:32'),
(109, 'CAOBA S/N ENTRE BOQU', 'MADERAS', '', '', '1008', '0', 'Si', 20, '2015-11-17 20:45:48'),
(110, '18', 'PRADO', '', '548', '1007', '0', 'Si', 20, '2015-11-17 20:47:31'),
(111, '49 POR 48-B Y 50 VAL', 'SISAL', '', '222', '1010', '0', 'Si', 20, '2015-11-17 20:49:22'),
(112, 'C 43 X 66 Y 72 MERID', 'CENTRO', '', '541-D', '1104', '0', 'Si', 13, '2015-11-18 00:24:30'),
(113, '', '', '', '', '3064', '0', '--', 13, '2015-11-18 01:04:38'),
(114, '71 POR 68  MERIDA, Y', 'CENTRO', '', '537-A', '1014', '97100', 'Si', 20, '2015-11-18 16:46:52'),
(115, 'PERIFERICO NORTE KM.', '', '1', '13917', '1015', '0', 'Si', 20, '2015-11-18 16:53:17'),
(116, '16 POR 3 Y 5', 'VISTA ALEG', '', '234', '1019', '0', 'Si', 20, '2015-11-18 16:54:58'),
(117, '', '', '', '', '1022', '0', 'Si', 20, '2015-11-18 17:00:37'),
(118, '21 POR 20 Y 24 AV. J', 'CD INDUSTR', '', '407', '1025', '97288', 'Si', 20, '2015-11-18 17:09:07'),
(119, '40 POR 15 Y 17    ME', 'SAN PEDRO ', '3', '365', '1026', '0', 'Si', 20, '2015-11-18 17:23:50'),
(120, '', '', '', '', '1034', '0', 'Si', 20, '2015-11-18 17:28:51'),
(121, '', '', '', '', '1040', '0', 'Si', 20, '2015-11-18 17:31:54'),
(122, '', '', '', '', '1042', '0', 'Si', 20, '2015-11-18 17:41:45'),
(123, '59 POR 12 Y 14', 'ESPERANZA', '', '', '1044', '0', 'Si', 20, '2015-11-18 17:45:15'),
(124, 'AV. ITZAES POR 65 Y ', '', '', '541', '1045', '0', 'Si', 20, '2015-11-18 17:49:47'),
(125, '12 POR 37 DIAGONAL Y', 'MELCHOR OC', '', '310', '1052', '97165', 'Si', 20, '2015-11-18 17:54:06'),
(126, '6 PR 13 Y AV. ALEMAN', 'FELIPE CAR', '', '110', '1061', '0', 'Si', 20, '2015-11-18 17:59:39'),
(127, '', '', '', '', '1062', '0', 'Si', 20, '2015-11-18 18:01:44'),
(128, '57  MERIDA, YUCATAN', 'CENTRO', '', '421', '1064', '0', 'Si', 20, '2015-11-18 18:09:10'),
(129, 'VILLAHERMOSA, TABASC', '', '', '', '1068', '0', 'Si', 20, '2015-11-18 18:14:04'),
(130, 'CIUDAD DEL CARMEN', '', '', '', '1069', '0', 'Si', 20, '2015-11-18 18:18:23'),
(131, '22  POR 41', '', '336', 'EMILIANO ZAPATA OTE.', '1070', '', 'Si', 20, '2015-11-18 18:23:26'),
(132, '10 POR 29 Y 29-A', 'SAN PEDRO ', '', '610-D', '1072', '97000', 'Si', 20, '2015-11-18 18:36:55'),
(133, '', 'CIUDAD DEL', '', '', '1073', '0', 'Si', 20, '2015-11-18 18:39:08'),
(134, '', 'CIUDAD DEL', '', '', '1073', '0', 'Si', 20, '2015-11-18 18:39:09'),
(135, 'AV. RESURGIMIENTO   ', 'BUENAVISTA', '', '189', '1076', '0', 'Si', 20, '2015-11-18 18:42:07'),
(136, 'TABLAJE CATASTRAL  ', 'CIUDAD IND', '', '19522 AMPLIACION', '1077', '0', 'Si', 20, '2015-11-18 18:50:49'),
(137, '', '', '', '', '1078', '0', 'Si', 20, '2015-11-18 18:55:37'),
(138, '15 H POR 4A', 'MISNE', '', '118', '1079', '0', 'Si', 20, '2015-11-18 18:58:28'),
(139, '48 POR 49 Y 51 ', 'CENTRO', '', '475', '1080', '0', 'Si', 20, '2015-11-18 19:02:23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tdguias`
--

CREATE TABLE IF NOT EXISTS `tdguias` (
  `Id_Cg` int(11) NOT NULL AUTO_INCREMENT,
  `St_Dg` varchar(5) NOT NULL,
  `ID_Guia` varchar(60) NOT NULL,
  `IdSurc_S` varchar(60) NOT NULL,
  `Des_Dg` varchar(60) NOT NULL,
  `DefineState_Ds` int(11) NOT NULL,
  `personnelReceived` varchar(11) NOT NULL,
  `Importe_Dg` varchar(11) NOT NULL,
  `Validacion_Dg` varchar(2) NOT NULL,
  `Osbservacions_Dg` varchar(200) NOT NULL,
  `DateRecord` date NOT NULL,
  `TimeRecord` time NOT NULL,
  `idUsers` int(11) NOT NULL,
  `AutoRecord` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_Cg`),
  KEY `ID_Guia` (`ID_Guia`),
  KEY `St_Cg` (`DefineState_Ds`),
  KEY `St_Cg_2` (`DefineState_Ds`),
  KEY `DefineState_Ds` (`DefineState_Ds`),
  KEY `idUsers` (`idUsers`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=40 ;

--
-- Volcado de datos para la tabla `tdguias`
--

INSERT INTO `tdguias` (`Id_Cg`, `St_Dg`, `ID_Guia`, `IdSurc_S`, `Des_Dg`, `DefineState_Ds`, `personnelReceived`, `Importe_Dg`, `Validacion_Dg`, `Osbservacions_Dg`, `DateRecord`, `TimeRecord`, `idUsers`, `AutoRecord`) VALUES
(36, 'tt', 'H1234', 'MID', 'CTM', 3, 'jose', '100', 'si', '-', '2015-11-18', '12:02:00', 13, '2015-11-19 17:19:43'),
(37, 't', 'guia1', 'MID', 'CTM', 3, 'jorge', '1', 'si', '-', '2015-11-18', '20:00:00', 13, '2015-11-20 01:07:46'),
(38, 't', 'guia2', 'MID', 'CTM', 3, 'prueba2', '1', 'si', 'll', '2015-11-18', '20:01:00', 13, '2015-11-20 01:10:02'),
(39, 't', 'guia3', 'MID', 'CAN', 3, 'prueba', '10', 'si', 'vhvv', '2015-11-18', '20:03:00', 13, '2015-11-20 01:09:50');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `thguias`
--

CREATE TABLE IF NOT EXISTS `thguias` (
  `ID_Guia` int(11) NOT NULL AUTO_INCREMENT,
  `St_Hguia` varchar(5) NOT NULL,
  `Code_Cli` varchar(60) NOT NULL,
  `Guia_Hguia` varchar(60) NOT NULL,
  `Date_Recolect` date NOT NULL,
  `Origen_Hguia` varchar(20) NOT NULL,
  `Destino_Hguia` varchar(20) NOT NULL,
  `Maestro` int(11) NOT NULL,
  `Sup_Hguia` int(11) NOT NULL,
  `FXC_Hguia` int(11) NOT NULL,
  `Piezas_Hguia` int(11) NOT NULL,
  `Peso_Hguia` varchar(11) NOT NULL,
  `Name_Hguia` varchar(60) NOT NULL,
  `Consig_Hguia` varchar(60) NOT NULL,
  `Direccion_Hguia` varchar(120) NOT NULL,
  `idUser` int(11) NOT NULL,
  `DateTimeReceipt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID_Guia`),
  KEY `ID_Des` (`Code_Cli`),
  KEY `ID_Des_2` (`Code_Cli`),
  KEY `Origen_Hguia` (`Origen_Hguia`,`Destino_Hguia`),
  KEY `Destino_Hguia` (`Destino_Hguia`),
  KEY `Origen_Hguia_2` (`Origen_Hguia`,`Destino_Hguia`),
  KEY `idUser` (`idUser`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=161 ;

--
-- Volcado de datos para la tabla `thguias`
--

INSERT INTO `thguias` (`ID_Guia`, `St_Hguia`, `Code_Cli`, `Guia_Hguia`, `Date_Recolect`, `Origen_Hguia`, `Destino_Hguia`, `Maestro`, `Sup_Hguia`, `FXC_Hguia`, `Piezas_Hguia`, `Peso_Hguia`, `Name_Hguia`, `Consig_Hguia`, `Direccion_Hguia`, `idUser`, `DateTimeReceipt`) VALUES
(45, 'p', 'H239', '56522', '2015-10-22', 'CTM', 'MID', 1000, 1001, 0, 1, '1', 'JUAN', 'empresa', 'xxx', 12, '2015-10-22 19:30:32'),
(137, 'ok', '1080', 'guia1', '2015-11-18', 'MID', 'CTM', 3000, 3001, 1, 1, '1', 'XELIX', 'persona', 'calle 45 y55', 13, '2015-11-25 21:00:05'),
(138, 'ok', '1079', 'guia2', '2015-11-18', 'MID', 'CTM', 3000, 3001, 1, 1, '1', 'ALEJANDRO AGUILAR GONGORA', 'persona', 'calle 445 66', 13, '2015-11-25 21:00:05'),
(139, 'ok', '1078', 'guia3', '2015-11-18', 'MID', 'CAN', 3000, 3001, 1, 1, '1', 'MIGUEL MARTINEZ', 'perosna', 'calle345', 13, '2015-11-25 21:00:05'),
(140, 'TT', '3126', '58964', '2015-11-26', 'MID', 'CTM', 350, 711, 0, 2, '0', 'MARICELA ESTRADA', 'NICTE JIMENEZ', 'OCURRE OFICINA', 13, '2015-11-27 16:14:07'),
(141, 'TT', '3063', '61608', '2015-11-26', 'MID', 'CTM', 350, 711, 0, 1, '0', 'AEROFLASH', 'AEROFLASH', 'OCURRE OFICINA', 13, '2015-11-27 16:16:26'),
(142, 'TT', '3063', '61607', '2015-11-26', 'MID', 'CTM', 350, 711, 0, 4, '0', 'AEROFLASH', 'AEROFLASH', 'OCURRE OFICINA', 13, '2015-11-27 16:18:22'),
(143, 'TT', '3148', '59991', '2015-11-26', 'MID', 'CTM', 350, 711, 0, 1, '0', 'NAZAN COMERC', 'VIANEY', 'OTHON P BCO #2410 CENTRO', 13, '2015-11-27 17:12:30'),
(144, 'TT', '3148', '59992', '2015-11-26', 'MID', 'CTM', 350, 711, 0, 1, '0', 'NAZAN COMERC', 'VIANEY', 'OTHON P BCO #2410 CENTRO', 13, '2015-11-27 17:14:30'),
(145, 'TT', '3148', '60057', '2015-11-26', 'MID', 'CTM', 350, 711, 0, 1, '0', 'WATA GROUP', 'VIANEY', 'ALVARO OBREGON #247 MADERO', 13, '2015-11-27 17:16:11'),
(146, 'TT', '3148', '60059', '2015-11-26', 'MID', 'CTM', 350, 711, 0, 1, '0', 'WATA GROUP', 'VIANEY', 'ALVARO OBREGON #247 MADERO', 13, '2015-11-27 17:17:18'),
(147, 'TT', '3148', '60063', '2015-11-26', 'MID', 'CTM', 350, 711, 0, 1, '0', 'WATA GROUP', 'VIANEY', 'ALVARO OBREGON #247 MADERO', 13, '2015-11-27 17:52:39'),
(148, 'TT', '3000', '61969', '2015-11-26', 'MID', 'CTM', 350, 711, 0, 1, '0', 'WATA GROUP', 'TANIA GOMEZ', 'AV LAZARO C #184', 13, '2015-11-27 17:54:02'),
(149, 'TT', '1029', '60499', '2015-11-26', 'MID', 'CTM', 350, 711, 0, 1, '0', 'SAN FRANCISCO', 'SUPER SN FCO CTM', 'AV SAN SALVADOR X VENUSTIANO C', 13, '2015-11-27 17:55:23'),
(150, 'TT', '3000', '62289', '2015-11-26', 'MID', 'CTM', 350, 711, 120, 1, '0', 'REYNA DOMINGUEZ', 'STARCOM', 'OCURRE OFICINA', 13, '2015-11-27 17:59:57'),
(151, 'TT', '3000', '62072', '2015-11-26', 'MID', 'CTM', 350, 711, 120, 1, '0', 'SURTIDOR TAPICERO', 'VICTOR MANUEL MENDOZA', 'FELIPE ANGELES 312', 13, '2015-11-27 18:01:32'),
(152, 'TT', '3000', '60708', '2015-11-26', 'MID', 'CTM', 350, 711, 0, 1, '0', 'EVANS', 'MAYO BERMUDEZ', 'AV JUAREZ #251', 13, '2015-11-27 18:05:21'),
(153, 'TT', '1OOO', '61393', '2015-11-26', 'MID', 'CTM', 350, 711, 120, 1, '0', 'BRAULIO CHI', 'MISAEL MTZ', 'OCURRE OFICINA', 13, '2015-11-27 18:06:54'),
(154, 'TT', '3000', '57783', '2015-11-26', 'MID', 'CTM', 350, 711, 65, 1, '0', 'MUNDO TERRA', 'MAYRA FLOREANO', 'XEC-PICH X CHUPON', 13, '2015-11-27 18:09:35'),
(155, 'TT', '3000', '61265', '2015-11-26', 'MID', 'CTM', 350, 711, 65, 1, '0', 'NAZAN COMERC', 'MAYRA FLOREANO', 'XEC-PICH X CHUPON', 13, '2015-11-27 18:11:36'),
(156, 'TT', '3000', '61968', '2015-11-26', 'MID', 'CTM', 350, 711, 65, 1, '0', 'WATA GROUP', 'MAYRA FLOREANO', 'XEC-PICH X CHUPON', 13, '2015-11-27 18:12:41'),
(157, 'TT', '3170', '58673', '2015-11-26', 'MID', 'CTM', 350, 711, 0, 5, '0', 'MUEVETIERRA', 'LLANTAS TORNEL', 'DOMICILIO CONOCIDO', 13, '2015-11-27 18:13:59'),
(158, 'TT', '3027', '50210', '2015-11-26', 'MID', 'CTM', 350, 711, 0, 1, '0', 'GPO NOVEM', 'MATILDE ROVIROSA', 'AV MACHUXAC SN', 13, '2015-11-27 18:21:19'),
(159, 'TT', '3148', '59947', '2015-11-26', 'MID', 'CTM', 350, 711, 0, 1, '0', 'MODACLUB', 'VIANEY', 'ALVARO OBREGON #247 MADERO', 13, '2015-11-27 18:23:01'),
(160, 'TT', '3148', '59951', '2015-11-26', 'MID', 'CTM', 350, 711, 0, 1, '0', 'MODACLUB', 'VIANEY', 'ALVARO OBREGON #247 MADERO', 13, '2015-11-27 18:24:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tsend`
--

CREATE TABLE IF NOT EXISTS `tsend` (
  `Id_Send` int(11) NOT NULL AUTO_INCREMENT,
  `Code_Send` varchar(20) NOT NULL,
  `Name_Send` varchar(60) NOT NULL,
  `St_Send` char(2) NOT NULL,
  PRIMARY KEY (`Id_Send`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=17 ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tsucur`
--

CREATE TABLE IF NOT EXISTS `tsucur` (
  `Id_Sucur` int(11) NOT NULL AUTO_INCREMENT,
  `Code_Sucur` varchar(20) NOT NULL,
  `Name_Sucur` varchar(60) NOT NULL,
  `Address_Sucur` varchar(120) NOT NULL,
  `St_Sucur` set('Si','No') NOT NULL,
  PRIMARY KEY (`Id_Sucur`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Volcado de datos para la tabla `tsucur`
--

INSERT INTO `tsucur` (`Id_Sucur`, `Code_Sucur`, `Name_Sucur`, `Address_Sucur`, `St_Sucur`) VALUES
(20, 'CTM', 'Chetumal', '------------------', 'Si'),
(21, 'MID', 'Merida', 'Conocida', 'Si');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `idUsers` int(11) NOT NULL AUTO_INCREMENT,
  `loginUsers` varchar(15) COLLATE utf8_spanish_ci DEFAULT NULL,
  `passUsers` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `NameUsers` varchar(60) COLLATE utf8_spanish_ci NOT NULL,
  `emailUsers` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `Id_Sucur` int(11) NOT NULL,
  `idprofile` int(11) DEFAULT NULL,
  PRIMARY KEY (`idUsers`),
  KEY `idprofile` (`idprofile`),
  KEY `Id_Sucur` (`Id_Sucur`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci AUTO_INCREMENT=22 ;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`idUsers`, `loginUsers`, `passUsers`, `NameUsers`, `emailUsers`, `Id_Sucur`, `idprofile`) VALUES
(12, 'ADMIN', 'qwe123', 'Administrador', 'EC-envios@hotmail.com ', 20, 1),
(13, 'elsy', '7268', 'empleado de merida', 'leomay08@hotmail.com', 21, 10),
(14, 'ADMIN2', '123', '-', 'ad@hotmail.com', 21, 1),
(15, 'Rocio', '3675', 'Administradora Rocio', 'joagemi@hotmail.com', 20, 1),
(16, 'Miguel', '1048', 'Administrador Miguel', 'miguel_patron911@hotmail.com', 20, 1),
(17, 'Gema', '5594', 'Administradora Gema', 'liz_b_c@hotmail.com', 20, 1),
(18, 'Fatima', '2020', 'empleado de chetumal', 'fati13.05.88@gmail.com', 20, 10),
(19, 'rocio', '3675', '', '', 20, 1),
(20, 'Manuela', 'merida', 'Merida', '', 21, 1),
(21, 'usermerida', '123', 'empleado merida', '', 21, 10);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`idUsers`) REFERENCES `users` (`idUsers`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tdclientes`
--
ALTER TABLE `tdclientes`
  ADD CONSTRAINT `tdclientes_ibfk_4` FOREIGN KEY (`idUsers`) REFERENCES `users` (`idUsers`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `tdguias`
--
ALTER TABLE `tdguias`
  ADD CONSTRAINT `tdguias_ibfk_4` FOREIGN KEY (`DefineState_Ds`) REFERENCES `define_state` (`Id_ds`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `tdguias_ibfk_5` FOREIGN KEY (`idUsers`) REFERENCES `users` (`idUsers`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `thguias`
--
ALTER TABLE `thguias`
  ADD CONSTRAINT `thguias_ibfk_1` FOREIGN KEY (`idUser`) REFERENCES `users` (`idUsers`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`Id_Sucur`) REFERENCES `tsucur` (`Id_Sucur`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`idprofile`) REFERENCES `profiles` (`idProfile`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
