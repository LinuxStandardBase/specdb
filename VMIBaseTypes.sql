-- MySQL dump 9.11
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

--
-- Table structure for table `VMIBaseTypes`
--

DROP TABLE IF EXISTS VMIBaseTypes;
CREATE TABLE VMIBaseTypes (
  VBTcid int(11) NOT NULL default '0',
  VBTpos int(11) NOT NULL default '0',
  VBTbasetype int(11) NOT NULL default '0',
  VBTflags bigint(20) unsigned NOT NULL default '0',
  VBTaid int(11) NOT NULL default '1',
  PRIMARY KEY  (VBTcid,VBTpos,VBTaid),
  KEY VBTciid (VBTcid)
) TYPE=MyISAM;

