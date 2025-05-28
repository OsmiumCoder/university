import '../mc_question.dart';

abstract class QuestionFetch {
  Future<MCQuestion> fetch();
}