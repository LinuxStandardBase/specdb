-- MySQL dump 8.22
--
-- Host: localhost    Database: lsb
---------------------------------------------------------

--
-- Table structure for table 'Constant'
--

DROP TABLE IF EXISTS Constant;
CREATE TABLE Constant (
  Cid int(10) NOT NULL auto_increment,
  Cname varchar(80) binary NOT NULL default '',
  Ctype enum('int','float','string','Unknown') NOT NULL default 'Unknown',
  Cheadgroup int(10) NOT NULL default '0',
  Ccomment varchar(60) default NULL,
  Cstd enum('Yes','No','SrcOnly') NOT NULL default 'No',
  PRIMARY KEY  (Cid),
  UNIQUE KEY k_c_name (Cname)
) TYPE=MyISAM;

