-- MySQL dump 8.22
--
-- Host: localhost    Database: lsb
---------------------------------------------------------
-- Server version	3.23.50-log

--
-- Table structure for table 'TestInt'
--

DROP TABLE IF EXISTS TestInt;
CREATE TABLE TestInt (
  TSIint int(11) NOT NULL default '0',
  TSItest int(11) NOT NULL default '0',
  UNIQUE KEY TSIint (TSIint,TSItest)
) TYPE=MyISAM;

