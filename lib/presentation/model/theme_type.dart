import 'package:flutter/material.dart';
import 'package:weather_test_task/presentation/theme/dark_theme.dart';
import 'package:weather_test_task/presentation/theme/light_theme.dart';

enum ThemeType {
  light,
  dark,
}

extension ThemeTypeAddition on ThemeType {
  static ThemeType getThemeTypeByName(String name) {
    return ThemeType.values.firstWhere(
        (element) => element.name.toLowerCase() == name.toLowerCase());
  }

  ThemeData get themeData {
    switch (this) {
      case ThemeType.light:
        return lightTheme;
      case ThemeType.dark:
        return darkTheme;
    }
  }
}
