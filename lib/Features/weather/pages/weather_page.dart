import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourtripplaner/Features/models/weather_model.dart';
import 'package:yourtripplaner/Features/weather/cubit/weather_cubit.dart';
import 'package:yourtripplaner/app/core/enums.dart';
import 'package:yourtripplaner/data/remote_data_sources/weather_remote_data_source.dart';
import 'package:yourtripplaner/repositories/weather_repository.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => WeatherCubit(
              WeatherRepository(WeatherRemoteDataSource()),
            ),
        child: BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
          if (state.status == Status.error) {
            final errorMessage = state.errorMessage ?? 'Unkown error';
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ));
          }
        }, builder: (context, state) {
          final weatherModel = state.model;
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: const Text(''),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Center(
              child: Builder(builder: (context) {
                if (state.status == Status.loading) {
                  return const Text('Loading');
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (weatherModel != null)
                      _DisplayWeatherWidget(
                        weatherModel: weatherModel,
                      ),
                    _SearchWidget(),
                  ],
                );
              }),
            ),
          );
        }));
  }
}

class _SearchWidget extends StatelessWidget {
  _SearchWidget({
    Key? key,
  }) : super(key: key);

  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                
              ),
              label: Text('City'),
              fillColor: Colors.blue,
              hintText: 'London',
            ),
          )),
          const SizedBox(width: 20),
          ElevatedButton(
            
            onPressed: () {
              context
                  .read<WeatherCubit>()
                  .getWeatherModel(city: _controller.text);
            },
            
            child: const Text('Get'),
            
          ),

        ],
      ),
    );
  }
}

class _DisplayWeatherWidget extends StatelessWidget {
  const _DisplayWeatherWidget({
    Key? key,
    required this.weatherModel,
  }) : super(key: key);

  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              weatherModel.temperature.toString(),
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 60),
            Text(
              weatherModel.city,
              style: Theme.of(context).textTheme.headline2,
            ),
            const SizedBox(height: 60),
          ],
        );
      },
    );
  }
}
