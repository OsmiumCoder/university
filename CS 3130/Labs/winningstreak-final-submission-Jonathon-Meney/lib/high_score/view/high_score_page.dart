import 'package:flutter/material.dart';
import 'high_score_view.dart';

/// Stateless widget responsible for providing HighScoreCubit to StreakView
class HighScorePage extends StatelessWidget {
  const HighScorePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return HighScoreView();
  }
}