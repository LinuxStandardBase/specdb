# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'CmdInt'
#
DROP TABLE IF EXISTS CmdInt;
CREATE TABLE CmdInt (
  CIcid int(11) DEFAULT '0' NOT NULL,
  CIiid int(11) DEFAULT '0' NOT NULL,
  CIvid int(11) DEFAULT '0' NOT NULL,
  UNIQUE k_CI (CIcid,CIiid,CIvid)
);

