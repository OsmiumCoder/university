//lib/streak/view/streak_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winning_streak_lab06/streak/streak.dart';

import 'package:winning_streak_lab06/multiple_choice_question/multiple_choice_question.dart';

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
        actions: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: Row(children: <Widget>[
              const Icon(Icons.check_rounded, color: Colors.red, size: 36.0),
              BlocBuilder<StreakCubit, int>(
                builder: (context, state) {
                  return Text(
                    '$state',
                    textScaleFactor: 2.0,
                  );
                },
              ),
            ]),
          ),
        ],
      ),
      body: BlocConsumer<QuestionCubit, QuestionState>(
          listener: (context, state) {
        // if(state is QuestionError) {
        //   Scaffold.of(context).showSnackBar(
        //     SnackBar(
        //       content: Text(state.message),
        //     ),
        //   );
        // }
      }, builder: (context, state) {
        return MCQView();
      }),
    );
  }
}
