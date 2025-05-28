//lib/high_score/view/high_score_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winning_streak/high_score/cubit/hs_toggle_cubit.dart';
import 'package:winning_streak/high_score/cubit/local_high_score_cubit.dart';

import '../cubit/global_high_score_cubit.dart';
import '../model/high_score_record.dart';

/// Show the high score
class HighScoreView extends StatelessWidget {
  static List<String> months = [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  const HighScoreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Winning Streak - High Scores"),
      ),
      body: BlocBuilder<HSToggleCubit, bool>(builder: (context, state) {
        if (state == HSToggleCubit.LOCAL) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<LocalHighScoreCubit, HighScoreState>(
                builder: (context, leaderBoardState) {
              if (leaderBoardState.leaderboard.isEmpty) {
                return const Center(
                  child: Text(
                    'No High Scores Yet',
                    textScaleFactor: 2.0,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 204, 0, 1)),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: leaderBoardState.leaderboard.length,
                    itemBuilder: (context, index) {
                      HighScoreRecord hsr = leaderBoardState.leaderboard[index];
                      return Card(
                          child: Padding(
                              padding: const EdgeInsets.all((20.0)),
                              child: ListTile(
                                leading: const Icon(Icons.star,
                                    color: Color.fromRGBO(255, 204, 0, 1)),
                                title: Center(
                                  child: Text(
                                      "Streak: ${hsr.length}, ${months[hsr.date.month]} ${hsr.date.day}"),
                                ),
                                trailing: const Icon(Icons.star,
                                    color: Color.fromRGBO(255, 204, 0, 1)),
                              )));
                    });
              }
            }),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: BlocBuilder<GlobalHighScoreCubit, GlobalHighScoreState>(
                builder: (context, leaderBoardState) {
              if (leaderBoardState.leaderboard.isEmpty) {
                return const Center(
                  child: Text(
                    'No High Scores Yet',
                    textScaleFactor: 2.0,
                    style: TextStyle(
                        color: Color.fromRGBO(255, 204, 0, 1)),
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: leaderBoardState.leaderboard.length,
                    itemBuilder: (context, index) {
                      HighScoreRecord hsr = leaderBoardState.leaderboard[index];
                      return Card(
                          child: Padding(
                              padding: const EdgeInsets.all((20.0)),
                              child: ListTile(
                                leading: const Icon(Icons.star,
                                    color: Color.fromRGBO(255, 204, 0, 1)),
                                title: Center(
                                  child: Text(
                                      "${hsr.name}\nStreak: ${hsr.length}\n${months[hsr.date.month]} ${hsr.date.day}"),
                                ),
                                trailing: const Icon(Icons.star,
                                    color: Color.fromRGBO(255, 204, 0, 1)),
                              )));
                    });
              }
            }),
          );
        }
      }),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  static const IconData iconLocal = Icons.bungalow;
  static const IconData iconGlobal = Icons.location_city;

  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HSToggleCubit, bool>(builder: (context, state) {
      const int local = 0;
      const int global = 1;
      return NavigationBar(
        backgroundColor: const Color.fromRGBO(255, 204, 0, 1),
        onDestinationSelected: (index) =>
            context.read<HSToggleCubit>().toggle(index == global),
        selectedIndex: state == HSToggleCubit.LOCAL ? local : global,
        destinations: const [
          NavigationDestination(icon: Icon(iconLocal), label: "Local"),
          NavigationDestination(icon: Icon(iconGlobal), label: "Global")
        ],
      );
    });
  }
}
