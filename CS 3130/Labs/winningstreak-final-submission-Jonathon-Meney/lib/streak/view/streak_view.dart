//lib/streak/view/streak_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winning_streak/streak/streak.dart';

import 'package:winning_streak/multiple_choice_question/multiple_choice_question.dart';

/// A StatelessWidget which reacts to the provided
/// StreakCubit state and notifies it in response to user input.
class StreakView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: const Text("Winning Streak"),
              ),
      body: BlocConsumer<QuestionCubit, QuestionState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MCQView();
        }
      ),
    );
  }
}