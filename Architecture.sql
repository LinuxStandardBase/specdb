# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'Architecture'
#
DROP TABLE IF EXISTS Architecture;
CREATE TABLE Architecture (
  Aid int(10) DEFAULT '0' NOT NULL auto_increment,
  Aname varchar(60) DEFAULT '' NOT NULL,
  Aspecification varchar(60) DEFAULT '' NOT NULL,
  Asymbol varchar(60) DEFAULT '' NOT NULL,
  PRIMARY KEY (Aid)
);

