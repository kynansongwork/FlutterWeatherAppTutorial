import 'package:flutter_weather/blocs/weather_state.dart';
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

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    // async* is used when deferring to another method
    if(event is FetchWeather) {
      yield WeatherLoading();
      // yield is similar to return but does not terminate the function
      // As only fetchweather is being handled, yielding the loading state is all that is needed.
      
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoaded(weather: weather);
      } catch (_) {
        yield WeatherError();
      }
    }
  }
}