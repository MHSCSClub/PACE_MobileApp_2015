<?php
	$cid = $_POST['cid'];

	$db = new mysqli('localhost', 'super', '0x4D4853', 'memorymom');
	$stmt = $db->prepare('SELECT pid FROM relation WHERE cid = ?');
	$stmt->bind_param('d', $cid);
	$stmt->execute();
	$result = $stmt->get_result();
	$rows = array();
	while($r = $result->fetch_assoc()) {
		$rows[] = $r;
	}
	echo json_encode($rows);
?>