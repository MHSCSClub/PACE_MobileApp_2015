# MHSMobileAppDevBowl2015
Contains all the php code and ios code. PHP AND SERVER SET UP STUFF
once you set up the server open the ServerURL class and type in the root URL with all the php files and connection to the database.

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
