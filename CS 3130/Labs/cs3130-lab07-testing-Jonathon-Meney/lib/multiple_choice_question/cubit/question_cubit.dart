import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../multiple_choice_question.dart';


part 'question_state.dart';

class QuestionCubit extends Cubit<QuestionState> {

  final QuestionFetch _questionFetcher;

  QuestionCubit(this._questionFetcher) : super(QuestionInitial());

  ///fetch a question and advance the state
  Future<void> getQuestion() async {
    bool tryAgain = true;
    while(tryAgain) {
      try {
        //first emit loading
        emit(QuestionLoading());
        //get the question and pass to QuestionLoaded
        final question = await _questionFetcher.fetch();
        tryAgain = false;
        emit(QuestionLoaded(question));
      } on FormatException {
        //the json was not good we should retry to get a good one
        tryAgain = true;
      } on RangeError {
        //the question didn't have enough choices
        //try again
        tryAgain = true;
      } on NetworkException catch (e) {
        tryAgain = false;
        emit(QuestionError("Error fetching questions from internet"));
      }
    }
  }

  ///change the state to QuestionAnswered
  void submitAnswer(MCQuestion question, int answer) {
    emit(QuestionAnswered(question, answer));
  }
}
