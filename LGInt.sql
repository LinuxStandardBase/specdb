-- MySQL dump 8.22
--
-- Host: localhost    Database: lsb
---------------------------------------------------------
-- Server version	3.23.50-log

--
-- Table structure for table 'LGInt'
--

DROP TABLE IF EXISTS LGInt;
CREATE TABLE LGInt (
  LGIint int(11) NOT NULL default '0',
  LGIlibg int(11) NOT NULL default '0',
  UNIQUE KEY k_LGI (LGIint,LGIlibg)
) TYPE=MyISAM;

