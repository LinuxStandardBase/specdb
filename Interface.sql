# MySQL dump 8.16
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.23.42-log

#
# Table structure for table 'Interface'
#

DROP TABLE IF EXISTS Interface;
CREATE TABLE Interface (
  Iid int(10) NOT NULL auto_increment,
  Iname varchar(255) binary NOT NULL default '',
  Istatus enum('Included','Excluded','Defered','Unknown') NOT NULL default 'Unknown',
  Itype enum('Function','Data','Unknown') NOT NULL default 'Unknown',
  Istandard int(10) NOT NULL default '0',
  Iarch int(10) NOT NULL default '1',
  Iheader int(10) NOT NULL default '0',
  Ireturn int(11) NOT NULL default '0',
  Iversion int(11) NOT NULL default '0',
  Idocumented enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  Itested enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  PRIMARY KEY  (Iid)
) TYPE=MyISAM;

