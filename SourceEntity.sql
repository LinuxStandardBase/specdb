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
-- Table structure for table `SourceEntity`
--

DROP TABLE IF EXISTS `SourceEntity`;
CREATE TABLE `SourceEntity` (
  `SEid` int(10) NOT NULL auto_increment,
  `SEbinid` int(10) unsigned default NULL,
  `SEshid` int(12) NOT NULL,
  `SEname` varchar(255) character set latin1 collate latin1_bin NOT NULL default '',
  `SEparent` int(10) default NULL,
  `SEtype` enum('namespace','using-declaration','using-directive','class','struct','typedef','variable','function','friend','code_block','macro','include','header') default NULL,
  `SEheader` int(10) unsigned NOT NULL default '0',
  `SEapi` tinyint(1) NOT NULL default '1',
  `SEneedbin` tinyint(1) NOT NULL default '0',
  `SEstandard` int(10) unsigned default '0',
  `SErefspec` int(10) unsigned NOT NULL default '0',
  `SEdocumented` enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  `SEcomment` varchar(255) default NULL,
  `SEcandidatefor` varchar(255) default NULL,
  `SEdeprecatedsince` varchar(255) default NULL,
  `SEaccessible` tinyint(1) NOT NULL default '1',
  `SEurl` varchar(255) default NULL,
  `SElibrary` varchar(200) character set latin1 collate latin1_bin default NULL,
  PRIMARY KEY  (`SEid`),
  KEY `k_SEname` (`SEname`,`SElibrary`,`SEid`),
  KEY `k_SEstandard` (`SEstandard`),
  KEY `k_SEdocumented` (`SEdocumented`),
  KEY `k_SEheader` (`SEheader`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2009-03-12 14:13:04
