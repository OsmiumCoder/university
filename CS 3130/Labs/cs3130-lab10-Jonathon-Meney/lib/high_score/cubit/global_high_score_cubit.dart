import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import '../database/global_high_score_database.dart';
import '../model/high_score_record.dart';

part 'global_high_score_state.dart';

class GlobalHighScoreCubit extends Cubit<GlobalHighScoreState> {
  GlobalHighScoreDatabase db;
  late StreamSubscription subscription;


  GlobalHighScoreCubit(this.db) : super(GlobalHighScoreState()) {
    // fetchHighScores();
    subscription = db.subscribe(_processEvent);
  }

  void _processEvent(DatabaseEvent event){
    final hsMap =  event.snapshot.value as Map<dynamic, dynamic>;
    print(hsMap);
    HighScoreRecord hsr = HighScoreRecord.fromMap( hsMap);
    print(hsr.length);
    addToScoreboard(hsr);
  }

  //update the leaderboard
  void addToScoreboard(HighScoreRecord highScoreRecord) {
    List<HighScoreRecord> leaders = <HighScoreRecord>[highScoreRecord];
    leaders.addAll(state.leaderboard);
    leaders.sort((a,b)=>b.compareTo(a));
    if(leaders.length > 10) {
      leaders = leaders.sublist(0, 10);
    }
    emit(state.copyWith(status:HSStatus.loaded, leaderboard: leaders));
  }

  Future<void> fetchHighScores() async {
    emit(state.copyWith(status: HSStatus.loading));
    //get the high scores
    List<HighScoreRecord> highScores = await db.get();
    emit(state.copyWith(status: HSStatus.loaded, leaderboard: highScores));
  }

  //send this score onto the database
  //don't bother submitting anything that can't possibly be a high score
  void submitPossibleHighScore(
      String initials, int streakLength, DateTime when) {
    print("submit high score");
    HighScoreRecord candidate = HighScoreRecord(initials, streakLength, when);

    if (state.leaderboard.length < 10) {
      db.put(candidate);
    } else {
      HighScoreRecord min =
          state.leaderboard.reduce((a, b) => a.compareTo(b) < 0 ? a : b);
      //is the min bigger than the candidate
      bool hs = min.compareTo(candidate) > 0 || state.leaderboard.length < 10;
      if (hs) {
        db.put(candidate);
      }
    }
  }
}
