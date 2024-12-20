import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherDataProvider {
  Future<String> getCurrentWeather(String cityName) async {
    try {
      // String cityName = 'London';
      final res = await http.get(
        Uri.parse(
          'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIKey',
        ),
      );

      // final data = jsonDecode(res.body);

      // if (data['cod'] != '200') {
      //   throw 'An unexpected error occurred';
      // }

      // return data;
      return res.body;
    } catch (e) {
      throw e.toString();
    }
  }
}
