import 'package:multiple_choice_question/multiple_choice_question.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final awesome = Awesome();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(awesome.isAwesome, isTrue);
    });
  });

  group("MCQuestion", ()
  {
    //perform some common set-up
    List<String> choices = ["A", "B", "C"];

    String category = "A,B or C";
    String text = "Is is A,B or C?";

    int correctIdx = 2;

    late MCQuestion question;

    //the setUp method gets called before every test in this group
    setUp(() {
      question = MCQuestion(category, text, choices, correctIdx);
    });

    test('test correct index on declaration', () {
      print(question);
      expect(question.correctIndex, correctIdx);
    });

    test('correct index too low on creation throws RangeError', () {
      expect( () => MCQuestion(category, text, choices, -1), throwsA(isRangeError));
    });

    test('correct index too high on creation throws RangeError', () {
      expect( () => MCQuestion(category, text, choices, choices.length), throwsA(isRangeError));
    });

    test('test random shuffle tracks correct index', () {
      String correctText = question.getChoice(correctIdx);

      //Everyday I'm shuffling (until the choice at idx 2 moves)
      while (question.getChoice(correctIdx) == correctText) {
        question.shuffle();
      }
      expect(question.correctIndex, isNot(2));
    });

    //TODO Add unit-tests - getters, toString, etc.

  });//end of the group
}
