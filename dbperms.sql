#
# This permission scheme allows two users to be defined
#
# lsbuser
#	This user may browse the DB, but not make any changes.
#
# lsbadmin@localhost
#	This user may make any changes to the DB.
#

#
# Open up these tables for the LSB db admin
#
GRANT INSERT,UPDATE,DELETE ON Architecture TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON ArchConst TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON ArchClass TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON ArchDE TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON ArchES TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON ArchLib TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON ArchInt TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON ArchType TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON BaseTypes TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON ClassInfo TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON ClassVtab TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON Command TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON Constant TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON DynamicEntries TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON ElfSections TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON Header TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON HeaderGroup TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON Interface TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON InterfaceAttribute TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON LGInt TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON LibGroup TO lsbadmin@localhost;
# Only want to allow certain column to be edited
#GRANT INSERT,UPDATE ON Library TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON SModCmd TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON SModLib TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON Parameter TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON RpmTag TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON SectionTypes TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON Standard TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON Type TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON TypeMember TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON TypeMemberExtras TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON Version TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON Vtable TO lsbadmin@localhost;
#
# The rest should be "read Only" from the localhost
#
GRANT SELECT ON * TO lsbuser@localhost;
GRANT SELECT ON * TO lsbadmin@localhost;

# Allow lsbuser to create temporary tables - vital for DB Navigator
GRANT CREATE TEMPORARY TABLES ON lsb.* TO lsbuser@localhost;

# Allow lsbuser to add interface comments; authentication here will go
# through the linux-foundation wiki
GRANT INSERT ON InterfaceComment TO lsbuser@localhost;
GRANT INSERT ON InterfaceVote TO lsbuser@localhost;

FLUSH PRIVILEGES;
