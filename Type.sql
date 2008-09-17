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
-- Table structure for table `Type`
--

DROP TABLE IF EXISTS `Type`;
CREATE TABLE `Type` (
  `Tid` int(10) unsigned NOT NULL auto_increment,
  `Tname` varchar(255) character set latin1 collate latin1_bin NOT NULL default '',
  `Ttype` enum('Intrinsic','FuncPtr','Enum','Pointer','Typedef','Struct','Union','Array','Literal','Const','Class','Unknown','BinVariable','Volatile','Function','Ref','Namespace','Template','TemplateInstance','Macro','MemberPtr','MethodPtr') NOT NULL default 'Unknown',
  `Theadgroup` int(10) unsigned NOT NULL default '0',
  `Tdescription` varchar(255) NOT NULL default '',
  `Tarray` varchar(16) default NULL,
  `Tsrconly` enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  `Tconly` enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  `Tindirect` enum('Yes','No','Unknown') NOT NULL default 'Unknown',
  `Tunmangled` text,
  `Tmemberof` int(10) unsigned NOT NULL default '0',
  `Tinstanceof` int(10) unsigned NOT NULL default '0',
  `Tlibrary` varchar(255) NOT NULL default '',
  `Tclass` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`Tid`),
  UNIQUE KEY `Tname` (`Tname`,`Theadgroup`,`Ttype`,`Tlibrary`),
  KEY `k_Theadergroup` (`Theadgroup`),
  KEY `k_Tsrconly` (`Tsrconly`),
  KEY `k_Tindirect` (`Tindirect`),
  KEY `k_Tconly` (`Tconly`),
  KEY `k_Ttype` (`Ttype`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

