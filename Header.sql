# MySQL dump 8.16
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.23.42-log

#
# Table structure for table 'Header'
#

DROP TABLE IF EXISTS Header;
CREATE TABLE Header (
  Hid int(10) NOT NULL auto_increment,
  Hname varchar(60) binary NOT NULL default '',
  Hstd enum('Yes','No') NOT NULL default 'No',
  PRIMARY KEY  (Hid),
  UNIQUE KEY Hname (Hname)
) TYPE=MyISAM;

