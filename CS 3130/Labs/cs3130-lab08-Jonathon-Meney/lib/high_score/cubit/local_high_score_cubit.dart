import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../high_score_record.dart';
part 'high_score_state.dart';

class LocalHighScoreCubit extends Cubit<HighScoreState> {

  LocalHighScoreCubit() : super(HighScoreState()) {
    _fetchHighScores();
  }

  //this will eventually save the local database to disk
  //for now it is just in memory so fetching will return []
  Future<void> _fetchHighScores() async {
    emit(state.copyWith(status:HSStatus.loading));

    //get the high scores
    emit(state.copyWith(status:HSStatus.loaded));

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

    //descending order ...
    //reverse the a and b here to change to descending
    leaders.sort((a,b)=>a.compareTo(b));

    if(leaders.length > 10) {
      leaders = leaders.sublist(0, 10);
    }
    emit(state.copyWith(leaderboard: leaders));
  }
}
