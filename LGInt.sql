# MySQL dump 8.14
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.23.39-log

#
# Table structure for table 'LGInt'
#

DROP TABLE IF EXISTS LGInt;
CREATE TABLE LGInt (
  LGIint int(11) NOT NULL default '0',
  LGIlibg int(11) NOT NULL default '0',
  PRIMARY KEY  (LGIint,LGIlibg)
) TYPE=MyISAM;

