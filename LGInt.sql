# MySQL dump 7.1
#
# Host: localhost    Database: lsb
#--------------------------------------------------------
# Server version	3.22.32

#
# Table structure for table 'LGInt'
#
DROP TABLE IF EXISTS LGInt;
CREATE TABLE LGInt (
  LGIint int(11) DEFAULT '0' NOT NULL,
  LGIlibg int(11) DEFAULT '0' NOT NULL,
  UNIQUE k_LGI (LGIint,LGIlibg)
);

