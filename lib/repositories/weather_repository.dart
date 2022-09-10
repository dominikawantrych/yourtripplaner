import 'package:yourtripplaner/Features/models/weather_model.dart';

class WeatherRepository {
  Future<WeatherModel?> getWeatherModel({
    required String city,
  }) async {
    return const WeatherModel(temperature: 5, city: 'London');
  }
}