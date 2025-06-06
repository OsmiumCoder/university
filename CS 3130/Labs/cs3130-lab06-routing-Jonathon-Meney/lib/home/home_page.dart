import 'package:flutter/material.dart';

import 'home_view.dart';

/// Stateless widget responsible for providing StreakCubit to StreakView
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}