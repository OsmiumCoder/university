//lib/home/home_view.dart

import 'package:flutter/material.dart';
import 'package:winning_streak_lab06/routes/route_generator.dart';

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
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  RouteGenerator.streakPage,
                );
              },
              child: const Text("Start a Streak"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteGenerator.highScorePage);
              },
              child: const Text("View High Scores"),
            ),
          ],
        ),
      ),
    );
  }
}
