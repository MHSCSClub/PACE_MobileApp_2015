<?php
	$pid = $_POST['pid'];
	$time = $_POST['time'];
	$type = $_POST['type'];
	$desc = $_POST['description'];

	$db = new mysqli('localhost', 'super', '0x4D4853', 'memorymom');
	$stmt = $db->prepare('INSERT INTO calender VALUES (NULL, ?, ?, ?, ?)');
	$stmt->bind_param('dsss', $pid, $time, $type, $desc);
	$stmt->execute();
	$res = $db->query('SELECT LAST_INSERT_ID()');
	$row = $res->fetch_assoc();
	$evtid = $row['LAST_INSERT_ID()'];
	echo $evtid;

	$len = $_POST['fclen'];
	$stmt = $db->prepare('INSERT INTO eventdata VALUES (NULL, ?, ?)');
	for($i = 0; $i < $len; ++$i) {
		$fcid = $_POST['fc'.$i];
		$stmt->bind_param('dd', $evtid, $fcid);
		$stmt->execute();
	}
?>