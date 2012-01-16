#
# This permission scheme allows lsbuser to create and
# manipulate temporary tables in separate db
#

# Allow lsbuser to create temporary tables - vital for DB Navigator
GRANT CREATE TEMPORARY TABLES ON * TO lsbuser@localhost;
GRANT INSERT,SELECT,DELETE ON * TO lsbuser@localhost;


FLUSH PRIVILEGES;
