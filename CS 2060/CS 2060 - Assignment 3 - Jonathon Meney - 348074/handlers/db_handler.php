<?php
// $dbServerName = "peicloud.ca";
// $dbUsername = "u120";
// $dbPassword = "u120";
// $dbName = "db120";


$dbServerName = "localhost";
$dbUsername = "root";
$dbPassword = "";
$dbName = "character_creator";

$db = mysqli_connect($dbServerName, $dbUsername, $dbPassword, $dbName);

if (!$db) {
    die("Connection Failed: " . mysqli_connect_error());
}

?>