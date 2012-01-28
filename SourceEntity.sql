
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
DROP TABLE IF EXISTS `SourceEntity`;
CREATE TABLE `SourceEntity` (
  `SEid` int(10) NOT NULL AUTO_INCREMENT,
  `SEbinid` int(10) unsigned DEFAULT NULL,
  `SEshid` int(12) NOT NULL,
  `SEname` varchar(255) CHARACTER SET latin1 COLLATE latin1_bin NOT NULL DEFAULT '',
  `SEparent` int(10) DEFAULT NULL,
  `SEtype` enum('namespace','using-declaration','using-directive','class','struct','typedef','variable','function','friend','code_block','macro','include','header') DEFAULT NULL,
  `SEheader` int(10) unsigned NOT NULL DEFAULT '0',
  `SEapi` tinyint(1) NOT NULL DEFAULT '1',
  `SEneedbin` tinyint(1) NOT NULL DEFAULT '0',
  `SEstandard` int(10) unsigned DEFAULT '0',
  `SErefspec` int(10) unsigned NOT NULL DEFAULT '0',
  `SEdocumented` enum('Yes','No','Unknown') NOT NULL DEFAULT 'Unknown',
  `SEcomment` varchar(255) DEFAULT NULL,
  `SEcandidatefor` varchar(255) DEFAULT NULL,
  `SEdeprecatedsince` varchar(255) DEFAULT NULL,
  `SEaccessible` tinyint(1) NOT NULL DEFAULT '1',
  `SEurl` varchar(255) DEFAULT NULL,
  `SElibrary` varchar(200) CHARACTER SET latin1 COLLATE latin1_bin DEFAULT NULL,
  PRIMARY KEY (`SEid`),
  KEY `k_SEname` (`SEname`,`SElibrary`,`SEid`),
  KEY `k_SEstandard` (`SEstandard`),
  KEY `k_SEdocumented` (`SEdocumented`),
  KEY `k_SEheader` (`SEheader`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

