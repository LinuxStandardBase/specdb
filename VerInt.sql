# MySQL dump 8.14
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.23.39-log

#
# Table structure for table 'VerInt'
#

DROP TABLE IF EXISTS VerInt;
CREATE TABLE VerInt (
  VIver int(11) NOT NULL default '0',
  VIint int(11) NOT NULL default '0',
  PRIMARY KEY  (VIver,VIint)
) TYPE=MyISAM;

