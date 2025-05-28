import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winning_streak/high_score/cubit/hs_toggle_cubit.dart';
import 'package:winning_streak/high_score/cubit/local_high_score_cubit.dart';

import 'app.dart';
import 'streak_observer.dart';

void main() {
  //runApp(const StreakApp());
  BlocOverrides.runZoned(
        () => runApp( MultiBlocProvider(
            providers: <BlocProvider>[
                BlocProvider<HSToggleCubit>(
                  create: (_)=>HSToggleCubit(HSToggleCubit.LOCAL),
                ),
                BlocProvider<LocalHighScoreCubit>(
                  create: (_)=>LocalHighScoreCubit(),
                ),
              ],
              child: StreakApp(),
        )),
    blocObserver: StreakObserver(),
  );
}


