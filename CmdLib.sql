-- MySQL dump 8.21
--
-- Host: localhost    Database: lsb
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

