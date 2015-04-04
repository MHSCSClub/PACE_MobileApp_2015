<?php
	$pid = $_POST['pid'];
	$fcid = $_POST['fcid'];
	$db = new mysqli('localhost', 'super', '0x4D4853', 'memorymom');
	$stmt = $db->prepare('SELECT name FROM flashcard WHERE pid = ? AND fcid > ?');
	$stmt->bind_param('dd', $pid, $fcid);
	$stmt->execute();
	$result = $stmt->get_result();
	$rows = array();
	while($r = $result->fetch_assoc()) {
		$rows[] = $r;
	}
	echo json_encode($rows);
?>