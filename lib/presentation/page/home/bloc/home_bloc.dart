import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_test_task/data/constant/preference_key.dart';
import 'package:weather_test_task/data/local_storage/shared_prefs.dart';
import 'package:weather_test_task/domain/repository/weather_repository.dart';
import 'package:weather_test_task/domain/service/location_service.dart';
import 'package:weather_test_task/presentation/model/theme_type.dart';
import 'package:weather_test_task/presentation/page/home/bloc/home_event.dart';
import 'package:weather_test_task/presentation/page/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required this.weatherRepository,
    required this.locationService,
  }) : super(
          HomeInitialState(),
        ) {
    on<IncrementCounterEvent>(_onIncrementCounterEvent);
    on<DecrementCounterEvent>(_onDecrementCounterEvent);
    on<ChangeThemeEvent>(_onChangeThemeEvent);
    on<GetWeatherEvent>(_onGetWeatherEvent);
    on<RequestPermissionEvent>(_onRequestPermissionEvent);
  }

  final IWeatherRepository weatherRepository;
  final ILocationService locationService;

  Future<void> _onIncrementCounterEvent(
      IncrementCounterEvent event, Emitter<HomeState> emit) async {
    final newCounter =
        event.isDarkMode ? event.prevCounter + 2 : event.prevCounter + 1;
    if (newCounter > 10) {
      return;
    }
    emit(
      CountChangedState(count: newCounter),
    );
  }

  Future<void> _onDecrementCounterEvent(
      DecrementCounterEvent event, Emitter<HomeState> emit) async {
    final newCounter =
        event.isDarkMode ? event.prevCounter - 2 : event.prevCounter - 1;
    if (newCounter < 0) {
      return;
    }
    emit(
      CountChangedState(count: newCounter),
    );
  }

  Future<void> _onChangeThemeEvent(
      ChangeThemeEvent event, Emitter<HomeState> emit) async {
    var isDarkMode = event.prevTheme == ThemeType.dark;
    final newTheme = isDarkMode ? ThemeType.light : ThemeType.dark;
    SharedPrefs().setString(PreferenceKey.theme, newTheme.name);
    emit(
      ThemeChangedState(theme: newTheme),
    );
  }

  Future<void> _onGetWeatherEvent(
      GetWeatherEvent event, Emitter<HomeState> emit) async {
    try {
      final position = await locationService.getPosition();
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      final country = placemarks.first.country;
      if (country == null) {
        FailToLoadWeatherState(
          error: 'Fail to get user location',
        );
        return;
      }
      final weather = await weatherRepository.getWeather(country: country);
      emit(WeatherLoadedState(weather: weather, country: country));
    } catch (e) {
      emit(
        FailToLoadWeatherState(
          error: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRequestPermissionEvent(
      RequestPermissionEvent event, Emitter<HomeState> emit) async {
    try {
      await locationService.requestPermission();
      emit(PermissionRequestedState());
    } catch (e) {
      throw Exception(e);
    }
  }
}
