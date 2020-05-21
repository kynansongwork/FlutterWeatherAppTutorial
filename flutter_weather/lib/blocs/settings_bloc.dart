import 'dart:async';

import 'package:flutter_weather/widgets/widgets.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Settings event

abstract class SettingsEvent extends Equatable {}

// Event
class TemperatureUnitsToggled extends SettingsEvent {
  @override 
  List<Object> get props => [];
}

// Event consists of current Temperature Units
enum TemperatureUnits { fahrenheit, celsius }

class SettingsState extends Equatable {
  final TemperatureUnits temperatureUnits;

  const SettingsState({@required this.temperatureUnits})
    : assert(temperatureUnits != null);

  @override
  List<Object> get props => [temperatureUnits];
}

// Settings Bloc

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  @override
  SettingsState get initialState =>
    SettingsState(temperatureUnits: TemperatureUnits.celsius);

  @override
  Stream<SettingsState> mapEventToState(SettingsEvent event) async* {
    if (event is TemperatureUnitsToggled) {
      //Yield is similar to return but does not end the function.
      yield SettingsState(
        temperatureUnits: state.temperatureUnits == TemperatureUnits.celsius 
          ? TemperatureUnits.fahrenheit : TemperatureUnits.celsius,
      );
    }
  }
}