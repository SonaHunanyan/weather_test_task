import 'package:weather_test_task/domain/model/weather/weather.dart';

abstract class IWeatherRepository {
  Future<Weather> getWeather({required String country});
}
