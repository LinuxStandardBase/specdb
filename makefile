#
# This makefile contains the command to dump out the database
#
# This avoids creating one huge file that take a long time to manipulate
#
DBOPTS=-h $$LSBDBHOST -u $$LSBUSER --password=$$LSBDBPASSWD
DUMPOPTS=--quote-names --extended-insert=false

all:
	@echo "Please specify dump or restore"

dump::
	for table in `mysql $(DBOPTS) -e "SHOW TABLES" $$LSBDB | grep -v Tables` ;\
	do \
		set +e; \
		echo $$table; \
		mysqldump --add-drop-table --no-data $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | grep -v 'Server version' >$$table.sql;\
		mysqldump $(DBOPTS) $(DUMPOPTS) $$LSBDB $$table | grep INSERT >$$table.init;\
	done

restore::
	mysql $(DBOPTS) $$LSBDB <setupdb.sql;
	sleep 5
	LC_ALL=C $(SHELL) -c 'for table in [A-Z]*sql ;\
	do \
		set +e; \
		table=`basename $$table .sql`; \
		echo $$table; \
		mysql $(DBOPTS) $$LSBDB <$$table.sql; \
		mysql $(DBOPTS) $$LSBDB <$$table.init; \
	done'
	mysql $(DBOPTS) $$LSBDB <dbperms.sql;
