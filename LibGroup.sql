# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'LibGroup'
#
DROP TABLE IF EXISTS LibGroup;
CREATE TABLE LibGroup (
  LGid int(10) DEFAULT '0' NOT NULL auto_increment,
  LGname varchar(60) DEFAULT '' NOT NULL,
  LGlib int(10) DEFAULT '0' NOT NULL,
  LGarch int(10) DEFAULT '0' NOT NULL,
  LGorder int(10),
  LGdescription text NOT NULL,
  PRIMARY KEY (LGid),
  UNIQUE k_LG (LGname,LGlib)
);

