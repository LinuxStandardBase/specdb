DROP TABLE IF EXISTS `cache_IntRoughCorrespondance`;
CREATE TABLE `cache_IntRoughCorrespondance` 
    (PRIMARY KEY `Iid` (`Iid`,`RIid`,`Ilibrary`), KEY `RIid` (`RIid`), KEY `Ilib` (`Ilibrary`,`RIlibrary`))
    SELECT Iid, RIid, Ilibrary, RIlibrary FROM Interface,RawInterface
    WHERE RIname=Iname;
    
DROP TABLE IF EXISTS `cache_IntCorrespondance`;
CREATE TABLE `cache_IntCorrespondance`
    (PRIMARY KEY `Iid` (`Iid`,`RIid`), KEY `RIid` (`RIid`), KEY `Ilibrary` (`Ilibrary`) )
    SELECT Iid, RIid, Ilibrary FROM cache_IntRoughCorrespondance
    WHERE RIlibrary=Ilibrary;

DROP TABLE cache_IntRoughCorrespondance;

DROP TABLE IF EXISTS `cache_AppRoughLibs`;
CREATE TABLE `cache_AppRoughLibs`
    (PRIMARY KEY `Aid` (`Aid`,`RIlibrary`))
    SELECT DISTINCT AppRInt.ARIaid AS Aid, RIlibrary FROM AppRInt
    LEFT JOIN RawInterface ON RIid=ARIriid
    WHERE RIlibrary<>'';

DROP TABLE IF EXISTS `cache_AppLibUsage`;
CREATE TABLE `cache_AppLibUsage`
    (PRIMARY KEY `Aid` (`Aid`,`ALrunname`), KEY `ALrunname` (`ALrunname`) )
    SELECT DISTINCT Aid, ALrunname FROM cache_AppRoughLibs
    JOIN AppLib ON ALaid=Aid
    JOIN RawLibrary ON RLname=RIlibrary AND (RLsoname=ALrunname OR RLrunname=ALrunname);
    
DROP TABLE cache_AppRoughLibs;

DROP TABLE IF EXISTS `cache_RLibRIntMapping`;
CREATE TABLE `cache_RLibRIntMapping`
(
--    `RIname` varchar(750) character set latin1 collate latin1_bin NOT NULL default '',
--    `RIlibrary` varchar(200) character set latin1 collate latin1_bin NOT NULL default '',
    PRIMARY KEY `RIname` (`RIname`,`RIlibrary`)
) 
--ENGINE=MyISAM;
    SELECT DISTINCT RIname, RIlibrary FROM RawInterface;

--DROP TABLE IF EXISTS `cache_RLibInterfaceMapping`;
--CREATE TABLE `cache_RLibInterfaceMapping`
--    (PRIMARY KEY `RIname` (`RIname`,`RIlibrary`,`Iid`), KEY `Iid`(`Iid`) )
--    SELECT distinct RawInterface.RIname, RawInterface.RIlibrary, Iid FROM cache_RLibRIntMapping
--    LEFT JOIN RawInterface USING(RIname,RIlibrary)
--    LEFT JOIN cache_IntCorrespondance USING(RIid);
    
DROP TABLE IF EXISTS `cache_RIntNames`;
CREATE TABLE `cache_RIntNames`
(
    `RIname` varchar(750) character set latin1 collate latin1_bin NOT NULL default '',
    PRIMARY KEY `RIname` (`RIname`)
) ENGINE=MyISAM;
--    SELECT distinct RIname FROM RawInterface;

