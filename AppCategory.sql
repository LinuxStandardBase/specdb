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
-- Table structure for table `AppCategory`
--

DROP TABLE IF EXISTS `AppCategory`;
CREATE TABLE `AppCategory` (
  `ACaid` int(10) unsigned NOT NULL auto_increment,
  `AClicense` enum('Open Source','Proprietary','Unknown') NOT NULL default 'Open Source',
  `ACui` enum('Command Line','GUI','Unknown') NOT NULL default 'GUI',
  `ACsize` enum('Large','Medium','Small','Unknown') NOT NULL default 'Small',
  `ACvendor` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`ACaid`),
  KEY `k_ACcategories` (`AClicense`,`ACui`,`ACsize`,`ACvendor`),
  KEY `k_ACui_size_vendor` (`ACui`,`ACsize`,`ACvendor`),
  KEY `k_AClicense_size_vendor` (`AClicense`,`ACsize`,`ACvendor`),
  KEY `k_AClicense_vendor` (`AClicense`,`ACvendor`),
  KEY `k_ACsize_vendor` (`ACsize`,`ACvendor`),
  KEY `k_ACui_vendor` (`ACui`,`ACvendor`),
  KEY `k_ACvendor` (`ACvendor`)
) ENGINE=MyISAM AUTO_INCREMENT=9778 DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2007-10-29 12:46:29
