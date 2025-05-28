import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:winning_streak/high_score/database/local_high_score_database.dart';
import '../model/high_score_record.dart';
part 'high_score_state.dart';

class LocalHighScoreCubit extends Cubit<HighScoreState> {

  LocalHighScoreDatabase db;

  LocalHighScoreCubit(this.db) : super(HighScoreState()) {
    _fetchHighScores();
  }

  Future<void> _fetchHighScores() async {
    emit(state.copyWith(status:HSStatus.loading));
    List<HighScoreRecord> highScores = db.getLeaders();
    //get the high scores
    emit(state.copyWith(status:HSStatus.loaded, leaderboard: highScores));
  }

  //is a streak with length streakLength a high score?
  bool isHighScore(int streakLength, DateTime when) {

    if(state.leaderboard.length < 10) {
      return true;
    }
    HighScoreRecord candidate = HighScoreRecord("", streakLength, when);

    HighScoreRecord min = state.leaderboard.reduce((a,b)=>a.compareTo(b)<0?a:b);
    //is the min bigger than the candidate
    return min.compareTo(candidate) > 0;
  }

  //update the leaderboard
  void updateScoreboard(int streakLength,DateTime when, String initials ) {

    if(!isHighScore(streakLength, when)) {
      return;
    }

    List<HighScoreRecord> leaders = []..addAll(state.leaderboard);
    leaders.add(HighScoreRecord(initials, streakLength, when));

    leaders.sort((a,b)=>b.compareTo(a));

    if(leaders.length > 10) {
      leaders = leaders.sublist(0, 10);
    }

    emit(state.copyWith(leaderboard: leaders));

    //update the leaders
    db.put(leaders);
  }
}
