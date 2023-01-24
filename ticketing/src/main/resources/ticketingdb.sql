-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost
-- Temps de generació: 24-01-2023 a les 20:11:00
-- Versió del servidor: 10.1.32-MariaDB
-- Versió de PHP: 7.2.5

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de dades: `ticketingdb`
--

-- --------------------------------------------------------

--
-- Estructura de la taula `actions`
--

CREATE TABLE `actions` (
  `id` bigint(20) NOT NULL,
  `type` varchar(25) COLLATE utf8mb4_spanish_ci NOT NULL,
  `performer_username` varchar(25) COLLATE utf8mb4_spanish_ci NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ticket_id` bigint(20) NOT NULL,
  `priority` int(11) DEFAULT NULL,
  `technician_username` varchar(25) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `description` varchar(500) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `hours` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Bolcament de dades per a la taula `actions`
--

INSERT INTO `actions` (`id`, `type`, `performer_username`, `date`, `ticket_id`, `priority`, `technician_username`, `description`, `hours`) VALUES
(1, 'OPENING', 'alex', '2019-10-01 08:15:31', 1, NULL, NULL, NULL, NULL),
(2, 'OPENING', 'maria', '2019-09-24 07:54:13', 2, NULL, NULL, NULL, NULL),
(3, 'OPENING', 'lola', '2019-09-24 17:32:04', 3, NULL, NULL, NULL, NULL),
(4, 'OPENING', 'toni', '2019-09-27 11:27:50', 4, NULL, NULL, NULL, NULL),
(5, 'ASSIGNMENT', 'laia', '2019-10-02 11:21:15', 1, 4, 'raul', NULL, NULL),
(6, 'INTERVENTION', 'raul', '2019-10-04 13:25:11', 1, NULL, NULL, 'És un ratolí inalàmbric, les piles estaven gastades. S\'han substituït però segueix sense funcionar bé del tot. Cal canviar el ratolí.', 2),
(7, 'INTERVENTION', 'genis', '2019-10-05 15:44:37', 1, NULL, NULL, 'Ratolí inalàmbric canviat per model USB.', 1),
(8, 'CLOSE', 'raul', '2019-10-05 19:02:00', 1, NULL, NULL, NULL, NULL),
(9, 'ASSIGNMENT', 'laia', '2019-09-26 13:39:14', 2, 9, 'genis', NULL, NULL),
(10, 'INTERVENTION', 'genis', '2019-09-26 15:15:54', 2, NULL, NULL, 'Google Chrome instal·lat. Firefox actualitzat i restablert a la configuració de fàbrica, l\'ordinador està ple de virus. S\'ha actualitzat l\'antivirus, un escaneig complet en profunditat i programació d\'una tasca per automatitzar un escaneig dos cops per setmana (dilluns i dijous al migdia)', 4),
(11, 'ASSIGNMENT', 'laia', '2019-09-29 14:32:04', 3, 3, 'raul', NULL, NULL);

-- --------------------------------------------------------

--
-- Estructura de la taula `companies`
--

CREATE TABLE `companies` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Bolcament de dades per a la taula `companies`
--

INSERT INTO `companies` (`id`, `name`) VALUES
(1, 'INET'),
(2, 'T-SYSTEMS');

-- --------------------------------------------------------

--
-- Estructura de la taula `rooms`
--

CREATE TABLE `rooms` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Bolcament de dades per a la taula `rooms`
--

INSERT INTO `rooms` (`id`, `name`) VALUES
(2, 'Sala JÚPITER'),
(1, 'Sala SATURN'),
(3, 'Sala VENUS');

-- --------------------------------------------------------

--
-- Estructura de la taula `tickets`
--

CREATE TABLE `tickets` (
  `id` bigint(20) NOT NULL,
  `category` varchar(25) COLLATE utf8mb4_spanish_ci NOT NULL,
  `description` varchar(500) COLLATE utf8mb4_spanish_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Bolcament de dades per a la taula `tickets`
--

INSERT INTO `tickets` (`id`, `category`, `description`) VALUES
(1, 'HARDWARE', 'El ratolí no funciona bé, a vegades desapareix o no es mou. A més sovint he de posar un paper a sota. Ho podeu revisar? Gràcies'),
(2, 'NETWORK', 'Internet funciona molt lent, fent servir el navegador Firefox les pàgines triguen molt a carregar-se i s\'obren finestres emergents de propaganda. He provat d\'instal·lar Chrome però em demana la contrasenya d\'administrador. Necessito una solució urgentment!!!'),
(3, 'SUPPORT', 'Estic intentant fer el desglossament de l\'IVA pels apunts importats al programa de comptabilitat però no me\'n surto. Necessito un cop de ma perquè la propera setmana ve l\'auditor. Gràcies'),
(4, 'PRINTER', 'No puc imprimir a doble cara a la impressora de la Sala VENUS. Tot i que marco l\'opció abans d\'enviar a imprimir documents no surten a doble cara');

-- --------------------------------------------------------

--
-- Estructura de la taula `users`
--

CREATE TABLE `users` (
  `username` varchar(25) COLLATE utf8mb4_spanish_ci NOT NULL,
  `role` varchar(25) COLLATE utf8mb4_spanish_ci NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_spanish_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_spanish_ci NOT NULL,
  `extension` int(11) DEFAULT NULL,
  `room_id` bigint(20) DEFAULT NULL,
  `place` varchar(100) COLLATE utf8mb4_spanish_ci DEFAULT NULL,
  `company_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_spanish_ci;

--
-- Bolcament de dades per a la taula `users`
--

INSERT INTO `users` (`username`, `role`, `full_name`, `password`, `extension`, `room_id`, `place`, `company_id`) VALUES
('alex', 'EMPLOYEE', 'Àlex Macia Pérez', '$2a$10$D25CUjZHnolADZpCmQzWLee7eDX5LEA1jpa3chdrNZ8Ad5u4gHUbm', 3666, 1, 'L15', NULL),
('genis', 'TECHNICIAN', 'Genís Esteve i Prats', '$2a$10$fN.nOfWlRY/LLotIWiseoeh/foQ1vFCY9bnpXmK3k8.VwW7F1xoPi', 1515, NULL, NULL, 1),
('laia', 'SUPERVISOR', 'Laia Vives i Marsans', '$2a$10$EwsBI6trHD56ncjlsxAmwuic5R/qAzx6AyekBpCafndN.CiFuwJjK', 1501, NULL, NULL, 1),
('lola', 'EMPLOYEE', 'Lola Valls i Vilalta', '$2a$10$vTJ82FGgKP36.WHHtWAGNOvCt0bF27/0HzN9OFo1EuU722Z0PKhde', 2501, 3, 'L08', NULL),
('maria', 'EMPLOYEE', 'Maria Lopez i Castells', '$2a$10$EogCF6kJDxTPsfQFciZjROaSBd/8Ok3orVe49KdEebVdyVTYrCKs2', 3513, 1, 'L13', NULL),
('pepe', 'EMPLOYEE', 'Pepe Macia Pérez', '$2a$10$0AgLzuz1.6zfoyObY7.75upVeurPfuZeLN4w3Zg.fjUcWcUeHwFwK', 4555, 1, 'L15', NULL),
('raul', 'TECHNICIAN', 'Raul Casanova i Ferrer', '$2a$10$Zt92wjlBEPx2zXwdTfA4ZeM2cFAAX4MXY4y9y1BKMEZmYbNh.8dz6', 1504, NULL, NULL, 2),
('robert', 'EMPLOYEE', 'Robert Planes i Pujol', '$2a$10$H1S18hqeIbIoPgVU7ECURu6nsitQ0/sGSEJ9Z0Dw6rBV/bloAmCTS', 3510, 1, 'L10', NULL),
('toni', 'EMPLOYEE', 'Antoni Bosc i Cases', '$2a$10$T1lgKgp5XiQAuvTiq4alQeWkgCVHpsHVgmgk/X7wIkJwHypR6TMP2', 2508, 3, 'L08', NULL);

--
-- Índexs per a les taules bolcades
--

--
-- Índexs per a la taula `actions`
--
ALTER TABLE `actions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ticket_x_date` (`ticket_id`,`date`),
  ADD KEY `type` (`type`),
  ADD KEY `fk_performer_username` (`performer_username`),
  ADD KEY `fk_technician_username` (`technician_username`);

--
-- Índexs per a la taula `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índexs per a la taula `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Índexs per a la taula `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`);

--
-- Índexs per a la taula `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`),
  ADD KEY `role` (`role`),
  ADD KEY `full_name` (`full_name`),
  ADD KEY `role_x_full_name` (`role`,`full_name`),
  ADD KEY `fk_room_id` (`room_id`),
  ADD KEY `fk_company_id` (`company_id`);

--
-- AUTO_INCREMENT per les taules bolcades
--

--
-- AUTO_INCREMENT per la taula `actions`
--
ALTER TABLE `actions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT per la taula `companies`
--
ALTER TABLE `companies`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT per la taula `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT per la taula `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restriccions per a les taules bolcades
--

--
-- Restriccions per a la taula `actions`
--
ALTER TABLE `actions`
  ADD CONSTRAINT `fk_performer_username` FOREIGN KEY (`performer_username`) REFERENCES `users` (`username`),
  ADD CONSTRAINT `fk_technician_username` FOREIGN KEY (`technician_username`) REFERENCES `users` (`username`),
  ADD CONSTRAINT `fk_ticket_id` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id`);

--
-- Restriccions per a la taula `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_company_id` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`),
  ADD CONSTRAINT `fk_room_id` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
