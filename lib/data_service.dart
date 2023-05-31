import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:weather/models.dart';
import 'package:http/http.dart' as http;

class DataService {
  Future<WeatherResponse> getWeather(String city) async {
    final queryParameters = {
      'q': city,
      'appid': '98e8dfcf4ea2319b693eb4c58b2a6018',//def460871e1ffe64f71901ffbaf55129
      'units': 'metric', // Use metric for Celsius and imperial for Fahrenheit
    };

    final uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    final json = jsonDecode(response.body);
    return WeatherResponse.fromJson(json);
  }

  Future<WeatherResponse> getWeatherByCoordinates(double latitude, double longitude) async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    final String city = placemarks.first.locality ?? '';

    return getWeather(city);
  }
}
//