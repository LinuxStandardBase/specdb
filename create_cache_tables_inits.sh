#!/bin/bash

#awk 'BEGIN {FS=","}; {print "INSERT INTO cache_RLibRIntMapping VALUES(",$2,",",$5,");"}' RawInterface.init | sort | uniq > cache_RLibRIntMapping.init

# Create a table containing distinct RawInterface names
#awk 'BEGIN {FS=","}; {print "INSERT INTO cache_RIntNames VALUES(",$2,");"}' RawInterface.init | sort | uniq >cache_RIntNames.init
mysql -h $LSBDBHOST -u $LSBUSER --password=$LSBDBPASSWD $LSBDB -e 'DROP TABLE IF EXISTS `cache_RLibRIntMapping`; CREATE TABLE `cache_RLibRIntMapping` (`RIname` varchar(750) character set latin1 collate latin1_bin NOT NULL default "", `RIlibrary` varchar(250) character set latin1 collate latin1_bin NOT NULL default "",  PRIMARY KEY `RIname` (`RIname`,`RIlibrary`)) ENGINE=MyISAM'
mysql -h $LSBDBHOST -u $LSBUSER --password=$LSBDBPASSWD $LSBDB -e 'DROP TABLE IF EXISTS `cache_RIntNames`; CREATE TABLE `cache_RIntNames` (`RIname` varchar(750) character set latin1 collate latin1_bin NOT NULL default "", PRIMARY KEY `RIname` (`RIname`)) ENGINE=MyISAM'
mysql -h $LSBDBHOST -u $LSBUSER --password=$LSBDBPASSWD $LSBDB -e 'DROP TABLE IF EXISTS `cache_RIntCaseInsensitiveNames`; CREATE TABLE `cache_RIntCaseInsensitiveNames` (`RICINid` int(10) unsigned NOT NULL DEFAULT 0, `RIname` varchar(750) character set latin1 collate latin1_general_ci NOT NULL default "", `RIunmangled` text character set latin1 collate latin1_general_ci default NULL, `RIlibrary` varchar(250) character set latin1 collate latin1_bin NOT NULL default "", PRIMARY KEY (`RICINid`), KEY `RIname` (`RIname`,`RIlibrary`), KEY `k_RIunmangled`(`RIunmangled`(1000))) ENGINE=MyISAM' 

LC_ALL=C cut RawInterface.init -f2 | LC_ALL=C sort -u >cache_RIntNames.init
LC_ALL=C cut RawInterface.init -f2,5 | LC_ALL=C sort -u >cache_RLibRIntMapping.init
LC_ALL=C cut RawInterface.init -f2,3,5 | LC_ALL=C sort -u --ignore-case | nl -w1 >cache_RIntCaseInsensitiveNames.init

mysql -h $LSBDBHOST -u $LSBUSER --password=$LSBDBPASSWD $LSBDB -e "LOAD DATA INFILE '$PWD/cache_RIntNames.init' into table cache_RIntNames fields enclosed by '\''; optimize table cache_RIntNames"
mysql -h $LSBDBHOST -u $LSBUSER --password=$LSBDBPASSWD $LSBDB -e "LOAD DATA INFILE '$PWD/cache_RLibRIntMapping.init' into table cache_RLibRIntMapping fields enclosed by '\''; optimize table cache_RLibRIntMapping"
mysql -h $LSBDBHOST -u $LSBUSER --password=$LSBDBPASSWD $LSBDB -e "LOAD DATA INFILE '$PWD/cache_RIntCaseInsensitiveNames.init' into table cache_RIntCaseInsensitiveNames fields enclosed by '\''; optimize table cache_RIntCaseInsensitiveNames"

# For each LSB version, create a table with interfaces included in it (at least at one architecture)
#awk 'BEGIN {FS=","}; {print "DROP TABLE IF EXISTS cache_IntsIncludedIn_",$2,
#    ";\nCREATE TABLE cache_IntsIncludedIn_",$2,   
#    "(KEY `Iid` (`Iid`), KEY `Itype` (`Itype`), KEY `AIarch` (`AIarch`,`Iid`), KEY `LGIlibg` (`LGIlibg`), KEY `Lid` (`Lid`,`AIarch`))",
#    "SELECT Iid,AIarch,Itype,LGIlibg,LGlib AS Lid FROM Interface ",
#    "LEFT JOIN ArchInt ON AIint=Iid ",
#    "LEFT JOIN LGInt ON LGIint=Iid ",
#    "LEFT JOIN LibGroup ON LGIlibg=LGid ",
#    "WHERE AIappearedin <> \"\" AND AIappearedin <= ",$2," AND (AIwithdrawnin IS NULL OR AIwithdrawnin > ",$2,");\n";
#    ";"}' LSBVersion.init | sed s/\\./_/ | sed s/\ \'// | sed s/\'// >cache_IncludedInts.init
    
