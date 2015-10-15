<?php
	$pid = $_POST['pid'];
	$cid = $_POST['cid'];
	$db = new mysqli('localhost', 'super', '0x4D4853', 'memorymom');
	function check($db, $id, $type) 
	{
		$stmt = $db->prepare('SELECT type FROM user WHERE userid=?');
		$stmt->bind_param('d', $id);
		$stmt->execute();
		$res = $stmt->get_result();
		$ar = $res->fetch_assoc();
		if($ar['type'] == $type)
			return true;
		return false;
	}
	if(check($db, $pid, 'patient') && check($db, $cid, 'caretaker')) {
		$stmt = $db->prepare('SELECT * FROM relation WHERE cid=? AND pid=?');
		$stmt->bind_param('dd', $cid, $pid);
		$stmt->execute();
		$ar = $stmt->get_result()->fetch_assoc();
		if(sizeof($ar) != 0) {
			echo 'Entry error';
			exit();
		}
		$stmt = $db->prepare('INSERT INTO relation VALUES (NULL, ?, ?)');
		$stmt->bind_param('dd', $cid, $pid);
		$stmt->execute();
	} else {
		echo 'Error';
	}
?>