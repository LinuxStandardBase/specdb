-- MySQL dump 8.22
--
-- Host: localhost    Database: lsb
---------------------------------------------------------
-- Server version	3.23.52-log

--
-- Table structure for table 'ElfSections'
--

DROP TABLE IF EXISTS ElfSections;
CREATE TABLE ElfSections (
  ESid tinyint(3) NOT NULL auto_increment,
  ESname varchar(60) NOT NULL default '',
  ESstandard int(10) NOT NULL default '0',
  ESdescription blob,
  EStype int(10) NOT NULL default '0',
  ESattributes varchar(60) NOT NULL default '',
  ESSecType int(10) default NULL,
  ESarch int(11) NOT NULL default '1',
  PRIMARY KEY  (ESid)
) TYPE=MyISAM;

