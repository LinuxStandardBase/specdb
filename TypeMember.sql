# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'TypeMember'
#
DROP TABLE IF EXISTS TypeMember;
CREATE TABLE TypeMember (
  TMid int(10) DEFAULT '0' NOT NULL auto_increment,
  TMname varchar(60) DEFAULT '' NOT NULL,
  TMtypeid int(10) DEFAULT '0' NOT NULL,
  TMsize int(10) DEFAULT '0' NOT NULL,
  TMoffset int(10) DEFAULT '0' NOT NULL,
  TMposition int(10) DEFAULT '0' NOT NULL,
  TMcomment varchar(60),
  TMmemberof int(10) DEFAULT '0' NOT NULL,
  TMarray varchar(60),
  TMbitfiled enum('Yes','No') DEFAULT 'No' NOT NULL,
  PRIMARY KEY (TMid),
  KEY k_TMposmem (TMposition,TMmemberof)
);

