import 'package:conversion_units/conversion_units.dart';

extension TempretureParser on double {
  String get celsius => Kelvin.toCelsius(this).toStringAsFixed(2);
  String get fahrenheit => Kelvin.toFahrenheit(this).toStringAsFixed(2);
}
