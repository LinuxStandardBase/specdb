# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'Version'
#
DROP TABLE IF EXISTS Version;
CREATE TABLE Version (
  Vid int(10) DEFAULT '0' NOT NULL auto_increment,
  Vname varchar(60) DEFAULT '' NOT NULL,
  PRIMARY KEY (Vid)
);

