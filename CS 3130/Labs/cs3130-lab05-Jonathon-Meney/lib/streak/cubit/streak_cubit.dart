import 'package:bloc/bloc.dart';

/// A Cubit which manages an int as its state.
class StreakCubit extends Cubit<int> {
  StreakCubit() : super(0);

  void reset() {
    //emit will set the state to 0
    //AND tell everyone to update (e.g. redraw a UI widget)
    emit(0);
  }

  void increment() {
    emit(state + 1);
  }
}