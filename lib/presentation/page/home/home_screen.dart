import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_test_task/presentation/model/theme_type.dart';
import 'package:weather_test_task/presentation/page/home/bloc/home_bloc.dart';
import 'package:weather_test_task/presentation/page/home/bloc/home_event.dart';
import 'package:weather_test_task/presentation/page/home/bloc/home_state.dart';
import 'package:weather_test_task/presentation/page/home/widgets/rounded_button.dart';
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
  String? _weatherInfo;

  final _bloc = HomeBloc();

  late ThemeProvider _themeProvider;

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
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50 * rw(context)),
                        child: Text(
                          _weatherInfo ?? '',
                          style: context.themeData.textTheme.titleLarge,
                        ),
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
                    onTap: () {},
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