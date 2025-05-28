import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:winning_streak_lab04/models/streak_tracker.dart';
import 'screens/winning_streak_question.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => StreakTracker(),
    child: const MyApp(),
  )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const WinningStreakQuestion(),
    );
  }
}