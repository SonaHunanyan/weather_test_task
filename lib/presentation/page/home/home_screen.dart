import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:weather_test_task/domain/model/weather/weather.dart';
import 'package:weather_test_task/presentation/model/theme_type.dart';
import 'package:weather_test_task/presentation/page/home/bloc/home_bloc.dart';
import 'package:weather_test_task/presentation/page/home/bloc/home_event.dart';
import 'package:weather_test_task/presentation/page/home/bloc/home_state.dart';
import 'package:weather_test_task/presentation/page/home/widgets/rounded_button.dart';
import 'package:weather_test_task/presentation/page/home/widgets/tempreture_widget.dart';
import 'package:weather_test_task/presentation/provider/theme_provider.dart';
import 'package:weather_test_task/presentation/theme/app_strings.dart';
import 'package:weather_test_task/presentation/theme/app_theme.dart';
import 'package:weather_test_task/presentation/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _counter = 0;
  Weather? _weatherInfo;
  String? _country;

  final _bloc = HomeBloc(
    locationService: GetIt.I.get(),
    weatherRepository: GetIt.I.get(),
  );

  late ThemeProvider _themeProvider;

  @override
  void initState() {
    _bloc.add(RequestPermissionEvent());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => _bloc,
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is CountChangedState) {
            _counter = state.count;
          }
          if (state is ThemeChangedState) {
            _themeProvider.themeType = state.theme;
          }
          if (state is WeatherLoadedState) {
            _weatherInfo = state.weather;
            _country = state.country;
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) => Scaffold(
            backgroundColor: context.themeData.colorScheme.background,
            appBar: AppBar(
              backgroundColor: context.themeData.colorScheme.primaryContainer,
              title: Text(
                AppStrings.weatherCounter,
                style: context.themeData.textTheme.headlineLarge,
              ),
            ),
            body: Center(
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TempretureWidget(
                        weather: _weatherInfo,
                        coutry: _country,
                      ),
                      SizedBox(
                        height: 20 * rh(context),
                      ),
                      Text(
                        AppStrings.youHavePushed,
                        style: context.themeData.textTheme.titleLarge,
                      ),
                      Text(
                        '$_counter',
                        style: context.themeData.textTheme.labelMedium,
                      ),
                    ],
                  ),
                  RoundedButton(
                    bottom: 100 * rh(context),
                    right: 10 * rw(context),
                    onTap: () {
                      _bloc.add(
                        IncrementCounterEvent(
                          isDarkMode:
                              _themeProvider.themeType == ThemeType.dark,
                          prevCounter: _counter,
                        ),
                      );
                    },
                    iconData: Icons.add,
                  ),
                  RoundedButton(
                    bottom: 20 * rh(context),
                    right: 10 * rw(context),
                    onTap: () {
                      _bloc.add(
                        DecrementCounterEvent(
                          isDarkMode:
                              _themeProvider.themeType == ThemeType.dark,
                          prevCounter: _counter,
                        ),
                      );
                    },
                    iconData: Icons.remove,
                  ),
                  RoundedButton(
                    bottom: 20 * rh(context),
                    left: 10 * rw(context),
                    onTap: () {
                      _bloc.add(
                        ChangeThemeEvent(prevTheme: _themeProvider.themeType),
                      );
                    },
                    iconData: Icons.palette,
                  ),
                  RoundedButton(
                    bottom: 100 * rh(context),
                    left: 10 * rw(context),
                    onTap: () {
                      _bloc.add(GetWeatherEvent());
                    },
                    iconData: Icons.cloud,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
