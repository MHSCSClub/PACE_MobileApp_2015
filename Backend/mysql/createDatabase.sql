
CREATE DATABASE memorymom;

USE memorymom;

CREATE TABLE user
(
	userid int unsigned not null auto_increment primary key,
	type char(50) not null
);

CREATE TABLE relation
(
	relid int unsigned not null auto_increment primary key,
	cid int unsigned not null,
	pid int unsigned not null
);

CREATE TABLE calender
(
	evtid int unsigned not null auto_increment primary key,
	pid int unsigned not null,
	time datetime not null,
	type char(50) not null,
	description TEXT
);

CREATE TABLE eventdata
(
	edid int unsigned not null auto_increment primary key,
	evtid int unsigned not null,
	fcid int unsigned
);

CREATE TABLE flashcard
(
	fcid int unsigned not null auto_increment primary key,
	name char(50) not null
	/*
		other data
	*/
);