# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'CmdLib'
#
DROP TABLE IF EXISTS CmdLib;
CREATE TABLE CmdLib (
  CLcid int(11) DEFAULT '0' NOT NULL,
  CLlid int(11) DEFAULT '0' NOT NULL,
  UNIQUE k_CL (CLcid,CLlid)
);

