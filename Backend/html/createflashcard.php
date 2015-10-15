<?php
	$pid = $_POST['pid'];
	$name = $_POST['name'];

	$db = new mysqli('localhost', 'super', '0x4D4853', 'memorymom');
	$stmt = $db->prepare('INSERT INTO flashcard VALUES (NULL, ?, ?)');
	$stmt->bind_param('ds', $pid, $name);
	$stmt->execute();
	$res = $db->query('SELECT LAST_INSERT_ID()');
	$row = $res->fetch_assoc();
	echo $row['LAST_INSERT_ID()'];
?>