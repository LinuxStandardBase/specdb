-- MySQL dump 9.11
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

--
-- Table structure for table `TestSuite`
--

DROP TABLE IF EXISTS TestSuite;
CREATE TABLE TestSuite (
  TSid int(11) NOT NULL auto_increment,
  TSname varchar(16) NOT NULL default '',
  TSfullname varchar(255) NOT NULL default '',
  TSvendor varchar(128) NOT NULL default '',
  TSstatus enum('Included','Excluded') NOT NULL default 'Excluded',
  PRIMARY KEY  (TSid),
  UNIQUE KEY TSid (TSid,TSname),
  KEY TSid_2 (TSid,TSname)
) TYPE=MyISAM;

