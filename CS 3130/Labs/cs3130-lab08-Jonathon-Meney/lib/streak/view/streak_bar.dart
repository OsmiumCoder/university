
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winning_streak/streak/streak.dart';


class StreakBar extends AppBar {

  StreakBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }


}