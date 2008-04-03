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
-- Table structure for table `TypeMember`
--

DROP TABLE IF EXISTS `TypeMember`;
CREATE TABLE `TypeMember` (
  `TMid` int(10) unsigned NOT NULL auto_increment,
  `TMname` varchar(255) NOT NULL default '',
  `TMtypeid` int(10) unsigned NOT NULL default '0',
  `TMposition` int(11) NOT NULL default '0',
  `TMdescription` varchar(255) NOT NULL default '',
  `TMmemberof` int(10) unsigned NOT NULL default '0',
  `TMarray` varchar(128) default NULL,
  `TMbitfield` tinyint(4) NOT NULL default '0',
  `TMtypetype` int(10) unsigned NOT NULL default '0',
  `TMwithdrawnin` varchar(255) default NULL,
  `TMappearedin` varchar(255) NOT NULL default '',
  `TMaid` int(10) unsigned NOT NULL default '0',
  `TMaccess` enum('public','private','protected') default NULL,
  `TMvalue` varchar(255) default NULL,
  PRIMARY KEY  (`TMid`),
  KEY `k_TMposmem` (`TMposition`,`TMmemberof`),
  KEY `k_TMtypeid` (`TMtypeid`),
  KEY `k_TMmemberof` (`TMmemberof`),
  KEY `k_TMaid` (`TMaid`)
) ENGINE=MyISAM AUTO_INCREMENT=78469 DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-04-03 10:53:28
