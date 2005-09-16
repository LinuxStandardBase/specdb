-- MySQL dump 9.11
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

--
-- Table structure for table `ArchConst`
--

DROP TABLE IF EXISTS `ArchConst`;
CREATE TABLE `ArchConst` (
  `ACaid` int(11) NOT NULL default '0',
  `ACcid` int(11) NOT NULL default '0',
  `ACvalue` text NOT NULL,
  UNIQUE KEY `k_AC` (`ACaid`,`ACcid`)
) TYPE=MyISAM;

