-- MySQL dump 8.23
--
-- Host: base1.freestandards.org    Database: lsb
---------------------------------------------------------

--
-- Table structure for table `ArchClass`
--

DROP TABLE IF EXISTS ArchClass;
CREATE TABLE ArchClass (
  ACcid int(11) NOT NULL default '0',
  ACaid int(11) NOT NULL default '1',
  ACpos int(11) NOT NULL default '0',
  ACbaseoffset int(11) NOT NULL default '0',
  ACvoffset int(11) NOT NULL default '0',
  PRIMARY KEY  (ACcid,ACaid,ACpos)
) TYPE=MyISAM;

