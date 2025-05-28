import 'package:bloc/bloc.dart';

/// {@template streak_cubit}
/// A [Cubit] which manages an [int] as its state.
/// {@endtemplate}
class StreakCubit extends Cubit<int> {
  /// {@macro counter_cubit}
  StreakCubit() : super(0);

  /// Add 1 to the current state.
  void increment() => emit(state + 1);

  /// reset state to zero
  void reset() => emit(0);
}