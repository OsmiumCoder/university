<?php

if (isset($_POST["submit"])) {
    
    $username = $_POST["username"];
    $password = $_POST["password"];
    $passwordRepeat = $_POST["password_repeat"];
    
    require_once 'db_handler.php';
    require_once 'functions.php';

    if (emptySignUpField($username, $password, $passwordRepeat)) {
        header("location: ../signup.php?error=emptyfield");
        exit();
    }
    
    if (!pwdMatch($password, $passwordRepeat)) {
        header("location: ../signup.php?error=passwordmismatch");
        exit();
    }
    if (usernameExists($db, $username)) {
        header("location: ../signup.php?error=usernametaken");
        exit();
    }

    createUser($db, $username, $password);


} else {
    header("location: ../signup.php");
}

?>