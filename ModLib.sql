-- MySQL dump 8.21
--
-- Host: localhost    Database: lsb
---------------------------------------------------------

--
-- Table structure for table 'ModLib'
--

DROP TABLE IF EXISTS ModLib;
CREATE TABLE ModLib (
  MLmid int(11) NOT NULL default '0',
  MLlid int(4) NOT NULL default '0',
  PRIMARY KEY  (MLlid),
  UNIQUE KEY MLmid (MLmid,MLlid),
  KEY MLmid_2 (MLmid)
) TYPE=MyISAM;

