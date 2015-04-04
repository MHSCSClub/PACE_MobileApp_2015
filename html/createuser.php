<?php
	$usertype = $_POST['usertype'];
	$db = new mysqli('localhost', 'super', '0x4D4853', 'memorymom');
	$stmt = $db->prepare('INSERT INTO user VALUES (NULL, ?)');
	$stmt->bind_param('s', $usertype);
	$stmt->execute();
	$res = $db->query('SELECT LAST_INSERT_ID()');
	$row = $res->fetch_assoc();
	echo $row['LAST_INSERT_ID()'];
?>