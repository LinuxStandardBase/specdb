-- MySQL dump 9.11
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

--
-- Table structure for table `ModCmd`
--

DROP TABLE IF EXISTS `ModCmd`;
CREATE TABLE `ModCmd` (
  `MCmid` int(11) NOT NULL default '0',
  `MCcid` int(4) NOT NULL default '0',
  PRIMARY KEY  (`MCcid`),
  UNIQUE KEY `MCmid` (`MCmid`,`MCcid`),
  KEY `MCmid_2` (`MCmid`)
) TYPE=MyISAM;

