import 'package:flutter/material.dart';
import 'package:weather_test_task/presentation/theme/app_color.dart';

final base = ThemeData.light();

final lightTheme = base.copyWith(
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(
    background: Color(0xfff9f9f9),
    primary: AppColor.blue,
    secondary: AppColor.white,
    primaryContainer: AppColor.blueDeFrance,
  ),
  textTheme: base.primaryTextTheme.copyWith(
    headlineLarge: const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 25,
      height: 1,
      color: Colors.white,
    ),
    titleLarge: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1,
      color: AppColor.darkGrey,
    ),
    labelMedium: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 30,
      height: 1.5,
      color: AppColor.grey,
    ),
  ),
);
