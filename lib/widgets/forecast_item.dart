import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import 'package:intl/intl.dart';

class ForecastItem extends StatelessWidget {
  final DailyWeather dailyWeather;

  const ForecastItem({Key? key, required this.dailyWeather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                DateFormat('EEE, MMM d').format(DateTime.fromMillisecondsSinceEpoch(dailyWeather.dt * 1000)),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 1,
              child: Image.network(
                'http://openweathermap.org/img/wn/${dailyWeather.iconCode}.png',
                width: 50,
                height: 50,
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dailyWeather.description,
                    style: const TextStyle(fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${dailyWeather.minTemp.round()}°C / ${dailyWeather.maxTemp.round()}°C',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}