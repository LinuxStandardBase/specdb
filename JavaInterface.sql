-- MySQL dump 10.13  Distrib 5.1.46, for suse-linux-gnu (x86_64)
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
-- Table structure for table `JavaInterface`
--

DROP TABLE IF EXISTS `JavaInterface`;
CREATE TABLE `JavaInterface` (
  `JIid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `JIname` varchar(750) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT 'Unknown',
  `JIunmangled` varchar(900) NOT NULL DEFAULT 'Unknown',
  `JItype` enum('method','field','Unknown') NOT NULL DEFAULT 'Unknown',
  `JIjcid` int(10) unsigned NOT NULL DEFAULT '0',
  `JIaccess` enum('public','private','protected','Unknown') NOT NULL DEFAULT 'Unknown',
  `JIstatic` enum('Yes','No','Unknown') NOT NULL DEFAULT 'Unknown',
  `JIsynchronized` enum('Yes','No','Unknown') NOT NULL DEFAULT 'Unknown',
  `JIfinal` enum('Yes','No','Unknown') NOT NULL DEFAULT 'Unknown',
  `JIabstract` enum('Yes','No','Unknown') NOT NULL DEFAULT 'Unknown',
  PRIMARY KEY (`JIid`,`JIunmangled`),
  KEY `k_Class` (`JIjcid`,`JIname`),
  KEY `k_JIunmangled` (`JIunmangled`)
) ENGINE=MyISAM AUTO_INCREMENT=1030442 DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-10-26 17:29:05
