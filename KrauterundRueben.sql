-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Erstellungszeit: 20. Jun 2022 um 18:17
-- Server-Version: 10.8.3-MariaDB-1:10.8.3+maria~jammy
-- PHP-Version: 8.0.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `KrauterundRueben`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `bestellung`
--

CREATE TABLE `bestellung` (
  `bestellung_id` int(11) NOT NULL,
  `kd_id` int(11) DEFAULT NULL,
  `bestellungs_datum` date NOT NULL,
  `rechnungs_betrag` decimal(10,2) NOT NULL,
  `geliefert` tinyint(4) DEFAULT NULL,
  `rezept_id` int(11) NOT NULL,
  `Menge` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `bestellung`
--

INSERT INTO `bestellung` (`bestellung_id`, `kd_id`, `bestellungs_datum`, `rechnungs_betrag`, `geliefert`, `rezept_id`, `Menge`) VALUES
(1, 1, '2022-06-24', '25.98', 0, 1, 1),
(2, 1, '2022-07-06', '500.00', 0, 3, 50);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `kunden`
--

CREATE TABLE `kunden` (
  `kd_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `vorname` varchar(50) NOT NULL,
  `geburtsdatum` date NOT NULL,
  `strasse` varchar(50) NOT NULL,
  `haus_nr` varchar(6) NOT NULL,
  `plz` varchar(5) NOT NULL,
  `ort` varchar(50) NOT NULL,
  `tel_nr` varchar(25) DEFAULT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `kunden`
--

INSERT INTO `kunden` (`kd_id`, `name`, `vorname`, `geburtsdatum`, `strasse`, `haus_nr`, `plz`, `ort`, `tel_nr`, `email`) VALUES
(1, 'Schmidt', 'Anton', '1991-01-06', 'Röpredder', '13', '21031', 'Hamburg', '04071189459', 'as1991@gmx.de'),
(2, 'Salman', 'Bashar', '1980-11-12', 'Salmanstrasse', '31', '12312', 'Berlin', '01761231231', 'BasharMail@gmail.com');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `lieferant`
--

CREATE TABLE `lieferant` (
  `lieferant_id` int(11) NOT NULL,
  `kd_id` int(11) NOT NULL,
  `liefer_preis` double DEFAULT NULL,
  `bestellung_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `lieferant`
--

INSERT INTO `lieferant` (`lieferant_id`, `kd_id`, `liefer_preis`, `bestellung_id`) VALUES
(1, 1, 4.99, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rezepteinhalt`
--

CREATE TABLE `rezepteinhalt` (
  `rezept_inhalt_id` int(11) NOT NULL,
  `rezept_id` int(11) NOT NULL,
  `zutat_id` int(11) NOT NULL,
  `menge` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `rezepteinhalt`
--

INSERT INTO `rezepteinhalt` (`rezept_inhalt_id`, `rezept_id`, `zutat_id`, `menge`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 2),
(3, 2, 3, 1),
(4, 2, 2, 5),
(5, 3, 5, 1),
(6, 3, 6, 1),
(7, 4, 2, 10),
(8, 4, 7, 5),
(9, 4, 8, 0.5);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rezepten`
--

CREATE TABLE `rezepten` (
  `rezept_id` int(11) NOT NULL,
  `rezept_name` varchar(50) NOT NULL,
  `beschreibung` text NOT NULL,
  `bild_url` text DEFAULT NULL,
  `kaloiern_menge` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `rezepten`
--

INSERT INTO `rezepten` (`rezept_id`, `rezept_name`, `beschreibung`, `bild_url`, `kaloiern_menge`) VALUES
(1, 'Kartoffel und Tomaten', 'Kartoffel und Tomaten kochen.', NULL, 188),
(2, 'Tomaten und Hähnchen', 'Tomaten und Hähnchen anbraten.', NULL, 515),
(3, 'Bananen Milch', 'Ein Glass Milch und eine Banane in Mixer gut vermischen.', '', 299),
(4, 'Schweinenacken mit Gemüse', 'Schweinenacken in Stücke schneiden und zusammen mit Zwiebel und Kartoffel in Ofen bei 200 grad backen.', '', 309);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vegan`
--

CREATE TABLE `vegan` (
  `vegan_id` int(11) NOT NULL,
  `rezept_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `vegan`
--

INSERT INTO `vegan` (`vegan_id`, `rezept_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vegetarisch`
--

CREATE TABLE `vegetarisch` (
  `vegetarisch_id` int(11) NOT NULL,
  `rezept_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `vegetarisch`
--

INSERT INTO `vegetarisch` (`vegetarisch_id`, `rezept_id`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `zutaten`
--

CREATE TABLE `zutaten` (
  `zutat_id` int(11) NOT NULL,
  `zutat_name` varchar(50) NOT NULL,
  `einheit` varchar(25) NOT NULL,
  `netto_preis` decimal(10,2) NOT NULL,
  `kalorien` float NOT NULL,
  `kohlenhydrate` decimal(10,2) NOT NULL,
  `protien` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `zutaten`
--

INSERT INTO `zutaten` (`zutat_id`, `zutat_name`, `einheit`, `netto_preis`, `kalorien`, `kohlenhydrate`, `protien`) VALUES
(1, 'Tomaten', 'kg', '4.11', 18, '3.90', '0.90'),
(2, 'Kartoffel', 'kg', '8.30', 70, '15.00', '2.00'),
(3, 'Hähnchenbrust', 'kg', '10.50', 165, '0.00', '31.00'),
(4, 'Gurken', 'kg', '7.00', 16, '1.80', '0.60'),
(5, 'Milch', 'liter', '0.75', 42, '5.00', '3.40'),
(6, 'Bananen', 'kg', '5.99', 89, '23.00', '1.10'),
(7, 'Zwiebel', 'kg', '3.99', 40, '9.00', '1.10'),
(8, 'Schweinenacken', 'kg', '8.99', 199, '0.00', '19.60'),
(9, 'Ananas', 'kg', '6.99', 50, '13.00', '0.50'),
(10, 'Eier', 'Stück', '0.89', 155, '1.10', '13.00');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `bestellung`
--
ALTER TABLE `bestellung`
  ADD PRIMARY KEY (`bestellung_id`),
  ADD UNIQUE KEY `kd_id` (`bestellung_id`),
  ADD KEY `KUNDENNR` (`kd_id`),
  ADD KEY `rezept_id` (`rezept_id`);

--
-- Indizes für die Tabelle `kunden`
--
ALTER TABLE `kunden`
  ADD PRIMARY KEY (`kd_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indizes für die Tabelle `lieferant`
--
ALTER TABLE `lieferant`
  ADD PRIMARY KEY (`lieferant_id`),
  ADD KEY `kd_id` (`kd_id`),
  ADD KEY `bestellung_id` (`bestellung_id`);

--
-- Indizes für die Tabelle `rezepteinhalt`
--
ALTER TABLE `rezepteinhalt`
  ADD PRIMARY KEY (`rezept_inhalt_id`),
  ADD KEY `REZEPTNR` (`rezept_id`),
  ADD KEY `ZUTATENNR` (`zutat_id`);

--
-- Indizes für die Tabelle `rezepten`
--
ALTER TABLE `rezepten`
  ADD PRIMARY KEY (`rezept_id`);

--
-- Indizes für die Tabelle `vegan`
--
ALTER TABLE `vegan`
  ADD PRIMARY KEY (`vegan_id`),
  ADD KEY `recipe_id` (`rezept_id`);

--
-- Indizes für die Tabelle `vegetarisch`
--
ALTER TABLE `vegetarisch`
  ADD PRIMARY KEY (`vegetarisch_id`),
  ADD KEY `REZEPTNR` (`rezept_id`);

--
-- Indizes für die Tabelle `zutaten`
--
ALTER TABLE `zutaten`
  ADD PRIMARY KEY (`zutat_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `bestellung`
--
ALTER TABLE `bestellung`
  MODIFY `bestellung_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `kunden`
--
ALTER TABLE `kunden`
  MODIFY `kd_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `lieferant`
--
ALTER TABLE `lieferant`
  MODIFY `lieferant_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `rezepteinhalt`
--
ALTER TABLE `rezepteinhalt`
  MODIFY `rezept_inhalt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT für Tabelle `rezepten`
--
ALTER TABLE `rezepten`
  MODIFY `rezept_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT für Tabelle `vegan`
--
ALTER TABLE `vegan`
  MODIFY `vegan_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `vegetarisch`
--
ALTER TABLE `vegetarisch`
  MODIFY `vegetarisch_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT für Tabelle `zutaten`
--
ALTER TABLE `zutaten`
  MODIFY `zutat_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `bestellung`
--
ALTER TABLE `bestellung`
  ADD CONSTRAINT `bestellung_ibfk_1` FOREIGN KEY (`kd_id`) REFERENCES `kunden` (`kd_id`),
  ADD CONSTRAINT `bestellung_ibfk_2` FOREIGN KEY (`rezept_id`) REFERENCES `rezepten` (`rezept_id`);

--
-- Constraints der Tabelle `lieferant`
--
ALTER TABLE `lieferant`
  ADD CONSTRAINT `lieferant_ibfk_1` FOREIGN KEY (`kd_id`) REFERENCES `kunden` (`kd_id`),
  ADD CONSTRAINT `lieferant_ibfk_2` FOREIGN KEY (`bestellung_id`) REFERENCES `bestellung` (`bestellung_id`);

--
-- Constraints der Tabelle `rezepteinhalt`
--
ALTER TABLE `rezepteinhalt`
  ADD CONSTRAINT `rezepteinhalt_ibfk_1` FOREIGN KEY (`rezept_id`) REFERENCES `rezepten` (`rezept_id`),
  ADD CONSTRAINT `rezepteinhalt_ibfk_2` FOREIGN KEY (`zutat_id`) REFERENCES `zutaten` (`zutat_id`);

--
-- Constraints der Tabelle `vegan`
--
ALTER TABLE `vegan`
  ADD CONSTRAINT `vegan_ibfk_1` FOREIGN KEY (`rezept_id`) REFERENCES `rezepten` (`rezept_id`);

--
-- Constraints der Tabelle `vegetarisch`
--
ALTER TABLE `vegetarisch`
  ADD CONSTRAINT `vegetarisch_ibfk_1` FOREIGN KEY (`rezept_id`) REFERENCES `rezepten` (`rezept_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
