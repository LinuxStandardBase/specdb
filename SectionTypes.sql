# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'SectionTypes'
#
DROP TABLE IF EXISTS SectionTypes;
CREATE TABLE SectionTypes (
  STid int(10) DEFAULT '0' NOT NULL auto_increment,
  STname varchar(60) DEFAULT '' NOT NULL,
  STvalue int(10) unsigned DEFAULT '0' NOT NULL,
  STstandard int(10) DEFAULT '0' NOT NULL,
  STdescription varchar(250),
  STarch int(11) DEFAULT '1' NOT NULL,
  PRIMARY KEY (STid),
  UNIQUE k_STname (STname(20)),
  UNIQUE k_STvalue (STvalue)
);

