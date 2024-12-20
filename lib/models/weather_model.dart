import 'dart:convert';

class HourlyForecast {
  final DateTime time;
  final String skyCondition;
  final double temperature;

  HourlyForecast({
    required this.time,
    required this.skyCondition,
    required this.temperature,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time.toIso8601String(),
      'skyCondition': skyCondition,
      'temperature': temperature,
    };
  }

  factory HourlyForecast.fromMap(Map<String, dynamic> map) {
    return HourlyForecast(
      time: DateTime.parse(map['dt_txt']),
      skyCondition: map['weather'][0]['main'],
      temperature:
          (map['main']['temp'] as num).toDouble(), // Ensure double type
    );
  }

  String toJson() => json.encode(toMap());

  factory HourlyForecast.fromJson(String source) =>
      HourlyForecast.fromMap(json.decode(source) as Map<String, dynamic>);
}

class WeatherModel {
  final double currentTemp;
  final String currentSky;
  final double currentPressure;
  final double currentWindSpeed;
  final double currentHumidity;
  final List<HourlyForecast> hourlyForecasts;

  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
    required this.hourlyForecasts,
  });

  WeatherModel copyWith({
    double? currentTemp,
    String? currentSky,
    double? currentPressure,
    double? currentWindSpeed,
    double? currentHumidity,
    List<HourlyForecast>? hourlyForecasts,
  }) {
    return WeatherModel(
      currentTemp: currentTemp ?? this.currentTemp,
      currentSky: currentSky ?? this.currentSky,
      currentPressure: currentPressure ?? this.currentPressure,
      currentWindSpeed: currentWindSpeed ?? this.currentWindSpeed,
      currentHumidity: currentHumidity ?? this.currentHumidity,
      hourlyForecasts: hourlyForecasts ?? this.hourlyForecasts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'currentTemp': currentTemp,
      'currentSky': currentSky,
      'currentPressure': currentPressure,
      'currentWindSpeed': currentWindSpeed,
      'currentHumidity': currentHumidity,
      'hourlyForecasts': hourlyForecasts.map((x) => x.toMap()).toList(),
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];
    final hourlyForecasts = (map['list'] as List).map((forecast) {
      return HourlyForecast.fromMap(forecast);
    }).toList();

    return WeatherModel(
      currentTemp: (currentWeatherData['main']['temp'] as num)
          .toDouble(), // Ensure double
      currentSky: currentWeatherData['weather'][0]['main'],
      currentPressure: (currentWeatherData['main']['pressure'] as num)
          .toDouble(), // Ensure double
      currentWindSpeed: (currentWeatherData['wind']['speed'] as num)
          .toDouble(), // Ensure double
      currentHumidity: (currentWeatherData['main']['humidity'] as num)
          .toDouble(), // Ensure double
      hourlyForecasts: hourlyForecasts,
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'WeatherModel(currentTemp: $currentTemp, currentSky: $currentSky, currentPressure: $currentPressure, currentWindSpeed: $currentWindSpeed, currentHumidity: $currentHumidity, hourlyForecasts: $hourlyForecasts)';
  }

  @override
  bool operator ==(covariant WeatherModel other) {
    if (identical(this, other)) return true;

    return other.currentTemp == currentTemp &&
        other.currentSky == currentSky &&
        other.currentPressure == currentPressure &&
        other.currentWindSpeed == currentWindSpeed &&
        other.currentHumidity == currentHumidity &&
        other.hourlyForecasts == hourlyForecasts;
  }

  @override
  int get hashCode {
    return currentTemp.hashCode ^
        currentSky.hashCode ^
        currentPressure.hashCode ^
        currentWindSpeed.hashCode ^
        currentHumidity.hashCode ^
        hourlyForecasts.hashCode;
  }
}
