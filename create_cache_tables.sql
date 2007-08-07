DROP TABLE IF EXISTS `cache_IntRoughCorrespondance`;
CREATE TABLE `cache_IntRoughCorrespondance` 
    (KEY `Iid` (`Iid`,`RIid`,`Ilibrary`), KEY `RIid` (`RIid`), KEY `Ilib` (`Ilibrary`,`RIlibrary`))
    SELECT Iid, RIid, Ilibrary, RIlibrary FROM Interface,RawInterface
    WHERE RIname=Iname;
    
DROP TABLE IF EXISTS `cache_IntCorrespondance`;
CREATE TABLE `cache_IntCorrespondance`
    (KEY `Iid` (`Iid`,`RIid`), KEY `RIid` (`RIid`), KEY `Ilibrary` (`Ilibrary`) )
    SELECT Iid, RIid, Ilibrary FROM cache_IntRoughCorrespondance
    WHERE RIlibrary=Ilibrary;

ANALYZE TABLE cache_IntCorrespondance;
