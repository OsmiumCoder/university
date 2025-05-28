import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'category.dart';

import 'question_fetch.dart';
import '../mc_question.dart';

class RandomQuestionFetch extends QuestionFetch {

  // 6756 has 47 clues
  static const String uri = "http://137.149.157.9:3000/api/category?id=";

  // static const int maxCategory = 18418;

  final int maxCategory = 8000;
  final int minCategory = 6348;

  late final http.Client client;

  RandomQuestionFetch({client}) : client = client??http.Client();

  Future<http.Response> _fetchFromJService() async {

    int randomCategory = Random().nextInt(maxCategory-1) + minCategory;

    //fetch json from jService and convert to Category
    final response = await client
        .get(Uri.parse("$uri$randomCategory"));
    return response;
  }

  @override
  Future<MCQuestion> fetch() async {

    var response = await _fetchFromJService();
    Map<String, dynamic> json = jsonDecode(response.body);
    print("before:${json["clues_count"] < 4}");

    while (json["clues_count"] < 4) {
      print("inside: ${json["clues_count"]}");
      await Future.delayed(const Duration(seconds: 5), () async {
        response = await _fetchFromJService();
        json = jsonDecode(response.body);
      });
    }

    if (response.statusCode == 200) {
      //200 is the http status code for OK (it worked)
      // If the server did return a 200 OK response,
      // then parse the JSON.

      var category = Category.fromJSON(json);
      var question = category.toMCQuestion(4);

      return question;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw NetworkException();
    }
  }
}