-- MySQL dump 8.21
--
-- Host: localhost    Database: lsb
---------------------------------------------------------

--
-- Table structure for table 'ClassInfo'
--

DROP TABLE IF EXISTS ClassInfo;
CREATE TABLE ClassInfo (
  CIid int(11) NOT NULL auto_increment,
  CIname varchar(128) NOT NULL default '',
  CItid int(11) NOT NULL default '0',
  CIvtable int(11) NOT NULL default '0',
  CInumvfunc int(11) NOT NULL default '0',
  CIrtti int(11) NOT NULL default '0',
  CInumbasetype int(11) NOT NULL default '0',
  CIbase int(11) NOT NULL default '0',
  CInumvmitypes int(11) NOT NULL default '0',
  CIflags int(11) NOT NULL default '0',
  CIvcalloffset int(11) NOT NULL default '0',
  CIbaseoffset int(11) NOT NULL default '0',
  CIbasevtable int(11) NOT NULL default '0',
  CIlibg int(11) NOT NULL default '0',
  CIvtclass tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (CIid),
  UNIQUE KEY CIname (CIname),
  KEY CIlibg (CIlibg)
) TYPE=MyISAM;

