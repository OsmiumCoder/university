import 'package:multiple_choice_question/multiple_choice_question.dart';
import 'package:test/test.dart';

void main() {
  group("MCQuestion", () {
    //perform some common set-up
    List<String> choices = ["A", "B", "C"];

    String category = "A,B or C";
    String text = "Is is A,B or C?";

    int correctIndex = 2;

    late MCQuestion question;

    //the setUp method gets called before every test in this group
    setUp(() {
      question = MCQuestion(category, text, choices, correctIndex);
    });

    test('test correct index on declaration', () {
      expect(question.correctIndex, 2);
    });

    test('correct index too low on creation throws RangeError', () {
      expect( () => MCQuestion(category, text, choices, -1), throwsA(isRangeError));
    });

    // given more test
    test('correct index too large on creation throws RangeError', () {
      expect(() => MCQuestion(category, text, choices, 3), throwsRangeError);
    });

    // other tests
    test('get length of choices returns correct length', () {
      expect(question.choiceCount, 3);
    });

    test('getChoice returns correct choice', () {
      expect(question.getChoice(1), choices[1]);
    });

    test('getChoice throws range error if choice out of range', () {
      expect(() => question.getChoice(-1), throwsRangeError);
      expect(() => question.getChoice(10), throwsRangeError);
    });

    test('toString returns correctly formatted string', () {
      expect(question.toString(), 'category: A,B or C\n'
                                  'question: Is is A,B or C?\n'
                                  'choices: A,\n'
                                            'B,\n'
                                            'C,\n'
                                  'correct index: 2\n'
          '');
    });

    test('test correct index works after random shuffle', () {
      String correctText = question.getChoice(correctIndex);

      //Everyday I'm shuffling (until the choice at idx 2 moves)
      while (question.getChoice(correctIndex) == correctText) {
        question.shuffle();
      }
      expect(question.correctIndex, isNot(2));
    });
  });

  group('A group of tests', () {
    final awesome = Awesome();

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(awesome.isAwesome, isTrue);
    });
  });
}
