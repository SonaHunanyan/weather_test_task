import 'package:weather_test_task/data/constant/app_url.dart';
import 'package:weather_test_task/data/http/dio.dart';
import 'package:weather_test_task/domain/model/weather/weather.dart';
import 'package:weather_test_task/domain/repository/weather_repository.dart';

class WeatherRepository implements IWeatherRepository {
  @override
  Future<Weather> getWeather({required String country}) async {
    final params = <String, dynamic>{
      'q': country,
      'appid': 'c2cf3adcc65c876fbe91e5d7ec04f44c',
    };

    final resp = await dio.get(
      AppUrl.weather,
      queryParameters: params,
    );

    final balance = Weather.fromJson(resp.data['main']);
    return balance;
  }
}
