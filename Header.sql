-- MySQL dump 10.13  Distrib 5.1.36, for suse-linux-gnu (x86_64)
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
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Header` (
  `Hid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Hname` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `Hlib` int(10) unsigned NOT NULL DEFAULT '0',
  `Hsrcerror` enum('Yes','No') NOT NULL DEFAULT 'No',
  `Hcandidatefor` varchar(255) DEFAULT NULL,
  `Happearedin` varchar(5) NOT NULL,
  `Hwithdrawnin` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`Hid`),
  UNIQUE KEY `Hname` (`Hname`,`Happearedin`),
  KEY `k_appearedin` (`Happearedin`,`Hwithdrawnin`),
  KEY `k_withdrawnin` (`Hwithdrawnin`),
  KEY `k_Hlib` (`Hlib`)
) ENGINE=MyISAM AUTO_INCREMENT=1422 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-04-05 11:07:23
