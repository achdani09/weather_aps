import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';









class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Weather> _currentWeather;
  String _currentCity = 'Jakarta'; // Default city
  final TextEditingController _citySearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadLastCity();
  }

    Future<void> _loadLastCity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastCity = prefs.getString('last_city');
    if (lastCity != null && lastCity.isNotEmpty) {
      setState(() {
        _currentCity = lastCity;
        _fetchWeatherData();
      });
    } else {
      _fetchWeatherData();
    }
  }
  
  Future<void> _saveCity(String city) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_city', city);
  }

  Future<void> _fetchWeatherData() async {
    setState(() {
      _currentWeather = WeatherApi().getCurrentWeather(_currentCity);
    });
  }

  Future<void> _fetchWeatherByLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Layanan lokasi dinonaktifkan. Mohon aktifkan.')),
      );
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Izin lokasi ditolak.')),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Izin lokasi ditolak permanen. Mohon izinkan secara manual di pengaturan aplikasi.')),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentWeather = WeatherApi().getCurrentWeatherByCoordinates(position.latitude, position.longitude);
    });
  }