-- MySQL dump 8.22
--
-- Host: localhost    Database: lsb
---------------------------------------------------------
-- Server version	3.23.53-log

--
-- Table structure for table 'Parameter'
--

DROP TABLE IF EXISTS Parameter;
CREATE TABLE Parameter (
  Pint int(11) NOT NULL default '0',
  Ppos int(11) NOT NULL default '0',
  Ptype int(11) NOT NULL default '0',
  Parsize smallint(6) default NULL,
  Pconst enum('Y','N') NOT NULL default 'N',
  UNIQUE KEY k_Pa (Pint,Ppos),
  KEY Pint (Pint)
) TYPE=MyISAM;

