import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_test_task/data/constant/preference_key.dart';
import 'package:weather_test_task/data/local_storage/shared_prefs.dart';
import 'package:weather_test_task/presentation/extension/bloc_observer.dart';
import 'package:weather_test_task/presentation/model/theme_type.dart';
import 'package:weather_test_task/presentation/page/home/home_screen.dart';
import 'package:weather_test_task/presentation/provider/theme_provider.dart';
import 'package:weather_test_task/presentation/utils/service_locator.dart';

Future<void> main() async {
  await _init();
  final theme = SharedPrefs()
      .valueByKey(PreferenceKey.theme, defaultValue: ThemeType.light.name);
  final themeType = ThemeTypeAddition.getThemeTypeByName(theme);
  runApp(MyApp(
    themeType: themeType,
  ));
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await setupDependencies();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.themeType});
  final ThemeType themeType;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(themeType: themeType),
      child: Consumer<ThemeProvider>(
        builder: (context, ThemeProvider themeNotifier, child) {
          return MaterialApp(
            title: 'Weather',
            theme: themeNotifier.themeType?.themeData,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
