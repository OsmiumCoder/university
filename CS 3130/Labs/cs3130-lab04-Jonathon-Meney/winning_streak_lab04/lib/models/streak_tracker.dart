import 'package:flutter/material.dart';

class StreakTracker with ChangeNotifier {
  int _correctQuestionsInARow = 0;

  void incrementCorrectQuestionsInARow() {
    _correctQuestionsInARow++;
    notifyListeners();
  }

  void resetCorrectQuestionsInARow() {
    _correctQuestionsInARow = 0;
    notifyListeners();
  }

  int get correctQuestionsInARow => _correctQuestionsInARow;
}