-- MySQL dump 9.10
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

--
-- Table structure for table `ArchLib`
--

DROP TABLE IF EXISTS ArchLib;
CREATE TABLE ArchLib (
  ALlid int(11) NOT NULL default '0',
  ALaid int(11) NOT NULL default '0',
  ALrunname varchar(32) NOT NULL default '0',
  UNIQUE KEY ALlid (ALlid,ALaid)
) TYPE=MyISAM;

