import 'package:flutter/material.dart';
import 'streak/streak.dart';

/// A MaterialApp which sets the `home` to StreakPage.
class StreakApp extends MaterialApp {

   StreakApp({Key? key}) : super(key: key,
    home: const StreakPage(),
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),);
}