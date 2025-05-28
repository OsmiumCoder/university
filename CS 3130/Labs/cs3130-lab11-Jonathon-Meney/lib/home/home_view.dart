//lib/home/home_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winning_streak/auth/cubit/authorization_cubit.dart';
import 'package:winning_streak/routes/route_generator.dart';

/// Show the high score
class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Winning Streak Quiz Game"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListTile(
                    title: const Text("Signing name for high scores\nPress enter to submit:"),
                    subtitle: TextField(
                      autofocus: false,
                      decoration:
                          const InputDecoration(hintText: "Enter name or initials"),
                      onSubmitted: (value) {
                        context.read<AuthorizationCubit>().setInitials(value);
                        print(value);
                      },
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                      child: const Text('Start a Streak'),
                      onPressed: () => Navigator.pushNamed(
                            context,
                            RouteGenerator.streakPage,
                          )),
                  ElevatedButton(
                      child: const Text('View High Scores'),
                      onPressed: () => Navigator.pushNamed(
                            context,
                            RouteGenerator.highScorePage,
                          )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
