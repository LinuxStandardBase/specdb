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
-- Table structure for table `Application`
--

DROP TABLE IF EXISTS `Application`;
CREATE TABLE `Application` (
  `Aid` int(10) unsigned NOT NULL auto_increment,
  `Aname` varchar(255) character set latin1 collate latin1_bin NOT NULL,
  `Aversion` varchar(255) NOT NULL default '',
  `Aarch` int(10) unsigned NOT NULL default '0',
  `Aabitag` varchar(255) NOT NULL default '',
  `Acompany` varchar(255) NOT NULL default '',
  `Asummary` varchar(255) default NULL,
  `Acomment` varchar(255) default NULL,
  `Aurl` varchar(255) default NULL,
  `Apackager` varchar(255) default NULL,
  PRIMARY KEY  (`Aid`),
  UNIQUE KEY `k_Aname` (`Aname`,`Aversion`,`Aarch`),
  KEY `k_Aarch` (`Aarch`)
) ENGINE=MyISAM AUTO_INCREMENT=5119 DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2008-02-11  9:47:45
