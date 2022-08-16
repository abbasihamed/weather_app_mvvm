import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_mvvm/src/logic/get_image.dart';
import 'package:weather_mvvm/src/logic/to_celsius.dart';
import 'package:weather_mvvm/src/view_model/weather_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WeatherViewModel());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[800],
      ),
      body: GetBuilder<WeatherViewModel>(
        init: WeatherViewModel(),
        builder: (weather) {
          return Stack(
            children: [
              SizedBox.expand(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.25, 0.5, 0.70, 1.0],
                      colors: [
                        Colors.yellow[800]!,
                        Colors.yellow[700]!,
                        Colors.yellow[500]!,
                        Colors.yellow[400]!,
                      ],
                    ),
                  ),
                ),
              ),
              WeatherMainData(weather: weather),
            ],
          );
        },
      ),
    );
  }
}

class WeatherLoading extends StatelessWidget {
  const WeatherLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CupertinoActivityIndicator(
        radius: 35,
      ),
    );
  }
}

class WeatherMainData extends StatelessWidget {
  final WeatherViewModel weather;
  const WeatherMainData({Key? key, required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (weather.loading) {
      return const WeatherLoading();
    }
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            Text(
              weather.weatherModel.name ?? 'Unkown',
              style: theme.textTheme.headline1,
            ),
            Text(
              'Update 11:30 P.M',
              style: theme.textTheme.subtitle1,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset(weather.weatherModel.weather![0].main!.toImage()),
                Text(
                  '${weather.weatherModel.main!.temp!.toCelsius()} C°',
                  style: theme.textTheme.headline1!.copyWith(fontSize: 30),
                ),
                Column(
                  children: [
                    Text(
                      'max ${weather.weatherModel.main!.tempMax!.toCelsius()} C°',
                      style: theme.textTheme.subtitle1!.copyWith(fontSize: 18),
                    ),
                    Text(
                      'min ${weather.weatherModel.main!.tempMin!.toCelsius()} C°',
                      style: theme.textTheme.subtitle1!.copyWith(fontSize: 18),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 40),
            Text(
              weather.weatherModel.weather![0].description ?? 'Unkown',
              style: theme.textTheme.subtitle1!.copyWith(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
