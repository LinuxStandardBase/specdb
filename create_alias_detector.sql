delimiter //

DROP PROCEDURE IF EXISTS detect_aliases_for_distr //

CREATE PROCEDURE detect_aliases_for_distr (IN Did INT(10) UNSIGNED)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE Cid1 INT(10) UNSIGNED;
    DECLARE Cid2 INT(10) UNSIGNED;
    DECLARE RLid1 INT(10) UNSIGNED;
    DECLARE RLid2 INT(10) UNSIGNED;
    DECLARE RLname VARCHAR(255);
    DECLARE RLrunname VARCHAR(255);
    DECLARE RLpath VARCHAR(255);
    DECLARE RLversion VARCHAR(255);
--    DECLARE comp_cur CURSOR FOR SELECT Cid1, Cid2 FROM tmp_AliasCandidates;

    DECLARE libs_cur CURSOR FOR SELECT tmp_AliasCandidates.Cid1, tmp_AliasCandidates.Cid2, RL1.RLid, RL2.RLid
		FROM tmp_AliasCandidates 
		JOIN RawLibrary RL1 ON RL1.RLcomponent=tmp_AliasCandidates.Cid1
		JOIN RawLibrary RL2 ON RL2.RLcomponent=tmp_AliasCandidates.Cid2
		WHERE RL1.RLname = RL2.RLname
		AND RL1.RLrunname = RL2.RLrunname
		AND RL1.RLpath = RL2.RLpath
		AND RL1.RLversion = RL2.RLversion;
    
    DECLARE comp_cur CURSOR FOR SELECT tmp_DistrCompContent.Cid, tmp_OtherCompContent.Cid
	FROM tmp_DistrCompContent JOIN tmp_OtherCompContent
	ON tmp_DistrCompContent.lib_cnt=tmp_OtherCompContent.lib_cnt
	AND tmp_DistrCompContent.class_cnt=tmp_OtherCompContent.class_cnt
	AND tmp_DistrCompContent.int_cnt=tmp_OtherCompContent.int_cnt
	AND tmp_DistrCompContent.rilm_cnt=tmp_OtherCompContent.rilm_cnt
	AND tmp_DistrCompContent.cmd_cnt=tmp_OtherCompContent.cmd_cnt
	AND tmp_DistrCompContent.jint_cnt=tmp_OtherCompContent.jint_cnt;

    DECLARE result_cur CURSOR FOR SELECT tmp_FoundAlias.Cid1, tmp_FoundAlias.Cid2 FROM tmp_FoundAlias;

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;

--    DROP TABLE IF EXISTS tmp_ProcStatus;
--    CREATE TABLE tmp_ProcStatus(
--	status TEXT,
--	time timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
--	);

--    INSERT INTO tmp_ProcStatus (status) VALUES("Starting proc...");

-- Temporary tables with number of different objects in every component
-- Note that we don't look at classes here, since if two components
-- have the same sets of libraries and interfaces, then they automatically
-- have the same sets of classes
    DROP TABLE IF EXISTS tmp_Cmds;
    CREATE TEMPORARY TABLE tmp_Cmds
        (KEY Cid(Cid))
        SELECT RCcomponent AS Cid, COUNT(RCid) AS cmd_cnt FROM RawCommand 
        GROUP BY Cid;

    DROP TABLE IF EXISTS tmp_Classes;
    CREATE TEMPORARY TABLE tmp_Classes 
        (KEY Cid(Cid))
        SELECT RLcomponent AS Cid, (
            SELECT COUNT(RLRCrcid)
            FROM RLibRClass 
            WHERE RLid=RLRCrlid
        ) AS class_cnt
        FROM RawLibrary;

    DROP TABLE IF EXISTS tmp_RLibContent;
    CREATE TEMPORARY TABLE tmp_RLibContent
        (KEY RLid(RLRIrlid))
        SELECT RLRIrlid, COUNT(RLRIriid) AS int_cnt FROM RLibRInt
        GROUP BY RLRIrlid;

    DROP TABLE IF EXISTS tmp_Ints;
    CREATE TEMPORARY TABLE tmp_Ints 
        (KEY Cid(Cid))
        SELECT RLcomponent AS Cid, COUNT(RLRIrlid) AS lib_cnt, int_cnt FROM RawLibrary
        JOIN tmp_RLibContent ON RLid=RLRIrlid
        GROUP BY Cid;

    DROP TABLE IF EXISTS tmp_RILMs;
    CREATE TEMPORARY TABLE tmp_RILMs 
        (KEY Cid(Cid))
        SELECT CRMcid AS Cid, COUNT(CRMrilmid) AS rilm_cnt FROM CompRILM
        GROUP BY Cid;

    DROP TABLE IF EXISTS tmp_Jints;
    CREATE TEMPORARY TABLE tmp_Jints 
        (KEY Cid(Cid))
        SELECT CJIcid AS Cid, COUNT(CJIjiid) AS jint_cnt FROM CompJInt
        GROUP BY Cid;

-- Components from the distribution being processd
    DROP TABLE IF EXISTS tmp_DistrCompContent;
    SET @stmt_text = CONCAT("CREATE TEMPORARY TABLE tmp_DistrCompContent 
        (KEY Cid(lib_cnt,class_cnt,int_cnt,rilm_cnt,cmd_cnt, jint_cnt, Cid))
        SELECT lib_cnt, class_cnt, int_cnt, rilm_cnt, cmd_cnt, jint_cnt, Cid FROM Component
        LEFT JOIN tmp_Cmds USING(Cid)
        LEFT JOIN tmp_Classes USING(Cid)
        LEFT JOIN tmp_Ints USING(Cid)
        LEFT JOIN tmp_RILMs USING(Cid)
        LEFT JOIN tmp_Jints USING(Cid)
        WHERE Cdistr=", Did,
        " AND Calias=0
        ");
    PREPARE stmt FROM @stmt_text;
    EXECUTE stmt;

-- Components from the other distributions
    DROP TABLE IF EXISTS tmp_OtherCompContent;
    SET @stmt_text = CONCAT("CREATE TEMPORARY TABLE tmp_OtherCompContent 
        (KEY Cid(lib_cnt,class_cnt,int_cnt,rilm_cnt,cmd_cnt, jint_cnt, Cid))
        SELECT lib_cnt, class_cnt, int_cnt, rilm_cnt, cmd_cnt, jint_cnt, Cid FROM Component
        LEFT JOIN tmp_Cmds USING(Cid)
        LEFT JOIN tmp_Classes USING(Cid)
        LEFT JOIN tmp_Ints USING(Cid)
        LEFT JOIN tmp_RILMs USING(Cid)
        LEFT JOIN tmp_Jints USING(Cid)
        WHERE Cdistr!=", Did,
        " AND Calias=0
        ");
    PREPARE stmt FROM @stmt_text;
    EXECUTE stmt;

-- If no objects of a certain kind are found in a component,
-- then appropriate counter is set to NULL.
-- This is not good for us, since we want to compare counters, but NULL != NULL.
-- So let's replace all NULLs with zeros.
    UPDATE tmp_OtherCompContent SET lib_cnt=0 WHERE lib_cnt IS NULL;
    UPDATE tmp_OtherCompContent SET cmd_cnt=0 WHERE cmd_cnt IS NULL;
    UPDATE tmp_OtherCompContent SET class_cnt=0 WHERE class_cnt IS NULL;
    UPDATE tmp_OtherCompContent SET int_cnt=0 WHERE int_cnt IS NULL;
    UPDATE tmp_OtherCompContent SET rilm_cnt=0 WHERE rilm_cnt IS NULL;
    UPDATE tmp_OtherCompContent SET jint_cnt=0 WHERE jint_cnt IS NULL;
    UPDATE tmp_DistrCompContent SET lib_cnt=0 WHERE lib_cnt IS NULL;
    UPDATE tmp_DistrCompContent SET cmd_cnt=0 WHERE cmd_cnt IS NULL;
    UPDATE tmp_DistrCompContent SET class_cnt=0 WHERE class_cnt IS NULL;
    UPDATE tmp_DistrCompContent SET int_cnt=0 WHERE int_cnt IS NULL;
    UPDATE tmp_DistrCompContent SET jint_cnt=0 WHERE jint_cnt IS NULL;
    UPDATE tmp_DistrCompContent SET rilm_cnt=0 WHERE rilm_cnt IS NULL;

-- tmp_AliasCandidates will contain pairs of alias candidates Cids.
-- Alias candidates are the component who have the same number of all objects.
-- The first Cid (Cid1) always corresponds to a component from the distribution under process,
-- the second one - to a component from some other distribution.
    DROP TABLE IF EXISTS tmp_AliasCandidates;
    CREATE TEMPORARY TABLE tmp_AliasCandidates 
	(KEY Cid(Cid1,Cid2))
	SELECT tmp_DistrCompContent.Cid AS Cid1, tmp_OtherCompContent.Cid AS Cid2 
	FROM tmp_DistrCompContent JOIN tmp_OtherCompContent
	ON tmp_DistrCompContent.lib_cnt=tmp_OtherCompContent.lib_cnt
	AND tmp_DistrCompContent.class_cnt=tmp_OtherCompContent.class_cnt
	AND tmp_DistrCompContent.int_cnt=tmp_OtherCompContent.int_cnt
	AND tmp_DistrCompContent.rilm_cnt=tmp_OtherCompContent.rilm_cnt
	AND tmp_DistrCompContent.cmd_cnt=tmp_OtherCompContent.cmd_cnt
	AND tmp_DistrCompContent.jint_cnt=tmp_OtherCompContent.jint_cnt;
    
-- tmp_BrokenAlias will contain (Cid1, Cid2) pairs that are proved
-- not to be aliases.
    DROP TABLE IF EXISTS tmp_BrokenAlias;
    CREATE TEMPORARY TABLE tmp_BrokenAlias(
	Cid1 INT(10) UNSIGNED NOT NULL DEFAULT 0,
	Cid2 INT(10) UNSIGNED NOT NULL DEFAULT 0,
	UNIQUE KEY Cid(Cid1,Cid2)
	);
    
    DROP TABLE IF EXISTS tmp_FoundAlias;
    CREATE TEMPORARY TABLE tmp_FoundAlias(
	Cid1 INT(10) UNSIGNED NOT NULL DEFAULT 0,
	Cid2 INT(10) UNSIGNED NOT NULL DEFAULT 0,
	KEY Cid(Cid1)
	);

    OPEN comp_cur;

-- INSERT INTO tmp_ProcStatus (status) VALUES ("Starting main loop");

main_loop: 
    REPEAT
        FETCH comp_cur INTO Cid1, Cid2;
	
	IF NOT done THEN
	
-- INSERT INTO tmp_ProcStatus (status) VALUES (concat("Checking comps ", Cid1, " and ", Cid2));

-- 1) Check if components have the same set of libraries 	
	DROP TABLE IF EXISTS tmp_CompLibs;

-- 1.1) Union of libraries from both components
	SET @stmt_text = CONCAT("CREATE TEMPORARY TABLE tmp_CompLibs
        (KEY RLid(RLname, RLrunname, RLpath, RLversion(10)))
        SELECT RLname, RLrunname, RLpath, RLversion, RLsoname FROM RawLibrary 
        WHERE RLcomponent = ", Cid1, "
        UNION DISTINCT 
        SELECT RLname, RLrunname, RLpath, RLversion, RLsoname FROM RawLibrary
        WHERE RLcomponent = ", Cid2
	);
        PREPARE stmt FROM @stmt_text;
	EXECUTE stmt;

-- INSERT INTO tmp_ProcStatus (status) VALUES ("tmp_CompLibs is ready");
	
-- 1.2) Let's check if any libary from the union is absent in one of the components
	SET @present = (SELECT 1 FROM tmp_CompLibs
            WHERE NOT EXISTS (
    	        SELECT 1 FROM RawLibrary 
    	        WHERE RLcomponent = Cid1
    	    	AND RawLibrary.RLname = tmp_CompLibs.RLname 
            	AND RawLibrary.RLrunname = tmp_CompLibs.RLrunname
    		    AND RawLibrary.RLpath = tmp_CompLibs.RLpath 
    	        AND RawLibrary.RLversion = tmp_CompLibs.RLversion
        	)
		LIMIT 1);
	IF @present THEN
	    INSERT IGNORE INTO tmp_BrokenAlias VALUES(Cid1,Cid2);
	    ITERATE main_loop;
	END IF;

	SET @present = (SELECT 1 FROM tmp_CompLibs
		WHERE NOT EXISTS (
		    SELECT 1 FROM RawLibrary 
		    WHERE RLcomponent = Cid2
		    AND RawLibrary.RLname = tmp_CompLibs.RLname 
		    AND RawLibrary.RLrunname = tmp_CompLibs.RLrunname
		    AND RawLibrary.RLpath = tmp_CompLibs.RLpath 
		    AND RawLibrary.RLversion = tmp_CompLibs.RLversion
		)
		LIMIT 1);
	IF @present THEN
	    INSERT IGNORE INTO tmp_BrokenAlias VALUES(Cid1,Cid2);
	    ITERATE main_loop;
	END IF;

-- INSERT INTO tmp_ProcStatus (status) VALUES ("Lib comparison is finished");

-- 1.3) Let's check if the components have the same set of CompLDpath entries
	SET @stmt_text = CONCAT("INSERT IGNORE INTO tmp_BrokenAlias
		SELECT ", Cid1, ",", Cid2, "
		FROM CompLDpath C1 WHERE C1.CLDcid = ", Cid1, "
		AND NOT EXISTS (
		    SELECT 1 FROM CompLDpath C2 
		    WHERE C2.CLDcid = ", Cid2, "
		    AND C2.CLDpath=C1.CLDpath
		)
		LIMIT 1");
        PREPARE stmt FROM @stmt_text;
	EXECUTE stmt;

	SET @stmt_text = CONCAT("INSERT IGNORE INTO tmp_BrokenAlias
		SELECT ", Cid1, ",", Cid2, "
		FROM CompLDpath C1 WHERE C1.CLDcid = ", Cid2, "
		AND NOT EXISTS (
		    SELECT 1 FROM CompLDpath C2 
		    WHERE C2.CLDcid = ", Cid1, "
		    AND C2.CLDpath=C1.CLDpath
		)
		LIMIT 1");
        PREPARE stmt FROM @stmt_text;
	EXECUTE stmt;

-- INSERT INTO tmp_ProcStatus (status) VALUES ("CompLDpath comparison is finished");

-- 2) Check if components have the same set of RILMs
	SET @stmt_text = CONCAT("INSERT IGNORE INTO tmp_BrokenAlias
		SELECT ", Cid1, ",", Cid2, "
		FROM CompRILM C1 WHERE C1.CRMcid = ", Cid1, "
		AND NOT EXISTS (
		    SELECT 1 FROM CompRILM C2 
		    WHERE C2.CRMcid = ", Cid2, "
		    AND C2.CRMrilmid=C1.CRMrilmid
		)
		LIMIT 1");
        PREPARE stmt FROM @stmt_text;
	EXECUTE stmt;

	SET @stmt_text = CONCAT("INSERT IGNORE INTO tmp_BrokenAlias
		SELECT ", Cid1, ",", Cid2, "
		FROM CompRILM C1 WHERE C1.CRMcid = ", Cid2, "
		AND NOT EXISTS (
		    SELECT 1 FROM CompRILM C2 
		    WHERE C2.CRMcid = ", Cid1, "
		    AND C2.CRMrilmid=C1.CRMrilmid
		)
		LIMIT 1");
        PREPARE stmt FROM @stmt_text;
	EXECUTE stmt;

-- INSERT INTO tmp_ProcStatus (status) VALUES ("RILM comparison is finished");

-- 3) Check if components have the same set of RawCommands
	SET @stmt_text = CONCAT("INSERT IGNORE INTO tmp_BrokenAlias
		SELECT ", Cid1, ",", Cid2, "
		FROM RawCommand C1 WHERE C1.RCcomponent = ", Cid1, "
		AND NOT EXISTS (
		    SELECT 1 FROM RawCommand C2 
		    WHERE C2.RCcomponent = ", Cid2, "
		    AND C2.RCname=C1.RCname
		    AND C2.RCpath=C1.RCpath
		)
		LIMIT 1");
        PREPARE stmt FROM @stmt_text;
	EXECUTE stmt;

	SET @stmt_text = CONCAT("INSERT IGNORE INTO tmp_BrokenAlias
		SELECT ", Cid1, ",", Cid2, "
		FROM RawCommand C1 WHERE C1.RCcomponent = ", Cid2, "
		AND NOT EXISTS (
		    SELECT 1 FROM RawCommand C2 
		    WHERE C2.RCcomponent = ", Cid1, "
		    AND C2.RCname=C1.RCname
		    AND C2.RCpath=C1.RCpath
		)
		LIMIT 1");
        PREPARE stmt FROM @stmt_text;
	EXECUTE stmt;

-- 4) Check if components have the same set of JInts
	SET @stmt_text = CONCAT("INSERT IGNORE INTO tmp_BrokenAlias
		SELECT ", Cid1, ",", Cid2, "
		FROM CompJInt C1 WHERE C1.CJIcid = ", Cid1, "
		AND NOT EXISTS (
		    SELECT 1 FROM CompJInt C2 
		    WHERE C2.CJIcid = ", Cid2, "
		    AND C2.CJIjiid=C1.CJIjiid
		)
		LIMIT 1");
        PREPARE stmt FROM @stmt_text;
	EXECUTE stmt;

	SET @stmt_text = CONCAT("INSERT IGNORE INTO tmp_BrokenAlias
		SELECT ", Cid1, ",", Cid2, "
		FROM CompJInt C1 WHERE C1.CJIcid = ", Cid2, "
		AND NOT EXISTS (
		    SELECT 1 FROM CompJInt C2 
		    WHERE C2.CJIcid = ", Cid1, "
		    AND C2.CJIjiid=C1.CJIjiid
		)
		LIMIT 1");
        PREPARE stmt FROM @stmt_text;
	EXECUTE stmt;

-- INSERT INTO tmp_ProcStatus (status) VALUES ("All comparisons are finished, proceed with the next pair");

	END IF;

    UNTIL done END REPEAT main_loop;

    CLOSE comp_cur;
    SET done = 0;

--    INSERT INTO tmp_ProcStatus (status) VALUES("Finished main loop");

    DELETE FROM tmp_AliasCandidates 
    WHERE EXISTS (
	SELECT 1 FROM tmp_BrokenAlias
	WHERE tmp_BrokenAlias.Cid1 = tmp_AliasCandidates.Cid1
	AND tmp_BrokenAlias.Cid2 = tmp_AliasCandidates.Cid2
    );
    DELETE FROM tmp_BrokenAlias;
    
--    INSERT INTO tmp_ProcStatus (status) VALUES("Starting lib_loop...");

-- 5) Check if components have the same set of RawInterfaces
    SET @Cid1_old=0;
    SET @Cid2_old=0;

    OPEN libs_cur;
lib_loop:
    REPEAT
	FETCH libs_cur INTO Cid1, Cid2, RLid1, RLid2;

	IF NOT done THEN

--        INSERT INTO tmp_ProcStatus (status) VALUES(CONCAT("Checking ", Cid1, " vs ", Cid2, " (libs: ", RLid1, " vs ", RLid2, " )"));

--      Check - probably (Cid1, Cid2) pair was already found to be a "broken alias"
	SET @present = (SELECT 1 FROM tmp_BrokenAlias
		WHERE tmp_BrokenAlias.Cid1=Cid1
		AND tmp_BrokenAlias.Cid2=Cid2
		);
	IF @present THEN
	    ITERATE lib_loop;
	END IF;

--	Let's check - probably we have alredy found an alias for Cid1, no need to look for another one	
	IF @Cid1_old=Cid1 AND @Cid2_old!=Cid2 THEN
	    SET @present = (SELECT 1 FROM tmp_BrokenAlias
		    WHERE tmp_BrokenAlias.Cid1=Cid1
		    AND tmp_BrokenAlias.Cid2=@Cid2_old
		);
	    IF @present IS NULL THEN
		INSERT IGNORE INTO tmp_BrokenAlias VALUES(Cid1,Cid2);
		ITERATE lib_loop;
	    END IF;
	END IF;

	SET @Cid1_old = Cid1;
	SET @Cid2_old = Cid2;

--  check RLibDeps records
	SET @present = (SELECT 1 FROM RLibDeps R1
		WHERE RLDrlid = RLid1
		AND NOT EXISTS (
		    SELECT 1 FROM RLibDeps R2
		    WHERE R2.RLDrlid = RLid2
		    AND R2.RLDrlsid = R1.RLDrlsid
		)
		LIMIT 1);
	IF @present THEN
	    INSERT IGNORE INTO tmp_BrokenAlias VALUES(Cid1,Cid2);
	    ITERATE lib_loop;
	END IF;

	SET @present = (SELECT 1 FROM RLibDeps R1
		WHERE RLDrlid = RLid2
		AND NOT EXISTS (
		    SELECT 1 FROM RLibDeps R2
		    WHERE R2.RLDrlid = RLid1
		    AND R2.RLDrlsid = R1.RLDrlsid
		)
		LIMIT 1);
	IF @present THEN
	    INSERT IGNORE INTO tmp_BrokenAlias VALUES(Cid1,Cid2);
	    ITERATE lib_loop;
	END IF;

--  check RLibLink records
	SET @present = (SELECT 1 FROM RLibLink R1
		WHERE RLLrlid = RLid1
		AND NOT EXISTS (
		    SELECT 1 FROM RLibLink R2
		    WHERE R2.RLLrlid = RLid2
		    AND R2.RLLlinkname = R1.RLLlinkname
		)
		LIMIT 1);
	IF @present THEN
	    INSERT IGNORE INTO tmp_BrokenAlias VALUES(Cid1,Cid2);
	    ITERATE lib_loop;
	END IF;

	SET @present = (SELECT 1 FROM RLibLink R1
		WHERE RLLrlid = RLid2
		AND NOT EXISTS (
		    SELECT 1 FROM RLibLink R2
		    WHERE R2.RLLrlid = RLid1
		    AND R2.RLLlinkname = R1.RLLlinkname
		)
		LIMIT 1);
	IF @present THEN
	    INSERT IGNORE INTO tmp_BrokenAlias VALUES(Cid1,Cid2);
	    ITERATE lib_loop;
	END IF;

--      check RLibRInt records
	SET @present = (SELECT 1 FROM RLibRInt R1
		WHERE RLRIrlid = RLid1
		AND NOT EXISTS (
		    SELECT 1 FROM RLibRInt R2
		    WHERE R2.RLRIrlid = RLid2
		    AND R2.RLRIriid = R1.RLRIriid
		)
		LIMIT 1);
	IF @present THEN
	    INSERT IGNORE INTO tmp_BrokenAlias VALUES(Cid1,Cid2);
	    ITERATE lib_loop;
	END IF;

	SET @present = (SELECT 1 FROM RLibRInt R1
		WHERE RLRIrlid = RLid2
		AND NOT EXISTS (
		    SELECT 1 FROM RLibRInt R2
		    WHERE R2.RLRIrlid = RLid1
		    AND R2.RLRIriid = R1.RLRIriid
		)
		LIMIT 1);
	IF @present THEN
	    INSERT IGNORE INTO tmp_BrokenAlias VALUES(Cid1,Cid2);
	    ITERATE lib_loop;
	END IF;
	
	END IF;

    UNTIL done END REPEAT lib_loop;

--    INSERT INTO tmp_ProcStatus (status) VALUES("Finished lib_loop...");
	
    CLOSE libs_cur;
    SET done = 0;

-- Drop alias candidates that were found not to be aliases
    DELETE FROM tmp_AliasCandidates 
    WHERE EXISTS (
	SELECT 1 FROM tmp_BrokenAlias
	WHERE tmp_BrokenAlias.Cid1 = tmp_AliasCandidates.Cid1
	AND tmp_BrokenAlias.Cid2 = tmp_AliasCandidates.Cid2
    );
    
    INSERT INTO tmp_FoundAlias 
    SELECT tmp_AliasCandidates.Cid1, tmp_AliasCandidates.Cid2 
    FROM tmp_AliasCandidates
    GROUP BY tmp_AliasCandidates.Cid1;

--    INSERT INTO tmp_ProcStatus (status) VALUES("tmp_FoundAlias is ready");

-- Remember RLid of libraries that are in aliased components.
-- This set of RLids will help us to drop their interfaces
    DROP TABLE IF EXISTS tmp_Libs;
    CREATE TEMPORARY TABLE tmp_Libs
	(KEY RLid(RLid))
	SELECT RLid FROM tmp_FoundAlias
	JOIN RawLibrary ON RLcomponent=tmp_FoundAlias.Cid1;

--    INSERT INTO tmp_ProcStatus (status) VALUES("tmp_Libs is ready");

-- Finally, select the resulting set of aliases and update the database
    OPEN result_cur;
    REPEAT
	FETCH result_cur INTO Cid1, Cid2;
	IF NOT done THEN
    	    UPDATE Component SET Calias = Cid2 WHERE Cid = Cid1;
    	    UPDATE Component SET Calias = Cid2 WHERE Calias = Cid1;
    	    DELETE FROM RawLibrary WHERE RLcomponent = Cid1;
    	    DELETE FROM RawCommand WHERE RCcomponent = Cid1;
    	    DELETE FROM CompRILM WHERE CRMcid = Cid1;
	    DELETE FROM CompJInt WHERE CJIcid = Cid1;
	END IF;
    UNTIL done END REPEAT;
    CLOSE result_cur;
    
    DELETE FROM RLibDeps WHERE EXISTS (SELECT 1 FROM tmp_Libs WHERE RLid=RLDrlid);
    DELETE FROM RLibLink WHERE EXISTS (SELECT 1 FROM tmp_Libs WHERE RLid=RLLrlid);
    DELETE FROM RLibRClass WHERE EXISTS (SELECT 1 FROM tmp_Libs WHERE RLid=RLRCrlid);
    DELETE FROM RLibRInt WHERE EXISTS (SELECT 1 FROM tmp_Libs WHERE RLid=RLRIrlid);
    DELETE FROM WeakSymbol WHERE EXISTS (SELECT 1 FROM tmp_Libs WHERE RLid=WSrlid);
    DELETE FROM CompatSymbol WHERE EXISTS (SELECT 1 FROM tmp_Libs WHERE RLid=CSrlid);
END
//

DROP PROCEDURE IF EXISTS detect_biarch_comps_for_distr //

CREATE PROCEDURE detect_biarch_comps_for_distr (IN DistrId INT(10) UNSIGNED)
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE Cid1 INT(10) UNSIGNED;
    DECLARE b_Cname VARCHAR(255);
    DECLARE b_Cversion VARCHAR(255);
    DECLARE b_Cpackages VARCHAR(255);
    DECLARE result_cur CURSOR FOR SELECT Cid, Cname, Cversion, Cpackages FROM Component
                                     JOIN RawLibrary ON RLcomponent=Cid
                                     WHERE Cdistr=DistrId
				     GROUP BY Cid
                                     HAVING COUNT(DISTINCT RLarch) > 1;

    DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;

    OPEN result_cur;

main_loop: 
    REPEAT
	FETCH result_cur INTO Cid1, b_Cname, b_Cversion, b_Cpackages;
	IF NOT done THEN
	    SET @b_arch=(SELECT DISTINCT RLarch FROM RawLibrary WHERE RLcomponent=Cid1 ORDER BY RLarch LIMIT 1);
	    IF( @b_arch != 6 AND @b_arch != 2 AND @b_arch != 10 ) THEN
		ITERATE main_loop;
	    END IF;
	    
	    SET @newName = CONCAT(b_Cname,"-32bit");
	    
	    SET @existingCid=(SELECT Cid FROM Component WHERE Cname=@newName AND Cversion=b_Cversion AND Cdistr=DistrId AND Carch=@b_arch);

	    IF( @existingCid > 0 ) THEN
                CREATE TEMPORARY TABLE tmp_BiLibs (KEY RLid(RLid)) SELECT RLid FROM RawLibrary WHERE RLcomponent=Cid1 AND RLarch=@b_arch;
                DELETE FROM RLibRInt WHERE EXISTS (SELECT 1 FROM tmp_BiLibs WHERE RLid=RLRIrlid);
                DELETE FROM WeakSymbol WHERE EXISTS (SELECT 1 FROM tmp_BiLibs WHERE RLid=WSrlid);
                DELETE FROM CompatSymbol WHERE EXISTS (SELECT 1 FROM tmp_BiLibs WHERE RLid=CSrlid);
                DELETE FROM RawLibrary WHERE RLcomponent=Cid1 AND RLarch=@b_arch;
                DROP TABLE tmp_BiLibs;
	    ELSE 
		INSERT INTO Component (Cid, Cname, Cversion, Cpackages, Carch, Cdistr) VALUES (0, @newName, b_Cversion, b_Cpackages, @b_arch, DistrId);
		SET @newCid=(SELECT LAST_INSERT_ID());
		UPDATE RawLibrary SET RLcomponent=@newCid WHERE RLcomponent=Cid1 AND RLarch=@b_arch;
	    END IF;
	END IF;
    UNTIL done END REPEAT main_loop;
    CLOSE result_cur;
    
    UPDATE Component JOIN RawLibrary ON RLcomponent=Cid SET Carch=RLarch WHERE Cdistr=DistrId;
END
//

delimiter ;

-- call detect_aliases_for_distr(235);
