# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'ArchInt'
#
DROP TABLE IF EXISTS ArchInt;
CREATE TABLE ArchInt (
  AIarch int(11) DEFAULT '0' NOT NULL,
  AIint int(11) DEFAULT '0' NOT NULL,
  UNIQUE k_AI (AIarch,AIint)
);

