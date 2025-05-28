import 'package:bloc/bloc.dart';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winning_streak/high_score/cubit/hs_toggle_cubit.dart';
import 'package:winning_streak/high_score/cubit/local_high_score_cubit.dart';
import 'package:winning_streak/high_score/cubit/global_high_score_cubit.dart';
import 'package:winning_streak/high_score/database/local_high_score_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'app.dart';
import 'high_score/database/global_high_score_database.dart';
import 'streak_observer.dart';

void main() async {
  await LocalHighScoreDatabase.init();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  BlocOverrides.runZoned(
    () => runApp(MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<HSToggleCubit>(
          create: (_) => HSToggleCubit(HSToggleCubit.LOCAL),
        ),
        BlocProvider<LocalHighScoreCubit>(
          create: (_) => LocalHighScoreCubit(LocalHighScoreDatabase()),
        ),
        BlocProvider<GlobalHighScoreCubit>(
          create: (_) => GlobalHighScoreCubit(GlobalHighScoreDatabase()),
        ),
      ],
      child: StreakApp(),
    )),
    blocObserver: StreakObserver(),
  );
}
