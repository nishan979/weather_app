class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;
  final String feelsLike;
  final String minTemperature;
  final String maxTemperature;
  final String pressure;
  final String humidity;
  final String windSpeed;
  final String winDegree;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
    required this.feelsLike,
    required this.minTemperature,
    required this.maxTemperature,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.winDegree,

  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      cityName: json['name'],
      temperature: json['main']['temp'],
      mainCondition: json['weather'][0]['main'],
      feelsLike: json['main']['feels_like'],
      minTemperature: json['main']['temp_min'],
      maxTemperature: json['main']['temp_max'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      winDegree: json['wind']['deg'],
    );
  }
}
