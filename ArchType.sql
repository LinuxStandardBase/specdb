# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'ArchType'
#
DROP TABLE IF EXISTS ArchType;
CREATE TABLE ArchType (
  ATaid int(11) DEFAULT '0' NOT NULL,
  ATtid int(11) DEFAULT '0' NOT NULL,
  ATsize int(11) DEFAULT '0' NOT NULL,
  UNIQUE k_AT (ATaid,ATtid)
);

