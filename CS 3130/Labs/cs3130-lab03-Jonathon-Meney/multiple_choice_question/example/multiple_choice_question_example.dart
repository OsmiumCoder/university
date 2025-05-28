import 'package:multiple_choice_question/multiple_choice_question.dart';

void main() async {

  late MCQuestion question;
  bool done = false;

  //try to get an MCQuestion 3 times before declaring failure
  for (int i = 0; i< 3 && !done; i++) {
    try {
      question = await RandomQuestionFetch().fetch();
      print(question);
      done = true;
    }
    on RangeError catch(e) {
      print(e.message);
      print("attempt: ${i+1} of 3");
    }
    on FormatException catch(e) {
      print(e.message);
      print("attempt: ${i+1} of 3");
    }
    catch(e) {
      print(e);
      print("attempt: ${i+1} of 3");
    }
  }
}