// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';

import 'package:yourtripplaner/Features/models/weather_model.dart';
import 'package:yourtripplaner/app/core/enums.dart';
import 'package:yourtripplaner/repositories/weather_repository.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(const WeatherState());

  final WeatherRepository _weatherRepository;

  Future<void> getWeatherModel({
    required String city,
  }) async {
    emit(const WeatherState(status: Status.loading));
    try {
      final weatherModel = await _weatherRepository.getWeatherModel(city: city);
      emit(
        WeatherState(
          model: weatherModel,
          status: Status.success,
        ),
      );
    } catch (error) {
      emit(WeatherState(status: Status.error, errorMessage: error.toString()));
    }
  }
}
