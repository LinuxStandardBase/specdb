-- MySQL dump 9.11
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

--
-- Table structure for table `ArchTypeMem`
--

DROP TABLE IF EXISTS `ArchTypeMem`;
CREATE TABLE `ArchTypeMem` (
  `ATMaid` int(11) NOT NULL default '0',
  `ATMtmid` int(11) NOT NULL default '0',
  `ATMsize` int(11) NOT NULL default '0',
  `ATMoffset` int(11) NOT NULL default '0',
  PRIMARY KEY  (`ATMaid`,`ATMtmid`)
) TYPE=MyISAM;

