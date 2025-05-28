## Lab 01 - Dart basics


The following lab follows from the Text: Flutter Complete Reference - Alberto Miola (Chapters 2 and 3)

This lab can be completed on DartPad (or completed into a local file (e.g. lab_01.dart) and compiled and run using dart lab_01.dart). There is no deliverable. The objective is to introduce and familiarize ourselves with the dart language basics through practice and examples.

## Get Started:
### Navigate to DartPad.dev in the browser
 - (or similarly open your favourite editor with a file called lab01.dart).

## Task 1 (Easing into it)

###Print your first name then print it in reverse.

Starting from a blank dart program.

**A.** Create a main method:

```Dart
void main() {

}

```

**B.** Within that method create and initialize a `String` variable called `firstName`, initialized with your first name.

<details><summary>Hint</summary>
<p>

#### not too tough so far:
```dart
void main() {
  String firstName = "Andrew"; //did you use var or String?
}
```

</p>
</details>

**C.** Print the last character of the String out to the console only.
  - Did you notice that DartPad has code suggestions and completion? try: **firstName.**
  - (can you use one of the suggestions to complete this task?)
  - Does your code work for any String (or did you hardcode the index position)?
<details><summary>Hint</summary>
<p>

```dart
void main() {
  String firstName = "Andrew";
  print(firstName[firstName.length-1]);
}
```

</p>
</details>
<br>

**D.** Print the String out in reverse


A for-loop in Dart might take this general form,
with the initialization, termination clause and increment rules going into the for loop header:

```Dart
for(var i = 0; i < X; i++) {
  //body of the loop
}
```

Use a for-loop to complete this task

<details><summary>Hint</summary>
<p>

```dart
void main(){

  String firstName = "Andrew";
  print(firstName[firstName.length-1]);

  for(var i = firstName.length-1; i >= 0; i--) {
    print(firstName[i]);
  }
}
```

</p>
</details>
<br>

**E.** Add a comment at the top of the program:
Note: /// is a Dartdoc style comment (more on this later)

```Dart
/// Prints a String in reverse order (CS3130 Lab 1, Task 1)
```

run your program and ensure everything is working.

*Task 1 Complete*

## Task 2 - Random Dice Rolls

Start with a New Pad in DartPad (or a new blank .dart program)

Libraries in dart can be imported (made visible to your scope) using the **import** keyword. For example the built-in math library has some useful functionality and can be imported by adding this to the top of a program:

import 'dart:math';

Note that a Random integer between 0 (inclusive) and max (exclusive) can be generated with the following code:

```Dart
  //https://dart.dev/guides/language/effective-dart/style#prefer-using-lowercamelcase-for-constant-names
  const max = 6; //
  Random rnd = new Random(); //or var rnd = new Random();
  int value = rnd.nextInt(max); //or var value = rnd.nextInt(max);

```

In this task simulate a simple game where two people alternate rolling a single die for a total of 10 times each and the player with the highest cumulative value (sum of all rolls) wins.

The game should conclude at the earliest point that the game is decided. i.e., if I have made 10 die rolls and have an cumulative score of 20 and you have rolled 9 times (meaning your last roll could be next) but your total score is 13, then the game should end. Rational: You can roll a max of 6 in a single roll and therefore your max possible score is 19 which is a losing score, so the game simply ends immediately without you having rolled a tenth time.

**A.** Create a `diceRoll` function that simulates rolling the die. It should return a random value between 1 and 6 (inclusive)

A typical function can look like this in Dart:

```Dart
/// dartdoc style comments
return_type functionName (parameter list) {

  //body of the function here

}

```

<details><summary>Hint</summary>
<p>

```dart
import 'dart:math';

/// notice the below function documentation (comment at the top of the function) is a 3rd person verb
/// see: https://dart.dev/guides/language/effective-dart/documentation

/// Returns a random integer between 1 and 6 inclusive
int diceRoll(){

  var rnd = new Random();
  return rnd.nextInt(6) + 1;
}

void main() {

  //nothing to see here yet

}

```



If you wanted to get fancy or more compact you can use the arrow syntax to complete the function in one line:

```dart
///Returns a random integer between 1 and 6
int diceRoll() => new Random().nextInt(6)+1;
```
</p>
</details>
<br>

**B.** Call your `diceRoll` method in `main` and print the result. Run the program a few times to ensure things are working.

```dart
void main() {
  print(diceRoll());
}
```

**C.** Create a `isGameLost` method that returns true if a given player has already lost the game. Here is a potential method header:

```dart

///Returns true if [score] cannot catch up to [opponentScore] given the remaining number of [turnsRemaining],
///and false otherwise
bool isGameLost (int score, int opponentScore, int turnsRemaining) {

  //method body here

}
```

**D.** Test your method with a few different values to see if it is working:

```dart
  print(isGameOver(13, 20, 1)); //game is lost (true)
  print(isGameOver(14, 20, 1)); //not lost (false)
  print(isGameOver(20, 20, 0)); //not lost (false)
  print(isGameOver(19, 20, 0)); //game is lost (true)
  //add your own function calls here
```

<details><summary>Hint</summary>
<p>

```dart
import 'dart:math';

///Returns a random integer between 1 and 6
int diceRoll() => new Random().nextInt(6)+1;

///Returns true if [score] cannot catch up to [opponentScore] given the remaining number of [turnsRemaining],
///and false otherwise
bool isGameLost(int score, int opponentScore, int turnsRemaining) {
  final maxRoll = 6;
  var maxAdditional = turnsRemaining * maxRoll;
  return score + maxAdditional < opponentScore;
}

void main() {
  print(isGameOver(13, 20, 1)); //game is lost (true)
  print(isGameOver(14, 20, 1)); //not lost (false)
  print(isGameOver(20, 20, 0)); //not lost (false)
  print(isGameOver(19, 20, 0)); //game is lost (true)
}

```

</p>
</details>
<br>

**E.** Complete the program so it simluates the game and generates output such as:

```Courier
Turn: 1, player 1 rolled a 5, current total: 5
Turn: 1, player 2 rolled a 2, current total: 2

Turn: 2, player 1 rolled a 6, current total: 11
Turn: 2, player 2 rolled a 2, current total: 4

Turn: 3, player 1 rolled a 6, current total: 17
Turn: 3, player 2 rolled a 1, current total: 5

Turn: 4, player 1 rolled a 1, current total: 18
Turn: 4, player 2 rolled a 6, current total: 11

Turn: 5, player 1 rolled a 6, current total: 24
Turn: 5, player 2 rolled a 2, current total: 13

Turn: 6, player 1 rolled a 5, current total: 29
Turn: 6, player 2 rolled a 5, current total: 18

Turn: 7, player 1 rolled a 4, current total: 33
Turn: 7, player 2 rolled a 1, current total: 19

Turn: 8, player 1 rolled a 6, current total: 39
game ends half-way through turn: 8

final score Player 1: 39, Player 2: 19
```

Note we've seen a for-loop but you may be interested in a while-loop as well. A while-loop takes the form:

```dart
while(condition) {

  //body of the loop here

}

```


<details><summary>Hint</summary>
<p>

Some other helper functions may also aid readability and code reuse, such as a log function:

```dart
///print the current roll state
void log(int turn, int dieValue, int player, int total) {
  // body here
}

```

</p>
</details>
<br>



<details><summary>Solution</summary>
<p>

Did you already complete the task?

Solution posted at the conclusion of the lab

Ask for help or try things and practice writing code.
OR
Help a peer by discussing your approaches to the solution.
OR
Improve the game in some manner.
  - add i/o
  - improve the text output
  - change the parameters - more players or dice
  - refactor your solution
    - new methods
    - other approaches / algorithms
</p>
</details>
<br>
