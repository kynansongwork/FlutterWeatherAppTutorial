import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter_weather/models/models.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {}
// Initial state which has no data due to no city selection

class WeatherLoading extends WeatherState {}
// State during the fetch for a given city

class WeatherLoaded extends WeatherState {
  final Weather weather;

  const WeatherLoaded({@required this.weather}) : assert(weather != null);

  @override
  List<Object> get props => [weather];
}
// State when a succesful fetch occurs

class WeatherError extends WeatherState {}
// Error state