import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'category.dart';

import 'question_fetch.dart';
import '../mc_question.dart';

class RandomQuestionFetch extends QuestionFetch {

  final String _uri = "http://137.149.157.9:3000/api/category?id=";

  final int minCategory = 6139;
  final int maxCategory = 8226;

  @override
  Future<MCQuestion> fetch() async {

    int randomCategory = minCategory + Random().nextInt(maxCategory - minCategory);

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
      throw NetworkException();
    }
  }
}