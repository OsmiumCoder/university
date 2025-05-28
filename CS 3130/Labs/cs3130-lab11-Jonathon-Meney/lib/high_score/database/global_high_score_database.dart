import 'dart:async';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_database/firebase_database.dart';
import '../model/high_score_record.dart';

class GlobalHighScoreDatabase {

  //the real-time database
  late final DatabaseReference ref;

  static const String _leaders = "leaders";

  static const String lengthField = "length";
  static const String initialsField = "initials";
  static const String dateField = "date";

  //pass this in the constructor to allow for future testing / mocking
  GlobalHighScoreDatabase({ref} ) : this.ref=ref??FirebaseDatabase.instance.ref(_leaders);

  //add a high score record to the database
  void put(HighScoreRecord highScoreRecord) {

    //append to a list
    //follows from example at:
    //https://firebase.flutter.dev/docs/database/lists-of-data

    try {
      DatabaseReference leadersList = ref.push();
      leadersList.set({
        lengthField: highScoreRecord.length,
        initialsField: highScoreRecord.name,
        dateField: highScoreRecord.date.millisecondsSinceEpoch
      });
    } on FirebaseException catch (e){
      print('oops');
      print(e.code);
      print(e.message);
    }
  }

StreamSubscription subscribe( Function(DatabaseEvent event) fn   ) {
  return ref.orderByChild(lengthField)
      .limitToLast(10).onChildAdded.listen(fn);
}

  //retrieve high scores from our database
  Future<List<HighScoreRecord>> get() async {
    final highScores = <HighScoreRecord>[];
    //top 10 leaders
    final topLeaders = await ref.orderByChild(lengthField)
        .limitToLast(10).get();
    if (topLeaders.exists) {
      for (final highScore in topLeaders.children) {

        final hsMap = highScore.value as Map<dynamic, dynamic>;
        highScores.insert(0,HighScoreRecord.fromMap(hsMap));
      }
    }
    return highScores;
  }
}