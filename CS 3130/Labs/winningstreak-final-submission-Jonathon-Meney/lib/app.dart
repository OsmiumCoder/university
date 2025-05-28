import 'package:flutter/material.dart';
import 'package:winning_streak/routes/route_generator.dart';

/// A MaterialApp which sets the `home` to StreakPage.
class StreakApp extends MaterialApp {
   StreakApp({Key? key}) : super(key: key,
      initialRoute:  RouteGenerator.homePage,
      onGenerateRoute: RouteGenerator.generateRoute,
      theme: ThemeData(
          primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(backgroundColor: Color.fromRGBO(255, 204, 0, 1)),
        scaffoldBackgroundColor: const Color.fromRGBO(8, 20, 132, 1),
          ),
     debugShowCheckedModeBanner: false
  );
}