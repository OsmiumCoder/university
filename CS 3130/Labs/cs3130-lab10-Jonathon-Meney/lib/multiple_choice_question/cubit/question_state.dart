part of 'question_cubit.dart';

@immutable
abstract class QuestionState {
  const QuestionState();
}

class QuestionInitial extends QuestionState {}

class QuestionLoading extends QuestionState {
  const QuestionLoading();
}

class QuestionLoaded extends QuestionState {
  final MCQuestion question;
  const QuestionLoaded(this.question);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is QuestionLoaded && o.question == question;
  }

  @override
  int get hashCode => question.hashCode;
}

class QuestionAnswered extends QuestionState {
  final MCQuestion question;
  final int answer;
  const QuestionAnswered(this.question, this.answer);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is QuestionAnswered &&
           o.question == question &&
           o.answer == answer;
  }

  @override
  int get hashCode => question.hashCode ^ answer.hashCode;
}

class QuestionError extends QuestionState {
  final String message;
  const QuestionError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is QuestionError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
