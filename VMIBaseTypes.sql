-- MySQL dump 9.08
--
-- Host: base1.freestandards.org    Database: lsb
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

