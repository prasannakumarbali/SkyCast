import 'package:flutter/material.dart';
import 'package:weather/data_service.dart';
import 'package:weather/models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  List<String> _popularCities = [
    'London',
    'Paris',
    'New York',
    'Tokyo'
  ]; // Popular cities
  List<WeatherData> _weatherList = [];

  @override
  void initState() {
    super.initState();
    _fetchWeatherDataForCities(_popularCities);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,// vanishes the debug banner red banner at top right corner
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        appBarTheme: AppBarTheme(
          color: Colors.deepPurple,
        ),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Colors.deepPurpleAccent),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Weather App',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < _weatherList.length; i++)
                  Column(
                    children: [
                      if (i > 0) SizedBox(height: 24.0),
                      Column(
                        children: [
                          Text(
                            _weatherList[i].cityName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Image.network(
                            _weatherList[i].weatherResponse.iconUrl,
                            width: 120,
                            height: 120,
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            _capitalizeFirstLetter(
                              _weatherList[i].weatherResponse.weatherInfo.description,
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildTemperatureCard(
                                '${_weatherList[i].weatherResponse.tempInfo.temperatureC.toStringAsFixed(0)}°C',
                                'Celsius',
                              ),
                              SizedBox(width: 16.0),
                              _buildTemperatureCard(
                                '${_weatherList[i].weatherResponse.tempInfo.temperatureF.toStringAsFixed(0)}°F',
                                'Fahrenheit',
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24.0),
                      Divider(
                        color: Colors.grey.withOpacity(0.8),
                        thickness: 1.0,
                        indent: 16.0,
                        endIndent: 16.0,
                      ),
                    ],
                  ),
                SizedBox(height: 24.0),
                TextField(
                  controller: _cityTextController,
                  decoration: InputDecoration(
                    labelText: 'City',
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _search,
                  child: const Text(
                    'Search',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 15, 189, 163),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 24.0,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTemperatureCard(String temperature, String unit) {
    return Container(
      width: 120,
      padding: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 171, 209, 128),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Text(
            temperature,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            unit,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _fetchWeatherDataForCities(List<String> cities) async {
    for (final city in cities) {
      final weatherResponse = await _dataService.getWeather(city);
      setState(() {
        _weatherList.add(WeatherData(city, weatherResponse));
      });
    }
  }

  void _search() async {
    final city = _cityTextController.text.trim();
    if (city.isNotEmpty) {
      final weatherResponse = await _dataService.getWeather(city);
      setState(() {
        _weatherList.add(WeatherData(city, weatherResponse));
      });
      _cityTextController.clear();
    }
  }

  String _capitalizeFirstLetter(String text) {
    if (text.isEmpty) return '';
    return text[0].toUpperCase() + text.substring(1);
  }
}

class WeatherData {
  final String cityName;
  final WeatherResponse weatherResponse;

  WeatherData(this.cityName, this.weatherResponse);
}
//