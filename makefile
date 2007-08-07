#
# This makefile contains the commands to dump out the database by table
# This avoids creating one huge file that take a long time to manipulate
#
# It also allows populating (or re-populating) a database
#

DBOPTS=-h $$LSBDBHOST -u $$LSBUSER --password=$$LSBDBPASSWD
DUMPOPTS=--quote-names --extended-insert=false

ELEMENTS=AbiApi AbiMacro ArchClass ArchConst ArchDE ArchES ArchInt Architecture \
	ArchLib ArchType BaseTypes ClassInfo ClassVtab Command \
	Constant DynamicEntries ElfSections Header \
	HeaderGroup Interface InterfaceAttribute LGInt LibGroup \
	Library LSBVersion ModCmd ModLib Module Parameter RpmTag SectionTypes \
	Standard Type TypeMember TemplateParameter TypeMemberExtras TypeType Version \
	VMIBaseTypes Vtable

all:
	@echo "Please specify dump or restore"

dump::
	for table in `mysql $(DBOPTS) -e "SHOW TABLES" $$LSBDB | grep -v Tables | grep -v cache_` ;\
	do \
		set +e; \
		echo $$table; \
		mysqldump --add-drop-table --no-data $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | grep -v 'Server version' >$$table.sql;\
		mysqldump $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | grep INSERT >$$table.init;\
	done

restore::
	@mysqladmin $(DBOPTS) drop $$LSBDB
	@mysqladmin $(DBOPTS) create $$LSBDB
	#mysql $(DBOPTS) $$LSBDB <setupdb.sql;
	sleep 5
	LC_ALL=C $(SHELL) -c 'for table in [A-Z]*sql ;\
	do \
		set +e; \
		table=`basename $$table .sql`; \
		echo $$table; \
		mysql $(DBOPTS) $$LSBDB <$$table.sql; \
		mysql $(DBOPTS) $$LSBDB <$$table.init; \
		mysql $(DBOPTS) $$LSBDB -e "ANALYZE TABLE $$table"; \
	done'
	mysql $(DBOPTS) $$LSBDB <create_cache_tables.sql;
	mysql $(DBOPTS) $$LSBDB <dbperms.sql;

# these two rules dump/restore the "LSB Elements" only,
# not any of the other database info.  This is only for
# performance for developers fiddling with elements,
# otherwise the full dump/restore is safer
dumpelements::
	for table in $(ELEMENTS) ; \
	do \
		set +e; \
		echo $$table; \
		mysqldump --add-drop-table --no-data $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | grep -v 'Server version' >$$table.sql;\
		mysqldump $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | grep INSERT >$$table.init;\
	done

elements::
	for table in $(ELEMENTS) ; \
	do \
		set +e; \
		echo $$table; \
		mysql $(DBOPTS) $$LSBDB <$$table.sql; \
		mysql $(DBOPTS) $$LSBDB <$$table.init; \
	done
