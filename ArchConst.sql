# MySQL dump 8.16
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.23.47-log

#
# Table structure for table 'ArchConst'
#

DROP TABLE IF EXISTS ArchConst;
CREATE TABLE ArchConst (
  ACaid int(11) NOT NULL default '0',
  ACcid int(11) NOT NULL default '0',
  ACvalue varchar(255) NOT NULL default '',
  UNIQUE KEY k_AC (ACaid,ACcid)
) TYPE=MyISAM;

