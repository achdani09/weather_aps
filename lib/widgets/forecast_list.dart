import 'package:flutter/material.dart';

class ForecastList extends StatelessWidget {
  const ForecastList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> dummyForecasts = [
      {'time': 'Currently', 'temp': '23°C', 'icon': '01d'},
      {'time': 'Sat 02:00', 'temp': '22°C', 'icon': '02n'},
      {'time': 'Sat 03:00', 'temp': '21°C', 'icon': '04n'},
      {'time': 'Sat 04:00', 'temp': '20°C', 'icon': '04n'},
      {'time': 'Sat 05:00', 'temp': '19°C', 'icon': '04n'},
      {'time': 'Sat 06:00', 'temp': '18°C', 'icon': '04n'},
      {'time': 'Sat 07:00', 'temp': '19°C', 'icon': '02d'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Weather Forecasts',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: dummyForecasts.length,
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                margin: EdgeInsets.only(left: index == 0 ? 16 : 8, right: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      dummyForecasts[index]['time']!,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Image.network(
                      'http://openweathermap.org/img/wn/${dummyForecasts[index]['icon']}@2x.png',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      dummyForecasts[index]['temp']!,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}