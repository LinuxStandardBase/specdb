-- MySQL dump 9.10
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

--
-- Table structure for table `Standard`
--

DROP TABLE IF EXISTS Standard;
CREATE TABLE Standard (
  Sid tinyint(3) NOT NULL auto_increment,
  Sname varchar(60) NOT NULL default '',
  Sfull varchar(255) default NULL,
  Surl varchar(255) default NULL,
  Scomment varchar(60) default NULL,
  Stype enum('Standard','Reference','Unknown') NOT NULL default 'Unknown',
  Sarch int(11) NOT NULL default '1',
  PRIMARY KEY  (Sid),
  UNIQUE KEY Sname (Sname),
  KEY Stype (Stype)
) TYPE=MyISAM;

