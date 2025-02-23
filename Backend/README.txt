Your request should go to:

http://aakatz3.asuscomm.com:8085/mobile/

**New standard: EVERY reply is in JSON
Also even if you recieve no response, it is good if the server status 200 OK, 
in case of an error, the server will send back 500 server error

What your app needs to do for the backend:

On startup:

The app needs to communicate with the server. Send a POST request with (for now):
	usertype = 'patient' / 'caretaker'
To /createuser.php
The server will create a user and send back just the userid 
You should store the userid locally

If the user is a patient, you should display the userid
If the user is a caretaker, you should give them an option to enter the userid
After entering the patient userid, send another POST request with (for now):
	pid = the patient user id
	cid = your user id
To /linkpatient.php

On update:

Patient:

Events:
Send a POST request with:
	pid = stored patient id
To /updateevents.php
The server will return, in the following format, all events in JSON format with the matching pid:

evtid = event id 
time = date and time 
type = type of event
title = title of event
descrition = description 

Now you have all created events

To get the flashcards on an event, you must send a POST request with:
	evtid = event id
To /getflashcards.php
The server will return, in the following format, the flash card IDS (not the actual cards) in the JSON format:

fcid: flash card id

Flashcards:
Of course, this is useless without the actual flashcards. However flashcards are expensive (images), so store a local version on you phont
In the server, flash cards will be identified by a unique id. You will send your greatest flashcard id, and the server will give you all 
the flashcards with pid matching your pid and id greater than current.

Send a POST request with:
	pid = patient id
	fcid = greatest current flashcard id
To /updateflashcard.php
The server will return (in JSON):

fcid: flashcard id
other info

Store the greatest id you recieve

Caretaker:

Get all your patient ids, update like you would each patient.
Get all patient ids, send a POST request with:
	cid = caretaker id
To /getpatients.php
You will receive all patient ids in the JSON format:

pid: patient id

Creation (caretaker only):

New events:
To create new events, you must send the following in a POST request:
	pid = patient id
	time = date and time
	type = type of event
	title = title of the event
	description = description of event
Flashcards associated with the event will be passed like this:
	fclen = # of flashcards
	fc0 ... fclen - 1: id of each flashcard
To /createevent.php

New flashcards:
To create new flashcards, send the following in a POST request:
	pid = patient id
	name = name of person
	info = info
	picture = picture of person (THIS IS A FILE)
Note that picture must be uploaded through a FILE POST request, you can test FILE POST requests to /filetest.php
To /createflashcard.php
Server will return the highest indexed flashcard:
	fcid: highest flashcard id

