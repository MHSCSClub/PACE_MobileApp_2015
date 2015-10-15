<?php
	$db = new mysqli('localhost', 'super', '0x4D4853', 'memorymom');
	$sth = $db->query('SELECT * FROM user');
	$rows = array();
	while($r = $sth->fetch_assoc()) {
		$rows[] = $r;
	}
	echo json_encode($rows);
?>