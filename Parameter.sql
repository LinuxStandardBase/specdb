# MySQL dump 8.16
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.23.42-log

#
# Table structure for table 'Parameter'
#

DROP TABLE IF EXISTS Parameter;
CREATE TABLE Parameter (
  Pint int(11) NOT NULL default '0',
  Ppos int(11) NOT NULL default '0',
  Ptype int(11) NOT NULL default '0',
  KEY Pint (Pint)
) TYPE=MyISAM;

