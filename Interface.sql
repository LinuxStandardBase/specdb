-- MySQL dump 9.11
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

--
-- Table structure for table `Interface`
--

DROP TABLE IF EXISTS `Interface`;
CREATE TABLE `Interface` (
  `Iid` int(10) NOT NULL auto_increment,
  `Iname` varchar(255) binary NOT NULL default '',
  `Istatus` enum('Included','Excluded','Defered','Unknown','SrcOnly','Deprecated','Withdrawn') NOT NULL default 'Unknown',
  `Itype` enum('Function','Data','Alias','Common','Unknown') NOT NULL default 'Unknown',
  `Istandard` int(10) NOT NULL default '0',
  `Iarch` int(10) NOT NULL default '1',
  `Iheader` int(10) NOT NULL default '0',
  `Ireturn` int(11) NOT NULL default '0',
  `Iversion` int(11) NOT NULL default '0',
  `Idocumented` enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  `Itested` enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  `Iwithdrawnin` enum('1.1','1.2','1.3','2.0','3.0') NOT NULL default '1.1',
  `Icomment` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`Iid`),
  UNIQUE KEY `k_Iname` (`Iname`,`Iid`),
  KEY `Iname` (`Iname`),
  KEY `Istandard` (`Istandard`),
  KEY `Istatus` (`Istatus`),
  KEY `Itype` (`Itype`),
  KEY `Iarch` (`Iarch`)
) TYPE=MyISAM;

