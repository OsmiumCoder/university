import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_05/streak/cubit/streak_cubit.dart';
import '../../multiple_choice_question/cubit/question_cubit.dart';
import '../../multiple_choice_question/fetcher/random_question_fetch.dart';
import 'streak_view.dart';

/// Stateless widget responsible for providing StreakCubit to StreakView
class StreakPage extends StatelessWidget {
  const StreakPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<StreakCubit>(
          create: (_) => StreakCubit(),
        ),
        BlocProvider<QuestionCubit>(
          create: (context) => QuestionCubit(RandomQuestionFetch()),
        )
      ],
      child: StreakView(),
    );

  }
}