# MySQL dump 8.16
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.23.42-log

#
# Table structure for table 'CmdLib'
#

DROP TABLE IF EXISTS CmdLib;
CREATE TABLE CmdLib (
  CLcid int(11) NOT NULL default '0',
  CLlid int(11) NOT NULL default '0',
  UNIQUE KEY k_CL (CLcid,CLlid)
) TYPE=MyISAM;

