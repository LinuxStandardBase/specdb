-- MySQL dump 9.11
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

--
-- Table structure for table `ClassVtab`
--

DROP TABLE IF EXISTS `ClassVtab`;
CREATE TABLE `ClassVtab` (
  `CVcid` int(11) NOT NULL default '0',
  `CVclass` int(11) NOT NULL default '0',
  `CVpos` int(11) NOT NULL default '0',
  `CVrtti` int(11) NOT NULL default '0',
  `CVnumvtfuncs` int(11) NOT NULL default '0',
  UNIQUE KEY `CVcid` (`CVcid`,`CVpos`)
) TYPE=MyISAM;

