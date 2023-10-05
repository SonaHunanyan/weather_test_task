import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_test_task/data/constant/preference_key.dart';
import 'package:weather_test_task/data/local_storage/shared_prefs.dart';
import 'package:weather_test_task/presentation/model/theme_type.dart';
import 'package:weather_test_task/presentation/page/home/bloc/home_event.dart';
import 'package:weather_test_task/presentation/page/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(
          HomeInitialState(),
        ) {
    on<IncrementCounterEvent>(_onIncrementCounterEvent);
    on<DecrementCounterEvent>(_onDecrementCounterEvent);
    on<ChangeThemeEvent>(_onChangeThemeEvent);
  }

  Future<void> _onIncrementCounterEvent(
      IncrementCounterEvent event, Emitter<HomeState> emit) async {
    final newCounter =
        event.isDarkMode ? event.prevCounter + 2 : event.prevCounter + 1;
    if (newCounter > 10) {
      return;
    }
    emit(
      CountChangedState(count: newCounter),
    );
  }

  Future<void> _onDecrementCounterEvent(
      DecrementCounterEvent event, Emitter<HomeState> emit) async {
    final newCounter =
        event.isDarkMode ? event.prevCounter - 2 : event.prevCounter - 1;
    if (newCounter < 0) {
      return;
    }
    emit(
      CountChangedState(count: newCounter),
    );
  }

  Future<void> _onChangeThemeEvent(
      ChangeThemeEvent event, Emitter<HomeState> emit) async {
    var isDarkMode = event.prevTheme == ThemeType.dark;
    final newTheme = isDarkMode ? ThemeType.light : ThemeType.dark;
    SharedPrefs().setString(PreferenceKey.theme, newTheme.name);
    emit(
      ThemeChangedState(theme: newTheme),
    );
  }
}
