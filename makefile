#
# This makefile contains the command to dump out the database
#
# This avoids creating one huge file that take a long time to manipulate
#
DBOPTS=-h $$LSBDBHOST -u $$LSBUSER --password=$$LSBDBPASSWD

all:
	@echo "Please specify dump or restore"

dump::
	for table in `mysql $(DBOPTS) -e "SHOW TABLES" lsb | grep -v Tables` ;\
	do \
		set +e; \
		echo $$table; \
		mysqldump --add-drop-table --no-data $(DBOPTS) lsb $$table >$$table.sql;\
		mysqldump $(DBOPTS) lsb $$table | grep INSERT >$$table.init;\
	done

restore::
	mysql $(DBOPTS) lsb <setupdb.sql;
	for table in [A-Z]*sql ;\
	do \
		set +e; \
		table=`basename $$table .sql`; \
		echo $$table; \
		mysql $(DBOPTS) lsb <$$table.sql; \
		mysql $(DBOPTS) lsb <$$table.init; \
	done
	mysql $(DBOPTS) lsb <dbperms.sql;
