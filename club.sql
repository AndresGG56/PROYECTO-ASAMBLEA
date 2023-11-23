-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-11-2023 a las 04:31:59
-- Versión del servidor: 10.4.28-MariaDB
-- Versión de PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `club`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `AfiliarSocio` (IN `_cedula` INT, IN `_nombre` VARCHAR(40), IN `_tipoS` INT)   BEGIN
	DECLARE _fondos INT;
    IF (_tipoS = 0) THEN
    	SET _fondos = 50000;
    ELSE 
    	SET _fondos = 100000;
    END IF;
	INSERT INTO socio (Cedula, Nombre, Tipo_Suscripcion, Fondos) VALUES (_cedula, _nombre, _tipoS, _fondos);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `aumentarF` (IN `val` INT, IN `_Ced` INT)   BEGIN 
	UPDATE socio SET Fondos = (SELECT Fondos FROM socio WHERE Cedula = _Ced) + val WHERE Cedula = _Ced;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `crearFactura` (IN `_cDeudor` INT, IN `_val` INT, IN `_concepto` TEXT)   BEGIN
	INSERT INTO facturas (C_Deudor, Valor, Concepto) VALUES (_cDeudor, _val, _concepto);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pagarFactura` (IN `Id_f` INT)   BEGIN
    IF ((SELECT Valor FROM facturas WHERE Id = Id_f) < (SELECT Fondos FROM socio WHERE Cedula = (SELECT Cedula FROM facturas WHERE Id = Id_f))) THEN
    	UPDATE facturas SET pagada = 1 WHERE Id = Id_f;
        UPDATE socio SET Fondos = (SELECT Fondos FROM socio WHERE Cedula = (SELECT Cedula FROM facturas WHERE Id = Id_f)) - (SELECT Valor FROM facturas WHERE Id = Id_f) WHERE Cedula = (SELECT Cedula FROM facturas WHERE Id = Id_f);
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistrarInv` (IN `_cedula` INT, IN `_nombre` VARCHAR(40), IN `_cSocio` INT)   BEGIN
	
    IF ((SELECT fondos FROM socio AS F WHERE Cedula = _cSocio) > 0) THEN
		INSERT INTO personas VALUES (_cedula, _cSocio, _nombre);
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `facturas`
--

CREATE TABLE `facturas` (
  `C_Deudor` int(11) DEFAULT NULL,
  `Id` int(11) NOT NULL,
  `Valor` int(11) DEFAULT NULL,
  `Concepto` text DEFAULT NULL,
  `pagada` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `facturas`
--

INSERT INTO `facturas` (`C_Deudor`, `Id`, `Valor`, `Concepto`, `pagada`) VALUES
(123, 1, 20000, 'Agua', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `personas`
--

CREATE TABLE `personas` (
  `Cedula` int(11) NOT NULL,
  `C_Socio` int(11) DEFAULT NULL,
  `Nombre` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `personas`
--

INSERT INTO `personas` (`Cedula`, `C_Socio`, `Nombre`) VALUES
(456, 123, 'Jose');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `socio`
--

CREATE TABLE `socio` (
  `Cedula` int(11) NOT NULL,
  `Nombre` varchar(40) DEFAULT NULL,
  `Tipo_Suscripcion` int(1) DEFAULT NULL,
  `Fondos` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `socio`
--

INSERT INTO `socio` (`Cedula`, `Nombre`, `Tipo_Suscripcion`, `Fondos`) VALUES
(123, 'Juan', 0, 70000);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `facturas`
--
ALTER TABLE `facturas`
  ADD PRIMARY KEY (`Id`);

--
-- Indices de la tabla `personas`
--
ALTER TABLE `personas`
  ADD PRIMARY KEY (`Cedula`),
  ADD KEY `C_Socio` (`C_Socio`);

--
-- Indices de la tabla `socio`
--
ALTER TABLE `socio`
  ADD PRIMARY KEY (`Cedula`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `facturas`
--
ALTER TABLE `facturas`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `personas`
--
ALTER TABLE `personas`
  ADD CONSTRAINT `personas_ibfk_1` FOREIGN KEY (`C_Socio`) REFERENCES `socio` (`Cedula`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
