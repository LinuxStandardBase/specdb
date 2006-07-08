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
-- Table structure for table `TypeMember`
--

DROP TABLE IF EXISTS `TypeMember`;
CREATE TABLE `TypeMember` (
  `TMid` int(10) NOT NULL auto_increment,
  `TMname` varchar(60) NOT NULL default '',
  `TMtypeid` int(10) NOT NULL default '0',
  `TMsize` int(10) NOT NULL default '0',
  `TMoffset` int(10) NOT NULL default '0',
  `TMposition` int(10) NOT NULL default '0',
  `TMcomment` varchar(60) default NULL,
  `TMmemberof` int(10) NOT NULL default '0',
  `TMarray` varchar(128) default NULL,
  `TMbitfield` tinyint(4) NOT NULL default '0',
  `TMtypetype` int(11) NOT NULL default '0',
  PRIMARY KEY  (`TMid`),
  KEY `k_TMposmem` (`TMposition`,`TMmemberof`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

