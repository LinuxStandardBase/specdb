# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'Interface'
#
DROP TABLE IF EXISTS Interface;
CREATE TABLE Interface (
  Iid int(10) DEFAULT '0' NOT NULL auto_increment,
  Iname varchar(255) binary DEFAULT '' NOT NULL,
  Istatus enum('Included','Excluded','Defered','Unknown') DEFAULT 'Unknown' NOT NULL,
  Itype enum('Function','Data','Unknown') DEFAULT 'Unknown' NOT NULL,
  Istandard int(10) DEFAULT '0' NOT NULL,
  Iarch int(10) DEFAULT '1' NOT NULL,
  Iheader int(10) DEFAULT '0' NOT NULL,
  Ireturn int(11) DEFAULT '0' NOT NULL,
  Iversion int(11) DEFAULT '0' NOT NULL,
  Idocumented enum('Yes','No','Unknown') DEFAULT 'Unknown' NOT NULL,
  Itested enum('Yes','No','Unknown') DEFAULT 'Unknown' NOT NULL,
  PRIMARY KEY (Iid)
);

