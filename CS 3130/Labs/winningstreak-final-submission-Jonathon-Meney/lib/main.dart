import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winning_streak/auth/cubit/authorization_cubit.dart';
import 'package:winning_streak/high_score/cubit/hs_toggle_cubit.dart';
import 'package:winning_streak/high_score/cubit/local_high_score_cubit.dart';
import 'package:winning_streak/high_score/cubit/global_high_score_cubit.dart';
import 'package:winning_streak/high_score/database/local_high_score_database.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';


import 'app.dart';
import 'high_score/database/global_high_score_database.dart';
import 'streak_observer.dart';

void main() async {

  await LocalHighScoreDatabase.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //FirebaseAuth auth = FirebaseAuth.instance;
  /*await FirebaseAppCheck.instance.activate();
  String? token = await FirebaseAppCheck.instance.getToken();
  print("token: $token");
  await FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);

  FirebaseAppCheck.instance.onTokenChange.listen((token) {
    print("token: $token");
  });*/

  BlocOverrides.runZoned(
        () => runApp( MultiBlocProvider(
            providers: <BlocProvider>[
                BlocProvider<HSToggleCubit>(
                  create: (_)=>HSToggleCubit(HSToggleCubit.LOCAL),
                ),
                BlocProvider<LocalHighScoreCubit>(
                  create: (_)=>LocalHighScoreCubit(LocalHighScoreDatabase()),
                ),
              BlocProvider<GlobalHighScoreCubit>(
                create: (_)=>GlobalHighScoreCubit(GlobalHighScoreDatabase()),
              ),
              //provide the authorization cubit
              BlocProvider<AuthorizationCubit>(
                create: (_) => AuthorizationCubit(),
              )
              ],
              child: StreakApp(),
        )),
    blocObserver: StreakObserver(),
  );
}


