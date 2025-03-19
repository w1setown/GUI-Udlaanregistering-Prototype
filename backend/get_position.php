<?php

require_once 'cors.php';
require_once 'dbcon.php';

$result = $conn->query("SELECT id, role FROM user_position");

$positions = [];
if ($result) {
    while ($row = $result->fetch_assoc()) {
        $positions[] = $row;
    }
}

echo json_encode($positions);

$conn->close();