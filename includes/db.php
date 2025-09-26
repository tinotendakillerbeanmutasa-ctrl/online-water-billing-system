<?php
$host = "localhost";
$user = "root"; // Change to your MySQL username
$pass = ""; // Change to your MySQL password
db = "water_billing";

$conn = new mysqli($host, $user, $pass, $db);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>