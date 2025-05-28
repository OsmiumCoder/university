import 'package:bloc/bloc.dart';

///BlocObserver observes all state changes.
class StreakObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('${bloc.runtimeType} $change');
  }
}