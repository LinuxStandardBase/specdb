# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'DynamicEntries'
#
DROP TABLE IF EXISTS DynamicEntries;
CREATE TABLE DynamicEntries (
  DEid int(10) DEFAULT '0' NOT NULL auto_increment,
  DEname varchar(60) DEFAULT '' NOT NULL,
  DEstandard int(10) DEFAULT '0' NOT NULL,
  DEdescription varchar(60),
  DEarch int(11) DEFAULT '1' NOT NULL,
  PRIMARY KEY (DEid)
);

