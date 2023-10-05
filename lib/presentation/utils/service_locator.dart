import 'package:weather_test_task/data/local_storage/shared_prefs.dart';

Future<void> setupDependencies() async {
  await SharedPrefs().init();
}
