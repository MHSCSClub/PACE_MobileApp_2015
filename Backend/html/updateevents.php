<?php
	$pid = $_POST['pid'];
	$db = new mysqli('localhost', 'super', '0x4D4853', 'memorymom');
	$stmt = $db->prepare('SELECT evtid, time, type, description FROM calender WHERE pid = ? ');
	$stmt->bind_param('d', $pid);
	$stmt->execute();
	$result = $stmt->get_result();
	$rows = array();
	while($r = $result->fetch_assoc()) {
		$rows[] = $r;
	}
	echo json_encode($rows);
?>