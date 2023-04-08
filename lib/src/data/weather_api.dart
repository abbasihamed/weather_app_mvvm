import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weather_mvvm/src/data/api_state.dart';
import 'package:weather_mvvm/src/data/http_managment.dart';
import 'package:weather_mvvm/src/models/weather_models.dart';
import 'package:weather_mvvm/src/utils/constans.dart';

class WeatherServices {
  Future getCurrentWeather(String lat, String long) async {
    var response = await HttpManager.requestManager(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey');
    if (response is http.Response) {
      return Success(
          code: 200, successResponse: weatherModelFromJson(response.body));
    }
    if (response is Failure) {
      return response;
    }
  }

  Future getWeather({required String cityName}) async {
    var response = await HttpManager.requestManager(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey');
    if (response is http.Response) {
      return Success(
          code: 200, successResponse: weatherModelFromJson(response.body));
    }
    if (response is Failure) {
      return response;
    }
  }
}
