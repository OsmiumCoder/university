<?php

if (isset($_POST["submit"])) {
    session_start();
    $userId = $_SESSION["userId"];

    $name = $_POST["name"];
    $class = $_POST["class"];
    $background = $_POST["background"];
    $race = $_POST["race"];
    $health = $_POST["health"];
    $equipment = $_POST["equipment"];

    $strengthScore = $_POST["strengthscore"];
    $dexterityScore = $_POST["dexterityscore"];
    $constitutionScore = $_POST["constituitionscore"];
    $intelligenceScore = $_POST["intelligencescore"];
    $wisdomScore = $_POST["wisdomscore"];
    $charismaScore = $_POST["charismascore"];
    $abilityScores = array($strengthScore, $dexterityScore, $constitutionScore, $intelligenceScore, $wisdomScore, $charismaScore);

    $throws = $_POST["throws"];
    $proficiencies = $_POST["proficiencies"];
    $alignment = $_POST["alignment"];

    $backstory = $_POST["backstory"];

    $public = isset($_POST["public"]) ? 1 : 0;

    require_once 'db_handler.php';
    require_once 'functions.php';

    if (emptyFieldset($throws, $proficiencies, $alignment)) {
        header("location: ../character_form.php?error=emptyfieldset");
        exit();
    }
    if (raceUnselected($race)) {
        header("location: ../character_form.php?error=unselectedrace");
        exit();
    }
    
    createCharacter($db, $userId, $name, $class, $background, $race, $health, $equipment, $abilityScores, $throws, $proficiencies, $alignment, $backstory, $public);

} else {
    header("location: ../character_form.php");
}

?>