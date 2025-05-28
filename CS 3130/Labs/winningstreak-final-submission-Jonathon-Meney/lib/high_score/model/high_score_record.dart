import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:winning_streak/high_score/database/global_high_score_database.dart';

part 'high_score_record_adapter.dart';

@HiveType(typeId: 0)
class HighScoreRecord extends Equatable implements Comparable {

  final String name;
  final int length;
  final DateTime date;
  const HighScoreRecord(this.name, this.length, this.date);

  factory HighScoreRecord.fromMap(Map<dynamic, dynamic> map) {
    int length = map[GlobalHighScoreDatabase.lengthField] as int;
    String initials = map[GlobalHighScoreDatabase.initialsField] as String;
    int msFromEpoc = map[GlobalHighScoreDatabase.dateField] as int;
    DateTime date = DateTime.fromMillisecondsSinceEpoch(msFromEpoc);
    return HighScoreRecord(initials, length, date);
  }

  @override
  int compareTo(other) {
    //longest streaks and equal streaks organized by first occurring
    if (length == other.length) {
      return date.compareTo(other.date);
    }
    return length.compareTo(other.length);
  }

  @override
  List<Object?> get props => [name, length, date];
}