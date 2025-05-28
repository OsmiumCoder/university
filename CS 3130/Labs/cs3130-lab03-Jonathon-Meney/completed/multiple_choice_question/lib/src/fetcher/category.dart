import 'dart:math';

import '../../multiple_choice_question.dart';

///represent our requirements from a jService API category
class Category {

  final String categoryTitle;
  final int count;
  final List<Clue> clues;

  Category( {
    required this.categoryTitle,
    required this.count,
    required this.clues
  });

  ///generate a Category from the results of a jService category api call
  factory Category.fromJSON(Map<String, dynamic> json) {

    if (!json.containsKey('clues_count') ||
        !json.containsKey('clues') ||
        !json.containsKey('title') ) {
      throw ArgumentError("invalid json");
    }
    int number = json['clues_count'] as int;

    List<dynamic> jsonClues = json['clues'];
    List<Clue> parsedClues = <Clue>[];
    for (var clue in jsonClues) {
      if (! (clue is Map<String, dynamic>) ) {
        throw ArgumentError("Error parsing clues from json");
      }
      parsedClues.add(Clue.fromJSON(clue as Map<String, dynamic>));
    }
    return Category(
        categoryTitle: json['title'] as String,
        count: number,
        clues: parsedClues
    );
  }

  ///convert a category to a MCQuestion object
  MCQuestion toMCQuestion(int numberOfChoices) {

    if (clues.length < numberOfChoices) {
      throw RangeError.index(numberOfChoices, clues);
    }

    //random shuffle the list of clues
    clues.shuffle();

    //random correct answer:
    int correctIndex = Random().nextInt(numberOfChoices);
    String questionText = clues[correctIndex].question;

    List<String> choices = clues.sublist(0, numberOfChoices)
                          .map((clue)=>clue.answer.replaceAll(RegExp(r'<i>|</i>'), "")
                                                  .replaceAll("\\'", "'"))
                          .toList();

    return MCQuestion(categoryTitle,questionText, choices, correctIndex);

  }

}

//represent our requirements from a jService API Clue
class Clue {
  final String answer;
  final String question;

  Clue( {
    required this.answer,
    required this.question
  });

  ///generate a Clue from the clues array returned by a jService category api call
  factory Clue.fromJSON(Map<String, dynamic> json ) {

    if (!json.containsKey('answer') ||
        !json.containsKey('question') ){
      throw ArgumentError("invalid json");
    }

    return Clue(
        answer:json['answer'] as String,
        question:json['question'] as String
    );
  }
}
