#
# This permission scheme allows two users to be defined
#
# lsbuser
#	This user may browse the DB, but not make any changes.
#
# lsbadmin
#	This user may make any changes to the DB.
#

#
# Open up these tables for the LSB db admin
#
GRANT INSERT,UPDATE,DELETE ON lsb.Architecture TO lsbadmin;
GRANT INSERT,UPDATE,DELETE ON lsb.Constant TO lsbadmin;
GRANT INSERT,UPDATE,DELETE ON lsb.Header TO lsbadmin;
GRANT INSERT,UPDATE,DELETE ON lsb.HeaderGroup TO lsbadmin;
GRANT INSERT,UPDATE,DELETE ON lsb.Interface TO lsbadmin;
GRANT INSERT,UPDATE,DELETE ON lsb.LibGroup TO lsbadmin;
GRANT INSERT,UPDATE,DELETE ON lsb.LGInt TO lsbadmin;
# Only want to allow certain column to be edited
#GRANT INSERT,UPDATE ON lsb.Library TO lsbadmin;
GRANT INSERT,UPDATE,DELETE ON lsb.Parameter TO lsbadmin;
GRANT INSERT,UPDATE,DELETE ON lsb.Standard TO lsbadmin;
GRANT INSERT,UPDATE,DELETE ON lsb.Version TO lsbadmin;
GRANT INSERT,DELETE        ON lsb.VerInt TO lsbadmin;
#
# The rest should be "read Only" from the localhost
#
GRANT SELECT ON lsb.* TO lsbuser;
GRANT SELECT ON lsb.* TO lsbadmin;

FLUSH PRIVILEGES;
