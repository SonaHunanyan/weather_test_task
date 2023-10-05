import 'package:flutter/material.dart';
import 'package:weather_test_task/presentation/model/theme_type.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider({required ThemeType themeType}) : _themeType = themeType;

  ThemeType? _themeType;
  ThemeType? get themeType => _themeType;

  set themeType(ThemeType? themeType) {
    _themeType = themeType;
    notifyListeners();
  }
}
