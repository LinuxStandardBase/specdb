-- MySQL dump 8.21
--
-- Host: localhost    Database: lsb
---------------------------------------------------------

--
-- Table structure for table 'LibGroup'
--

DROP TABLE IF EXISTS LibGroup;
CREATE TABLE LibGroup (
  LGid int(10) NOT NULL auto_increment,
  LGname varchar(255) NOT NULL default '',
  LGlib int(10) NOT NULL default '0',
  LGarch int(10) NOT NULL default '0',
  LGorder int(10) default NULL,
  LGdescription text NOT NULL,
  PRIMARY KEY  (LGid),
  UNIQUE KEY k_LG (LGname,LGlib)
) TYPE=MyISAM;

