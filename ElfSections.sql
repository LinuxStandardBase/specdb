# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'ElfSections'
#
DROP TABLE IF EXISTS ElfSections;
CREATE TABLE ElfSections (
  ESid tinyint(3) DEFAULT '0' NOT NULL auto_increment,
  ESname varchar(60) DEFAULT '' NOT NULL,
  ESstandard int(10) DEFAULT '0' NOT NULL,
  ESdescription varchar(60),
  EStype int(10) DEFAULT '0' NOT NULL,
  ESattributes varchar(60) DEFAULT '' NOT NULL,
  ESSecType int(10),
  ESarch int(11) DEFAULT '1' NOT NULL,
  PRIMARY KEY (ESid)
);

