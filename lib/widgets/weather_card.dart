import 'package:flutter/material.dart';
import '../models/weather_model.dart'; // Import model Weather
import '../utils/string_extensions.dart'; // Import extension

class WeatherCard extends StatelessWidget {
  final Weather weather;

  const WeatherCard({Key? key, required this.weather}) : super(key: key);

  // Widget helper untuk info item (humidity, wind)
  Widget _buildInfoItem(IconData icon, String label, String value, Color textColor) {
    return Column(
      children: [
        Icon(icon, color: textColor.withOpacity(0.8), size: 24),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7))),
        Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: textColor)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade300, Colors.blue.shade600],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              weather.cityName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${weather.temperature.round()}°C',
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      weather.description.capitalizeFirstofEach,
                      style: const TextStyle(fontSize: 18, color: Colors.white70),
                    ),
                  ],
                ),
                Image.network(
                  'http://openweathermap.org/img/wn/${weather.iconCode}@2x.png',
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInfoItem(Icons.water_drop, 'Humidity', '${weather.humidity}%', Colors.white),
                _buildInfoItem(Icons.wind_power, 'Wind Speed', '${weather.windSpeed.round()} Km/H', Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}