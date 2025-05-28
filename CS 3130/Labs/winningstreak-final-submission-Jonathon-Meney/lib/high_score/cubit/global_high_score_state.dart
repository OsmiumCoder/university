part of 'global_high_score_cubit.dart';

enum HSStatus {loading, loaded, failure}

class GlobalHighScoreState extends Equatable {

  final List<HighScoreRecord> leaderboard;
  final HSStatus status;

  GlobalHighScoreState({
    this.status = HSStatus.loading,
    this.leaderboard = const<HighScoreRecord> []
  });

  ///generate a new HighScore State from this
  GlobalHighScoreState copyWith( {
    HSStatus? status,
    List<HighScoreRecord>? leaderboard,
  })
  {
    return GlobalHighScoreState(
      status: status ?? this.status,
      leaderboard : leaderboard ?? this.leaderboard
    );
  }

  @override
  List<Object> get props => [status, leaderboard];

  @override
  bool? get stringify => true;
}
