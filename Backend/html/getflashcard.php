<?php
	$evtid = $_POST['evtid'];

	$db = new mysqli('localhost', 'super', '0x4D4853', 'memorymom');
	$stmt = $db->prepare('SELECT fcid FROM eventdata WHERE evtid = ?');
	$stmt->bind_param('d', $evtid);
	$stmt->execute();
	$result = $stmt->get_result();
	$rows = array();
	while($r = $result->fetch_assoc()) {
		$rows[] = $r;
	}
	echo json_encode($rows);
?>