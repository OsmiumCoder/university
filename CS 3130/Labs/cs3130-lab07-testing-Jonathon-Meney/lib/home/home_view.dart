//lib/home/home_view.dart

import 'package:flutter/material.dart';
import 'package:winning_streak_lab07/routes/route_generator.dart';

/// Show the high score
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Winning Streak Quiz Game"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            ElevatedButton(
              child: Text('Start a Streak'),
              onPressed: () => Navigator.pushNamed(
                context,
                RouteGenerator.streakPage,
              )
            ),
            ElevatedButton(
            child: Text('View High Scores'),
            onPressed: () => Navigator.pushNamed(
              context,
              RouteGenerator.highScorePage,
            )
            ),
          ],
        ),
      ),
    );
  }
}