-- MySQL dump 8.21
--
-- Host: localhost    Database: lsb
---------------------------------------------------------
-- Server version	3.23.49-log

--
-- Table structure for table 'TestCmd'
--

DROP TABLE IF EXISTS TestCmd;
CREATE TABLE TestCmd (
  TSCcmd int(11) NOT NULL default '0',
  TSCtest int(11) NOT NULL default '0',
  UNIQUE KEY TSCcmd (TSCcmd,TSCtest)
) TYPE=MyISAM;

