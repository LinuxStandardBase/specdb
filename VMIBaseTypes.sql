-- MySQL dump 9.07
--
-- Host: localhost    Database: lsb
---------------------------------------------------------

--
-- Table structure for table 'VMIBaseTypes'
--

DROP TABLE IF EXISTS VMIBaseTypes;
CREATE TABLE VMIBaseTypes (
  VBTcid int(11) NOT NULL default '0',
  VBTpos int(11) NOT NULL default '0',
  VBTbasetype int(11) NOT NULL default '0',
  VBTflags int(11) NOT NULL default '0',
  KEY VBTciid (VBTcid)
) TYPE=MyISAM;

