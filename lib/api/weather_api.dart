import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../utils/app_constants.dart'; // Untuk API_KEY

class WeatherApi {
  final String _apiKey = AppConstants.openWeatherMapApiKey;
  final String _baseUrl = 'https://api.openweathermap.org/data/2.5';
