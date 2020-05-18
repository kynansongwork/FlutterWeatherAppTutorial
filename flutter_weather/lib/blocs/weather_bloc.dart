import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_weather/repositories/repositories.dart';
import 'package:flutter_weather/models/models.dart';
import 'package:flutter_weather/blocs/blocs.dart';

// Converts Weather events to weather states and has a dependency on Weather repository.

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository}) : assert(weatherRepository != null);
// required is used if the parameter is an optional

  @override
  WeatherState get initialState => WeatherEmpty();

  // @override
  // Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
  //   // async* is used when deferring to another method
  //   if(event is FetchWeather) {
  //     yield WeatherLoading();
  //     // yield is similar to return but does not terminate the function
  //     // As only fetchweather is being handled, yielding the loading state is all that is needed.
      
  //     try {
  //       final Weather weather = await weatherRepository.getWeather(event.city);
  //       yield WeatherLoaded(weather: weather);
  //     } catch (_) {
  //       yield WeatherError();
  //     }
  //   }
  //   // New event to ask the weatherRepository to make an api call to get weather.
  //   if (event is RefreshWeather) {
  //     try {
  //       final Weather weather = await weatherRepository.getWeather(event.city);
  //       yield WeatherLoaded(weather: weather);
  //     } catch (_) {
  //       yield state;
  //     }
  //   }
  // }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield* _mapFetchWeatherToState(event);
    } else if (event is RefreshWeather) {
      yield* _mapRefreshWeatherToState(event);
    }
  }

  Stream<WeatherState> _mapFetchWeatherToState(FetchWeather event) async* {
    yield WeatherLoading();
    try {
      final Weather weather = await weatherRepository.getWeather(event.city);
      yield WeatherLoaded(weather: weather);
    } catch (_) {
      yield WeatherError();
    }
  }

  Stream<WeatherState> _mapRefreshWeatherToState(RefreshWeather event) async* {
    try {
      final Weather weather = await weatherRepository.getWeather(event.city);
      yield WeatherLoaded(weather: weather);
    } catch (_) {
      yield state;
    }
  }
}