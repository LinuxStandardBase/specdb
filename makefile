#
# This makefile contains the commands to dump out the database by table
# This avoids creating one huge file that take a long time to manipulate
#
# It also allows populating (or re-populating) a database
#

DBOPTS=-h $$LSBDBHOST -u $$LSBUSER --password=$$LSBDBPASSWD
DUMPOPTS=--quote-names --extended-insert=false

ELEMENTS=AbiApi AbiMacro ArchClass ArchConst ArchDE ArchES ArchInt \
	Architecture ArchLib ArchType BaseTypes ClassInfo ClassVtab Command \
	Constant DynamicEntries ElfSections Header HeaderGroup \
	Interface InterfaceAttribute LGInt LibGroup Library \
	LSBVersion ModCmd ModLib Module Parameter RpmTag SectionTypes \
	Standard Type TypeMember TemplateParameter TypeMemberExtras TypeType \
	Version VMIBaseTypes Vtable
	
APP_TABLES=Application AppLib AppRInt RawInterface RawClass

all:
	@echo "Please specify dump or restore (or variants dumpall, restoreall, dump_apps, restore_apps)"

# dump the "source code" tables
dump::
	for table in $(ELEMENTS) ; \
	do \
		set +e; \
		echo $$table; \
		mysqldump --add-drop-table --no-data $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | grep -v 'Server version' >$$table.sql;\
		mysqldump $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | LC_ALL=C grep INSERT >$$table.init;\
	done

# dump everything: the "source code" tables + the "community" tables
# if the community tables are populated, this will be big!
dumpall::
	for table in `mysql $(DBOPTS) -e "SHOW TABLES" $$LSBDB | grep -v Tables | grep -v cache_` ;\
	do \
		set +e; \
		echo $$table; \
		mysqldump --add-drop-table --no-data $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | grep -v 'Server version' >$$table.sql;\
		mysqldump $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | LC_ALL=C grep INSERT >$$table.init;\
	done

restore::
	for table in $(ELEMENTS) ; \
	do \
		set +e; \
		echo $$table; \
		mysql $(DBOPTS) $$LSBDB <$$table.sql; \
		mysql $(DBOPTS) $$LSBDB <$$table.init; \
	done

restoreall::
	@mysqladmin $(DBOPTS) drop $$LSBDB
	@mysqladmin $(DBOPTS) create $$LSBDB
	#mysql $(DBOPTS) $$LSBDB <setupdb.sql;
	sleep 5
	LC_ALL=C $(SHELL) -c 'for table in [A-Z]*sql ; \
	do \
		set +e; \
		table=`basename $$table .sql`; \
		echo $$table; \
		mysql $(DBOPTS) $$LSBDB <$$table.sql; \
		mysql $(DBOPTS) $$LSBDB <$$table.init; \
		mysql $(DBOPTS) $$LSBDB -e "ANALYZE TABLE $$table"; \
	done'
	./create_cache_tables_inits.sh
	mysql $(DBOPTS) $$LSBDB <create_cache_tables.sql;
	mysql $(DBOPTS) $$LSBDB <cache_RIntNames.init;
	mysql $(DBOPTS) $$LSBDB <create_stored_procs.sql
#	mysql $(DBOPTS) $$LSBDB <cache_RLibRIntMapping.init
	rm -f cache*.init
	mysql $(DBOPTS) $$LSBDB <dbperms.sql;

# need a rule to populate the now external community tables,
# then call the 'cache' rule

cache::
	./create_cache_tables_inits.sh
	mysql $(DBOPTS) $$LSBDB <create_cache_tables.sql;
	mysql $(DBOPTS) $$LSBDB <cache_RIntNames.init;
	mysql $(DBOPTS) $$LSBDB <create_stored_procs.sql
#	mysql $(DBOPTS) $$LSBDB <cache_RLibRIntMapping.init
	rm -f cache*.init
	mysql $(DBOPTS) $$LSBDB <dbperms.sql;


# rules to process application data only

restore_apps::
	for table in $(APP_TABLES) ; \
	do \
		set +e; \
		echo $$table; \
	        mysql $(DBOPTS) $$LSBDB <$$table.sql; \
	        mysql $(DBOPTS) $$LSBDB <$$table.init; \
	done
	./create_cache_tables_inits.sh
	mysql $(DBOPTS) $$LSBDB <create_cache_tables.sql;
	mysql $(DBOPTS) $$LSBDB <cache_RIntNames.init;
	mysql $(DBOPTS) $$LSBDB <create_stored_procs.sql 
#       mysql $(DBOPTS) $$LSBDB <cache_RLibRIntMapping.init
	rm -f cache*.init
	mysql $(DBOPTS) $$LSBDB <dbperms.sql

dump_apps::
	for table in $(APP_TABLES) ; \
	do \
	        set +e; \
	        echo $$table; \
	        mysqldump --add-drop-table --no-data $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | grep -v 'Server version' >$$table.sql;\
	        mysqldump $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | LC_ALL=C grep INSERT >$$table.init;\
	done
