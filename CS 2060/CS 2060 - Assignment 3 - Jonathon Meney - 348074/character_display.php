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
    <div class="wrapper">
        <h1 style="text-align: center;">
            <?php 
                $data = $_GET["data"];
                echo $data["name"];
            ?>
        </h1>
        <?php
            $data = $_GET["data"];
            foreach ($data as $key => $value) {
                if ($key != "id" && $key != "user_id" && $key != "name" && $key != "public") {
                    if ($key != "throws" && $key != "proficiencies") {
                        if ($key == "alignment") {
                            $value = ucwords($value);
                        }
                        $key = ucfirst($key);
                        echo "<p>";
                        echo "<strong> $key: </strong>";
                        echo $value;
                        echo "</p>";
                    } else {
                        $value = unserialize($value);
                        $key = ucfirst($key);
                        echo "<p>";
                        echo "<strong> $key: </strong>";
                        foreach ($value as $key => $value) {
                            echo ucfirst($value) . " ";
                        }
                        echo "</p>";
                    }
                }
            }
        ?>
    </div>

    
</body>
</html>