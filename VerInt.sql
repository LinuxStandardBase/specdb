# MySQL dump 8.16
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.23.43-log

#
# Table structure for table 'VerInt'
#

DROP TABLE IF EXISTS VerInt;
CREATE TABLE VerInt (
  VIver int(11) NOT NULL default '0',
  VIint int(11) NOT NULL default '0',
  UNIQUE KEY k_VI (VIver,VIint)
) TYPE=MyISAM;

