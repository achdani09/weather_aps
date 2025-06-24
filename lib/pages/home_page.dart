import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/weather_card.dart';
import '../widgets/forecast_list.dart';
import '../widgets/drawer_content.dart';
import '../api/weather_api.dart';
import '../models/weather_model.dart';








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
  
  void _showCitySearchDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cari Desa/Kelurahan'),
          content: TextField(
            controller: _citySearchController,
            decoration: const InputDecoration(hintText: "Masukkan nama kota/desa"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Cari'),
              onPressed: () {
                if (_citySearchController.text.isNotEmpty) {
                  setState(() {
                    _currentCity = _citySearchController.text;
                    _saveCity(_currentCity);
                    _fetchWeatherData();
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lokasi diatur ke $_currentCity')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
void _onDrawerCitySelected(String city) {
    setState(() {
      _currentCity = city;
      _saveCity(_currentCity);
      _fetchWeatherData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onMenuPressed: () {
          Scaffold.of(context).openDrawer();
        },
        onLocationPressed: _fetchWeatherByLocation,
        onRefreshPressed: _fetchWeatherData,
      ),
      drawer: HomeDrawer(
        onCitySelected: _onDrawerCitySelected,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.blueGrey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: InkWell(
                      onTap: _showCitySearchDialog,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _currentCity,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const Icon(Icons.keyboard_arrow_down),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FutureBuilder<Weather>(
              future: _currentWeather,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: SpinKitFadingCircle(
                      color: Colors.blueAccent,
                      size: 50.0,
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}\nCoba refresh atau cek API Key Anda.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                    ),
                  );
                } else if (snapshot.hasData) {
                  return WeatherCard(weather: snapshot.data!);
                } else {
                  return const Center(child: Text('Tidak ada data cuaca'));
                }
              },
            ),
            const SizedBox(height: 20),
            const ForecastList(), // Menggunakan widget ForecastList
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}