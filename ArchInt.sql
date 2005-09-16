-- MySQL dump 9.11
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

--
-- Table structure for table `ArchInt`
--

DROP TABLE IF EXISTS `ArchInt`;
CREATE TABLE `ArchInt` (
  `AIarch` int(11) NOT NULL default '0',
  `AIint` int(11) NOT NULL default '0',
  `AIversion` smallint(6) NOT NULL default '0',
  UNIQUE KEY `k_AI` (`AIarch`,`AIint`),
  KEY `AIversion` (`AIversion`),
  KEY `k_av` (`AIint`,`AIversion`),
  KEY `AIint` (`AIint`)
) TYPE=MyISAM;

