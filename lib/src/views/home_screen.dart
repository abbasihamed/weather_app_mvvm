import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_mvvm/src/logic/background_controller.dart';
import 'package:weather_mvvm/src/logic/get_image.dart';
import 'package:weather_mvvm/src/logic/to_celsius.dart';
import 'package:weather_mvvm/src/utils/constans.dart';
import 'package:weather_mvvm/src/view_model/weather_view_model.dart';
import 'package:weather_mvvm/src/views/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isSearchMode = false;
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WeatherViewModel());
    Get.lazyPut(() => BackgroundController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: _isSearchMode
            ? WeatherTextField(
                controller: _controller,
              )
            : Text(
                'Weather',
                style: Theme.of(context).textTheme.subtitle1,
              ),
        leading: _isSearchMode
            ? IconButton(
                onPressed: () {
                  _isSearchMode = false;
                  setState(() {});
                },
                icon: const Icon(Icons.close),
              )
            : null,
        actions: [
          IconButton(
            onPressed: () {
              _isSearchMode = true;
              Get.find<WeatherViewModel>()
                  .searchCityWeather(cityName: _controller.text);
              FocusScope.of(context).unfocus();
              setState(() {});
            },
            icon: const Icon(Icons.search),
          ),
          if (!_isSearchMode)
            IconButton(
              onPressed: () {
                navKey.currentState!.push(
                  MaterialPageRoute(
                    builder: (context) => const SettingScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
            ),
        ],
      ),
      body: GetBuilder<WeatherViewModel>(
        init: WeatherViewModel(),
        builder: (weather) {
          return Stack(
            children: [
              const BackgroundColor(),
              WeatherMainData(weather: weather),
            ],
          );
        },
      ),
    );
  }
}

class WeatherTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  const WeatherTextField({
    Key? key,
    this.controller,
    this.hintText = 'City name',
    this.hintStyle,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<BackgroundController>(
      builder: (color) {
        return SizedBox(
          height: 50,
          child: TextFormField(
            controller: controller,
            onFieldSubmitted: (value) {
              Get.find<WeatherViewModel>().searchCityWeather(cityName: value);
            },
            cursorColor: color.appBarColor,
            showCursor: true,
            style:
                textStyle ?? theme.textTheme.headline1!.copyWith(fontSize: 20),
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle ??
                  theme.textTheme.subtitle1!.copyWith(fontSize: 18),
              contentPadding: const EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: color.appBarColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: color.appBarColor,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BackgroundColor extends StatelessWidget {
  const BackgroundColor({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BackgroundController>(
      init: BackgroundController(),
      builder: (color) {
        return SizedBox.expand(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.25, 0.5, 0.70, 1.0],
                colors: color.colorList,
              ),
            ),
          ),
        );
      },
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
                  '${weather.weatherModel.main!.temp!.unit()} C°',
                  style: theme.textTheme.headline1!.copyWith(fontSize: 30),
                ),
                Column(
                  children: [
                    Text(
                      'max ${weather.weatherModel.main!.tempMax!.unit()} C°',
                      style: theme.textTheme.subtitle1!.copyWith(fontSize: 18),
                    ),
                    Text(
                      'min ${weather.weatherModel.main!.tempMin!.unit()} C°',
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
