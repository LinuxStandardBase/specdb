# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'Header'
#
DROP TABLE IF EXISTS Header;
CREATE TABLE Header (
  Hid int(10) DEFAULT '0' NOT NULL auto_increment,
  Hname varchar(60) binary DEFAULT '' NOT NULL,
  PRIMARY KEY (Hid)
);

