import 'package:flutter_bloc/flutter_bloc.dart';

class HSToggleCubit extends Cubit<bool> {

  //much easier than trying to remember which is false and which is true
  static const bool LOCAL = false;
  static const bool GLOBAL = true;

  HSToggleCubit(bool initialState) : super(initialState);
  //switch to a new state
  void toggle(bool value) => emit(value);
}