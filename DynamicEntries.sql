-- MySQL dump 8.21
--
-- Host: localhost    Database: lsb
---------------------------------------------------------

--
-- Table structure for table 'DynamicEntries'
--

DROP TABLE IF EXISTS DynamicEntries;
CREATE TABLE DynamicEntries (
  DEid int(10) NOT NULL auto_increment,
  DEname varchar(60) NOT NULL default '',
  DEvalue varchar(11) NOT NULL default '0',
  DEstandard int(10) NOT NULL default '0',
  DEdescription blob,
  DEarch int(11) NOT NULL default '1',
  DEstatus enum('Included','Excluded') NOT NULL default 'Excluded',
  PRIMARY KEY  (DEid)
) TYPE=MyISAM;

