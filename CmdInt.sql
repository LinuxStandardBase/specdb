# MySQL dump 8.14
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.23.39-log

#
# Table structure for table 'CmdInt'
#

DROP TABLE IF EXISTS CmdInt;
CREATE TABLE CmdInt (
  CIcid int(11) NOT NULL default '0',
  CIiid int(11) NOT NULL default '0',
  CIvid int(11) NOT NULL default '0',
  PRIMARY KEY  (CIcid,CIiid,CIvid)
) TYPE=MyISAM;

