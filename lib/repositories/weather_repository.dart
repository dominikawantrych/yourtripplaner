import 'package:dio/dio.dart';
import 'package:yourtripplaner/Features/models/weather_model.dart';

class WeatherRepository {
  Future<WeatherModel?> getWeatherModel({
    required String city,
  }) async {
   
   final response = await Dio().get<Map<String, dynamic>>('http://api.weatherapi.com/v1/current.json?key=4905e1b1656c4bc4b40111205220204&q=$city&aqi=no');
  final responseData = response.data;

  if (responseData == null) {
    return null;
  }

  final name = responseData['location']['name'] as String;
  final temperature = (responseData['current']['temp_c'] + 0.0) as double;
  
  return WeatherModel(temperature: temperature, city: name);
  }
}