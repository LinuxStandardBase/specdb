
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
DROP TABLE IF EXISTS `FutureTarget`;
CREATE TABLE `FutureTarget` (
  `FTid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `FTname` varchar(255) NOT NULL DEFAULT '',
  `FTgroup` enum('LSB','Desktop','XML','Security','Runtimes','Manageability') NOT NULL DEFAULT 'LSB',
  `FTstatus` enum('Active','Completed','Blocked','Rejected','Inactive','Unknown') NOT NULL DEFAULT 'Unknown',
  `FTlicense` enum('Unknown','Ok','Issues') NOT NULL DEFAULT 'Unknown',
  `FTstable` enum('Yes','No','Unknown') NOT NULL DEFAULT 'Unknown',
  `FTbestpractice` enum('Yes','No','Unknown') NOT NULL DEFAULT 'Unknown',
  `FTrationale` enum('Yes','No','Unknown') NOT NULL DEFAULT 'Unknown',
  `FTsample` enum('Yes','No','In progress') NOT NULL DEFAULT 'No',
  `FTappbat` enum('Yes','No','In progress') NOT NULL DEFAULT 'No',
  `FTdemand` enum('Yes','No','Unknown') NOT NULL DEFAULT 'Unknown',
  `FTdepends` enum('Unknown','Ok','Issues') NOT NULL DEFAULT 'Unknown',
  `FTupstream` enum('Unknown','Ok','Issues') NOT NULL DEFAULT 'Unknown',
  `FTdistros` enum('Unknown','Ok','Issues') NOT NULL DEFAULT 'Unknown',
  `FTversions` enum('Unknown','Ok','Issues') NOT NULL DEFAULT 'Unknown',
  `FTpatches` enum('Unknown','Ok','Issues') NOT NULL DEFAULT 'Unknown',
  `FTdb` enum('Yes','No','In progress') NOT NULL DEFAULT 'No',
  `FTspec` enum('Yes','No','In progress') NOT NULL DEFAULT 'No',
  `FTtest` enum('Yes','No','In progress') NOT NULL DEFAULT 'No',
  `FTdevel` enum('Yes','No','In progress') NOT NULL DEFAULT 'No',
  `FTlsbversion` varchar(5) DEFAULT NULL,
  `FTurl` text,
  PRIMARY KEY (`FTid`),
  UNIQUE KEY `k_FTname` (`FTname`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

