import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../high_score_record.dart';
part 'high_score_state.dart';

class HighScoreCubit extends Cubit<HighScoreState> {
  HighScoreCubit() : super(HighScoreState());
}
