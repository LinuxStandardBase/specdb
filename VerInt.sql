# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'VerInt'
#
DROP TABLE IF EXISTS VerInt;
CREATE TABLE VerInt (
  VIver int(11) DEFAULT '0' NOT NULL,
  VIint int(11) DEFAULT '0' NOT NULL,
  UNIQUE k_VI (VIver,VIint)
);

