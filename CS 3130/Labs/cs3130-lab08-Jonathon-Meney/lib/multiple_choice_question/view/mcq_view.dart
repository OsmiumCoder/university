
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winning_streak/high_score/cubit/local_high_score_cubit.dart';
import 'package:winning_streak/multiple_choice_question/cubit/question_cubit.dart';

import 'package:winning_streak/multiple_choice_question/view/choice_tile.dart';
import 'package:winning_streak/multiple_choice_question/view/question_initial_view.dart';
import 'package:winning_streak/streak/streak.dart';

import '../mc_question.dart';

class MCQView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<QuestionCubit, QuestionState>(
      builder: (context, state) {
        if (state is QuestionInitial) {
          print("enter the initial");
          return QuestionInitialView();
        }
        else if (state is QuestionLoading) {
          return CircularProgressIndicator();
        }
        else if (state is QuestionLoaded) {
          var qstate = state as QuestionLoaded;
          MCQuestion mcQuestion = qstate.question;
          print(mcQuestion.questionText);
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                mcQuestion.questionText,
                textScaleFactor: 2.0,
              ),
              Column(
                  children: <Widget>[
                    ChoiceTile(option: 1,
                      text: mcQuestion.getChoice(0),
                      callBack: () =>context.read<QuestionCubit>().submitAnswer(mcQuestion, 0)
                    ),
                    ChoiceTile(option: 2,
                        text: mcQuestion.getChoice(1),
                        callBack: () =>context.read<QuestionCubit>().submitAnswer(mcQuestion, 1)
                    ),
                    ChoiceTile(option: 3,
                        text: mcQuestion.getChoice(2),
                        callBack: () =>context.read<QuestionCubit>().submitAnswer(mcQuestion, 2)
                    ),
                    ChoiceTile(option: 4,
                        text: mcQuestion.getChoice(3),
                        callBack: () =>context.read<QuestionCubit>().submitAnswer(mcQuestion, 3)
                    ),
                  ]
              )
            ],
          );
        }
        else if (state is QuestionAnswered) {

          var qstate = state as QuestionAnswered;
          MCQuestion mcQuestion = qstate.question;
          int correct = mcQuestion.correctIndex;
          int submitted = qstate.answer;
          bool streakEnded = submitted != correct;
          if(!streakEnded) {
            context.read<StreakCubit>().increment();
          }
          else { //streak is over
            int streak = context.read<StreakCubit>().state;

            if(context.read<LocalHighScoreCubit>().isHighScore(streak, DateTime.now())) {

              //might be a good spot for a dialog to get initials?
              print("new high score!");

              //save the streak as a high score
              var r = Random();
              String rando = String.fromCharCode(r.nextInt(26)+65) + String.fromCharCode(r.nextInt(26)+65) + String.fromCharCode(r.nextInt(26)+65);
              context.read<LocalHighScoreCubit>().updateScoreboard(streak, DateTime.now(), rando);
            }
            context.read<StreakCubit>().reset();
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                mcQuestion.questionText,
                textScaleFactor: 2.0,
              ),
              Column(
                  children: <Widget>[
                    ChoiceTile(option: mcQuestion.correctIndex+1,
                        color: correct == submitted? Colors.green:Colors.red,
                        text: mcQuestion.getChoice(mcQuestion.correctIndex),
                        callBack: context.read<QuestionCubit>().getQuestion
                    ),
                    Card(
                      child: ListTile(
                        title: Center(
                            child: streakEnded? Text("Done"):Text("Next Question"),
                        ),
                        onTap: streakEnded?()=>Navigator.pop(context):context.read<QuestionCubit>().getQuestion,
                      )
                    ),
                  ]
              )
            ],
          );
        }
        else { //error
          print("oops didn't match the state");
          return QuestionInitialView();
        }
      },
    );
  }
}
