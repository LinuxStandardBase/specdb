-- MySQL dump 9.10
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

--
-- Table structure for table `Version`
--

DROP TABLE IF EXISTS Version;
CREATE TABLE Version (
  Vid int(10) NOT NULL auto_increment,
  Vname varchar(60) binary NOT NULL default '',
  PRIMARY KEY  (Vid)
) TYPE=MyISAM;

