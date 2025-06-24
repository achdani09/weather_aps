import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../utils/app_constants.dart'; // Untuk API_KEY

class WeatherApi {
  final String _apiKey = AppConstants.openWeatherMapApiKey;
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<Weather> getCurrentWeather(String city) async {
    final response = await http.get(Uri.parse('$_baseUrl/weather?q=$city&appid=$_apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load current weather');
    }
  }

  
  Future<Weather> getCurrentWeatherByCoordinates(double lat, double lon) async {
    final response = await http.get(Uri.parse('$_baseUrl/weather?lat=$lat&lon=$lon&appid=$_apiKey&units=metric'));

    if (response.statusCode == 200) {
      return Weather.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load current weather by coordinates');
    }
  }