# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'Standard'
#
DROP TABLE IF EXISTS Standard;
CREATE TABLE Standard (
  Sid tinyint(3) DEFAULT '0' NOT NULL auto_increment,
  Sname varchar(60) DEFAULT '' NOT NULL,
  Sfull varchar(120),
  Surl varchar(60),
  Scomment varchar(60),
  Stype enum('Standard','Reference','Unknown') DEFAULT 'Unknown' NOT NULL,
  PRIMARY KEY (Sid),
  UNIQUE k_Sname (Sname)
);

