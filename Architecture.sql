-- MySQL dump 8.21
--
-- Host: localhost    Database: lsb
---------------------------------------------------------

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

