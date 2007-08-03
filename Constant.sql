-- MySQL dump 10.10
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
-- Table structure for table `Constant`
--

DROP TABLE IF EXISTS `Constant`;
CREATE TABLE `Constant` (
  `Cid` int(10) unsigned NOT NULL auto_increment,
  `Cname` varchar(255) character set latin1 collate latin1_bin NOT NULL default '',
  `Ctype` enum('int','long','float','double','longdouble','string','macro','Unknown','header_depend') NOT NULL default 'Unknown',
  `Cheadgroup` int(10) unsigned NOT NULL default '0',
  `Cdescription` varchar(255) NOT NULL default '',
  `Ccandidatefor` varchar(255) default NULL,
  `Csrconly` enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  PRIMARY KEY  (`Cid`),
  UNIQUE KEY `k_c_name` (`Cname`),
  KEY `Cheadgroup` (`Cheadgroup`)
) ENGINE=MyISAM AUTO_INCREMENT=10674 DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2007-08-03  8:16:43
