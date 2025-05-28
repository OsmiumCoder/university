import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'high_score/cubit/hs_toggle_cubit.dart';
import 'streak_observer.dart';

void main() {
  //runApp(const StreakApp());
  BlocOverrides.runZoned(
    () => runApp(MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<HSToggleCubit>(
          create: (_) => HSToggleCubit(HSToggleCubit.LOCAL),
        ),
      ],
      child: StreakApp(),
    )),
    blocObserver: StreakObserver(),
  );
}
