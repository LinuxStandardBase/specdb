# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'Command'
#
DROP TABLE IF EXISTS Command;
CREATE TABLE Command (
  Cid int(11) DEFAULT '0' NOT NULL auto_increment,
  Cname varchar(32) binary DEFAULT '' NOT NULL,
  Cpath varchar(64) binary DEFAULT '' NOT NULL,
  Cstatus enum('Included','Excluded','Unknown') DEFAULT 'Unknown' NOT NULL,
  Cstandard int(11) DEFAULT '0' NOT NULL,
  Cdocumented enum('Yes','No') DEFAULT 'No' NOT NULL,
  Ctested enum('Yes','No') DEFAULT 'No' NOT NULL,
  PRIMARY KEY (Cid),
  KEY Cid (Cid),
  UNIQUE Cid_2 (Cid,Cname,Cpath)
);

