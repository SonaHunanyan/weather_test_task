import 'package:flutter/material.dart';
import 'package:weather_test_task/domain/model/weather/weather.dart';
import 'package:weather_test_task/presentation/extension/tempreture_parser.dart';
import 'package:weather_test_task/presentation/theme/app_theme.dart';
import 'package:weather_test_task/presentation/utils/constants.dart';

class TempretureWidget extends StatelessWidget {
  const TempretureWidget(
      {super.key, required this.coutry, required this.weather});
  final String? coutry;
  final Weather? weather;

  @override
  Widget build(BuildContext context) {
    if (weather == null || coutry == null) {
      return const SizedBox();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50 * rw(context)),
      child: Text(
        'Weather for $coutry: ${weather!.temp.celsius}°C (${weather!.temp.fahrenheit}°F)',
        style: context.themeData.textTheme.titleLarge,
      ),
    );
  }
}
