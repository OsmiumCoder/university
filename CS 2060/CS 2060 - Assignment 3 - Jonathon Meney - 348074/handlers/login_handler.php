<?php

if (isset($_POST["submit"])) {
    $username = $_POST["username"];
    $password = $_POST["password"];

    require_once 'db_handler.php';
    require_once 'functions.php';

    if (emptyLoginField($username, $password)) {
        header("location: ../login.php?error=emptyfield");
        exit();
    }

    loginUser($db, $username, $password);
    
} else {
    header("location: ../login.php");
    exit();
}

?>