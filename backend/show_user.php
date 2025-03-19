<?php

require_once 'cors.php'; 
require_once 'dbcon.php';

header('Content-Type: application/json');

$query = "SELECT id, position_id, name, address, zip, city, cpr, email, class, is_blacklisted FROM user"; 
$result = $conn->query($query);

$users = [];
if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $users[] = $row;
    }
}

echo json_encode($users);
