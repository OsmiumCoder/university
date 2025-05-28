
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_05/multiple_choice_question/view/question_initial_view.dart';
import 'package:lab_05/streak/cubit/streak_cubit.dart';


import '../cubit/question_cubit.dart';
import '../mc_question.dart';
import 'choice_tile.dart';

class MCQView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionCubit, QuestionState>(
      builder: (context, state) {
        if (state is QuestionInitial) {
          return QuestionInitialView();
        }
        else if (state is QuestionLoading) {
          return const CircularProgressIndicator();
        }
        else if (state is QuestionLoaded) {
          MCQuestion mcQuestion = state.question;
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
                      callBack: () =>context
                          .read<QuestionCubit>()
                          .submitAnswer(mcQuestion, 0),
                    ),
                    ChoiceTile(option: 2,
                      text: mcQuestion.getChoice(1),
                      callBack: ()=> context
                          .read<QuestionCubit>()
                          .submitAnswer(mcQuestion,1),
                    ),
                    ChoiceTile(option: 3,
                      text: mcQuestion.getChoice(2),
                      callBack: () => context
                          .read<QuestionCubit>()
                          .submitAnswer(mcQuestion,2),
                    ),
                    ChoiceTile(option: 4,
                      text: mcQuestion.getChoice(3),
                      callBack: () => context
                          .read<QuestionCubit>()
                          .submitAnswer(mcQuestion,3),
                    ),
                  ]
              )
            ],
          );
        }
        else if (state is QuestionAnswered){
          MCQuestion mcQuestion = state.question;
          int correct = mcQuestion.correctIndex;
          int submitted = state.answer;

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
                          title: const Center(
                            child: Text("Next Question"),
                          ),
                          onTap: context.read<QuestionCubit>().getQuestion,
                        )
                    ),
                  ]
              )
            ],
          );
        }
        else {
          if(kDebugMode) {
            print("oops error occurred");
          }
          return QuestionInitialView();
        }
      },
    );

  }
}
