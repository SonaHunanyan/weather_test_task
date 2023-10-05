import 'package:equatable/equatable.dart';
import 'package:weather_test_task/presentation/model/theme_type.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {}

class CountChangedState extends HomeState {
  CountChangedState({required this.count});
  final int count;

  @override
  List<Object?> get props => [count];
}

class ThemeChangedState extends HomeState {
  ThemeChangedState({required this.theme});
  final ThemeType theme;
  @override
  List<Object?> get props => [theme.name];
}
