-- MySQL dump 8.21
--
-- Host: localhost    Database: lsb
---------------------------------------------------------
-- Server version	3.23.49-log

--
-- Table structure for table 'TypeMember'
--

DROP TABLE IF EXISTS TypeMember;
CREATE TABLE TypeMember (
  TMid int(10) NOT NULL auto_increment,
  TMname varchar(60) NOT NULL default '',
  TMtypeid int(10) NOT NULL default '0',
  TMsize int(10) NOT NULL default '0',
  TMoffset int(10) NOT NULL default '0',
  TMposition int(10) NOT NULL default '0',
  TMcomment varchar(60) default NULL,
  TMmemberof int(10) NOT NULL default '0',
  TMarray varchar(60) default NULL,
  TMbitfield tinyint(4) NOT NULL default '0',
  PRIMARY KEY  (TMid),
  KEY k_TMposmem (TMposition,TMmemberof)
) TYPE=MyISAM;

