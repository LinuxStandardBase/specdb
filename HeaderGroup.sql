# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'HeaderGroup'
#
DROP TABLE IF EXISTS HeaderGroup;
CREATE TABLE HeaderGroup (
  HGid int(10) DEFAULT '0' NOT NULL auto_increment,
  HGname varchar(60) DEFAULT '' NOT NULL,
  HGheader int(10) DEFAULT '0' NOT NULL,
  HGorder int(10) DEFAULT '0' NOT NULL,
  HGarch int(10) DEFAULT '0' NOT NULL,
  HGdescription text,
  PRIMARY KEY (HGid)
);

