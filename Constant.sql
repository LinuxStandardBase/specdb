# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'Constant'
#
DROP TABLE IF EXISTS Constant;
CREATE TABLE Constant (
  Cid int(10) DEFAULT '0' NOT NULL auto_increment,
  Cname varchar(60) DEFAULT '' NOT NULL,
  Cvalue varchar(60) DEFAULT '' NOT NULL,
  Ctype enum('int','float','string','Unknown') DEFAULT 'Unknown' NOT NULL,
  Cheadgroup int(10) DEFAULT '0' NOT NULL,
  Carch int(10) DEFAULT '0' NOT NULL,
  Ccomment varchar(60),
  UNIQUE k_c_name (Cname,Carch),
  PRIMARY KEY (Cid)
);

