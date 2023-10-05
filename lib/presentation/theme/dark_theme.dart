import 'package:flutter/material.dart';
import 'package:weather_test_task/presentation/theme/app_color.dart';

final base = ThemeData.dark();

final darkTheme = base.copyWith(
  colorScheme: const ColorScheme.light(
    background: Color(0xff2a2a2a),
    primary: AppColor.aquamarine,
    secondary: AppColor.black,
    primaryContainer: AppColor.blackOlive,
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
      color: AppColor.whiteGrey,
    ),
    labelMedium: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 30,
      height: 1.5,
      color: AppColor.lightGrey,
    ),
  ),
);
