<?php
// =================
// SIGN UP FUNCTIONS
// =================

/**
 * Determines if any sign up form fields are empty.
 * 
 * @param string $username the string in the username field
 * @param string $password the string in the password field
 * @param string $passwordRepeat the string in the repeated password field
 * @return bool true if any field is empty, flase otherwise
 */
function emptySignUpField($username, $password, $passwordRepeat) {
    return empty($username) || empty($password) || empty($passwordRepeat);
}

/**
 * Determines if the two given passwords match.
 *
 * @param string $password the string in the password field
 * @param string $passwordRepeat the string in the repeated password field
 * @return bool true if the passwords match, false otherwise
 */
function pwdMatch($password, $passwordRepeat) {
    return $password == $passwordRepeat;
}

/**
 * Determines if a user is already in the database.
 *
 * @param \mysqli $db the database object to search for the username
 * @param string $username the username to search for
 * @return array|false false if the user does not exist, the table row of the user otherwise
 */
function usernameExists($db, $username) {
    $sql = "SELECT * FROM users WHERE username = ?;";
    $statement = mysqli_stmt_init($db);
    if (!mysqli_stmt_prepare($statement, $sql)) {
        header("location: ../signup.php?error=badstatement");
        exit();
    }

    mysqli_stmt_bind_param($statement, "s", $username);
    mysqli_stmt_execute($statement);

    $fetchedData = mysqli_stmt_get_result($statement);
    if ($row = mysqli_fetch_assoc($fetchedData)) {
        return $row;
    } else {
        return false;
    }
    mysqli_stmt_close($statement);
}

/**
 * Adds a new user to the database.
 *
 * @param \mysqli $db the database object to add the user into
 * @param string $username the username of the new user
 * @param string $password the password attached to the username
 * @return never
 */
function createUser($db, $username, $password) {
    $sql = "INSERT INTO users (username, pwd) VALUES (?, ?);";
    $statement = mysqli_stmt_init($db);
    if (!mysqli_stmt_prepare($statement, $sql)) {
        header("location: ../signup.php?error=badstatement");
        exit();
    }

    $hashPwd = password_hash($password, PASSWORD_DEFAULT);

    mysqli_stmt_bind_param($statement, "ss", $username, $hashPwd);
    mysqli_stmt_execute($statement);
    mysqli_stmt_close($statement);

    header("location: ../login.php?error=none");
    exit();
}

// ===============
// LOGIN FUNCTIONS
// ===============

/**
 * Determines if any of the login fields are empty.
 *
 * @param string $username the string in the username field
 * @param string $password the string in the password field
 * @return bool true if any field is empty, false otherwise
 */
function emptyLoginField($username, $password) {
    if (empty($username) || empty($password)) {
        return true;
    }
    return false;
}

/**
 * Logs in a user and binds them to a new session.
 *
 * @param \mysqli $db the database to check if the username given exists
 * @param string $username the username of the user trying to sign in
 * @param string $password the password associated with the given username
 * @return never
 */
function loginUser($db, $username, $password) {
    $user = usernameExists($db, $username);

    if (!$user) {
        header("location: ../login.php?error=usernotfound");
        exit();
    }

    $hashedPwd = $user["pwd"];
    $checkPwd = password_verify($password, $hashedPwd);

    if (!$checkPwd) {
        header("location: ../login.php?error=wrongpassword");
        exit();
    } 
    elseif ($checkPwd) {
        session_start();
        $_SESSION["userId"] = $user["id"];
        $_SESSION["username"] = $user["username"];
        header("location: ../index.php");
        exit();
    }

}

// =========================
// CHARACTER CREATOR FUNCTIONS
// =========================

/**
 * Determines if at least one option was selected in each fieldset of the form.
 *
 * @param array $throws an array of the selected saving throws
 * @param array $proficiencies an array of the selected proficiencies
 * @param string $alignment the selected alignment
 * @return bool true if any fieldset was left empty, false otherwise
 */
function emptyFieldset($throws, $proficiencies, $alignment) {
    return empty($throws) || empty($proficiencies) || empty($alignment);
}

/**
 * Determines if a race was selected from the dropdown.
 *
 * @param string $race the selected race from the form
 * @return bool true if a race wasn't selected, false otherwise
 */
function raceUnselected($race) {
    return $race == "--Select a Race--";
}

/**
 * Creates a new character in the database.
 *
 * @param \mysqli $db the database to add the character to
 * @param int $userId the id of the user currently signed in
 * @param string $name the name of the new character
 * @param string $class the class of the new character
 * @param string $background the background of the new character
 * @param string $race the race of the new character
 * @param int $health the max health of the new character
 * @param string $equipment the list of equipment the new character has
 * @param array $abilityScores an array of the new characters ability scores
 * @param array $throws an array of the saving throws the new character has 
 * @param array $proficiencies an array of the proficiencies the new character has
 * @param string $alignment the alignment of the new character
 * @param string $backstory the backstory of the new character
 * @param bool $public true if the character is visible to the public, false otherwise
 * @return never
 */
function createCharacter($db, $userId, $name, $class, $background, $race, $health, $equipment, $abilityScores, $throws, $proficiencies, $alignment, $backstory, $public) {
    $sql = "INSERT INTO characters (user_id, name, class, background, race, health, equipment, strength, dexterity, constitution, intelligence, wisdom, charisma, throws, proficiencies, alignment, backstory, public) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";
    $statement = mysqli_stmt_init($db);
    if (!mysqli_stmt_prepare($statement, $sql)) {
        header("location: ../character_form.php?error=badstatement");
        exit();
    }

    $throwsString = serialize($throws);
    $proficienciesString = serialize($proficiencies);

    mysqli_stmt_bind_param($statement, "ssssssssssssssssss",
                                        $userId, 
                                        $name,
                                        $class,
                                        $background,
                                        $race,
                                        $health,
                                        $equipment,
                                        $abilityScores[0],
                                        $abilityScores[1],
                                        $abilityScores[2],
                                        $abilityScores[3],
                                        $abilityScores[4],
                                        $abilityScores[5],
                                        $throwsString,
                                        $proficienciesString,
                                        $alignment,
                                        $backstory,
                                        $public);
    mysqli_stmt_execute($statement);
    mysqli_stmt_close($statement);

    header("location: ../personal_characters.php?error=none");
    exit(); 
}

/**
 * Retrieves the characters made by the user currently signed in.
 *
 * @param \mysqli $db the database to get the characters from
 * @param string $userId the userId of the currently signed in user to get characters of
 * @return \mysqli_result the resultant rows of characters retrieved
 */
function getCharacters($db, $userId) {
    $sql = "SELECT * FROM characters WHERE user_id = ?;";
    $statement = mysqli_stmt_init($db);
    if (!mysqli_stmt_prepare($statement, $sql)) {
        header("location: ../index.php?error=badstatement");
        exit();
    }

    mysqli_stmt_bind_param($statement, "s", $userId);
    mysqli_stmt_execute($statement);

    $fetchedData = mysqli_stmt_get_result($statement);
    mysqli_stmt_close($statement);
    return $fetchedData;
}

/**
 * Retrieves all characters made public when created.
 *
 * @param \mysqli $db the database to retrieve characters from
 * @return \mysqli_result the resultant rows of characters retrieved
 */
function getPublicCharacters($db) {
    $sql = "SELECT * FROM characters WHERE public;";
    $statement = mysqli_stmt_init($db);
    if (!mysqli_stmt_prepare($statement, $sql)) {
        header("location: ../index.php?error=badstatement");
        exit();
    }

    mysqli_stmt_execute($statement);

    $fetchedData = mysqli_stmt_get_result($statement);
    mysqli_stmt_close($statement);
    return $fetchedData;
}

?>