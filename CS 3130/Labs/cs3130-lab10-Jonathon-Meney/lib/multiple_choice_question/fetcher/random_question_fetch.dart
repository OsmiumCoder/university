import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'category.dart';

import 'question_fetch.dart';
import '../mc_question.dart';

class RandomQuestionFetch extends QuestionFetch {

  static final String uri = "http://137.149.157.9:3000/category?id=";

  static final int max_category = 18418;

  late final http.Client client;

  RandomQuestionFetch({client}) : this.client = client??http.Client();

  Future<http.Response> _fetchFromJService() async {

    int randomCategory = Random().nextInt(max_category-1) +1;

    //fetch json from jService and convert to Category
    final response = await client
        .get(Uri.parse("$uri$randomCategory"));
    return response;
  }

  @override
  Future<MCQuestion> fetch() async {

    final response = await _fetchFromJService();

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