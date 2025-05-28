import 'dart:math';

void main() {
  print(diceRoll());
  print(isGameLost(13, 20, 1)); //game is lost (true)
  print(isGameLost(14, 20, 1)); //not lost (false)
  print(isGameLost(20, 20, 0)); //not lost (false)
  print(isGameLost(19, 20, 0)); //game is lost (true)
  //add your own function calls here

  int turn = 1;
  int playerOneScore = 0;
  int playerTwoScore = 0;

  while (turn < 11) {
    int playerOneRoll = diceRoll();
    playerOneScore += playerOneRoll;
    print("Turn: $turn, player 1 rolled a $playerOneRoll, current total: $playerOneScore");
    if (isGameLost(playerOneScore, playerTwoScore, 10-turn)) {
      print('game ends half-way through turn: $turn');
      break;
    }

    int playerTwoRoll = diceRoll();
    playerTwoScore += playerTwoRoll;
    print("Turn: $turn, player 2 rolled a $playerTwoRoll, current total: $playerTwoScore");
    if (isGameLost(playerOneScore, playerTwoScore, 10-turn)) {
      print('game ends at the end of turn: $turn');
      break;
    }

    turn++;
  }

  print('final score Player 1: $playerOneScore, Player 2: $playerTwoScore');
}

int diceRoll() {
  const max = 6; //
  Random rnd = new Random(); //or var rnd = new Random();
  int value = rnd.nextInt(max) + 1; //or var value = rnd.nextInt(max);
  return value;
}

///Returns true if [score] cannot catch up to [opponentScore] given the remaining number of [turnsRemaining],
///and false otherwise
bool isGameLost (int score, int opponentScore, int turnsRemaining) {
  final maxRoll = 6;
  var maxAdditional = turnsRemaining * maxRoll;
  return score + maxAdditional < opponentScore;
}