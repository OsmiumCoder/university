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
        <h1 style="text-align: center;">Character Maker</h1>
        <p style="text-align: center;">Use this form to make a character. At least one saving throw, and one proficiency must be chosen.</p>
        <?php
            if (isset($_GET["error"])) {
                if ($_GET["error"] == "emptyfieldset") {
                    echo '<p style="color:red; text-align:center;">At least, one saving throw, and one proficiency must be chosen. An alignment must also be chosen.</p>';
                }
                if ($_GET["error"] == "unselectedrace") {
                    echo '<p style="color:red; text-align:center;">A race must be selected</p>';
                }
                if ($_GET["error"] == "badstatement") {
                    echo '<p style="color:red; text-align:center;">Oops. Something went wrong on our end. Try again.</p>';
                }
            }
        ?>
        <form action="handlers/character_maker_handler.php" method="post" autocomplete="off">
            <p>
                <label for="name">Character Name:</label>
                <input type="text" name="name" required>
            </p>

            <p>
                <label for="class">Class:</label>
                <input type="text" name="class" required>
            </p>

            <p>
                <label for="background">Background:</label>
                <input type="text" name="background" required>
            </p>

            <p>
                <label for="race">Race:</label>
                <select name="race">
                    <option value="">--Select a Race--</option>
                    <option value="Human">Human</option>
                    <option value="Elf">Elf</option>
                    <option value="Dwarf">Dwarf</option>
                </select>
            </p>

            <p>
                <label for="health">Health:</label>
                <input type="number" name="health" min="0" max="1000" required>
            </p>

            <p>
                <label for="equipment">Equipment:</label>
                <textarea required name="equipment" style="width: 100%;" rows="10" placeholder="Write your character's equipment here."></textarea>
            </p>

            <fieldset style="margin-bottom: 16px;">
                <legend>Ability Scores</legend>
                <p>
                    <label for="strengthscore">Strength:</label>
                    <input required type="number" name="strengthscore" min="6" max="20">
                </p>
                <p>
                    <label for="dexterityscore">Dexterity:</label>    
                    <input required type="number" name="dexterityscore" min="6" max="20">
                </p>
                <p>
                    <label for="constituitionscore">Constitution:</label>    
                    <input required type="number" name="constituitionscore" min="6" max="20">
                </p>
                <p>
                    <label for="intelligencescore">Intelligence:</label>    
                    <input required type="number" name="intelligencescore" min="6" max="20">
                </p>
                <p>
                    <label for="wisdomscore">Wisdom:</label>    
                    <input required type="number" name="wisdomscore" min="6" max="20">
                </p>
                <p>
                    <label for="charismascore">Charisma:</label>    
                    <input required type="number" name="charismascore" min="6" max="20">
                </p>
            </fieldset>

            <fieldset style="margin-bottom: 16px;">
                <legend>Saving Throws</legend>
                <p>
                    <input type="checkbox" name="throws[]" value="strength">
                    <label for="strength">Strength</label>
                </p>
                <p>
                    <input type="checkbox" name="throws[]" value="dexterity">
                    <label for="dexterity">Dexterity</label>
                </p>
                <p>
                    <input type="checkbox" name="throws[]" value="constitution">
                    <label for="constitution">Constitution</label>
                </p>
                <p>
                    <input type="checkbox" name="throws[]" value="intelligence">
                    <label for="intelligence">Intelligence</label>
                </p>
                <p>
                    <input type="checkbox" name="throws[]" value="wisdom">
                    <label for="wisdom">Wisdom</label>
                </p>
                <p>
                    <input type="checkbox" name="throws[]" value="charisma">
                    <label for="charisma">Charisma</label>
                </p>
            </fieldset>

            <fieldset style="margin-bottom: 16px;">
                <legend>Skills</legend>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="acrobatics">
                    <label for="acrobatics">Acrobatics</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="animal handling">
                    <label for="animal_handling">Animal Handling</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="arcana">
                    <label for="arcana">Arcana</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="athletics">
                    <label for="athletics">Athletics</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="deception">
                    <label for="deception">Deception</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="history">
                    <label for="history">History</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="insight">
                    <label for="insight">Insight</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="intimidation">
                    <label for="intimidation">Intimidation</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="investigation">
                    <label for="investigation">Investigation</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="medicine">
                    <label for="medicine">Medicine</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="nature">
                    <label for="nature">Nature</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="perception">
                    <label for="perception">Perception</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="performance">
                    <label for="performance">Performance</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="persuasion">
                    <label for="persuasion">Persuasion</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="religion">
                    <label for="religion">Religion</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="sleight of hand">
                    <label for="sleight_of_hand">Sleight of Hand</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="stealth">
                    <label for="stealth">Stealth</label>
                </p>
                <p>
                    <input type="checkbox" name="proficiencies[]" value="survival">
                    <label for="survival">Survival</label>
                </p>
            </fieldset>

            <fieldset>
                <legend>Alignment</legend>
                <p>
                    <input type="radio" name="alignment" value="lawful good">
                    <label for="lg">Lawful Good</label>
                </p>
                <p>
                    <input type="radio" name="alignment" value="lawful neutral">
                    <label for="ln">Lawful Neutral</label>
                </p>
                <p>
                    <input type="radio" name="alignment" value="lawful evil">
                    <label for="le">Lawful Evil</label>
                </p>
                <p>
                    <input type="radio" name="alignment" value="neutral good">
                    <label for="ng">Neutral Good</label>
                </p>
                <p>
                    <input type="radio" name="alignment" value="neutral">
                    <label for="nn">Neutral Neutral</label>
                </p>
                <p>
                    <input type="radio" name="alignment" value="neutral evil">
                    <label for="ne">Neutral Evil</label>
                </p>
                <p>
                    <input type="radio" name="alignment" value="chaotic good">
                    <label for="cg">Chaotic Good</label>
                </p>
                <p>
                    <input type="radio" name="alignment" value="chaotic neurtal">
                    <label for="cn">Chaotic Neutral</label>
                </p>
                <p>
                    <input type="radio" name="alignment" value="chatotic evil">
                    <label for="ce">Chaotic Evil</label>
                </p>
                
            </fieldset>

            <p>
                <label for="backstory">Backstory:<br></label>
                <textarea required name="backstory" style="width: 100%;" rows="10" placeholder="Write your character's backstory here."></textarea>
            </p>

            <p>
                <label for="public">If you would like this character to be visible to the public check this box.</label>
                <input type="checkbox" name="public">
            </p>
            
            <p>
                <input type="submit" name="submit">
            </p>
        </form>
    </div>

</body>
</html>