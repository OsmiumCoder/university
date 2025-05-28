/// file: mc_question.dart
/*
category: the serpent
question: Kaa the serpent had his mesmerizing eyes
set on Mowgli in this 1967 Disney favorite

choices: [ Raiders of the Lost Ark,
          The Jungle Book,
          Conan the Barbarian,
          Kill Bill ]

correct index: 1
 */
class MCQuestion {

  //instance fields
  final String category;
  final String question;
  final List<String> _choices;
  int _correctIndex;

  //constructor

  MCQuestion(this.category, this.question, this._choices, this._correctIndex) {
    if (correctIndex < 0 || correctIndex >= _choices.length) {
      throw RangeError.index(correctIndex, _choices);
    }
  }
  
  int get choiceCount => _choices.length;

  int get correctIndex => _correctIndex;

  ///shuffle the choices and ensure the correct index moves as well
  void shuffle() {
    String correctText = _choices[correctIndex];

    _choices.shuffle();
    _correctIndex = _choices.indexOf(correctText);
  }

  String getChoice(int index) {
    if (index < 0 || index >= choiceCount) {
      throw RangeError.index(index, _choices);
    }
    return _choices[index];
  }

  @override
  String toString() {
    StringBuffer stringBuffer = StringBuffer("category: $category\nquestion: $question\nchoices:\n");
    for (var i = 0; i < _choices.length; i++) {
      stringBuffer.write("${_choices[i]},\n");
    }
    stringBuffer.write("correct index: $correctIndex\n");

    return stringBuffer.toString();
  }


}