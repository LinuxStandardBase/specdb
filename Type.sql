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
-- Table structure for table `Type`
--

DROP TABLE IF EXISTS `Type`;
CREATE TABLE `Type` (
  `Tid` int(10) unsigned NOT NULL auto_increment,
  `Tname` varchar(255) character set latin1 collate latin1_bin NOT NULL default '',
  `Ttype` enum('Intrinsic','FuncPtr','Enum','Pointer','Typedef','Struct','Union','Array','Literal','Const','Class','Unknown','TypeInfo','Volatile','Function') NOT NULL default 'Unknown',
  `Tbasetype` int(10) unsigned NOT NULL default '0',
  `Theadergroup` int(10) unsigned NOT NULL default '0',
  `Tdescription` varchar(255) NOT NULL default '',
  `Tarray` varchar(16) default NULL,
  `Tstatus` enum('Referenced','Indirect','Excluded','SrcOnly','Conly') NOT NULL default 'Excluded',
  `Tarch` int(10) unsigned NOT NULL default '1',
  `Tattribute` varchar(64) default NULL,
  PRIMARY KEY  (`Tid`),
  UNIQUE KEY `Tnamearch` (`Tname`,`Tarch`,`Ttype`),
  KEY `Tarch` (`Tarch`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

