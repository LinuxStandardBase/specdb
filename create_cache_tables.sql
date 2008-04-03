-- Temporary table used to create the next one
DROP TABLE IF EXISTS `cache_IntRoughCorrespondance`;
CREATE TABLE `cache_IntRoughCorrespondance` 
    SELECT Iid, RIid, Ilibrary, RIlibrary FROM Interface LEFT JOIN RawInterface ON Iname=RIname;
DELETE FROM cache_IntRoughCorrespondance WHERE RIid IS NULL;

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
    (KEY `Aid` (`Aid`))
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

-- Two temporary tables to create the third one with distributions content
CREATE TEMPORARY TABLE `tmp_DistrCmds`
    (KEY `Did`(`Did`))
    SELECT Cdistr AS Did, COUNT(distinct RCid) AS cmd_cnt FROM Component
    LEFT JOIN RawCommand ON RCcomponent=Cid
    GROUP BY Cdistr;
    
CREATE TEMPORARY TABLE `tmp_DistrClasses`
    (KEY `Did`(`Did`))
    SELECT Cdistr AS Did, COUNT(distinct RLRCrcid) AS class_cnt FROM Component
    LEFT JOIN RawLibrary ON RLcomponent=Cid
    LEFT JOIN RLibRClass ON RLRCrlid=RLid
    GROUP BY Cdistr;

DROP TABLE IF EXISTS `cache_DistrContent`;
CREATE TABLE `cache_DistrContent`
    (PRIMARY KEY `Did` (`Did`) )
    SELECT Cdistr AS Did, COUNT(distinct Cid) AS comp_cnt, COUNT(distinct RLid) AS lib_cnt, COUNT(distinct RLRIriid) AS int_cnt, cmd_cnt, class_cnt FROM Component
    LEFT JOIN RawLibrary ON RLcomponent=Cid
    LEFT JOIN RLibRInt ON RLRIrlid=RLid
    LEFT JOIN tmp_DistrCmds ON Cdistr=Did
    LEFT JOIN tmp_DistrClasses USING(Did)
    GROUP BY Cdistr;
