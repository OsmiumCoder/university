import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../multiple_choice_question.dart';

part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {
  final QuestionFetch _questionFetcher;

  QuestionCubit(this._questionFetcher) : super(const QuestionInitial());

  Future<void> getQuestion() async {
    emit(const QuestionLoading());

    var fetchAttempts = 3;

    while (fetchAttempts > 0) {
      try {
        final question = await _questionFetcher.fetch();
        fetchAttempts--;
        emit(QuestionLoaded(question));
        return;
      } on FormatException {
        fetchAttempts--;
      } on RangeError {
        fetchAttempts--;
      } on NetworkException {
        fetchAttempts--;
        emit(const QuestionError("Network error"));
      }
    }

    emit(const QuestionError("Network error"));
  }

  void submitAnswer(MCQuestion question, int answer) {
    emit(QuestionAnswered(question, answer));
  }
}
