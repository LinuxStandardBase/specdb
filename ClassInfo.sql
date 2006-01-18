-- MySQL dump 10.9
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ClassInfo`
--

DROP TABLE IF EXISTS `ClassInfo`;
CREATE TABLE `ClassInfo` (
  `CIid` int(11) NOT NULL auto_increment,
  `CIname` varchar(128) NOT NULL default '',
  `CItid` int(11) NOT NULL default '0',
  `CIvtable` int(11) NOT NULL default '0',
  `CInumvfunc` int(11) NOT NULL default '0',
  `CInumvtab` int(11) NOT NULL default '1',
  `CIrtti` int(11) NOT NULL default '0',
  `CInumbasetype` int(11) NOT NULL default '0',
  `CIbase` int(11) NOT NULL default '0',
  `CInumvmitypes` int(11) NOT NULL default '0',
  `CIflags` int(11) NOT NULL default '0',
  `CIvcalloffset` int(11) NOT NULL default '0',
  `CIbaseoffset` int(11) NOT NULL default '0',
  `CIbasevtable` int(11) NOT NULL default '0',
  `CIlibg` int(11) NOT NULL default '0',
  `CIvtclass` tinyint(1) NOT NULL default '1',
  `CIvtt` int(11) NOT NULL default '0',
  `CInumvtt` int(11) NOT NULL default '0',
  PRIMARY KEY  (`CIid`),
  UNIQUE KEY `CIname` (`CIname`),
  KEY `CIlibg` (`CIlibg`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

