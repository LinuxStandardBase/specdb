-- MySQL dump 9.11
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

--
-- Table structure for table `Profile`
--

DROP TABLE IF EXISTS Profile;
CREATE TABLE Profile (
  Pid int(11) NOT NULL default '0',
  Pname varchar(32) NOT NULL default '',
  Pdesc varchar(255) NOT NULL default '',
  PRIMARY KEY  (Pid),
  UNIQUE KEY Pname (Pname),
  UNIQUE KEY Pid (Pid)
) TYPE=MyISAM;

