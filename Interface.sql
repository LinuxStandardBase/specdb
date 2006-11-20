-- MySQL dump 10.9
--
-- Host: localhost    Database: lsb
-- ------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
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
  `Istdstatus` enum('Included','Excluded','Unknown','Withdrawn','Future','SrcOnly') NOT NULL default 'Unknown',
  `Itype` enum('Function','Data','Alias','Common','Unknown') NOT NULL default 'Unknown',
  `Istandard` int(10) unsigned NOT NULL default '0',
  `Iarch` int(10) unsigned NOT NULL default '1',
  `Iheader` int(10) unsigned NOT NULL default '0',
  `Ireturn` int(10) unsigned NOT NULL default '0',
  `Iversion` int(10) unsigned NOT NULL default '0',
  `Idocumented` enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  `Itested` enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  `Iwithdrawnin` varchar(255) default NULL,
  `Icomment` varchar(255) default NULL,
  `Icandidatefor` varchar(255) default NULL,
  `Iisdeprecated` enum('Yes','No','Unknown') default 'Unknown',
  PRIMARY KEY  (`Iid`),
  KEY `k_Iname` (`Iname`,`Iid`),
  KEY `Istandard` (`Istandard`),
  KEY `Istdstatus` (`Istdstatus`),
  KEY `Itype` (`Itype`),
  KEY `Iarch` (`Iarch`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

