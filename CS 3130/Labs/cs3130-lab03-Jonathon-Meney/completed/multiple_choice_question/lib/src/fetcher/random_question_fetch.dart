import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:multiple_choice_question/src/fetcher/category.dart';

import 'package:multiple_choice_question/src/fetcher/question_fetch.dart';
import 'package:multiple_choice_question/src/mc_question.dart';

class RandomQuestionFetch extends QuestionFetch {

  final String _uri = "https://jservice.io/api/category?id=";

  final int max_category = 18418;

  @override
  Future<MCQuestion> fetch() async {

    int randomCategory = Random().nextInt(max_category);

    //fetch json from jService and convert to Category
    final response = await http
        .get(Uri.parse("$_uri$randomCategory"));

    if (response.statusCode == 200) {
      //200 is the http status code for OK (it worked)
      // If the server did return a 200 OK response,
      // then parse the JSON.

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