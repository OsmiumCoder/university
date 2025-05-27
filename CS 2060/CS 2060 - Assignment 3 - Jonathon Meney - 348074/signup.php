<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>D&amp;D Character Creator</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <?php
        include_once 'navbar.php';
    ?>
    <div class="signupform">
        <form action="handlers/signup_handler.php" method="post">
            <h2>Sign Up</h2>
            <p>
                <label for="username">Enter Username:</label>
                <input type="text" name="username">
            </p>

            <p>
                <label for="password">Enter Password:</label>
                <input type="password" name="password">
            </p>

            <p>
                <label for="password_repeat">Re-enter Password:</label>
                <input type="password" name="password_repeat">
            </p>
            
            <p>
                <button type="submit" name="submit">Sign Up</button>
            </p>
        </form>

        <?php
            if (isset($_GET["error"])) {
                if ($_GET["error"] == "emptyfield") {
                    echo '<p style="color:red;">All fields must be filled.</p>';
                }
                if ($_GET["error"] == "passwordmismatch") {
                    echo '<p style="color:red;">Passwords are not the same.</p>';
                }
                if ($_GET["error"] == "usernametaken") {
                    echo '<p style="color:red;">Username already taken.</p>';
                }
                if ($_GET["error"] == "badstatement") {
                    echo '<p style="color:red;">Oops. Something went wrong on our end. Try again.</p>';
                }
            }

        ?>
    </div>

</body>
</html>