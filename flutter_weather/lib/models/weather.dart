import 'package:equatable/equatable.dart';
//Equatable allows comparissons between objects without overiding ==

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  clear,
  unknown
}

class Weather extends Equatable {
  final WeatherCondition condition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;

  const Weather({
    this.condition,
    this.formattedCondition,
    this.minTemp,
    this.temp,
    this.maxTemp,
    this.locationId,
    this.created,
    this.lastUpdated,
    this.location
  });

  @override
  List<Object> get props => [
    condition, 
    formattedCondition,
    minTemp,
    temp,
    maxTemp,
    locationId,
    created,
    lastUpdated,
    location,
  ];

  static Weather fromJson(dynamic json) {
    final consolidateWeather = json['consolidated_weather'][0];
    return Weather(
      condition: _mapStringToWeatherCondition(
        consolidateWeather['weather_state_abbr']),
      formattedCondition: consolidateWeather['weather_state_name'],
      minTemp: consolidateWeather['min_temp'] as double,
      temp: consolidateWeather['the_temp'] as double,
      maxTemp: consolidateWeather['max_temp'] as double,
      locationId: json['woeid'] as int,
      created: consolidateWeather['created'],
      lastUpdated: DateTime.now(),
      location: json['title'],
      );
  }
}