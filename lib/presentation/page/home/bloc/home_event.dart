import 'package:weather_test_task/presentation/model/theme_type.dart';

abstract class HomeEvent {}

class IncrementCounterEvent extends HomeEvent {
  IncrementCounterEvent({
    required this.isDarkMode,
    required this.prevCounter,
  });
  final bool isDarkMode;
  final int prevCounter;
}

class DecrementCounterEvent extends HomeEvent {
  DecrementCounterEvent({
    required this.isDarkMode,
    required this.prevCounter,
  });
  final bool isDarkMode;
  final int prevCounter;
}

class ChangeThemeEvent extends HomeEvent {
  ChangeThemeEvent({required this.prevTheme});
  final ThemeType? prevTheme;
}
