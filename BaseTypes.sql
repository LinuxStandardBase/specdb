-- MySQL dump 9.11
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

--
-- Table structure for table `BaseTypes`
--

DROP TABLE IF EXISTS `BaseTypes`;
CREATE TABLE `BaseTypes` (
  `BTcid` int(11) NOT NULL default '0',
  `BTpos` int(11) NOT NULL default '0',
  `BTrttiid` int(11) NOT NULL default '0',
  PRIMARY KEY  (`BTcid`,`BTpos`),
  KEY `BTcid` (`BTcid`)
) TYPE=MyISAM;

