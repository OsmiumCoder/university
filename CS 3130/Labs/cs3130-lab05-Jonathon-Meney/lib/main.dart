import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';
import 'streak_observer.dart';

void main() {
  //runApp(const StreakApp());
  BlocOverrides.runZoned(
        () => runApp( StreakApp()),
    blocObserver: StreakObserver(),
  );
}