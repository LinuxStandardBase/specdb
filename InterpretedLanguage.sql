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
-- Table structure for table `InterpretedLanguage`
--

DROP TABLE IF EXISTS `InterpretedLanguage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `InterpretedLanguage` (
  `ILid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ILname` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `ILversion` varchar(255) NOT NULL DEFAULT '',
  `ILlocation` varchar(255) NOT NULL DEFAULT '',
  `ILstandard` int(10) unsigned NOT NULL DEFAULT '0',
  `ILappearedin` varchar(5) NOT NULL,
  `ILwithdrawnin` varchar(5) DEFAULT NULL,
  `ILsmid` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ILid`),
  UNIQUE KEY `k_Iname` (`ILname`,`ILappearedin`),
  KEY `k_ILstandard` (`ILstandard`),
  KEY `k_appearedin` (`ILappearedin`,`ILwithdrawnin`),
  KEY `k_withdrawnin` (`ILwithdrawnin`),
  KEY `k_submodule` (`ILsmid`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-04-05 11:07:24
