-- MySQL dump 9.08
--
-- Host: localhost    Database: lsb
---------------------------------------------------------

--
-- Table structure for table 'TestInt'
--

DROP TABLE IF EXISTS TestInt;
CREATE TABLE TestInt (
  TSIint int(11) NOT NULL default '0',
  TSItest int(11) NOT NULL default '0',
  UNIQUE KEY TSIint (TSIint,TSItest)
) TYPE=MyISAM;

