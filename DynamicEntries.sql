-- MySQL dump 8.22
--
-- Host: localhost    Database: lsb
---------------------------------------------------------
-- Server version	3.23.51-log

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
  DEstatus enum('Included','Excluded') NOT NULL default 'Included',
  PRIMARY KEY  (DEid)
) TYPE=MyISAM;

