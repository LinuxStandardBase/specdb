# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'Type'
#
DROP TABLE IF EXISTS Type;
CREATE TABLE Type (
  Tid int(10) DEFAULT '0' NOT NULL auto_increment,
  Tname varchar(60) binary DEFAULT '' NOT NULL,
  Ttype enum('Intrinsic','FuncPtr','Enum','Pointer','Typedef','Struct','Union','Unknown') DEFAULT 'Unknown' NOT NULL,
  Tsize int(10) DEFAULT '0' NOT NULL,
  Tbasetype int(10),
  Theadergroup int(10) DEFAULT '0' NOT NULL,
  Tcomment varchar(60),
  Tarray varchar(16),
  Tarch int(11) DEFAULT '1' NOT NULL,
  PRIMARY KEY (Tid),
  UNIQUE Tname (Tname)
);

