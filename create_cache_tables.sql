-- First, create three temporary tables which used to create cache_IntCorrespondance 
--   They will be dropped if everything goes well
-- Soname <-> libname correspondance
DROP TABLE IF EXISTS `cache_SonameRLname`;
CREATE TABLE `cache_SonameRLname`
    (KEY `k_RLSid`(`RLSid`))
    SELECT DISTINCT RLSid,RLname FROM RawLibSoname, RawLibrary
    WHERE RLsoname=RLSsoname;

-- Table with list of dependancy names for every library
DROP TABLE IF EXISTS `cache_RLibDepsNames`;
CREATE TABLE `cache_RLibDepsNames`
    (KEY `k_RLname`(`RLname`))
    SELECT DISTINCT RawLibrary.RLname, cache_SonameRLname.RLname AS RLdepname FROM RawLibrary 
    LEFT JOIN RLibDeps ON RLDrlid=RLid
    LEFT JOIN cache_SonameRLname ON RLDrlsid=RLSid;

-- Table with RInt<->Int correspondance by name only (libraries are not taken into account)
DROP TABLE IF EXISTS `cache_IntRoughCorrespondance`;
CREATE TABLE `cache_IntRoughCorrespondance` 
    (KEY `k_Ilibrary`(`Ilibrary`,`RIlibrary`))
    SELECT Iid, RIid, Ilibrary, RIlibrary FROM Interface
    LEFT JOIN RawInterface ON Iname=RIname;
DELETE FROM cache_IntRoughCorrespondance WHERE RIid IS NULL;

-- Correspondance between RawInterface and Interface tables
DROP TABLE IF EXISTS `cache_IntCorrespondance`;
CREATE TABLE `cache_IntCorrespondance`
    (PRIMARY KEY `Iid` (`Iid`,`RIid`), KEY `RIid` (`RIid`), KEY `Ilibrary` (`Ilibrary`) )
    SELECT DISTINCT  Iid, RIid, Ilibrary FROM cache_IntRoughCorrespondance
    LEFT JOIN cache_RLibDepsNames ON Ilibrary=RLname
    WHERE RIlibrary=Ilibrary
    OR cache_RLibDepsNames.RLdepname=RIlibrary;

DROP TABLE cache_IntRoughCorrespondance;
DROP TABLE cache_SonameRLname;
DROP TABLE cache_RLibDepsNames;

-- Temporary table used to create the next one
DROP TABLE IF EXISTS `cache_AppRoughLibs`;
CREATE TABLE `cache_AppRoughLibs`
    (KEY `Aid` (`Aid`))
    SELECT DISTINCT AppRInt.ARIaid AS Aid, RIlibrary FROM AppRInt
    LEFT JOIN RawInterface ON RIid=ARIriid
    WHERE RIlibrary>'';

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


-- // Start cache_IntStatus

-- Create table with short interface status (for every version on every arch)
-- 'Short' means that for cases when interface was included, then withdrawn and
--    then included again, we take into account only its last period of being in LSB
DROP TABLE IF EXISTS cache_IntStatus;

CREATE TABLE cache_IntStatus
(PRIMARY KEY (`Iname`,`Ilibrary`,`AIarch`,`AIversion`))
SELECT Iid,Iname,Ilibrary,AIarch, MAX(AIappearedin) AS AIappearedin, MAX(AIwithdrawnin) AS AIwithdrawnin,
		Vname AS AIversion, MAX(AIdeprecatedsince) AS AIdeprecatedsince, SMmandatorysince, SMdeprecatedsince, Ldeprecatedsince
FROM Interface 
LEFT JOIN LGInt ON LGIint=Iid
LEFT JOIN LibGroup ON LGid=LGIlibg
LEFT JOIN Library ON Lid=LGlib
LEFT JOIN SModLib ON LGlib=SMLlid
LEFT JOIN SubModule ON SMid=SMLsmid
LEFT JOIN ArchInt ON AIint=Iid
LEFT JOIN Version ON Vid=AIversion 
WHERE AIappearedin > ''
GROUP BY Iid,AIarch,Vid;

ALTER TABLE cache_IntStatus ADD `ISstatus` enum('Included','Deprecated','Optional','Withdrawn') NOT NULL DEFAULT 'Included';
ALTER TABLE cache_IntStatus ADD `ISstatustext` VARCHAR(255) NOT NULL DEFAULT '';

-- For symbols which were included, then withdrawn and then included again
UPDATE cache_IntStatus SET AIwithdrawnin=NULL WHERE AIwithdrawnin < AIappearedin;

-- No sense in 'mandatorysince' for excluded symbols
UPDATE cache_IntStatus SET SMmandatorysince='' WHERE AIwithdrawnin IS NOT NULL;

-- Deprecation doesn't matter for withdrawn symbols
UPDATE cache_IntStatus SET AIdeprecatedsince=NULL WHERE AIdeprecatedsince < AIwithdrawnin;
UPDATE cache_IntStatus SET SMdeprecatedsince=NULL WHERE SMdeprecatedsince < AIwithdrawnin;
UPDATE cache_IntStatus SET Ldeprecatedsince=NULL WHERE Ldeprecatedsince < AIwithdrawnin;

-- Though this could be considered as db inconsistency, this actually doesn't break anything else,
-- so let's handle this here
UPDATE cache_IntStatus SET AIdeprecatedsince=Ldeprecatedsince WHERE AIdeprecatedsince > Ldeprecatedsince OR AIdeprecatedsince IS NULL;
UPDATE cache_IntStatus SET AIdeprecatedsince=SMdeprecatedsince WHERE AIdeprecatedsince > SMdeprecatedsince OR AIdeprecatedsince IS NULL;

UPDATE cache_IntStatus SET AIappearedin='' WHERE AIdeprecatedsince IS NOT NULL OR SMdeprecatedsince IS NOT NULL OR Ldeprecatedsince IS NOT NULL;
UPDATE cache_IntStatus SET ISstatus='Deprecated', ISstatustext=concat("Deprecated since ",AIdeprecatedsince) WHERE AIdeprecatedsince IS NOT NULL;
UPDATE cache_IntStatus SET ISstatus='Withdrawn', ISstatustext=concat("Withdrawn in ",AIwithdrawnin) WHERE AIwithdrawnin IS NOT NULL;
UPDATE cache_IntStatus SET ISstatus='Included', ISstatustext=concat("Included since ",AIappearedin) WHERE AIappearedin > '' AND SMmandatorysince > '';
UPDATE cache_IntStatus SET ISstatus='Optional', ISstatustext=concat("Trial since ",AIappearedin) WHERE AIappearedin > '' AND SMmandatorysince='' AND AIwithdrawnin IS NULL;

-- Update those records that don't have ArchInt entries
UPDATE cache_IntStatus SET ISstatus='Withdrawn', ISstatustext="Not in LSB" WHERE ISstatus<>'Withdrawn' AND (AIappearedin='' OR AIappearedin IS NULL) AND AIdeprecatedsince IS NULL;

ALTER TABLE cache_IntStatus ADD KEY `k_ArchStatus`(`AIarch`,`ISstatus`);

-- Some included interfaces can have generic and 7 arch-specific records
-- (due to symbol versions); let's remove the generic one for such cases
-- from the cache_IntStatus, but save them in the cache_ExtraGenericRecords
-- (the case when the number of arch-specific records ge 1 but lesser than 7 
-- shouldbe considered as db inconsistency)
CREATE TEMPORARY TABLE tmp_ArchSpecificInts
(KEY `k_Iid`(`Iid`))
SELECT Iid FROM cache_IntStatus 
WHERE AIarch>1 AND ISstatus <>'Withdrawn';

DROP TABLE IF EXISTS cache_ExtraGenericRecords;
CREATE TABLE cache_ExtraGenericRecords
(KEY `k_Iid`(`Iid`))
SELECT Iid, Iname, Ilibrary, AIversion, ISstatus, ISstatustext FROM cache_IntStatus 
JOIN tmp_ArchSpecificInts USING(Iid)
WHERE AIarch=1 AND ISstatus <>'Withdrawn';

DELETE FROM cache_IntStatus WHERE Iid IN (
  SELECT Iid FROM cache_ExtraGenericRecords
) AND AIarch=1 AND ISstatus <> 'Withdrawn';

CREATE TEMPORARY TABLE tmp_ExtraWithdrawnGenericRecords
(KEY `k_Iid`(`Iid`))
SELECT T1.Iid FROM cache_IntStatus T1, cache_IntStatus T2
WHERE T1.AIarch=1 AND T2.AIarch>1
AND T1.Iname=T2.Iname
AND T1.Ilibrary=T2.Ilibrary
AND T1.AIversion=T2.AIversion;

DELETE FROM cache_IntStatus WHERE Iid IN (
  SELECT Iid FROM tmp_ExtraWithdrawnGenericRecords
) AND AIarch=1;

-- These fields are not required during table usage
ALTER TABLE cache_IntStatus DROP AIappearedin;
ALTER TABLE cache_IntStatus DROP AIwithdrawnin;
ALTER TABLE cache_IntStatus DROP AIdeprecatedsince;
ALTER TABLE cache_IntStatus DROP Ldeprecatedsince;
ALTER TABLE cache_IntStatus DROP SMdeprecatedsince;
ALTER TABLE cache_IntStatus DROP SMmandatorysince;
ALTER TABLE cache_IntStatus DROP Iid;

-- // Finished with cache_IntStatus
