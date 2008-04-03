#!/bin/bash

#awk 'BEGIN {FS=","}; {print "INSERT INTO cache_RLibRIntMapping VALUES(",$2,",",$5,");"}' RawInterface.init | sort | uniq > cache_RLibRIntMapping.init

# Create a table containing distinct RawInterface names
#awk 'BEGIN {FS=","}; {print "INSERT INTO cache_RIntNames VALUES(",$2,");"}' RawInterface.init | sort | uniq >cache_RIntNames.init
mysql -h $LSBDBHOST -u $LSBUSER --password=$LSBDBPASSWD $LSBDB -e 'DROP TABLE IF EXISTS `cache_RLibRIntMapping`; CREATE TABLE `cache_RLibRIntMapping` (`RIname` varchar(750) character set latin1 collate latin1_bin NOT NULL default "", `RIlibrary` varchar(250) character set latin1 collate latin1_bin NOT NULL default "",  PRIMARY KEY `RIname` (`RIname`,`RIlibrary`)) ENGINE=MyISAM'
mysql -h $LSBDBHOST -u $LSBUSER --password=$LSBDBPASSWD $LSBDB -e 'DROP TABLE IF EXISTS `cache_RIntNames`; CREATE TABLE `cache_RIntNames` (`RIname` varchar(750) character set latin1 collate latin1_bin NOT NULL default "", PRIMARY KEY `RIname` (`RIname`)) ENGINE=MyISAM'

LC_ALL=C cut RawInterface.init -f2 | LC_ALL=C sort | LC_ALL=C uniq >cache_RIntNames.init
LC_ALL=C cut RawInterface.init -f2,5 | LC_ALL=C sort | LC_ALL=C uniq >cache_RLibRIntMapping.init

mysql -h $LSBDBHOST -u $LSBUSER --password=$LSBDBPASSWD $LSBDB -e "LOAD DATA INFILE '$PWD/cache_RIntNames.init' into table cache_RIntNames fields enclosed by '\''"
mysql -h $LSBDBHOST -u $LSBUSER --password=$LSBDBPASSWD $LSBDB -e "LOAD DATA INFILE '$PWD/cache_RLibRIntMapping.init' into table cache_RLibRIntMapping fields enclosed by '\''"

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
    
