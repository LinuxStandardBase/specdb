-- MySQL dump 8.23
--
-- Host: base1.freestandards.org    Database: lsb
---------------------------------------------------------

--
-- Table structure for table `ArchConst`
--

DROP TABLE IF EXISTS ArchConst;
CREATE TABLE ArchConst (
  ACaid int(11) NOT NULL default '0',
  ACcid int(11) NOT NULL default '0',
  ACvalue text NOT NULL,
  UNIQUE KEY k_AC (ACaid,ACcid)
) TYPE=MyISAM;

