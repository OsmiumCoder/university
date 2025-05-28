import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_05/multiple_choice_question/view/mcq_view.dart';
import 'package:lab_05/streak/cubit/streak_cubit.dart';


/// A StatelessWidget which reacts to the provided
/// StreakCubit state and notifies it in response to user input.
class StreakView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Winning Streak"),
        actions: <Widget>[
          Align(
            alignment:Alignment.bottomRight,
            child: Row(
                children: <Widget>[
                  const Icon(Icons.check_rounded,
                      color:Colors.red,
                      size:36.0),
                  BlocBuilder<StreakCubit, int>(
                    builder: (context, state) {
                      return Text('$state',
                        textScaleFactor: 2.0,
                      );
                    },
                  ),
                ]
            ),
          ),
        ],
      ),
      body: MCQView(),
    );
  }
}