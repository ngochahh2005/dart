import 'package:equatable/equatable.dart';
import '../models/weather.dart';

class WeatherState extends Equatable {

  @override
  List<Object?> get props => [];

  const WeatherState();
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  const WeatherLoaded(this.weather);
  @override
  List<Object?> get props => [weather];
}

class WeatherError extends WeatherState {
  final String msg;
  const WeatherError(this.msg);
  @override
  List<Object?> get props => [msg];
}