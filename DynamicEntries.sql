-- MySQL dump 8.21
--
-- Host: localhost    Database: lsb
---------------------------------------------------------
-- Server version	3.23.49-log

--
-- Table structure for table 'DynamicEntries'
--

DROP TABLE IF EXISTS DynamicEntries;
CREATE TABLE DynamicEntries (
  DEid int(10) NOT NULL auto_increment,
  DEname varchar(60) NOT NULL default '',
  DEstandard int(10) NOT NULL default '0',
  DEdescription blob,
  DEarch int(11) NOT NULL default '1',
  PRIMARY KEY  (DEid)
) TYPE=MyISAM;

