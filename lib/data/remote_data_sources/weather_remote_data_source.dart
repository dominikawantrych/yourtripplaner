import 'package:dio/dio.dart';

class WeatherRemoteDataSource {
  Future<Map<String, dynamic>?> getWeatherData({
    required String city,
  }) async {
   
   final response = await Dio().get<Map<String, dynamic>>('http://api.weatherapi.com/v1/current.json?key=4905e1b1656c4bc4b40111205220204&q=$city&aqi=no');
  return response.data;

 
  }
}