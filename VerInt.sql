-- MySQL dump 9.08
--
-- Host: base1.freestandards.org    Database: lsb
---------------------------------------------------------

--
-- Table structure for table 'VerInt'
--

DROP TABLE IF EXISTS VerInt;
CREATE TABLE VerInt (
  VIver int(11) NOT NULL default '0',
  VIint int(11) NOT NULL default '0',
  UNIQUE KEY k_VI (VIver,VIint)
) TYPE=MyISAM;

