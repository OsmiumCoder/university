
///represent a multiple-choice question
class MCQuestion {

  //instance fields
  final String category;
  final String questionText;

  int _correctIndex;
  final List<String> _choices;

  //initializing formals
  MCQuestion(this.category, this.questionText, this._choices, this._correctIndex) {
    if (correctIndex < 0 || correctIndex >= choiceCount) {
      throw RangeError.index(correctIndex, _choices);
    }
  }

  int get correctIndex => _correctIndex;

  int get choiceCount => _choices.length;

  //only comment methods when it isn't readily apparent from the method
  //name and parameter list / return type what the method does.
  //this method does not require comments. (delete this once you read it)
  String getChoice(int index) {
    if (index < 0 || index >= choiceCount) {
      throw RangeError.index(index, _choices);
    }
    return _choices[index].replaceAll("&amp;", "&");
  }


  ///shuffle the choices and ensure the correct index moves as well
  void shuffle() {
    String correctText = _choices[correctIndex];

    _choices.shuffle();
    _correctIndex = _choices.indexOf(correctText);
  }

  @override
  String toString() {
    var buffer = StringBuffer("category: $category\nquestion: $questionText\n");
    buffer.write("choices:\n");
    for (var i = 0; i < choiceCount; i++) {
      buffer.write("${_choices[i]}\n");
    }
    buffer.write("correct index: $_correctIndex");
    return buffer.toString();
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is MCQuestion &&
        o._choices.length == _choices.length &&
        o._choices.every((element) => _choices.contains(element)) &&
        o.questionText == questionText &&
        o.correctIndex == correctIndex;
  }

  @override
  int get hashCode {
        int hash = Object.hashAll(_choices);
        return hash ^ questionText.hashCode ^ correctIndex.hashCode;
  }
}