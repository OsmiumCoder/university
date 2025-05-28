import 'dart:math';

import '../../multiple_choice_question.dart';

class Category {
  final String categoryTitle;
  final int count;
  final List<Clue> clues;

  Category({required this.categoryTitle, required this.count, required this.clues});

  factory Category.fromJSON(Map<String, dynamic> json) {
    //check for errors
    if (!json.containsKey('results')) {
      throw FormatException('invalid json');
    }

    List<dynamic> jsonClues = json['results'];
    List<Clue> parsedClues = <Clue>[];

    //convert each to a Clue
    for (var jsonClue in jsonClues) {
      if (jsonClue is! Map<String, dynamic> ) {
        throw FormatException("Error parsing clues from json");
      }

      Clue clue = Clue.fromJSON(jsonClue);
      parsedClues.add(clue);
    }

    return Category(
        categoryTitle: json['results'][0]['category'] as String,
        count: parsedClues.length,
        clues: parsedClues);
  }

  MCQuestion toMCQuestion(int numberOfChoices) {
    if (clues.length < numberOfChoices) {
      throw RangeError.index(numberOfChoices, clues);
    }

    clues.shuffle();

    int correctIndex = Random().nextInt(numberOfChoices);
    String question = clues[correctIndex].question;

    List<String> choices = clues.sublist(0, numberOfChoices).map((clue) => clue.answer).toList();
    
    return MCQuestion(categoryTitle, question, choices, correctIndex);
  }
}

class Clue {
  final String answer;
  final String question;

  Clue( {
    required this.answer,
    required this.question
  });

  factory Clue.fromJSON(Map<String, dynamic> json) {

    //check for errors
    if (!json.containsKey('correct_answer') || !json.containsKey('question')) {
      throw FormatException('invalid json');
    }

    //construct and return a Clue object
    return Clue(
        answer: json['correct_answer'] as String,
        question: json['question'] as String
    );
  }
}