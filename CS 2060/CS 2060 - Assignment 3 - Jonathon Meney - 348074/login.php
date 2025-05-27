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
    <div class="loginform">
        <form action="handlers/login_handler.php" method="post">
            <h2>Login</h2>
            <p>
                <label for="username">Enter Username:</label>
                <input type="text" name="username">
            </p>

            <p>
                <label for="password">Enter Password:</label>
                <input type="password" name="password">
            </p>
            
            <p>
                <button type="submit" name="submit">Login</button>
            </p>
        </form>

        <?php
            if (isset($_GET["error"])) {
                if ($_GET["error"] == "emptyfield") {
                    echo '<p style="color:red;">All fields must be filled.</p>';
                }
                if ($_GET["error"] == "usernotfound") {
                    echo '<p style="color:red;">User not found.</p>';
                }
                if ($_GET["error"] == "wrongpassword") {
                    echo '<p style="color:red;">Incorrect Password.</p>';
                }
                if ($_GET["error"] == "badstatement") {
                    echo '<p style="color:red;">Oops. Something went wrong on our end. Try again.</p>';
                }
                if ($_GET["error"] == "none") {
                    echo '<p style="color:royalblue;">Account Successfully Created.</p>';
                }
            }

        ?>
    </div>
    
</body>
</html>