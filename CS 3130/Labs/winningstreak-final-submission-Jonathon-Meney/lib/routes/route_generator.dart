

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:winning_streak/high_score/view/high_score_page.dart';
import 'package:winning_streak/home/home_page.dart';
import 'package:winning_streak/routes/unknown_screen.dart';
import 'package:winning_streak/streak/streak.dart';

class RouteGenerator {

  static const String homePage = '/';
  static const String streakPage = '/streakGame';
  static const String highScorePage = '/highScore';

  //private constructor
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case streakPage:
        return MaterialPageRoute(
          builder: (_) => const StreakPage(),
        );
      case highScorePage:
        return MaterialPageRoute(
          builder: (_) => const HighScorePage(),
        );
    }
    if(kDebugMode) {
      return MaterialPageRoute(builder: (context) =>  UnknownScreen());
    }
    else {
      return MaterialPageRoute(builder: (context) => const HomePage());
    }
  }

}