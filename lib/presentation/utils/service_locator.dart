import 'package:weather_test_task/data/local_storage/shared_prefs.dart';
import 'package:get_it/get_it.dart';
import 'package:weather_test_task/data/repository/weather_repository.dart';
import 'package:weather_test_task/data/service/location_service.dart';
import 'package:weather_test_task/domain/repository/weather_repository.dart';
import 'package:weather_test_task/domain/service/location_service.dart';

Future<void> setupDependencies() async {
  await SharedPrefs().init();
  GetIt.I.registerSingleton<IWeatherRepository>(WeatherRepository());
  GetIt.I.registerSingleton<ILocationService>(LocationService());
}
