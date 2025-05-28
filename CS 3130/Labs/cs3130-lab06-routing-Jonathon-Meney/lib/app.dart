import 'package:flutter/material.dart';
import 'package:winning_streak_lab06/routes/route_generator.dart';
import 'package:winning_streak_lab06/streak/view/streak_page.dart';

/// A MaterialApp which sets the `home` to StreakPage.
class StreakApp extends MaterialApp {
  StreakApp({Key? key}) : super(key: key,
      initialRoute: RouteGenerator.homePage,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
      primarySwatch: Colors.green,
  )

  ,

  );
}