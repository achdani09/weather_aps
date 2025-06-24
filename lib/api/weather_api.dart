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

    Future<List<DailyWeather>> getDailyForecast(String city) async {
    final geoResponse = await http.get(Uri.parse('$_baseUrl/weather?q=$city&appid=$_apiKey'));

    if (geoResponse.statusCode != 200) {
      print('DEBUG - GAGAL GET KOORDINAT UNTuk $city. Status: ${geoResponse.statusCode}, Body: ${geoResponse.body}');
      throw Exception('Failed to get coordinates for city (Status: ${geoResponse.statusCode})');
    }

    final geoData = jsonDecode(geoResponse.body);
    final lat = geoData['coord']['lat'];
    final lon = geoData['coord']['lon'];

    print('DEBUG - KOORDINAT DIDAPATKAN UNTUK $city: Lat=$lat, Lon=$lon');


    final forecastResponse = await http.get(Uri.parse('$_baseUrl/onecall?lat=$lat&lon=$lon&exclude=current,minutely,hourly,alerts&appid=$_apiKey&units=metric'));

    if (forecastResponse.statusCode == 200) {
      print('DEBUG - RESPON ONE CALL API BERHASIL. Body (potongan): ${forecastResponse.body.substring(0, forecastResponse.body.length > 500 ? 500 : forecastResponse.body.length)}...');

      List<DailyWeather> dailyForecasts = [];
      final data = jsonDecode(forecastResponse.body)['daily'] as List; // Pastikan 'daily' ada
      for (var item in data) {
        dailyForecasts.add(DailyWeather.fromJson(item));
      }
      return dailyForecasts;
    } else {
      // Tambahkan print untuk melihat error respons jika gagal mendapatkan prakiraan
      print('DEBUG - GAGAL GET PRAKIRAAN HARIAN. Status: ${forecastResponse.statusCode}, Body: ${forecastResponse.body}');
      throw Exception('Failed to load daily forecast (Status: ${forecastResponse.statusCode})');
    }
  }
}