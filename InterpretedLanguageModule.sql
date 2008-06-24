-- MySQL dump 10.10
--
-- Host: db2.linux-foundation.org    Database: lsb
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
CREATE TABLE `InterpretedLanguageModule` (
  `ILMid` int(10) unsigned NOT NULL auto_increment,
  `ILMname` varchar(255) character set latin1 collate latin1_bin NOT NULL default '',
  `ILMversion` varchar(255) NOT NULL default '',
  `ILMlanguage` int(10) NOT NULL default '0',
  `ILMstandard` int(10) NOT NULL default '0',
  `ILMappearedin` varchar(5) NOT NULL,
  `ILMwithdrawnin` varchar(5) default NULL,
  `ILMurl` varchar(255) default NULL,
  PRIMARY KEY  (`ILMid`),
  UNIQUE KEY `k_ILMname` (`ILMlanguage`,`ILMname`,`ILMappearedin`),
  KEY `k_ILMstandard` (`ILMstandard`),
  KEY `k_appearedin` (`ILMappearedin`,`ILMwithdrawnin`),
  KEY `k_withdrawnin` (`ILMwithdrawnin`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

