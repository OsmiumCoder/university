import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:multiple_choice_question/src/fetcher/category.dart';

import 'package:multiple_choice_question/src/fetcher/question_fetch.dart';
import 'package:multiple_choice_question/src/mc_question.dart';

class RandomQuestionFetch extends QuestionFetch {
  final String _uri = "https://opentdb.com/api.php?amount=10&type=multiple&category=";

  @override
  Future<MCQuestion> fetch() async {
    int randomCategory = Random().nextInt(32 - 9) + 9;

    //fetch json from jService
    final response = await http.get(Uri.parse("$_uri$randomCategory"));

    if (response.statusCode == 200) {
      var category = Category.fromJSON(jsonDecode(response.body));
      var question = category.toMCQuestion(4);

      return question;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to fetch question');
    }
  }

}