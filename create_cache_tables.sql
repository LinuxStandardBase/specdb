-- Temporary table used to create the next one
DROP TABLE IF EXISTS `cache_IntRoughCorrespondance`;
CREATE TABLE `cache_IntRoughCorrespondance` 
    (PRIMARY KEY `Iid` (`Iid`,`RIid`,`Ilibrary`), KEY `RIid` (`RIid`), KEY `Ilib` (`Ilibrary`,`RIlibrary`))
    SELECT Iid, RIid, Ilibrary, RIlibrary FROM Interface,RawInterface
    WHERE RIname=Iname;

-- Correspondance between RawInterface and Interface tables    
DROP TABLE IF EXISTS `cache_IntCorrespondance`;
CREATE TABLE `cache_IntCorrespondance`
    (PRIMARY KEY `Iid` (`Iid`,`RIid`), KEY `RIid` (`RIid`), KEY `Ilibrary` (`Ilibrary`) )
    SELECT Iid, RIid, Ilibrary FROM cache_IntRoughCorrespondance
    WHERE RIlibrary=Ilibrary;

DROP TABLE cache_IntRoughCorrespondance;

-- Temporary table used to create the next one
DROP TABLE IF EXISTS `cache_AppRoughLibs`;
CREATE TABLE `cache_AppRoughLibs`
    (PRIMARY KEY `Aid` (`Aid`,`RIlibrary`))
    SELECT DISTINCT AppRInt.ARIaid AS Aid, RIlibrary FROM AppRInt
    LEFT JOIN RawInterface ON RIid=ARIriid
    WHERE RIlibrary<>'';

-- Libraries whose interfaces are actually used by applications
DROP TABLE IF EXISTS `cache_AppLibUsage`;
CREATE TABLE `cache_AppLibUsage`
    (PRIMARY KEY `Aid` (`Aid`,`ALrunname`,`RLname`), KEY `ALrunname` (`ALrunname`), KEY `RLname` (`RLname`), KEY `Aarch`(`Aarch`) )
    SELECT DISTINCT Application.Aid, ALrunname, RLname, Aarch FROM cache_AppRoughLibs
    LEFT JOIN Application ON Application.Aid = cache_AppRoughLibs.Aid
    JOIN AppLib ON ALaid=Application.Aid
    JOIN RawLibrary ON RLname=RIlibrary AND (RLsoname=ALrunname OR RLrunname=ALrunname);
    
DROP TABLE cache_AppRoughLibs;

-- Distinct (RIname, RIlibrary) values
DROP TABLE IF EXISTS `cache_RLibRIntMapping`;
CREATE TABLE `cache_RLibRIntMapping`
(
    PRIMARY KEY `RIname` (`RIname`,`RIlibrary`)
)
SELECT DISTINCT RIname, RIlibrary FROM RawInterface;
ALTER TABLE cache_RLibRIntMapping ADD RLibRIntId int(10) unsigned NOT NULL auto_increment, ADD KEY `RLibRIntId`(`RLibRIntId`);

-- Table with combined information about app<->rawint mapping.
-- We need additional field 'UniqId' here which will be NULL where Iid is NULL and
--	will have unique values for every (ARIaid,RIid,Iid) pair in order to simply calculate
--	number of unique pairs (RIid,Iid) for every application
DROP TABLE IF EXISTS `cache_AppRIntLib`;
CREATE TABLE `cache_AppRIntLib` (PRIMARY KEY (`ARIaid`,`RIid`), KEY `Aarch`(`Aarch`), KEY `RIid`(`RIid`,`Iid`), KEY `RLibRIntId`(`RLibRIntId`), KEY `RIlibrary`(`RIlibrary`), KEY `Iid`(`Iid`,`Aarch`), KEY `UniqId`(`UniqId`))
SELECT Aname, Aversion, Aarch, ARIaid, RawInterface.RIid, RawInterface.RIlibrary, RawInterface.RIname, RIunmangled, RLibRIntId, RIversion, Iid AS Iid, Iid AS UniqId FROM AppRInt
    LEFT JOIN RawInterface ON ARIriid=RawInterface.RIid
    LEFT JOIN cache_IntCorrespondance USING(RIid)
    LEFT JOIN cache_RLibRIntMapping ON cache_RLibRIntMapping.RIname=RawInterface.RIname AND cache_RLibRIntMapping.RIlibrary=RawInterface.RIlibrary
    LEFT JOIN Application ON Aid=ARIaid;

--DROP TABLE IF EXISTS `cache_RLibInterfaceMapping`;
--CREATE TABLE `cache_RLibInterfaceMapping`
--    (PRIMARY KEY `RIname` (`RIname`,`RIlibrary`,`Iid`), KEY `Iid`(`Iid`) )
--    SELECT distinct RawInterface.RIname, RawInterface.RIlibrary, Iid FROM cache_RLibRIntMapping
--    LEFT JOIN RawInterface USING(RIname,RIlibrary)
--    LEFT JOIN cache_IntCorrespondance USING(RIid);

-- Distinct RawInterface names.    
DROP TABLE IF EXISTS `cache_RIntNames`;
CREATE TABLE `cache_RIntNames`
(
    `RIname` varchar(750) character set latin1 collate latin1_bin NOT NULL default '',
    PRIMARY KEY `RIname` (`RIname`)
) ENGINE=MyISAM;
-- Do not perform 'select' here - it is too slow... Data for this table will be created
-- 	by 'create_cache_tables_inits.sh' script
--    SELECT distinct RIname FROM RawInterface;

