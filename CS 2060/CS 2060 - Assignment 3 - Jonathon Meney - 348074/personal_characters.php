<?php
    session_start();
?>

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

    <div class="wrapper" style="text-align: center;">
        <h1 style="text-align: center;">Your Characters</h1>
        <p>Here you can find a list of all the characters that you have created. Click on a name to view its contents.</p>
        <?php
            if (isset($_GET["error"])) {
                if ($_GET["error"] == "none") {
                    echo '<p style="color:royalblue; text-align:center;">Character successfully made.</p>';
                }
            }
        ?>
        <div class="character_list">
            <?php
                require_once 'handlers/db_handler.php';
                require_once 'handlers/functions.php';
                $rows = getCharacters($db, $_SESSION["userId"]);
                while ($row = mysqli_fetch_assoc($rows)) {
                    $dataArray = array("data" => $row);
                    $data = http_build_query($dataArray);
                    echo '<p><a href="character_display.php?' . $data . '">' . $row["name"] . '</a></p>';
                }
                
            ?>
        </div>
    </div>

</body>
</html>