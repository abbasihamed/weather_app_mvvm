import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_mvvm/src/logic/background_controller.dart';
import 'package:weather_mvvm/src/view_model/weather_view_model.dart';

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