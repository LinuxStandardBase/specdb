-- MySQL dump 9.07
--
-- Host: localhost    Database: lsb
---------------------------------------------------------

--
-- Table structure for table 'TestCmd'
--

DROP TABLE IF EXISTS TestCmd;
CREATE TABLE TestCmd (
  TSCcmd int(11) NOT NULL default '0',
  TSCtest int(11) NOT NULL default '0',
  UNIQUE KEY TSCcmd (TSCcmd,TSCtest)
) TYPE=MyISAM;

