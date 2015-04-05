<?php
	$usertype = $_POST['usertype'];
	if(!($usertype == 'patient' || $usertype == 'caretaker')) {
		echo 'Error';
		exit();
	}
	$db = new mysqli('localhost', 'super', '0x4D4853', 'memorymom');
	$stmt = $db->prepare('INSERT INTO user VALUES (NULL, ?)');
	$stmt->bind_param('s', $usertype);
	$stmt->execute();
	$res = $db->query('SELECT LAST_INSERT_ID()');
	$row = $res->fetch_assoc();
	echo $row['LAST_INSERT_ID()'];
?>