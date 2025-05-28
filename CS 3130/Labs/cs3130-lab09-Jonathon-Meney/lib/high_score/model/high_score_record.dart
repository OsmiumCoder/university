import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'high_score_record_adapter.dart';

@HiveType(typeId: 0)
class HighScoreRecord extends Equatable implements Comparable {

  final String name;
  final int length;
  final DateTime date;
  const HighScoreRecord(this.name, this.length, this.date);

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