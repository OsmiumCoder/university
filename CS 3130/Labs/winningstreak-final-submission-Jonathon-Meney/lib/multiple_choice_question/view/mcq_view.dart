import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winning_streak/auth/cubit/authorization_cubit.dart';

//import 'package:winning_streak/auth/cubit/authorization_cubit.dart';
import 'package:winning_streak/high_score/cubit/local_high_score_cubit.dart';
import 'package:winning_streak/multiple_choice_question/cubit/question_cubit.dart';

import 'package:winning_streak/multiple_choice_question/view/choice_tile.dart';
import 'package:winning_streak/multiple_choice_question/view/question_initial_view.dart';
import 'package:winning_streak/streak/streak.dart';

import '../../high_score/cubit/global_high_score_cubit.dart';
import '../mc_question.dart';

class MCQView extends StatelessWidget {
  const MCQView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //check for sign in here
    if(context.read<AuthorizationCubit>().state is AuthorizationSignedOut) {
      context.read<AuthorizationCubit>().signIn();
    }

    return BlocBuilder<QuestionCubit, QuestionState>(
      builder: (context, state) {
        if (state is QuestionInitial) {
          context.read<QuestionCubit>().getQuestion();
          return const Center(
              child: CircularProgressIndicator(
                  color: Color.fromRGBO(255, 204, 0, 1)));
          // return QuestionInitialView();
        } else if (state is QuestionLoading) {
          return const Center(
              child: CircularProgressIndicator(
            color: Color.fromRGBO(255, 204, 0, 1),
          ));
        } else if (state is QuestionLoaded) {
          MCQuestion mcQuestion = state.question;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  BlocBuilder<StreakCubit, int>(
                    builder: (context, state) {
                      return Text(
                        'Streak: $state',
                        textScaleFactor: 2.0,
                        style: const TextStyle(
                            color: Color.fromRGBO(255, 204, 0, 1)),
                      );
                    },
                  ),
                  Text(
                    mcQuestion.questionText.replaceAll("&amp;", "&"),
                    textScaleFactor: 2.0,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: "serif",
                        color: Color.fromRGBO(255, 204, 0, 1)),
                  ),
                  Column(children: <Widget>[
                    ChoiceTile(
                        option: 1,
                        text: mcQuestion.getChoice(0),
                        callBack: () => context
                            .read<QuestionCubit>()
                            .submitAnswer(mcQuestion, 0)),
                    ChoiceTile(
                        option: 2,
                        text: mcQuestion.getChoice(1),
                        callBack: () => context
                            .read<QuestionCubit>()
                            .submitAnswer(mcQuestion, 1)),
                    ChoiceTile(
                        option: 3,
                        text: mcQuestion.getChoice(2),
                        callBack: () => context
                            .read<QuestionCubit>()
                            .submitAnswer(mcQuestion, 2)),
                    ChoiceTile(
                        option: 4,
                        text: mcQuestion.getChoice(3),
                        callBack: () => context
                            .read<QuestionCubit>()
                            .submitAnswer(mcQuestion, 3)),
                  ])
                ],
              ),
            ),
          );
        } else if (state is QuestionAnswered) {
          MCQuestion mcQuestion = state.question;
          int correct = mcQuestion.correctIndex;
          int submitted = state.answer;
          bool streakEnded = submitted != correct;
          if (!streakEnded) {
            context.read<StreakCubit>().increment();
          } else {
            // streak is over
            int streak = context.read<StreakCubit>().state;

            //if the user is signed in submit the score to the global db
            if (context.read<AuthorizationCubit>().state
                is AuthorizationSignedIn) {
              var auth = FirebaseAuth.instance.currentUser;
              print(auth!.displayName);
              context.read<GlobalHighScoreCubit>().submitPossibleHighScore(
                  auth.displayName!, streak, DateTime.now());
            }

            if (context
                .read<LocalHighScoreCubit>()
                .isHighScore(streak, DateTime.now())) {

              //save the streak as a high score
              context
                  .read<LocalHighScoreCubit>()
                  .updateScoreboard(streak, DateTime.now());
            }
            context.read<StreakCubit>().reset();
          }
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  mcQuestion.questionText.replaceAll("&amp;", "&"),
                  textScaleFactor: 2.0,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: "serif",
                      color: Color.fromRGBO(255, 204, 0, 1)),
                ),
                Column(children: <Widget>[
                  ChoiceTile(
                      option: mcQuestion.correctIndex + 1,
                      color: correct == submitted ? Colors.green : Colors.red,
                      text: mcQuestion.getChoice(mcQuestion.correctIndex),
                      callBack: context.read<QuestionCubit>().getQuestion),
                  Card(
                      child: ListTile(
                    title: Center(
                      child: streakEnded
                          ? const Text("Done")
                          : const Text("Next Question"),
                    ),
                    onTap: streakEnded
                        ? () => Navigator.pop(context)
                        : context.read<QuestionCubit>().getQuestion,
                  )),
                ])
              ],
            ),
          );
        } else {
          //error
          return QuestionInitialView();
        }
      },
    );
  }
}
