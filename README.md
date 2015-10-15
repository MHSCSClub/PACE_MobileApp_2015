# MHSMobileAppDevBowl2015
Contains all the php code and ios code.


Table information:

	calender
	+-------------+------------------+------+-----+---------+----------------+
	| Field       | Type             | Null | Key | Default | Extra          |
	+-------------+------------------+------+-----+---------+----------------+
	| evtid       | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
	| pid         | int(10) unsigned | NO   |     | NULL    |                |
	| time        | datetime         | NO   |     | NULL    |                |
	| type        | char(50)         | NO   |     | NULL    |                |
	| title       | char(50)         | YES  |     | NULL    |                |
	| description | text             | YES  |     | NULL    |                |
	+-------------+------------------+------+-----+---------+----------------+
	
	eventdata
	+-------+------------------+------+-----+---------+----------------+
	| Field | Type             | Null | Key | Default | Extra          |
	+-------+------------------+------+-----+---------+----------------+
	| edid  | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
	| evtid | int(10) unsigned | NO   |     | NULL    |                |
	| fcid  | int(10) unsigned | YES  |     | NULL    |                |
	+-------+------------------+------+-----+---------+----------------+
	
	flashcard
	+---------+------------------+------+-----+---------+----------------+
	| Field   | Type             | Null | Key | Default | Extra          |
	+---------+------------------+------+-----+---------+----------------+
	| fcid    | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
	| pid     | int(10) unsigned | YES  |     | NULL    |                |
	| name    | char(50)         | NO   |     | NULL    |                |
	| info    | text             | YES  |     | NULL    |                |
	| picture | mediumblob       | YES  |     | NULL    |                |
	+---------+------------------+------+-----+---------+----------------+
	
	relation
	+-------+------------------+------+-----+---------+----------------+
	| Field | Type             | Null | Key | Default | Extra          |
	+-------+------------------+------+-----+---------+----------------+
	| relid | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
	| cid   | int(10) unsigned | NO   |     | NULL    |                |
	| pid   | int(10) unsigned | NO   |     | NULL    |                |
	+-------+------------------+------+-----+---------+----------------+
	
	user
	+--------+------------------+------+-----+---------+----------------+
	| Field  | Type             | Null | Key | Default | Extra          |
	+--------+------------------+------+-----+---------+----------------+
	| userid | int(10) unsigned | NO   | PRI | NULL    | auto_increment |
	| type   | char(50)         | NO   |     | NULL    |                |
	+--------+------------------+------+-----+---------+----------------+	
	
The name of the database should be `memorymom`, you must also create an administrative user with credentials:

	username: super
	password: 0x4D4853
Once you set up the server open the `ServerURL` class in the app content and type in the root URL for the server location. 
