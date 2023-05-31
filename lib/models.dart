class WeatherResponse {
  final String cityName;
  final WeatherInfo weatherInfo;
  final TemperatureInfo tempInfo;

  WeatherResponse({
    required this.cityName,
    required this.weatherInfo,
    required this.tempInfo,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];
    final weatherInfo = WeatherInfo.fromJson(json['weather'][0]);
    final tempInfo = TemperatureInfo.fromJson(json['main']);

    return WeatherResponse(
      cityName: cityName,
      weatherInfo: weatherInfo,
      tempInfo: tempInfo,
    );
  }

  String get iconUrl => 'https://openweathermap.org/img/w/${weatherInfo.icon}.png';
}

class WeatherInfo {
  final String description;
  final String icon;

  WeatherInfo({
    required this.description,
    required this.icon,
  });

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];

    return WeatherInfo(
      description: description,
      icon: icon,
    );
  }
}

class TemperatureInfo {
  final double temperatureC;
  final double temperatureF;

  TemperatureInfo({
    required this.temperatureC,
    required this.temperatureF,
  });

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperatureC = json['temp'].toDouble();
    final temperatureF = temperatureC * 9 / 5 + 32;

    return TemperatureInfo(
      temperatureC: temperatureC,
      temperatureF: temperatureF,
    );
  }
}
//