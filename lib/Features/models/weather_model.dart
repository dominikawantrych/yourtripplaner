import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  const WeatherModel({
    required this.temperature,
    required this.city,
  });

  @JsonKey(name: 'temp_c')
  final double temperature;

  @JsonKey(name: 'name')
  final String city;

  factory WeatherModel.fromJson(Map<String, dynamic> json) =>
      _$WeatherModelFromJson(json);

   Map<String, dynamic> toJson() => _$WeatherModelToJson(this);    

 

  // WeatherModel.fromJson(Map<String, dynamic> json)
  //     : temperature = json['temp_c'] ,
  //       city = json['location'];

}
