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
GRANT INSERT,UPDATE,DELETE on lsb.Architecture TO lsbadmin;
GRANT INSERT,UPDATE,DELETE on lsb.Constant TO lsbadmin;
GRANT INSERT,UPDATE,DELETE on lsb.Header TO lsbadmin;
GRANT INSERT,UPDATE,DELETE on lsb.HeaderGroup TO lsbadmin;
GRANT INSERT,UPDATE,DELETE on lsb.Interface TO lsbadmin;
GRANT INSERT,UPDATE,DELETE on lsb.LibGroup TO lsbadmin;
GRANT INSERT,UPDATE,DELETE on lsb.LGInt TO lsbadmin;
GRANT INSERT,UPDATE,DELETE on lsb.Library TO lsbadmin;
GRANT INSERT,UPDATE,DELETE on lsb.Parameter TO lsbadmin;
GRANT INSERT,UPDATE,DELETE on lsb.Standard TO lsbadmin;
GRANT INSERT,UPDATE,DELETE on lsb.Version TO lsbadmin;
GRANT INSERT,DELETE        on lsb.VerInt TO lsbadmin;
#
# The rest should be "read Only" from the localhost
#
GRANT SELECT on lsb.* to lsbuser;
GRANT SELECT on lsb.* to lsbadmin;
#
# Make it take affect
#
FLUSH PRIVILEGES

