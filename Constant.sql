# MySQL dump 8.16
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.23.46-log

#
# Table structure for table 'Constant'
#

DROP TABLE IF EXISTS Constant;
CREATE TABLE Constant (
  Cid int(10) NOT NULL auto_increment,
  Cname varchar(60) binary NOT NULL default '',
  Ctype enum('int','float','string','Unknown') NOT NULL default 'Unknown',
  Cheadgroup int(10) NOT NULL default '0',
  Ccomment varchar(60) default NULL,
  Cstd enum('Yes','No') NOT NULL default 'No',
  PRIMARY KEY  (Cid),
  UNIQUE KEY k_c_name (Cname)
) TYPE=MyISAM;

