#
# This makefile contains the commands to dump out the database by table
# This avoids creating one huge file that take a long time to manipulate
#
# It also allows populating (or re-populating) a database
#

DBOPTS=-h $$LSBDBHOST -u $$LSBUSER --password=$$LSBDBPASSWD
DUMPOPTS=--quote-names --extended-insert=false --triggers=FALSE --skip-dump-date --skip-comments
# Add '--local-infile' here if there are any problems with direct access to files
FILEOPTS=
# If TMPLSBDB environment variable is set, it will be used for temp database name;
# otherwise we'll use "${LSBDB}_tmp"
TMPLSBDB=$${TMPLSBDB=${LSBDB}}_tmp

ELEMENTS=AbiApi AbiMacro ArchClass ArchConst ArchDE ArchES ArchInt \
	Architecture ArchLib ArchType BaseTypes ClassInfo ClassVtab CmdStd Command CommandAttribute \
	Constant ConstantAttribute DynamicEntries ElfSections Header HeaderGroup \
	Interface InterfaceAttribute InterpretedLanguage InterpretedLanguageModule IntStd InterfaceComment InterfaceVote \
	LGInt LibGroup Library LibraryAttribute LSBVersion SModCmd SModLib SModStd ModSMod Module SubModule \
	Parameter RpmTag SectionTypes \
	Standard Type TypeMember TypeMemberExtras TypeType \
	Version VMIBaseTypes Vtable RawDynamicEntries
APP_TABLES=Application AppLib AppCategory AppInterpreter AppRInt RawInterface RawClass AppRILM RawILModule

COMMUNITY=AppCategory AppInfo AppInterpreter AppJInt AppLib AppRequires AppRILM AppRInt AppShippedLib \
	Application ApprovedCommand ApprovedLibrary CompatSymbol CompFile CompInfo CompJInt CompLDpath \
	Component CompProvides CompRequires CompRILM Distribution DistrVendor JavaBaseClass JavaClass \
	JavaInterface RILMBuiltin RLibDeps RLibLink RLibRClass RLibRInt RawClass RawCommand RawILModule \
	RawInterface RawLibSoname RawLibrary WeakSymbol

all:
	@echo "Please specify dump or restore (or variants dumpall, restoreall, dump_apps, restore_apps)"

# dump the "source code" tables
dump::
	for table in $(ELEMENTS) ; \
	do \
		set +e; \
		echo $$table; \
		mysqldump --add-drop-table --no-data $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | grep -v 'Server version' |grep -v 'character_set_client' >$$table.sql;\
		mysqldump $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | LC_ALL=C grep INSERT >$$table.init;\
	done

# dump everything: the "source code" tables + the "community" tables
# if the community tables are populated, this will be big!
dumpall::
	for table in `mysql $(DBOPTS) -e "SHOW TABLES" $$LSBDB | grep -v Tables | grep -v cache_` ;\
	do \
		set +e; \
		echo $$table; \
		mysqldump --add-drop-table --no-data $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | grep -v 'Server version' |grep -v 'character_set_client' >$$table.sql;\
		case "$(ELEMENTS)" in \
			*"$$table"*) mysqldump $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | LC_ALL=C grep INSERT >$$table.init ;; \
			*) rm -f "$$PWD/$$table.init" && mysql $(DBOPTS) $$LSBDB -e "select * from $$table into outfile '$$PWD/$$table.init'" ;; \
		esac;\
	done

restore::
	for table in $(ELEMENTS) ; \
	do \
		set +e; \
		echo $$table; \
		mysql $(DBOPTS) $$LSBDB <$$table.sql; \
		mysql $(DBOPTS) $$LSBDB <$$table.init; \
		mysql $(DBOPTS) $$LSBDB -e "OPTIMIZE TABLE $$table"; \
	done

community_check::
	ret_code=0; \
	for table in $(COMMUNITY); \
	do \
		if [[ ! -e $$table.init ]]; \
		then \
			echo "Missing community table init file: $$table.init"; \
			ret_code=1; \
		fi; \
	done; \
	if [[ $$ret_code == "1" ]]; \
	then \
		echo "!!!Make sure you have the latest community data files unpacked to this folder"; \
	fi; \
	exit $$ret_code

restoreall:: community_check
	mysql $(DBOPTS) -e "drop database if exists $$LSBDB"
	mysql $(DBOPTS) -e "drop database if exists $(TMPLSBDB)"
	@mysqladmin $(DBOPTS) create $$LSBDB
	@mysqladmin $(DBOPTS) create $(TMPLSBDB)
	#mysql $(DBOPTS) $$LSBDB <setupdb.sql;
#	sleep 5
	LC_ALL=C $(SHELL) -c 'for table in [A-Z]*sql ; \
	do \
		set +e; \
		table=`basename $$table .sql`; \
		echo $$table; \
		mysql $(DBOPTS) $$LSBDB <$$table.sql; \
		case "$(ELEMENTS)" in \
		        *"$$table"*) mysql $(DBOPTS) $$LSBDB <$$table.init ;; \
		        *) mysql $(DBOPTS) $(FILEOPTS) $$LSBDB -e "load data infile \"$${PWD}/$${table}.init\" into table $$table" ;; \
		esac;\
	done'
	FILEOPTS=$(FILEOPTS) ./create_cache_tables_inits.sh
	mysql $(DBOPTS) $$LSBDB <create_cache_tables.sql;
	mysql $(DBOPTS) $$LSBDB <create_alias_detector.sql;
	mysql $(DBOPTS) $$LSBDB <create_stored_procs.sql
	rm -f cache*.init
	LC_ALL=C $(SHELL) -c 'for table in [A-Z]*sql ; \
	do \
		table=`basename $$table .sql`; \
		mysql $(DBOPTS) $$LSBDB -e "SET SESSION myisam_sort_buffer_size = 30 * 1024 * 1024; OPTIMIZE TABLE $$table"; \
	done'
	mysql $(DBOPTS) $$LSBDB <dbperms.sql;
	mysql $(DBOPTS) $(TMPLSBDB) <tmpdbperms.sql;

# need a rule to populate the now external community tables,
# then call the 'cache' rule

cache::
#	FILEOPTS=$(FILEOPTS) ./create_cache_tables_inits.sh
	mysql $(DBOPTS) $$LSBDB <create_cache_tables.sql;
	mysql $(DBOPTS) $$LSBDB <create_stored_procs.sql
	rm -f cache*.init
	LC_ALL=C $(SHELL) -c 'for table in [A-Z]*sql ; \
	do \
	    table=`basename $$table .sql`; \
	    mysql $(DBOPTS) $$LSBDB -e "SET SESSION myisam_sort_buffer_size = 30 * 1024 * 1024; OPTIMIZE TABLE $$table"; \
	done'
	mysql $(DBOPTS) $$LSBDB <dbperms.sql;
	mysql $(DBOPTS) $(TMPLSBDB) <tmpdbperms.sql;


# rules to process application data only

restore_apps::
	for table in $(APP_TABLES) ; \
	do \
		set +e; \
		echo $$table; \
	        mysql $(DBOPTS) $$LSBDB <$$table.sql; \
		mysql $(DBOPTS) $(FILEOPTS) $$LSBDB -e "load data infile '$$PWD/$$table.init' into table $$table";\
	done
	FILEOPTS=$(FILEOPTS) ./create_cache_tables_inits.sh
	mysql $(DBOPTS) $$LSBDB <create_cache_tables.sql;
	mysql $(DBOPTS) $$LSBDB <create_stored_procs.sql 
	rm -f cache*.init
	mysql $(DBOPTS) $$LSBDB <dbperms.sql
	mysql $(DBOPTS) $(TMPLSBDB) <tmpdbperms.sql;

dump_apps::
	for table in $(APP_TABLES) ; \
	do \
	        set +e; \
	        echo $$table; \
	        mysqldump --add-drop-table --no-data $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | grep -v 'Server version' >$$table.sql;\
		rm -f "$$PWD/$$table.init" && mysql $(DBOPTS) $$LSBDB -e "select * from $$table into outfile '$$PWD/$$table.init'";\
	done

# Optimization for spec part tables

optimize::
	for table in $(ELEMENTS) ; \
	do \
	        set +e; \
	        echo $$table; \
	        mysql $(DBOPTS) $$LSBDB -e "OPTIMIZE TABLE $$table"; \
	done
