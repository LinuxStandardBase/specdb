-- MySQL dump 8.21
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
  VBTflags bigint(12) unsigned NOT NULL default '0',
  PRIMARY KEY  (VBTcid,VBTpos),
  KEY VBTciid (VBTcid)
) TYPE=MyISAM;

