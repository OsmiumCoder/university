part of 'local_high_score_cubit.dart';

enum HSStatus {loading, loaded, failure}

class HighScoreState extends Equatable {

  final List<HighScoreRecord> leaderboard;
  final HSStatus status;

  HighScoreState({
    this.status = HSStatus.loading,
    this.leaderboard = const<HighScoreRecord> []
  });

  ///generate a new HighScore State from this
  HighScoreState copyWith( {
    HSStatus? status,
    List<HighScoreRecord>? leaderboard,
  })
  {
    return HighScoreState(
      status: status ?? this.status,
      leaderboard : leaderboard ?? this.leaderboard
    );
  }

  @override
  List<Object> get props => [status, leaderboard];

  @override
  bool? get stringify => true;
}
