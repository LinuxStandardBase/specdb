-- MySQL dump 9.11
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

--
-- Table structure for table `Module`
--

DROP TABLE IF EXISTS Module;
CREATE TABLE Module (
  Mid int(11) NOT NULL auto_increment,
  Mname varchar(32) NOT NULL default '',
  Mdesc varchar(255) NOT NULL default '',
  PRIMARY KEY  (Mid),
  UNIQUE KEY Pname (Mname),
  UNIQUE KEY Pid (Mid),
  UNIQUE KEY Mid (Mid)
) TYPE=MyISAM;

