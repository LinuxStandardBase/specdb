SET SESSION myisam_sort_buffer_size = 30 * 1024 * 1024;

delimiter //

DROP PROCEDURE IF EXISTS create_included_ints_table //

CREATE PROCEDURE create_included_ints_table ()
BEGIN
    DECLARE version CHAR(255);
    DECLARE arch INT(10) UNSIGNED;
    DECLARE table_name char(255);
    DECLARE table_arch_name char(255);
    DECLARE table_correspondance_name char(255);
    DECLARE done INT DEFAULT 0;
    DECLARE done_arch INT DEFAULT 0;
    DECLARE version_cur CURSOR FOR SELECT LVvalue FROM LSBVersion;
    DECLARE arch_cur CURSOR FOR SELECT Aid FROM Architecture;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;

    OPEN version_cur;
    REPEAT
    FETCH version_cur INTO version;
    IF NOT done THEN
        SET @version_name = REPLACE( version, '.', '_' );
        SET @table_name = CONCAT( 'cache_IntsIncludedIn_', @version_name );
        SET @stmt_text = CONCAT( "DROP TABLE IF EXISTS ", @table_name);
        PREPARE stmt FROM @stmt_text;
        EXECUTE stmt;

        SET @stmt_text = CONCAT( "CREATE TABLE ", @table_name,
            "(KEY `Iid` (`Iid`), KEY `Itype` (`Itype`,`Itestable`), KEY `AIarch` (`AIarch`,`Iid`), KEY `ISsid`(`ISsid`), KEY `LGIlibg` (`LGIlibg`), KEY `Lid` (`Lid`,`AIarch`), KEY `Idocumented` (`Idocumented`), KEY `AIdeprecatedsince`(`AIdeprecatedsince`) )
            SELECT Iid, AIarch, Itype, LGIlibg, LGlib AS Lid, ISsid, Itestable, Idocumented, AIdeprecatedsince FROM Interface
            LEFT JOIN ArchInt ON AIint=Iid
            LEFT JOIN IntStd ON ISiid=Iid
            LEFT JOIN LGInt ON LGIint=Iid
            LEFT JOIN LibGroup ON LGIlibg=LGid
            WHERE AIappearedin > '' AND AIappearedin <= '", version, "' AND (AIwithdrawnin IS NULL OR AIwithdrawnin > '", version, "')
            AND ( ISsid IS NULL OR (ISappearedin > '' AND ISappearedin <= '", version, "' AND ISwithdrawnin IS NULL OR ISwithdrawnin > '", version, "') )");
        PREPARE stmt FROM @stmt_text;
        EXECUTE stmt;

        SET @table_correspondance_name = CONCAT( @table_name, "_correspondance" );
        SET @stmt_text = CONCAT( "DROP TABLE IF EXISTS ", @table_correspondance_name);
        PREPARE stmt FROM @stmt_text;
        EXECUTE stmt;

        SET @stmt_text = CONCAT( "CREATE TABLE ", @table_correspondance_name,
            " (PRIMARY KEY `Iid` (`Iid`,`RIid`,`AIarch`), KEY `RIid` (`RIid`), KEY `Ilibrary` (`Ilibrary`) )
              SELECT ", @table_name, ".Iid, RIid, AIarch, Ilibrary FROM ", @table_name,
            " LEFT JOIN cache_IntCorrespondance USING(Iid) GROUP BY ", @table_name, ".Iid, RIid, AIarch"
        );
        PREPARE stmt FROM @stmt_text;
        EXECUTE stmt;

        OPEN arch_cur;
        REPEAT
        FETCH arch_cur INTO arch;
        SET @table_arch_name = CONCAT( @table_name, "_on_", arch );
        SET @stmt_text = CONCAT( "DROP TABLE IF EXISTS ", @table_arch_name);
        PREPARE stmt FROM @stmt_text;
        EXECUTE stmt;

        SET @stmt_text = CONCAT( "CREATE TABLE ", @table_arch_name,
            "(KEY `Iid` (`Iid`), KEY `Itype` (`Itype`,`Itestable`), KEY `AIarch` (`AIarch`,`Iid`), KEY `ISsid`(`ISsid`), KEY `LGIlibg` (`LGIlibg`), KEY `Lid` (`Lid`,`AIarch`), KEY `Idocumented`(`Idocumented`), KEY `AIdeprecatedsince`(`AIdeprecatedsince`))
            SELECT Iid, max(AIarch) as AIarch, Itype, LGIlibg, Lid, ISsid, Itestable, Idocumented, AIdeprecatedsince FROM ", @table_name,
            " WHERE AIarch=1 OR AIarch=", arch,
            " GROUP BY Iid");
        PREPARE stmt FROM @stmt_text;
        EXECUTE stmt;

        SET @table_correspondance_name = CONCAT( @table_arch_name, "_correspondance" );
            SET @stmt_text = CONCAT( "DROP TABLE IF EXISTS ", @table_correspondance_name);
                PREPARE stmt FROM @stmt_text;
            EXECUTE stmt;

        SET @stmt_text = CONCAT( "CREATE TABLE ", @table_correspondance_name,
            " (PRIMARY KEY `Iid` (`Iid`,`RIid`,`AIarch`), KEY `RIid` (`RIid`), KEY `Ilibrary` (`Ilibrary`) )
              SELECT ", @table_arch_name, ".Iid, RIid, AIarch, Ilibrary FROM ", @table_arch_name,
            " LEFT JOIN cache_IntCorrespondance USING(Iid)"
            );
        PREPARE stmt FROM @stmt_text;
        EXECUTE stmt;

        UNTIL done END REPEAT;
        SET done = 0;
        CLOSE arch_cur;

    END IF;
    UNTIL done END REPEAT;

    CLOSE version_cur;

    DROP TABLE IF EXISTS cache_IntsIncludedEver;

    SET @stmt_text = CONCAT( "CREATE TABLE cache_IntsIncludedEver
        (KEY `Iid` (`Iid`), KEY `Itype` (`Itype`,`Itestable`), KEY `AIarch` (`AIarch`,`Iid`), KEY `ISsid`(`ISsid`), KEY `LGIlibg` (`LGIlibg`), KEY `Lid` (`Lid`,`AIarch`), KEY `Idocumented` (`Idocumented`), KEY `AIdeprecatedsince`(`AIdeprecatedsince`) )
        SELECT Iid, AIarch, Itype, LGIlibg, LGlib AS Lid, ISsid, Itestable, Idocumented, AIdeprecatedsince FROM Interface
        LEFT JOIN ArchInt ON AIint=Iid
        LEFT JOIN IntStd ON ISiid=Iid
        LEFT JOIN LGInt ON LGIint=Iid
        LEFT JOIN LibGroup ON LGIlibg=LGid
        WHERE AIappearedin > ''
        AND (ISsid IS NULL OR ISappearedin > '')");
    PREPARE stmt FROM @stmt_text;
    EXECUTE stmt;

    OPEN arch_cur;
    SET done = 0;
    REPEAT
        FETCH arch_cur INTO arch;
        SET @table_arch_name = CONCAT( "cache_IntsIncludedEver_on_", arch );
        SET @stmt_text = CONCAT( "DROP TABLE IF EXISTS ", @table_arch_name);
        PREPARE stmt FROM @stmt_text;
        EXECUTE stmt;

        SET @stmt_text = CONCAT( "CREATE TABLE ", @table_arch_name,
            "(KEY `Iid` (`Iid`), KEY `Itype` (`Itype`,`Itestable`), KEY `AIarch` (`AIarch`,`Iid`), KEY `ISsid`(`ISsid`), KEY `LGIlibg` (`LGIlibg`), KEY `Lid` (`Lid`,`AIarch`), KEY `Idocumented`(`Idocumented`), KEY `AIdeprecatedsince`(`AIdeprecatedsince`))
            SELECT Iid, MAX(AIarch) AS AIarch, Itype, LGIlibg, Lid, ISsid, Itestable, Idocumented, AIdeprecatedsince FROM cache_IntsIncludedEver
            WHERE AIarch=1 OR AIarch=", arch,
            " GROUP BY Iid");
        PREPARE stmt FROM @stmt_text;
        EXECUTE stmt;

    UNTIL done END REPEAT;

    CLOSE arch_cur;
END
//

DROP PROCEDURE IF EXISTS create_cache_Component_tables //

CREATE PROCEDURE create_cache_Component_tables ()
BEGIN
    DECLARE arch INT(10) UNSIGNED;
    DECLARE table_arch_name char(255);
    DECLARE done INT DEFAULT 0;
    DECLARE arch_cur CURSOR FOR SELECT Aid FROM Architecture;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;

-- cache_Component_on_<arch> for all supported architectures
-- Note that simple cache_Component itself is created by the create_cache_tables.sql
    OPEN arch_cur;
    SET done = 0;
    REPEAT
        FETCH arch_cur INTO arch;
        SET @table_arch_name = CONCAT( "cache_Component_on_", arch );
        SET @stmt_text = CONCAT( "DROP TABLE IF EXISTS ", @table_arch_name);
        PREPARE stmt FROM @stmt_text;
        EXECUTE stmt;

        SET @stmt_text = CONCAT( "CREATE TABLE ", @table_arch_name,
            "(KEY `k_Cid` (`Cid`), KEY `k_Carch` (`Carch`), KEY `k_Cdistr` (`Cdistr`,`Carch`))
            SELECT IF(Calias > 0, Calias, Cid) AS Cid, Cid AS Crealcid, Carch, Cname, Cversion, Cdistr, Cpackages
            FROM Component
            LEFT JOIN Distribution ON Did=Cdistr
            WHERE Darch=", arch, " OR (Darch IS NULL AND Carch=", arch, ")");
        PREPARE stmt FROM @stmt_text;
        EXECUTE stmt;
    UNTIL done END REPEAT;

    CLOSE arch_cur;
END
//

DROP PROCEDURE IF EXISTS fill_uniq_pairs_id //

CREATE PROCEDURE fill_uniq_pairs_id ()
BEGIN
    DECLARE app_id INT(10) UNSIGNED;
    DECLARE rawint_id INT(10) UNSIGNED;
    DECLARE int_id INT(10) UNSIGNED;
    DECLARE done INT DEFAULT 0;
    DECLARE uniq_id INT(10) UNSIGNED DEFAULT 1;
    DECLARE records_cur CURSOR FOR SELECT ARIaid, RIid, Iid FROM cache_AppRIntLib WHERE Iid IS NOT NULL;
    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;

    OPEN records_cur;

    REPEAT
    FETCH records_cur INTO app_id, rawint_id, int_id;
    IF NOT done THEN
        UPDATE cache_AppRIntLib SET UniqId=uniq_id WHERE ARIaid=app_id AND RIid=rawint_id AND Iid=int_id;
        SET uniq_id = uniq_id + 1;
    END IF;
    UNTIL done END REPEAT;

    CLOSE records_cur;
END
//

-- Procedure used in consistency check
DROP PROCEDURE IF EXISTS count_libs_presence //

CREATE PROCEDURE count_libs_presence ()
BEGIN
    DECLARE libname varchar(750);
    DECLARE alname varchar(750);
    DECLARE done INT DEFAULT 0;
    DECLARE cur_1 cursor for SELECT ALsoname, CONCAT(ALsoname,'%') FROM ApprovedLibrary;
    DECLARE continue handler for sqlstate '02000' set done = 1;

    OPEN cur_1;

    REPEAT
    fetch cur_1 into alname, libname;
        IF NOT done THEN
        SET @stmt_text = CONCAT("INSERT INTO tmp_Result
            SELECT ALsoname, ALlibname, COUNT(DISTINCT Cdistr) AS distr_cnt FROM ApprovedLibrary, RawLibrary
            LEFT JOIN cache_Component ON Cid=RLcomponent
            WHERE ALsoname='", alname ,"'
            AND RLsoname LIKE '", libname, "'
            GROUP BY ALsoname ORDER BY distr_cnt DESC, ALlibname, ALsoname" );
        PREPARE stmt FROM @stmt_text;
        EXECUTE stmt;
    END IF;

    until done end REPEAT;

    close cur_1;

END
//

-- Detect all libraries loaded as dependencies (either directly or
-- through dependency chain) of libraries with given name
-- in every distribution
DROP PROCEDURE IF EXISTS fill_lib_loaded_deps_full //

CREATE PROCEDURE fill_lib_loaded_deps_full (IN LSBTMPDB VARCHAR(255), IN par_LibName VARCHAR(255) )
BEGIN
    DECLARE done INT DEFAULT 0;

-- Init tmp_LibDeps with direct library dependencies
    SET @stmt_text = CONCAT("INSERT INTO ", LSBTMPDB, ".tmp_LibDeps
        SELECT RL1.RLid AS RLid, C2.RLid AS DepId
        FROM RawLibrary RL1
        JOIN cache_Component C1 ON C1.Cid=RL1.RLcomponent
        JOIN RLibDeps ON RLDrlid=RL1.RLid
        JOIN cache_RLidRLSoname C2 ON RLDrlsid=RLSid
        WHERE RL1.RLname='", par_LibName, "' AND C1.Cdistr=C2.Cdistr
        AND C1.Carch=C2.Carch;");
    PREPARE stmt FROM @stmt_text;
    EXECUTE stmt;

-- This table will store a list of dependencies added during the last iteration.
-- At the first step, these were direct dependencies.
    SET @stmt_text = CONCAT("CREATE TEMPORARY TABLE tmp_LastDeps
        (KEY k_RLid(RLid), KEY k_DepId(DepId))
        SELECT RLid, DepId FROM ", LSBTMPDB, ".tmp_LibDeps;");
    PREPARE stmt FROM @stmt_text;
    EXECUTE stmt;

-- This will be a list of newly selected dependencies
    CREATE TEMPORARY TABLE tmp_NewDeps (
        RLid INT(10) UNSIGNED,
        DepId INT(10) UNSIGNED,
        KEY k_RLid(RLid),
        KEY k_DepId(DepId)
    );

-- Now recursively process library dependencies.
-- On every step, we'll take dependencies of libraries added during the previous step
-- and select only those that are not added to tmp_LibDeps yet.
    REPEAT
        SET @stmt_text = CONCAT("INSERT INTO tmp_NewDeps
            SELECT DISTINCT tmp_LastDeps.RLid AS RLid, C2.RLid AS DepId
            FROM tmp_LastDeps
            JOIN RawLibrary RL1 ON tmp_LastDeps.DepId=RL1.RLid
            JOIN cache_Component C1 ON C1.Cid=RL1.RLcomponent
            JOIN RLibDeps ON RLDrlid=RL1.RLid
            JOIN cache_RLidRLSoname C2 ON RLDrlsid=RLSid
            WHERE C1.Cdistr=C2.Cdistr
            AND C1.Carch=C2.Carch
            AND NOT EXISTS (
             SELECT 1 FROM ", LSBTMPDB, ".tmp_LibDeps
             WHERE tmp_LibDeps.RLid=tmp_LastDeps.RLid
             AND tmp_LibDeps.DepId = C2.RLid
            );");
        PREPARE stmt FROM @stmt_text;
        -- EXECUTE stmt;

        SET @found=(SELECT 1 FROM tmp_NewDeps LIMIT 1);
        IF @found IS NOT NULL THEN
            SET @stmt_text = CONCAT("INSERT INTO ", LSBTMPDB, ".tmp_LibDeps SELECT * FROM tmp_NewDeps;");
            PREPARE stmt FROM @stmt_text;
            EXECUTE stmt;
            DELETE FROM tmp_LastDeps;
            INSERT INTO tmp_LastDeps SELECT * FROM tmp_NewDeps;
            DELETE FROM tmp_NewDeps;
        ELSE
            SET done = 1;
        END IF;
    UNTIL done END REPEAT;

    DROP TABLE tmp_NewDeps;
    DROP TABLE tmp_LastDeps;
END
//

-- The same as above, but only considers two steps of dependency resolution,
-- not the full chain
DROP PROCEDURE IF EXISTS fill_lib_loaded_deps_limited //

CREATE PROCEDURE fill_lib_loaded_deps_limited (IN LSBTMPDB VARCHAR(255), IN par_LibName VARCHAR(255) )
BEGIN
    DECLARE done INT DEFAULT 0;

-- Init tmp_LibDeps with direct library dependencies
    SET @stmt_text = CONCAT("INSERT INTO ", LSBTMPDB, ".tmp_LibDeps
        SELECT RL1.RLid AS RLid, C2.RLid AS DepId
        FROM RawLibrary RL1
        JOIN cache_Component C1 ON C1.Cid=RL1.RLcomponent
        JOIN RLibDeps ON RLDrlid=RL1.RLid
        JOIN cache_RLidRLSoname C2 ON RLDrlsid=RLSid
        WHERE RL1.RLname='", par_LibName, "' AND C1.Cdistr=C2.Cdistr
        AND C1.Carch=C2.Carch;");
    PREPARE stmt FROM @stmt_text;
    EXECUTE stmt;

-- This table will store a list of dependencies added during the last iteration.
-- At the first step, these were direct dependencies.
    SET @stmt_text = CONCAT("CREATE TEMPORARY TABLE tmp_LastDeps
        (KEY k_RLid(RLid), KEY k_DepId(DepId))
        SELECT RLid, DepId FROM ", LSBTMPDB, ".tmp_LibDeps;");
    PREPARE stmt FROM @stmt_text;
    EXECUTE stmt;

-- This will be a list of newly selected dependencies
    CREATE TEMPORARY TABLE tmp_NewDeps (
        RLid INT(10) UNSIGNED,
        DepId INT(10) UNSIGNED,
        KEY k_RLid(RLid),
        KEY k_DepId(DepId)
    );

-- No cycles here - only add dependecies of library direct dependencies
    SET @stmt_text = CONCAT("INSERT INTO tmp_NewDeps
        SELECT DISTINCT tmp_LastDeps.RLid AS RLid, C2.RLid AS DepId
        FROM tmp_LastDeps
        JOIN RawLibrary RL1 ON tmp_LastDeps.DepId=RL1.RLid
        JOIN cache_Component C1 ON C1.Cid=RL1.RLcomponent
        JOIN RLibDeps ON RLDrlid=RL1.RLid
        JOIN cache_RLidRLSoname C2 ON RLDrlsid=RLSid
        WHERE C1.Cdistr=C2.Cdistr
        AND C1.Carch=C2.Carch
        AND NOT EXISTS (
         SELECT 1 FROM ", LSBTMPDB, ".tmp_LibDeps
         WHERE tmp_LibDeps.RLid=tmp_LastDeps.RLid
         AND tmp_LibDeps.DepId = C2.RLid
        );");
    PREPARE stmt FROM @stmt_text;
    -- EXECUTE stmt;

    SET @found=(SELECT 1 FROM tmp_NewDeps LIMIT 1);
    IF @found IS NOT NULL THEN
        SET @stmt_text = CONCAT("INSERT INTO ", LSBTMPDB, ".tmp_LibDeps SELECT * FROM tmp_NewDeps;");
        PREPARE stmt FROM @stmt_text;
        EXECUTE stmt;
    END IF;

    DROP TABLE tmp_NewDeps;
    DROP TABLE tmp_LastDeps;
END
//

delimiter ;

# create cache_IntsIncludedIn* tables
CALL create_included_ints_table();

CALL fill_uniq_pairs_id();

CALL create_cache_Component_tables();

# Clean up tables - not every architecture was present in every LSB version
DELETE FROM cache_IntsIncludedIn_1_0_on_10;
DELETE FROM cache_IntsIncludedIn_1_0_on_11;
DELETE FROM cache_IntsIncludedIn_1_0_on_12;
DELETE FROM cache_IntsIncludedIn_1_0_on_3;
DELETE FROM cache_IntsIncludedIn_1_0_on_6;
DELETE FROM cache_IntsIncludedIn_1_0_on_9;
DELETE FROM cache_IntsIncludedIn_1_1_on_10;
DELETE FROM cache_IntsIncludedIn_1_1_on_11;
DELETE FROM cache_IntsIncludedIn_1_1_on_12;
DELETE FROM cache_IntsIncludedIn_1_1_on_3;
DELETE FROM cache_IntsIncludedIn_1_1_on_6;
DELETE FROM cache_IntsIncludedIn_1_1_on_9;
DELETE FROM cache_IntsIncludedIn_1_2_on_10;
DELETE FROM cache_IntsIncludedIn_1_2_on_11;
DELETE FROM cache_IntsIncludedIn_1_2_on_12;
DELETE FROM cache_IntsIncludedIn_1_2_on_3;
DELETE FROM cache_IntsIncludedIn_1_2_on_9;
DELETE FROM cache_IntsIncludedIn_1_3_on_11;
DELETE FROM cache_IntsIncludedIn_1_3_on_9;
