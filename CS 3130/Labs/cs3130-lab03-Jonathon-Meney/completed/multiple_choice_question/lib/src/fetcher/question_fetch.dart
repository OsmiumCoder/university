import 'package:multiple_choice_question/multiple_choice_question.dart';

import '../mc_question.dart';

abstract class QuestionFetch {
  Future<MCQuestion> fetch();
}