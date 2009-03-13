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
-- Table structure for table `FutureTarget`
--

DROP TABLE IF EXISTS `FutureTarget`;
CREATE TABLE `FutureTarget` (
  `FTid` int(10) unsigned NOT NULL auto_increment,
  `FTname` varchar(255) NOT NULL default '',
  `FTgroup` enum('LSB','Desktop','XML','Security','Runtimes','Manageability') NOT NULL default 'LSB',
  `FTstatus` enum('Active','Completed','Blocked','Rejected','Inactive','Unknown') NOT NULL default 'Unknown',
  `FTlicense` enum('Unknown','Ok','Issues') NOT NULL default 'Unknown',
  `FTstable` enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  `FTbestpractice` enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  `FTrationale` enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  `FTsample` enum('Yes','No','In progress') NOT NULL default 'No',
  `FTappbat` enum('Yes','No','In progress') NOT NULL default 'No',
  `FTdemand` enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  `FTdepends` enum('Unknown','Ok','Issues') NOT NULL default 'Unknown',
  `FTupstream` enum('Unknown','Ok','Issues') NOT NULL default 'Unknown',
  `FTdistros` enum('Unknown','Ok','Issues') NOT NULL default 'Unknown',
  `FTversions` enum('Unknown','Ok','Issues') NOT NULL default 'Unknown',
  `FTpatches` enum('Unknown','Ok','Issues') NOT NULL default 'Unknown',
  `FTdb` enum('Yes','No','In progress') NOT NULL default 'No',
  `FTspec` enum('Yes','No','In progress') NOT NULL default 'No',
  `FTtest` enum('Yes','No','In progress') NOT NULL default 'No',
  `FTdevel` enum('Yes','No','In progress') NOT NULL default 'No',
  `FTlsbversion` varchar(5) default NULL,
  `FTurl` text,
  PRIMARY KEY  (`FTid`),
  UNIQUE KEY `k_FTname` (`FTname`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-03-12 14:05:36
