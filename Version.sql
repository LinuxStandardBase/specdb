# MySQL dump 8.14
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.23.39-log

#
# Table structure for table 'Version'
#

DROP TABLE IF EXISTS Version;
CREATE TABLE Version (
  Vid int(10) NOT NULL auto_increment,
  Vname varchar(60) binary NOT NULL default '',
  PRIMARY KEY  (Vid)
) TYPE=MyISAM;

