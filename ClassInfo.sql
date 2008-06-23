-- MySQL dump 10.11
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ClassInfo`
--

DROP TABLE IF EXISTS `ClassInfo`;
CREATE TABLE `ClassInfo` (
  `CIid` int(10) unsigned NOT NULL auto_increment,
  `CIname` varchar(255) NOT NULL default '',
  `CItid` int(10) unsigned NOT NULL default '0',
  `CIvtable` int(10) unsigned NOT NULL default '0',
  `CInumvfunc` int(10) unsigned NOT NULL default '0',
  `CInumvtab` int(10) unsigned NOT NULL default '1',
  `CIrtti` int(10) unsigned NOT NULL default '0',
  `CInumbasetype` enum('0','1') NOT NULL default '0',
  `CIbase` int(10) unsigned NOT NULL default '0',
  `CInumvmitypes` int(10) unsigned NOT NULL default '0',
  `CIflags` int(11) NOT NULL default '0',
  `CIvcalloffset` int(11) NOT NULL default '0',
  `CIbaseoffset` int(11) NOT NULL default '0',
  `CIbasevtable` int(10) unsigned NOT NULL default '0',
  `CIlibg` int(10) unsigned NOT NULL default '0',
  `CIvtclass` enum('1','2') NOT NULL default '1',
  `CIvtt` int(10) unsigned NOT NULL default '0',
  `CInumvtt` int(10) unsigned NOT NULL default '0',
  `CIunmangled` text,
  `CIpurevirtual` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`CIid`),
  UNIQUE KEY `CIname` (`CIname`,`CIlibg`),
  KEY `CIlibg` (`CIlibg`),
  KEY `k_CIunmangled` (`CIunmangled`(1000))
) ENGINE=MyISAM AUTO_INCREMENT=2503 DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-06-23  8:00:52
