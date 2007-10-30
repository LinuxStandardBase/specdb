#!/bin/bash

#awk 'BEGIN {FS=","}; {print "INSERT INTO cache_RLibRIntMapping VALUES(",$2,",",$5,");"}' RawInterface.init | sort | uniq > cache_RLibRIntMapping.init

# Create a table containing distinct RawInterface names
awk 'BEGIN {FS=","}; {print "INSERT INTO cache_RIntNames VALUES(",$2,");"}' RawInterface.init | sort | uniq >cache_RIntNames.init

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
    
