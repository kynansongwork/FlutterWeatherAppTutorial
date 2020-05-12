import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_weather/models/weather.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient {

// Base URL and instantiating http client
  static const baseUrl = 'https://www.metaweather.com';
  final http.Client httpClient;

// Constructor that requires and instance of http client
  WeatherApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

// http request and decoding of the response
// Future completes if the asynchronous operation succeeds
  Future<int>getLocationId(String city) async {
    final locationUrl = '$baseUrl/api/location/search/?query=$city';
    final locationResponse = await this.httpClient.get(locationUrl);

    if (locationResponse.statusCode != 200) {
      throw Exception('error getting locationId for city');
    }

    final locationJson = jsonDecode(locationResponse.body) as List;
    return (locationJson.first)['woeid'];
  }

  //fetching weather method
  Future<Weather> fetchWeather(int locationId) async {
    final weatherUrl = '$baseUrl/api/location/$locationId';
    final weatherResponse = await this.httpClient.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherJson = jsonDecode(weatherResponse.body);
    return Weather.fromJson(weatherJson);
  }
}