-- MySQL dump 8.22
--
-- Host: localhost    Database: lsb
---------------------------------------------------------
-- Server version	3.23.50-log

--
-- Table structure for table 'Command'
--

DROP TABLE IF EXISTS Command;
CREATE TABLE Command (
  Cid int(11) NOT NULL auto_increment,
  Cname varchar(32) binary NOT NULL default '',
  Cpath varchar(64) binary NOT NULL default '',
  Cstatus enum('Included','Excluded','Unknown') NOT NULL default 'Unknown',
  Cstandard int(11) NOT NULL default '0',
  Cdocumented enum('Yes','No') NOT NULL default 'No',
  Ctested enum('Yes','No') NOT NULL default 'No',
  PRIMARY KEY  (Cid),
  UNIQUE KEY Cpath (Cpath),
  UNIQUE KEY Cname (Cname)
) TYPE=MyISAM;

