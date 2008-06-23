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
-- Table structure for table `Header`
--

DROP TABLE IF EXISTS `Header`;
CREATE TABLE `Header` (
  `Hid` int(10) unsigned NOT NULL auto_increment,
  `Hname` varchar(255) character set latin1 collate latin1_bin NOT NULL default '',
  `Hlib` int(10) unsigned NOT NULL default '0',
  `Hsrcerror` enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  `Hcandidatefor` varchar(255) default NULL,
  `Happearedin` varchar(5) NOT NULL,
  `Hwithdrawnin` varchar(5) default NULL,
  PRIMARY KEY  (`Hid`),
  UNIQUE KEY `Hname` (`Hname`,`Happearedin`),
  KEY `k_appearedin` (`Happearedin`,`Hwithdrawnin`),
  KEY `k_withdrawnin` (`Hwithdrawnin`),
  KEY `k_Hlib` (`Hlib`)
) ENGINE=MyISAM AUTO_INCREMENT=904 DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-06-23  8:00:53
