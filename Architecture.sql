-- MySQL dump 8.22
--
-- Host: localhost    Database: lsb
---------------------------------------------------------
-- Server version	3.23.52-log

--
-- Table structure for table 'Architecture'
--

DROP TABLE IF EXISTS Architecture;
CREATE TABLE Architecture (
  Aid int(10) NOT NULL auto_increment,
  Aname varchar(60) NOT NULL default '',
  Aspecification varchar(60) NOT NULL default '',
  Asymbol varchar(60) NOT NULL default '',
  PRIMARY KEY  (Aid)
) TYPE=MyISAM;

