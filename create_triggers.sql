DELIMITER |

-- Triggers to set Itestable field (by default it is set to 'Yes', so we only need to mark untestable entries):
-- 1) only functions are testable
-- 2) private interfaces are not testable
-- 3) thunks are not testable (other c++ specific things such as vtables are not testable, too, but they all have 'Data' Itype)
DROP TRIGGER IF EXISTS int_insert |

CREATE TRIGGER int_insert BEFORE INSERT ON Interface
FOR EACH ROW BEGIN
    IF NEW.Iaccess = 'Private' OR NEW.Itype<>'Function' OR NEW.Iunmangled like '%thunk%' THEN
	SET NEW.Itestable='No';
    END IF;

    -- in addition, set documentation info for compiler-specific c++ things
    IF NEW.Iunmangled like 'vtable%' OR NEW.Iunmangled like 'typeinfo%' OR NEW.Iunmangled like '%thunk%' OR NEW.Iunmangled like 'guard variable' THEN
            SET NEW.Idocumented='Yes';
            SET NEW.Isrcbin='BinOnly';
    END IF;
								
END

|

DROP TRIGGER IF EXISTS int_update |

CREATE TRIGGER int_update BEFORE UPDATE ON Interface
FOR EACH ROW BEGIN
    IF NEW.Iaccess = 'Private' OR NEW.Itype<>'Function' OR NEW.Iunmangled like '%thunk%' THEN
        SET NEW.Itestable='No';
    END IF;
END

|

-- Triggers to set Ilibrary field on LGInt changes
DROP TRIGGER IF EXISTS int_ilibrary_on_lgint_insert |

CREATE TRIGGER int_ilibrary_on_lgint_insert AFTER INSERT ON LGInt
FOR EACH ROW BEGIN
    UPDATE Interface SET Ilibrary=(SELECT Lname FROM Library LEFT JOIN LibGroup ON LGlib=Lid WHERE LGid=NEW.LGIlibg) WHERE Iid=NEW.LGIint;
END

|

DROP TRIGGER IF EXISTS int_ilibrary_on_lgint_update  |

CREATE TRIGGER int_ilibrary_on_lgint_update AFTER UPDATE ON LGInt
FOR EACH ROW BEGIN
    UPDATE Interface SET Ilibrary=(SELECT Lname FROM Library LEFT JOIN LibGroup ON LGlib=Lid LEFT JOIN LGInt ON LGIlibg=LGid WHERE LGIint=NEW.LGIint) WHERE Iid=NEW.LGIint;
END

|

DROP TRIGGER IF EXISTS int_after_insert |

CREATE TRIGGER int_after_insert AFTER INSERT ON Interface
FOR EACH ROW BEGIN
    SET @Iid=(SELECT Iid FROM Interface WHERE Iunmangled=NEW.Iunmangled AND Ilibrary=NEW.Ilibrary);
    SET @Sid=(SELECT Sid FROM Standard WHERE Sname='CXXABI');
    IF NEW.Iunmangled like 'vtable%' THEN
	REPLACE INTO IntStd VALUES(@Iid,@Sid,0,'',NULL,'cxxabi-1.83.html#vtable-desc');
    ELSEIF NEW.Iunmangled like 'typeinfo%' THEN
	REPLACE INTO IntStd VALUES(@Iid,@Sid,0,'',NULL,'cxxabi-1.83.html#typeinfo-desc');
    ELSEIF NEW.Iunmangled like '%thunk%' THEN
	REPLACE INTO IntStd VALUES(@Iid,@Sid,0,'',NULL,'cxxabi-1.83.html#thunk-desc');
    ELSEIF NEW.Iunmangled like 'guard variable%' THEN
	REPLACE INTO IntStd VALUES(@Iid,@Sid,0,'',NULL,'cxxabi-1.83.html#guards-desc');
    END IF;
END

|
DELIMITER ;