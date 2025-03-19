<?php

require_once 'cors.php'; 
require_once 'dbcon.php'; 

header('Content-Type: application/json'); 

$data = json_decode(file_get_contents("php://input"), true);

if (isset($data['name'], $data['address'], $data['zip'], $data['city'], $data['cpr'], $data['class'], $data['email'], $data['position_id'])) {
    $name = $data['name'];
    $address = $data['address'];
    $zip = $data['zip'];
    $city = $data['city'];
    $cpr = $data['cpr'];
    $email = $data['email'];
    $class = $data['class'];
    $position_id = $data['position_id'];

    
    $stmt = $conn->prepare("INSERT INTO user (position_id, name, address, zip, city, email) VALUES (?, ?, ?, ?, ?, ?, ?,?)");
    $stmt->bind_param("ississ", $position_id, $name, $address, $zip, $city, $email);

    if ($stmt->execute()) {
        echo json_encode(['status' => 'success']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Failed to add user.']);
    }

    $stmt->close(); 
} else {
    echo json_encode(['status' => 'error', 'message' => 'Invalid input.']);
}

$conn->close(); 
?>
