-- MySQL dump 8.23
--
-- Host: localhost    Database: lsb
---------------------------------------------------------

--
-- Table structure for table `TypeType`
--

DROP TABLE IF EXISTS TypeType;
CREATE TABLE TypeType (
  TTid int(11) NOT NULL auto_increment,
  TTname varchar(64) NOT NULL default '',
  TTdesc varchar(255) NOT NULL default '',
  PRIMARY KEY  (TTid),
  UNIQUE KEY TTid (TTid,TTname)
) TYPE=MyISAM;

