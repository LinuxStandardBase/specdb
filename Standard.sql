-- MySQL dump 9.11
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
  Sfull blob,
  Surl varchar(255) default NULL,
  Scomment varchar(60) default NULL,
  Stype enum('Standard','Reference','Unknown') NOT NULL default 'Unknown',
  Sarch int(11) NOT NULL default '1',
  Sshort varchar(128) NOT NULL default '',
  PRIMARY KEY  (Sid),
  UNIQUE KEY Sname (Sname),
  KEY Stype (Stype),
  KEY Sshort (Sshort)
) TYPE=MyISAM;

