-- MySQL dump 8.21
--
-- Host: localhost    Database: lsb
---------------------------------------------------------

--
-- Table structure for table 'ProfLib'
--

DROP TABLE IF EXISTS ProfLib;
CREATE TABLE ProfLib (
  PLpid int(11) NOT NULL default '0',
  PLlid tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (PLpid,PLlid)
) TYPE=MyISAM;

