
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
DROP TABLE IF EXISTS `SourceQualifier`;
CREATE TABLE `SourceQualifier` (
  `SQshid` int(12) NOT NULL,
  `SQpos` int(8) NOT NULL DEFAULT '0',
  `SQqual` enum('const','volatile','restrict','cv-qualifier','inline','static','virtual','explicit','decl-specifier','declares','private','public','protected','access-specifier','throw','operator','abstract_attribute','storage-class-specifier','linkage','size','base','parent','definition_at','return_type','is_function','parameter','overloads','is_template','template_parameter','export','specializes','is_template-id','template-id_parameter','default_value','initializer','ctor-init','array_length','friend_link','dependency','precedence','link-to','scoped','declare-scope','typename','pointer-to','reference-to','modifier-to','macro','macro_bottom','GNU_attribute','header','order','api','library','iid','hides','is_branch','no-escape','compliant','incompliant','alteration','entity','_Shadow_id','_Shadow_type','_Shadow_value','_Shadow_kind','definition_here','_Parent_pos','_Anti_class','_TemplateParameter','child','_Standard_min','_Standard_max','_New','_Dont_print') NOT NULL DEFAULT 'const',
  `SQvalshid` int(12) DEFAULT NULL,
  PRIMARY KEY (`SQshid`,`SQpos`,`SQqual`),
  KEY `k_SQvalshid` (`SQvalshid`),
  KEY `k_SQqual` (`SQqual`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

