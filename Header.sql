-- MySQL dump 9.10
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

--
-- Table structure for table `Header`
--

DROP TABLE IF EXISTS Header;
CREATE TABLE Header (
  Hid int(10) NOT NULL auto_increment,
  Hname varchar(60) binary NOT NULL default '',
  Hstd enum('Yes','No','SrcOnly','SrcError') NOT NULL default 'No',
  Hlib int(11) NOT NULL default '0',
  PRIMARY KEY  (Hid),
  UNIQUE KEY Hname (Hname)
) TYPE=MyISAM;

