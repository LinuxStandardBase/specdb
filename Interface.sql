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
-- Table structure for table `Interface`
--

DROP TABLE IF EXISTS `Interface`;
CREATE TABLE `Interface` (
  `Iid` int(10) unsigned NOT NULL auto_increment,
  `Iname` varchar(255) character set latin1 collate latin1_bin NOT NULL default '',
  `Itype` enum('Function','Data','Alias','Common') NOT NULL default 'Function',
  `Iheader` int(10) unsigned NOT NULL default '0',
  `Ireturn` int(10) unsigned NOT NULL default '0',
  `Idocumented` enum('Yes','No') NOT NULL default 'No',
  `Icomment` varchar(255) default NULL,
  `Icandidatefor` varchar(255) default NULL,
  `Iunmangled` text,
  `Isrcbin` enum('Both','SrcOnly','BinOnly') NOT NULL default 'Both',
  `Ilibrary` varchar(200) character set latin1 collate latin1_bin default NULL,
  `Istatic` enum('Yes','No') default NULL,
  `Ivirtual` enum('Yes','No') default NULL,
  `Iaccess` enum('public','private','protected') default NULL,
  `Ifkind` enum('Normal','Observer','Constructor','Destructor') default NULL,
  `Icharge` enum('in-charge','not-in-charge','in-charge-deleting') default NULL,
  `Iclass` int(10) unsigned NOT NULL default '0',
  `Ishortname` varchar(255) character set latin1 collate latin1_bin default NULL,
  `Itestable` enum('Yes','No') default 'Yes',
  `Ithrow` enum('Yes','No') NOT NULL default 'No',
  PRIMARY KEY  (`Iid`),
  UNIQUE KEY `k_Iname` (`Iname`,`Ilibrary`),
  KEY `Itype` (`Itype`),
  KEY `k_Idocumented` (`Idocumented`),
  KEY `k_Iheader` (`Iheader`),
  KEY `k_Isrcbin` (`Isrcbin`),
  KEY `k_Itestable` (`Itestable`),
  KEY `k_Iunmangled` (`Iunmangled`(1000)),
  KEY `k_Ireturn` (`Ireturn`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

