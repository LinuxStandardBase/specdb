-- MySQL dump 10.10
--
-- Host: db.linux-foundation.org    Database: lsb
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
-- Table structure for table `ArchInt`
--

DROP TABLE IF EXISTS `ArchInt`;
CREATE TABLE `ArchInt` (
  `AIarch` int(10) unsigned NOT NULL default '0',
  `AIint` int(10) unsigned NOT NULL default '0',
  `AIversion` int(10) unsigned NOT NULL default '0',
  `AIappearedin` varchar(255) NOT NULL default '',
  `AIwithdrawnin` varchar(255) default NULL,
  PRIMARY KEY  (`AIarch`,`AIint`,`AIappearedin`),
  KEY `AIversion` (`AIversion`),
  KEY `k_av` (`AIint`,`AIversion`),
  KEY `k_appearedin` (`AIappearedin`,`AIwithdrawnin`),
  KEY `k_withdrawnin` (`AIwithdrawnin`,`AIarch`),
  KEY `k_appeared_arch` (`AIappearedin`,`AIarch`),
  KEY `k_archappeared` (`AIarch`,`AIappearedin`,`AIwithdrawnin`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

