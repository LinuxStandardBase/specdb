# MySQL dump 8.14
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.23.39-log

#
# Table structure for table 'ArchInt'
#

DROP TABLE IF EXISTS ArchInt;
CREATE TABLE ArchInt (
  AIarch int(11) NOT NULL default '0',
  AIint int(11) NOT NULL default '0',
  PRIMARY KEY  (AIarch,AIint)
) TYPE=MyISAM;

