-- MySQL dump 8.21
--
-- Host: localhost    Database: lsb
---------------------------------------------------------

--
-- Table structure for table 'ArchClass'
--

DROP TABLE IF EXISTS ArchClass;
CREATE TABLE ArchClass (
  ACcid int(11) NOT NULL default '0',
  ACaid int(11) NOT NULL default '1',
  ACvoffset int(11) NOT NULL default '0',
  PRIMARY KEY  (ACcid,ACaid)
) TYPE=MyISAM;

