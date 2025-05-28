//lib/high_score/view/high_score_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winning_streak_lab07/high_score/cubit/hs_toggle_cubit.dart';

/// Show the high score
class HighScoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Winning Streak - High Scores"),
      ),
      body: BlocBuilder<HSToggleCubit, bool>(
          builder: (context, state) {
            if (state == HSToggleCubit.LOCAL) {
              return Text("local high score list");
            }
            else {
              return Text("global high score list");
            }
          }
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget{

  static const IconData icon_local = Icons.bungalow;
  static const IconData icon_global = Icons.location_city;

  CustomBottomNavigationBar() : super();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HSToggleCubit, bool> (
        builder: (context, state) {
          const int local = 0;
          const int global = 1;
          return BottomNavigationBar(
            items: const<BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(icon_local),
                label: 'Local',
              ),
              BottomNavigationBarItem(
                icon: Icon(icon_global),
                label: 'Global',
              ),
            ],
            onTap: (index) => context.read<HSToggleCubit>().toggle(index == global),
            currentIndex: state==HSToggleCubit.LOCAL? local:global,
          );
        }
    );
  }


}