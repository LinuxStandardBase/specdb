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
GRANT INSERT,UPDATE,DELETE ON lsb.Architecture TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.ArchConst TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.ArchLib TO lsbadmin@localhost;
GRANT INSERT,DELETE        ON lsb.ArchInt TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.ArchType TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.ArchTypeMem TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.CmdInt TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.CmdLib TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.Command TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.Constant TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.DynamicEntries TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.ElfSections TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.Header TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.HeaderGroup TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.Interface TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.LGInt TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.LibGroup TO lsbadmin@localhost;
# Only want to allow certain column to be edited
#GRANT INSERT,UPDATE ON lsb.Library TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.Parameter TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.SectionTypes TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.Standard TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.Type TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.TypeMember TO lsbadmin@localhost;
GRANT INSERT,DELETE        ON lsb.VerInt TO lsbadmin@localhost;
GRANT INSERT,UPDATE,DELETE ON lsb.Version TO lsbadmin@localhost;
#
# The rest should be "read Only" from the localhost
#
GRANT SELECT ON lsb.* TO lsbuser@localhost;
GRANT SELECT ON lsb.* TO lsbadmin@localhost;

FLUSH PRIVILEGES;
