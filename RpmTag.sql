-- MySQL dump 8.22
--
-- Host: localhost    Database: lsb
---------------------------------------------------------
-- Server version	3.23.52-log

--
-- Table structure for table 'RpmTag'
--

DROP TABLE IF EXISTS RpmTag;
CREATE TABLE RpmTag (
  Rid int(11) NOT NULL auto_increment,
  Rname varchar(64) NOT NULL default '',
  Rtag int(11) NOT NULL default '0',
  Rtype enum('NULL_TYPE','CHAR_TYPE','INT8','INT16','INT32','INT64','STRING','BIN','STRING_ARRAY','I18NSTRING') NOT NULL default 'BIN',
  Rcount int(11) NOT NULL default '0',
  Rgroup enum('Private','Signature','Header') NOT NULL default 'Private',
  Rstatus enum('Required','Optional') NOT NULL default 'Required',
  Rdescription text NOT NULL,
  PRIMARY KEY  (Rid),
  UNIQUE KEY Rid (Rid),
  UNIQUE KEY Rname (Rname),
  KEY Rtag (Rtag)
) TYPE=MyISAM;

