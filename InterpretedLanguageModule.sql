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
-- Table structure for table `InterpretedLanguageModule`
--

DROP TABLE IF EXISTS `InterpretedLanguageModule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `InterpretedLanguageModule` (
  `ILMid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ILMname` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `ILMversion` varchar(255) NOT NULL DEFAULT '',
  `ILMlanguage` int(10) unsigned NOT NULL DEFAULT '0',
  `ILMstandard` int(10) unsigned NOT NULL DEFAULT '0',
  `ILMappearedin` varchar(5) NOT NULL,
  `ILMwithdrawnin` varchar(5) DEFAULT NULL,
  `ILMurl` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ILMid`),
  UNIQUE KEY `k_ILMname` (`ILMlanguage`,`ILMname`,`ILMappearedin`),
  KEY `k_ILMstandard` (`ILMstandard`),
  KEY `k_appearedin` (`ILMappearedin`,`ILMwithdrawnin`),
  KEY `k_withdrawnin` (`ILMwithdrawnin`)
) ENGINE=MyISAM AUTO_INCREMENT=368 DEFAULT CHARSET=latin1;
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
