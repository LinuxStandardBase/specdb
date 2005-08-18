-- MySQL dump 8.23
--
-- Host: base1.freestandards.org    Database: lsb
---------------------------------------------------------

--
-- Table structure for table `Module`
--

DROP TABLE IF EXISTS Module;
CREATE TABLE Module (
  Mid int(11) NOT NULL auto_increment,
  Mname varchar(32) NOT NULL default '',
  Mdesc varchar(255) NOT NULL default '',
  PRIMARY KEY  (Mid),
  UNIQUE KEY Mname (Mname),
  KEY Mid (Mid,Mname)
) TYPE=MyISAM;

