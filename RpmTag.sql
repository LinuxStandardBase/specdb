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
-- Table structure for table `RpmTag`
--

DROP TABLE IF EXISTS `RpmTag`;
CREATE TABLE `RpmTag` (
  `Rid` int(10) unsigned NOT NULL auto_increment,
  `Rname` varchar(255) NOT NULL default '',
  `Rtag` int(11) NOT NULL default '0',
  `Rtype` enum('NULL_TYPE','CHAR_TYPE','INT8','INT16','INT32','INT64','STRING','BIN','STRING_ARRAY','I18NSTRING') NOT NULL default 'BIN',
  `Rcount` int(11) NOT NULL default '0',
  `Rgroup` enum('Private','Signature','SigDigest','SigSigning','Header','Other','Ignore','PackageInfo','InstallInfo','FileDetails','Dependencies') NOT NULL default 'Private',
  `Rstatus` enum('Required','Optional','Informational','Deprecated','Obsolete','Reserved') NOT NULL default 'Required',
  `Rdescription` text NOT NULL,
  `Rappearedin` varchar(5) NOT NULL,
  `Rwithdrawnin` varchar(5) default NULL,
  PRIMARY KEY  (`Rid`),
  UNIQUE KEY `Rname` (`Rname`,`Rstatus`),
  KEY `Rtag` (`Rtag`),
  KEY `Rgroup` (`Rgroup`),
  KEY `Rstatus` (`Rstatus`),
  KEY `k_appearedin` (`Rappearedin`),
  KEY `k_withdrawnin` (`Rwithdrawnin`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

