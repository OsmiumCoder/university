<nav>
    <ol>
        <li class="left"><a href="index.php">Home</a></li>
        <li class="left"><a href="public_characters.php">Public Characters</a></li>
        <?php
            if (isset($_SESSION["userId"])) {
                echo '<li class="right"><a href="handlers/logout_handler.php">Logout</a></li>';
                echo '<li class="right"><a href="character_form.php">Create Character</a></li>';
                echo '<li class="right"><a href="personal_characters.php">Your Characters</a></li>';
            }
            else {
                echo '<li class="right"><a href="signup.php">Sign Up</a></li>';
                echo '<li class="right"><a href="login.php">Login</a></li>';
            }
        ?>
    </ol>
</nav>