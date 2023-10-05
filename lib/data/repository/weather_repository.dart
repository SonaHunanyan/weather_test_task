import 'package:weather_test_task/data/constant/api_key.dart';
import 'package:weather_test_task/data/constant/app_url.dart';
import 'package:weather_test_task/data/http/dio.dart';
import 'package:weather_test_task/domain/model/weather/weather.dart';
import 'package:weather_test_task/domain/repository/weather_repository.dart';

class WeatherRepository implements IWeatherRepository {
  @override
  Future<Weather> getWeather({required String country}) async {
    final params = <String, dynamic>{
      'q': country,
      'appid': ApiKey.weather,
    };

    final resp = await dio.get(
      AppUrl.weather,
      queryParameters: params,
    );

    final balance = Weather.fromJson(resp.data['main']);
    return balance;
  }
}
