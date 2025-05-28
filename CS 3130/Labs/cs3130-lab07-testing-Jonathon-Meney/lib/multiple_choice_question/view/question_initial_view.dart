

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winning_streak_lab07/multiple_choice_question/cubit/question_cubit.dart';


class QuestionInitialView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
      ),
      onPressed:context.read<QuestionCubit>().getQuestion,
      child: Text('retrieve first question'),
    );
  }
}