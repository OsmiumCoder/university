import 'package:flutter/material.dart';

import '../mc_question.dart';

class ChoiceTile extends StatelessWidget {
  final int option;
  final String text;
  final void Function() callBack;
  final Color? color;

  const ChoiceTile( {required this.option, required this.text, required this.callBack, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: color,
        child: ListTile(
          leading: Text("${option}."),
          title: Text(text),
          onTap: callBack,
        )
    );
  }
}
