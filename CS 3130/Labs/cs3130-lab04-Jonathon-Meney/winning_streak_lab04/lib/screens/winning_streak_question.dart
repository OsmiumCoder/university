import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/streak_tracker.dart';

///screen where a question is displayed for the user to answer
class WinningStreakQuestion extends StatelessWidget {

  const WinningStreakQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text("Winning Streak"),
        actions: <Widget>[
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: <Widget>[
                const Icon(
                  Icons.check_rounded,
                  color: Colors.green,
                ),
                Consumer<StreakTracker> (
                  builder: (context, streak, child) =>
                      Text("${streak.correctQuestionsInARow}"),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          const Text(
            "I am a question",
          ),
          Column(
            children: <Widget>[
              Card(
                child: ChoiceTile(
                  text: "right answer",
                  callBack: context.read<StreakTracker>().incrementCorrectQuestionsInARow,
                ),
              ),
              Card(
                child: ChoiceTile(
                  text: "answer",
                  callBack: context.read<StreakTracker>().resetCorrectQuestionsInARow,
                ),
              ),
              Card(
                child: ChoiceTile(
                  text: "answer",
                  callBack: context.read<StreakTracker>().resetCorrectQuestionsInARow,
                ),
              ),
              Card(
                child: ChoiceTile(
                  text: "answer",
                  callBack: context.read<StreakTracker>().resetCorrectQuestionsInARow,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChoiceTile extends StatelessWidget {
  final String text;
  final void Function() callBack;

  const ChoiceTile( {super.key, required this.text, required this.callBack});

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
          title: Text(text),
          onTap: callBack, //note we don't have direct access to _streak or increment anymore
        )
    );
  }
}
