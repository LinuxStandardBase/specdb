-- MySQL dump 9.11
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

--
-- Table structure for table `LGInt`
--

DROP TABLE IF EXISTS LGInt;
CREATE TABLE LGInt (
  LGIint int(11) NOT NULL default '0',
  LGIlibg int(11) NOT NULL default '0',
  UNIQUE KEY k_LGI (LGIint,LGIlibg)
) TYPE=MyISAM;

