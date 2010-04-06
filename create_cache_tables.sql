-- Component table with Cid replaced by Calias, if the latter is greater than zero;
-- original Cid is preserved in the Crealcid field
DROP TABLE IF EXISTS `cache_Component`;
CREATE TABLE `cache_Component`
    (KEY `k_Cid` (`Cid`), KEY `k_Carch` (`Carch`), KEY `k_Cdistr` (`Cdistr`,`Carch`))
    SELECT IF(Calias > 0, Calias, Cid) AS Cid, Cid AS Crealcid, Carch, Cname, Cversion, Cdistr, Cpackages
    FROM Component
    LEFT JOIN Distribution ON Did=Cdistr;

-- Table with RLid, RLsoname and Cdistr for every RLSid
-- (that is, this table says us how every soname is satisfied in distributions)
DROP TABLE IF EXISTS `cache_RLidRLSoname`;
CREATE TABLE `cache_RLidRLSoname`
    (KEY Cdistr(RLSid,Cdistr,Carch), KEY RLSid(RLid))
    SELECT RLSid, RLid, Cdistr, Carch
    FROM RawLibSoname
    JOIN RawLibrary ON RLSsoname=RLsoname
    JOIN cache_Component ON RLcomponent=Cid;

-- First, create three temporary tables which used to create cache_IntCorrespondance
--   They will be dropped if everything goes well
-- Soname <-> libname correspondance
CREATE TEMPORARY TABLE `tmp_cache_SonameRLname`
    (KEY `k_RLSid`(`RLSid`))
    SELECT DISTINCT RLSid,RLname FROM RawLibSoname, RawLibrary
    WHERE RLsoname=RLSsoname;

-- Table with list of dependency names for every library
CREATE TEMPORARY TABLE `tmp_cache_RLibDepsNames`
    (KEY `k_RLname`(`RLname`))
    SELECT DISTINCT RawLibrary.RLname, tmp_cache_SonameRLname.RLname AS RLdepname FROM RawLibrary
    LEFT JOIN RLibDeps ON RLDrlid=RLid
    LEFT JOIN tmp_cache_SonameRLname ON RLDrlsid=RLSid;
--    UNION DISTINCT
--    SELECT DISTINCT RLibLink.RLLlibname, RawLibrary.RLname AS RLdepname FROM RawLibrary
--    JOIN RLibLink ON RLid=RLLrlid;
-- DELETE FROM tmp_cache_RLibDepsNames WHERE RLname=RLdepname;

-- We'll build 'correspondance' table for interfaces ever included in the spec
CREATE TEMPORARY TABLE `tmp_IntsIncludedEver`
    (KEY `k_Iname`(`Iname`))
    SELECT Iid, Iname, Ilibrary FROM Interface
    JOIN ArchInt ON AIint=Iid
    WHERE AIappearedin > '';

-- Table with RInt<->Int correspondance by name only (libraries are not taken into account)
CREATE TEMPORARY TABLE `tmp_cache_IntRoughCorrespondance`
    (KEY `k_Ilibrary`(`Ilibrary`,`RIlibrary`))
    SELECT Iid, RIid, Ilibrary, RIlibrary FROM tmp_IntsIncludedEver
    LEFT JOIN RawInterface ON Iname=RIname;
DELETE FROM tmp_cache_IntRoughCorrespondance WHERE RIid IS NULL;

-- Correspondance between RawInterface and Interface tables
-- NOTE: Joining with tmp_cache_RLibDepsNames is for 'incorrect' apps
-- that uses interfaces not from DT_NEEDED libs (but from libs loaded as
-- dependencies of the NEEDED ones).
-- This trick currently works for LSB, but theoretically can cause problems
-- with key duplication in the cache_AppRIntLib table below.
DROP TABLE IF EXISTS `cache_IntCorrespondance`;
CREATE TABLE `cache_IntCorrespondance`
    (PRIMARY KEY `Iid` (`Iid`,`RIid`), KEY `RIid` (`RIid`), KEY `Ilibrary` (`Ilibrary`) )
    SELECT DISTINCT  Iid, RIid, Ilibrary FROM tmp_cache_IntRoughCorrespondance
    LEFT JOIN tmp_cache_RLibDepsNames ON Ilibrary=RLname
    WHERE RIlibrary=Ilibrary
    OR tmp_cache_RLibDepsNames.RLdepname=RIlibrary;

-- Temporary table used to create the next one
CREATE TEMPORARY TABLE `tmp_cache_AppRoughLibs`
    (KEY `Aid` (`Aid`))
    SELECT AppRInt.ARIaid AS Aid, RIlibrary, COUNT(ARIriid) AS int_cnt FROM AppRInt
    LEFT JOIN RawInterface ON RIid=ARIriid
    WHERE RIlibrary > ''
    GROUP BY Aid, RIlibrary;

-- Libraries whose interfaces are actually used by applications
DROP TABLE IF EXISTS `cache_AppLibUsage`;
CREATE TABLE `cache_AppLibUsage`
    (PRIMARY KEY `Aid` (`Aid`,`ALrunname`,`RLname`), KEY `ALrunname` (`ALrunname`), KEY `RLname` (`RLname`), KEY `Aarch`(`Aarch`) )
    SELECT DISTINCT Application.Aid, ALrunname, RLname, Aarch, int_cnt FROM tmp_cache_AppRoughLibs
    LEFT JOIN Application ON Application.Aid = tmp_cache_AppRoughLibs.Aid
    JOIN AppLib ON ALaid=Application.Aid
    JOIN RawLibrary ON RLname=RIlibrary AND (RLsoname=ALrunname OR RLrunname=ALrunname);

-- By default, this will be 'big int'; we don't need such a large range
ALTER TABLE cache_AppLibUsage CHANGE int_cnt int_cnt int(10) unsigned NOT NULL default 0;

-- Table with combined information about app<->rawint mapping.
-- We need additional field 'UniqId' here which will be NULL where Iid is NULL and
--  will have unique values for every (ARIaid,RIid,Iid) pair in order to simply calculate
--  number of unique pairs (RIid,Iid) for every application
DROP TABLE IF EXISTS `cache_AppRIntLib`;
CREATE TABLE `cache_AppRIntLib` (PRIMARY KEY (`ARIaid`,`RIid`,`Iid`), KEY `Aarch`(`Aarch`), KEY `RIid`(`RIid`,`Iid`), KEY `RLibRIntId`(`RLibRIntId`), KEY `RIlibrary`(`RIlibrary`), KEY `Iid`(`Iid`,`Aarch`), KEY `UniqId`(`UniqId`))
SELECT Aname, Aversion, Aarch, ARIaid, RawInterface.RIid, RawInterface.RIlibrary, RawInterface.RIname, RIunmangled, RLibRIntId, RIversion, Iid AS Iid, Iid AS UniqId FROM AppRInt
    LEFT JOIN RawInterface ON ARIriid=RawInterface.RIid
    LEFT JOIN cache_IntCorrespondance USING(RIid)
    LEFT JOIN cache_RLibRIntMapping ON cache_RLibRIntMapping.RIname=RawInterface.RIname AND cache_RLibRIntMapping.RIlibrary=RawInterface.RIlibrary
    LEFT JOIN Application ON Aid=ARIaid;

-- Now detect and drop superfluous entries in the cache_AppRIntLib
-- which may come from the tricks with RLibDeps and not-very-correct apps.
-- More precisely, the following situation will cause problems for Navigator:
--
--  Application A has two files, 'aa' and 'bb'; 'aa' depends on libc and libpthread,
--  'bb' depends on libc only. Now let both files use 'connect' symbol which is present
--  in both libc and libpthread. The upload script will honestly mark two different
--  'connect' instances as application dependencies (one from libc, the other from pthread).
--  However, since libpthread is very likely to depend itself on libc, then when building
--  correspondance tables we'll associate 'connect' from libpthread in the Interface table
--  with both 'connect' from libc and 'connect' from libpthread in the RawInterface one.
--  And when building cache_AppRIntLib table, we'll add three records for our application
--  1) 'connect' from libc (direct dependency)
--  2) 'connect' from libpthread (direct dependency)
--  3) 'connect' from libc (indirect dependency through libpthread->libc chain)
--  But oops! We have counted 'connect' from libc twice for our application.
--  This will confuse Navigator and will lead to incorrect numbers in statistics.
-- So let's simply drop superfluous records right now.
CREATE TEMPORARY TABLE tmp_exact_match_ints
(KEY Iid(ARIaid, RIid))
SELECT ARIaid, RIid, Iid FROM cache_AppRIntLib
JOIN Interface USING(Iid)
WHERE RIlibrary=Ilibrary;

CREATE TEMPORARY TABLE tmp_superfluous_ints
(KEY Iid(ARIaid, RIid, Iid))
SELECT ARIaid, RIid, Iid FROM cache_AppRIntLib
JOIN Interface USING(Iid)
WHERE RIlibrary != Ilibrary
AND EXISTS (
    SELECT 1 FROM tmp_exact_match_ints
    WHERE tmp_exact_match_ints.ARIaid = cache_AppRIntLib.ARIaid
    AND tmp_exact_match_ints.RIid = cache_AppRIntLib.RIid
);

DELETE FROM cache_AppRIntLib
WHERE EXISTS (
SELECT 1 FROM tmp_superfluous_ints
    WHERE tmp_superfluous_ints.ARIaid = cache_AppRIntLib.ARIaid
    AND tmp_superfluous_ints.RIid = cache_AppRIntLib.RIid
    AND tmp_superfluous_ints.Iid = cache_AppRIntLib.Iid
);
-- cache_AppRIntLib cleanup finished --

CREATE TEMPORARY TABLE `tmp_DistrCmds`
    (KEY `Did`(`Did`))
    SELECT Cdistr AS Did, COUNT(distinct RCid) AS cmd_cnt FROM cache_Component
    LEFT JOIN RawCommand ON RCcomponent=Cid
    GROUP BY Cdistr;

CREATE TEMPORARY TABLE `tmp_DistrClasses`
    (KEY `Did`(`Did`))
    SELECT Cdistr AS Did, COUNT(distinct RLRCrcid) AS class_cnt FROM cache_Component
    LEFT JOIN RawLibrary ON RLcomponent=Cid
    LEFT JOIN RLibRClass ON RLRCrlid=RLid
    GROUP BY Cdistr;

CREATE TEMPORARY TABLE `tmp_RLibContent`
    (KEY `RLid`(`RLid`))
    SELECT RLRIrlid AS RLid, COUNT(RLRIriid) AS int_cnt FROM RLibRInt
    GROUP BY RLRIrlid;

DROP TABLE IF EXISTS `cache_DistrContent`;
CREATE TABLE `cache_DistrContent`
    (PRIMARY KEY `Did` (`Did`) )
    SELECT cache_Component.Cdistr AS Did, COUNT(distinct cache_Component.Cid) AS comp_cnt, COUNT(distinct RawLibrary.RLid) AS lib_cnt, SUM(tmp_RLibContent.int_cnt) AS int_cnt, cmd_cnt, class_cnt FROM cache_Component
    LEFT JOIN RawLibrary ON RLcomponent=Cid
    LEFT JOIN tmp_RLibContent USING(RLid)
    LEFT JOIN tmp_DistrCmds ON Cdistr=Did
    LEFT JOIN tmp_DistrClasses USING(Did)
    GROUP BY cache_Component.Cdistr;

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

-- Split cache_RIntCaseInsensitiveName to several physical tables,
-- 1 million of records each
delimiter //

DROP PROCEDURE IF EXISTS split_cache_RIntCaseInsensitiveNames //

CREATE PROCEDURE split_cache_RIntCaseInsensitiveNames ()
BEGIN
    SET @cnt=(SELECT COUNT(*) FROM cache_RIntCaseInsensitiveNames);
-- total number of tables to be created
    SET @maxId=CEILING((SELECT @cnt/1000000));
    SET @i=1;
-- list of created tables, comma separated (cache_RIntCaseInsensitiveNames_1, cache_RIntCaseInsensitiveNames_2, ...)
    SET @union_tables="";

    label: LOOP
        SET @stmt_text = CONCAT( "DROP TABLE IF EXISTS cache_RIntCaseInsensitiveNames_", @i );
        PREPARE stmt FROM @stmt_text;
        EXECUTE stmt;

        SET @stmt_text = CONCAT( "CREATE TABLE cache_RIntCaseInsensitiveNames_", @i,
        "(`RICINid` int(10) unsigned NOT NULL auto_increment,
            `RIname` varchar(750) character set latin1 collate latin1_general_ci NOT NULL default '',
            `RIunmangled` text character set latin1 collate latin1_general_ci default NULL,
            `RIlibrary` varchar(250) character set latin1 collate latin1_bin NOT NULL default '',
            PRIMARY KEY (`RICINid`), KEY `RIname` (`RIname`,`RIlibrary`),
            KEY `k_RIunmangled`(`RIunmangled`(1000))
        ) ENGINE=MyISAM DEFAULT CHARSET=latin1" );
        PREPARE stmt FROM @stmt_text;
        EXECUTE stmt;

        SET @curIdx=(@i * 1000000);
        SET @oldIdx = @curIdx-1000000;

        SET @stmt_text = CONCAT( "INSERT INTO cache_RIntCaseInsensitiveNames_", @i,
        " SELECT * FROM cache_RIntCaseInsensitiveNames
            WHERE RICINid <= ", @curIdx,
            " AND RICINid > ", @oldIdx );
        PREPARE stmt FROM @stmt_text;
        EXECUTE stmt;

        SET @union_tables = CONCAT(@union_tables, "cache_RIntCaseInsensitiveNames_", @i);
        IF @i < @maxId THEN SET @union_tables = CONCAT(@union_tables, ","); END IF;

        SET @i=@i+1;
        IF @i <= @maxId THEN ITERATE label; END IF;
        LEAVE label;
    END LOOP label;

    DROP TABLE IF EXISTS cache_RIntCaseInsensitiveNames;

    SET @stmt_text = CONCAT( "CREATE TABLE cache_RIntCaseInsensitiveNames (
        `RICINid` int(10) unsigned NOT NULL auto_increment,
        `RIname` varchar(750) character set latin1 collate latin1_general_ci NOT NULL default '',
        `RIunmangled` text character set latin1 collate latin1_general_ci default NULL,
        `RIlibrary` varchar(250) character set latin1 collate latin1_bin NOT NULL default '',
        PRIMARY KEY (`RICINid`), KEY `RIname` (`RIname`,`RIlibrary`),
        KEY `k_RIunmangled`(`RIunmangled`(1000))
    ) ENGINE=MERGE UNION=(",@union_tables,") INSERT_METHOD=LAST DEFAULT CHARSET=latin1" );

    PREPARE stmt FROM @stmt_text;
    EXECUTE stmt;

END
//

delimiter ;

-- CALL split_cache_RIntCaseInsensitiveNames();
DROP PROCEDURE IF EXISTS split_cache_RIntCaseInsensitiveNames;
