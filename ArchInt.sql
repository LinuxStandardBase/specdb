-- MySQL dump 8.22
--
-- Host: localhost    Database: lsb
---------------------------------------------------------
-- Server version	3.23.50-log

--
-- Table structure for table 'ArchInt'
--

DROP TABLE IF EXISTS ArchInt;
CREATE TABLE ArchInt (
  AIarch int(11) NOT NULL default '0',
  AIint int(11) NOT NULL default '0',
  AIversion smallint(6) NOT NULL default '0',
  UNIQUE KEY k_AI (AIarch,AIint)
) TYPE=MyISAM;

