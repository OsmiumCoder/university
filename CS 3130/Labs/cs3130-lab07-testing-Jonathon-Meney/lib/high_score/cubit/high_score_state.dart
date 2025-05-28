part of 'high_score_cubit.dart';

enum HSStatus {local, globalLoading, globalLoaded, failure}

class HighScoreState extends Equatable {

  final List<HighScoreRecord> localLeaderBoard = [];
  final List<HighScoreRecord> globalLeaderBoard = [];

  HighScoreState();

  @override
  List<Object> get props => [];
}
