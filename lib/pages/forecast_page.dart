import 'package:flutter/material.dart';






class ForecastPage extends StatefulWidget {
  const ForecastPage({Key? key}) : super(key: key);

  @override
  State<ForecastPage> createState() => _ForecastPageState();
}
class _ForecastPageState extends State<ForecastPage> {
  late Future<List<DailyWeather>> _dailyForecast;
  String _currentCity = 'Jakarta'; // Default city for forecast

  @override
  void initState() {
    super.initState();
    _loadLastCityAndFetchForecast();
  }

  Future<void> _loadLastCityAndFetchForecast() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastCity = prefs.getString('last_city');
    if (lastCity != null && lastCity.isNotEmpty) {
      setState(() {
        _currentCity = lastCity;
      });
    }
    _fetchdailyforecast();
  }
  Future<void> _fetchDailyForecast() async {
    setState(() {
      _dailyForecast = WeatherApi().getDailyForecast(_currentCity);
    });
  }
  
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prakiraan 7 Hari'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchDailyForecast,
          ),
        ],
      ),
      body: FutureBuilder<List<DailyWeather>>(
        future: _dailyForecast,
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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ForecastItem(dailyWeather: snapshot.data![index]);
              },
            );
          } else {
            return const Center(child: Text('Tidak ada prakiraan cuaca'));
          }
        },
      ),
    );
  }
}