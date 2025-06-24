class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final String iconCode;
  final double minTemperature;
  final double maxTemperature;
  final int humidity;
  final double windSpeed;
  final int dt; // Timestamp

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.iconCode,
    required this.minTemperature,
    required this.maxTemperature,
    required this.humidity,
    required this.windSpeed,
    required this.dt,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'] ?? 'Unknown',
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
      minTemperature: (json['main']['temp_min'] as num).toDouble(),
      maxTemperature: (json['main']['temp_max'] as num).toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      dt: json['dt'],
    );
  }
}

class DailyWeather {
  final int dt;
  final double minTemp;
  final double maxTemp;
  final String description;
  final String iconCode;

  DailyWeather({
    required this.dt,
    required this.minTemp,
    required this.maxTemp,
    required this.description,
    required this.iconCode,
  });

  factory DailyWeather.fromJson(Map<String, dynamic> json) {
    return DailyWeather(
      dt: json['dt'],
      minTemp: (json['temp']['min'] as num).toDouble(),
      maxTemp: (json['temp']['max'] as num).toDouble(),
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
    );
  }
}