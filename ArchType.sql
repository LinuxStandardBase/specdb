-- MySQL dump 8.22
--
-- Host: localhost    Database: lsb
---------------------------------------------------------
-- Server version	3.23.50-log

--
-- Table structure for table 'ArchType'
--

DROP TABLE IF EXISTS ArchType;
CREATE TABLE ArchType (
  ATaid int(11) NOT NULL default '0',
  ATtid int(11) NOT NULL default '0',
  ATsize int(11) NOT NULL default '0',
  UNIQUE KEY k_AT (ATaid,ATtid)
) TYPE=MyISAM;

