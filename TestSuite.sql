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
-- Table structure for table `TestSuite`
--

DROP TABLE IF EXISTS `TestSuite`;
CREATE TABLE `TestSuite` (
  `TSid` int(10) unsigned NOT NULL auto_increment,
  `TSname` varchar(255) NOT NULL default '',
  `TSfullname` varchar(255) NOT NULL default '',
  `TSvendor` varchar(255) NOT NULL default '',
  `TSstatus` enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  `TSpartof` varchar(255) NOT NULL default '',
  `TSversion` varchar(255) NOT NULL default '',
  `TSlsbversion` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`TSid`),
  KEY `TSid` (`TSid`,`TSname`,`TSversion`),
  KEY `TSlsbversion` (`TSlsbversion`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

