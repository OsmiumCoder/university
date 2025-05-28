import 'package:a1_fakenews/reader/screens/news_article_screen.dart';
import 'package:a1_fakenews/reader/screens/news_index_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String indexRoute = "/";
  static const String articleRoute = "/article";

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments = (settings.arguments ?? <String, dynamic>{}) as Map;

    switch (settings.name) {
      case indexRoute:
        return MaterialPageRoute(builder: (_) => const NewsIndexScreen());
      case articleRoute:
        if (arguments['article'] != null) {
          return MaterialPageRoute(
              builder: (_) => NewsArticleScreen(article: arguments['article']));
        } else {
          // If no article was given just go back home.
          return MaterialPageRoute(builder: (_) => const NewsIndexScreen());
        }
      default:
        return MaterialPageRoute(builder: (_) => const NewsIndexScreen());
    }
  }
}
