#
# This makefile contains the commands to dump out the database by table
# This avoids creating one huge file that take a long time to manipulate
#
# It also allows populating (or re-populating) a database
#

DBOPTS=-h $$LSBDBHOST -u $$LSBUSER --password=$$LSBDBPASSWD
DUMPOPTS=--quote-names --extended-insert=false --triggers=FALSE --skip-dump-date --skip-comments
# Sometimes LOAD DATA INFILE doesn't work, but ...LOCAL INFILE does.
# If this is your case, set this to 'local'.
LOCAL_INFILE_CMD=
# If DO_COPY is 'yes', then we copy files being loaded with LOAD DATA INFILE
# to a common temporary location first.
DO_COPY=no
# Use this temporary location if needed.
TMPDIR=/tmp
# If TMPLSBDB environment variable is set, it will be used for temp database
# name; otherwise we'll use "${LSBDB}_tmp"
TMPLSBDB=$${TMPLSBDB=${LSBDB}}_tmp

ELEMENTS=AbiApi AbiMacro ArchClass ArchConst ArchDE ArchES ArchInt \
	Architecture ArchLib ArchType BaseTypes ClassInfo ClassVtab CmdStd Command CommandAttribute \
	Constant ConstantAttribute DynamicEntries ElfSections Header HeaderGroup \
	ILModAttribute Interface InterfaceAttribute InterpretedLanguage InterpretedLanguageModule IntStd InterfaceComment InterfaceVote \
	LGInt LibGroup Library LibraryAttribute LSBVersion SModCmd SModLib SModStd ModSMod Module SubModule \
	Parameter RpmTag SectionTypes \
	Standard Type TypeMember TypeMemberExtras TypeType \
	Version VMIBaseTypes Vtable RawDynamicEntries
APP_TABLES=Application AppLib AppCategory AppInterpreter AppRInt RawInterface RawClass AppRILM RawILModule
NAV_TABLES=ArchSource CxxApi FTRLib FutureTarget SourceBinary SourceCode \
	SourceEntity SourceHeader SourceQualifier SourceShadow StandardSource \
	TargetDistribution TestCaseSource TestCmd TestInt TestSuite UpliftTarget

COMMUNITY=AppCategory AppInfo AppInterpreter AppJInt AppLib AppRequires AppRILM AppRInt AppShippedLib \
	Application ApprovedCommand ApprovedLibrary CompatSymbol CompFile CompInfo CompJInt CompLDpath \
	Component CompProvides CompRequires CompRILM Distribution DistrVendor JavaBaseClass JavaClass \
	JavaInterface RILMBuiltin RLibDeps RLibLink RLibRClass RLibRInt RawClass RawCommand RawILModule \
	RawInterface RawLibSoname RawLibrary WeakSymbol

# The Java classes were intended for a future inclusion of Java into
# the spec; since that looks unlikely in the near future, ignore them.
# We should still list them here for the sake of the sanity checker.
JAVA_TABLES=JApplToJInterface JavaComponent JClassJInterface \
	JClassToInterface JClassToJInterface JCompJClass JCompToJClass \
	JCompToJInterface

# Used by the sanity checker for SQL scripts that don't correspond to
# tables that should exist.
SANITY_CHECKER_SQL=create_alias_detector create_cache_tables \
	create_stored_procs create_triggers dbperms setupdb tmpdbperms

ifeq (yes,$(DO_COPY))
LOAD_LOCATION=$(TMPDIR)
else
LOAD_LOCATION=$$PWD
endif

# These variables hold the targets for each thing that needs to be done
# in the form 'tablename_job'.  Example: 'Type_dump' would dump the Type
# table.  Most of the work this makefile does is based on these rules.

ELEMENTS_DUMP = $(shell echo $(ELEMENTS) | (while read line; do for word in $$line; do echo $$word; done; done) | (while read line; do echo "$${line}_dump"; done))
COMMUNITY_DUMP = $(shell echo $(COMMUNITY) | (while read line; do for word in $$line; do echo $$word; done; done) | (while read line; do echo "$${line}_dump"; done))
APP_TABLES_DUMP = $(shell echo $(APP_TABLES) | (while read line; do for word in $$line; do echo $$word; done; done) | (while read line; do echo "$${line}_dump"; done))
NAV_TABLES_DUMP = $(shell echo $(NAV_TABLES) | (while read line; do for word in $$line; do echo $$word; done; done) | (while read line; do echo "$${line}_dump"; done))
ELEMENTS_RESTORE = $(shell echo $(ELEMENTS) | (while read line; do for word in $$line; do echo $$word; done; done) | (while read line; do echo "$${line}_restore"; done))
COMMUNITY_RESTORE = $(shell echo $(COMMUNITY) | (while read line; do for word in $$line; do echo $$word; done; done) | (while read line; do echo "$${line}_restore"; done))
APP_TABLES_RESTORE = $(shell echo $(APP_TABLES) | (while read line; do for word in $$line; do echo $$word; done; done) | (while read line; do echo "$${line}_restore"; done))
NAV_TABLES_RESTORE = $(shell echo $(NAV_TABLES) | (while read line; do for word in $$line; do echo $$word; done; done) | (while read line; do echo "$${line}_restore"; done))

all:
	@echo "Please specify dump or restore (or variants dumpall, restoreall, dump_apps, restore_apps)"

# This is used to distinguish which dump and restore commands to use
# for the data of a particular table.
elements_list: makefile
	echo $(ELEMENTS) > $@

%_dump: elements_list
	@echo $*
	@mysqldump --add-drop-table --no-data $(DBOPTS) $(DUMPOPTS) $$LSBDB $* | grep -v 'Server version' |grep -v 'character_set_client' > $*.sql
	@if grep -q $* elements_list; then \
	  mysqldump $(DBOPTS) $(DUMPOPTS) $$LSBDB $* | (LC_ALL=C grep INSERT || true) > $*.init; \
	else \
	  rm -f "$$PWD/$*.init" && mysql $(DBOPTS) $$LSBDB -e "select * from $* into outfile '$$PWD/$*.init'"; \
	fi

%_restore: elements_list
	@echo $*
	@mysql $(DBOPTS) $$LSBDB < $*.sql
	@if grep -q $* elements_list; then \
	  mysql $(DBOPTS) $$LSBDB < $*.init; \
	else \
	  cp $*.init $(TMPDIR); \
	  chmod 644 $(TMPDIR)/$*.init; \
	  mysql $(DBOPTS) $$LSBDB -e "load data $(LOCAL_INFILE_CMD) infile '$(LOAD_LOCATION)/$*.init' into table $*"; \
	  rm -f $(TMPDIR)/$*.init; \
	fi

# dump the "source code" tables
dump: $(ELEMENTS_DUMP)

# dump everything: the "source code" tables + the "community" tables
# if the community tables are populated, this will be big!
dumpall: dump $(COMMUNITY_DUMP)

dbsetup::
	mysql $(DBOPTS) -e "drop database if exists $$LSBDB"
	mysql $(DBOPTS) -e "drop database if exists $(TMPLSBDB)"
	@mysqladmin $(DBOPTS) create $$LSBDB
	@mysqladmin $(DBOPTS) create $(TMPLSBDB)

community_check::
	@ret_code=0; \
	for table in $(COMMUNITY); \
	do \
		if [ ! -e $$table.init ]; \
		then \
			echo "Missing community table init file: $$table.init"; \
			ret_code=1; \
		fi; \
	done; \
	if [ $$ret_code -eq 1 ]; \
	then \
		echo "!!!Make sure you have the latest community data files unpacked to this folder"; \
	fi; \
	exit $$ret_code

alias_detector::
	mysql $(DBOPTS) $$LSBDB <create_alias_detector.sql;

optimize::
	LC_ALL=C $(SHELL) -c 'for table in [A-Z]*sql ; \
	do \
	    table=`basename $$table .sql`; \
	    mysql $(DBOPTS) $$LSBDB -e "SET SESSION myisam_sort_buffer_size = 30 * 1024 * 1024; OPTIMIZE TABLE $$table"; \
	done'

optimize_speconly::
	for table in $(ELEMENTS) ; \
	do \
	        set +e; \
	        echo $$table; \
	        mysql $(DBOPTS) $$LSBDB -e "OPTIMIZE TABLE $$table"; \
	done

permissions::
	mysql $(DBOPTS) $$LSBDB <dbperms.sql;
	mysql $(DBOPTS) $(TMPLSBDB) <tmpdbperms.sql;

# need a rule to populate the now external community tables,
# then call the 'cache' rule

cache::
	LOCALCMD=$(LOCAL_INFILE_CMD) ./create_cache_tables_inits.sh
	mysql $(DBOPTS) $$LSBDB <create_cache_tables.sql;
	mysql $(DBOPTS) $$LSBDB <create_stored_procs.sql
	rm -f cache*.init

restore: $(ELEMENTS_RESTORE) optimize_speconly

restoreall:: community_check dbsetup $(ELEMENTS_RESTORE) $(NAV_TABLES_RESTORE) \
  $(COMMUNITY_RESTORE) alias_detector cache optimize

# rules to process application data only

restore_apps: $(APP_TABLES_RESTORE) cache permissions

dump_apps: $(APP_TABLES_DUMP)

# rules to process Navigator data only

restore_nav: $(NAV_TABLES_RESTORE) cache permissions

dump_nav: $(NAV_TABLES_DUMP)

# Sanity-check table lists against the data in the repository.  For now,
# we don't consider a missing .init file to be a problem.

sanitycheck:
	@for table in $(ELEMENTS) $(NAV_TABLES) $(JAVA_TABLES) $(COMMUNITY); do \
	  if [ '!' -e $$table.sql ]; then \
	    echo "$$table missing table structure file $$table.sql"; \
	  fi; \
	done
	@for table in *.sql; do \
	  tablename=$$(basename $$table .sql); \
	  if [ $$(echo $(ELEMENTS) $(NAV_TABLES) $(JAVA_TABLES) $(COMMUNITY) $(SANITY_CHECKER_SQL) | grep $$tablename | wc -l) -eq 0 ]; then \
	    echo "unknown table data found: $$table"; \
	  fi; \
	done

# clean up

clean:
	rm -f elements_list
