-- MySQL dump 8.21
--
-- Host: localhost    Database: lsb
---------------------------------------------------------

--
-- Table structure for table 'Vtable'
--

DROP TABLE IF EXISTS Vtable;
CREATE TABLE Vtable (
  VTcid int(11) NOT NULL default '0',
  VTpos int(11) NOT NULL default '0',
  VTviid int(11) NOT NULL default '0',
  PRIMARY KEY  (VTcid,VTpos)
) TYPE=MyISAM;

