-- MySQL dump 9.08
--
-- Host: base1.freestandards.org    Database: lsb
---------------------------------------------------------

--
-- Table structure for table 'CmdLib'
--

DROP TABLE IF EXISTS CmdLib;
CREATE TABLE CmdLib (
  CLcid int(11) NOT NULL default '0',
  CLlid int(11) NOT NULL default '0',
  UNIQUE KEY k_CL (CLcid,CLlid)
) TYPE=MyISAM;

