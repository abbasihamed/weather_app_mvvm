import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_mvvm/injection.dart';
import 'package:weather_mvvm/src/data/api_state.dart';
import 'package:weather_mvvm/src/data/weather_api.dart';
import 'package:weather_mvvm/src/logic/background_controller.dart';
import 'package:weather_mvvm/src/logic/location_manager.dart';
import 'package:weather_mvvm/src/logic/validation.dart';
import 'package:weather_mvvm/src/models/error_models.dart';
import 'package:weather_mvvm/src/models/weather_models.dart';
import 'package:weather_mvvm/src/utils/constans.dart';

class WeatherViewModel extends GetxController {
  final loc = injection.get<LocationManager>();
  late WeatherModel _weatherModel;
  ErrorServices? _errorServices;
  bool _loading = true;

  bool get loading => _loading;
  WeatherModel get weatherModel => _weatherModel;
  ErrorServices? get errorServices => _errorServices;

  setLoading(bool loading) {
    _loading = loading;
    update();
  }

  setWeatherData(WeatherModel weatherData) {
    _weatherModel = weatherData;
    update();
  }

  setErrorServices(ErrorServices error) {
    _errorServices = error;
    update();
  }

  getCurrentWeather() async {
    setLoading(true);
    final permission = await loc.getPermission();
    if (permission) {
      final location = await loc.getLocation();
      var response = await injection.get<WeatherServices>().getCurrentWeather(
          location!.latitude.toString(), location.longitude.toString());
      if (response is Success) {
        setWeatherData(response.successResponse!);
        Get.find<BackgroundController>()
            .weatherConditions(response.successResponse!.weather![0].main!);
      }
      if (response is Failure) {
        ErrorServices errorServices = ErrorServices(
            code: response.code, errorMessage: response.failureResponse);
        setErrorServices(errorServices);
      }
    } else {
      ErrorServices errorServices = ErrorServices(
          code: 400, errorMessage: "Don't have access to location");
      setErrorServices(errorServices);
    }
    setLoading(false);
  }

  searchCityWeather({required String cityName}) async {
    if (CustomValidation.emptyValidation(value: cityName)) {
      setLoading(true);
      var response =
          await injection.get<WeatherServices>().getWeather(cityName: cityName);
      if (response is Success) {
        setWeatherData(response.successResponse!);
        Get.find<BackgroundController>()
            .weatherConditions(response.successResponse!.weather![0].main!);
      }
      if (response is Failure) {
        ErrorServices errorServices = ErrorServices(
            code: response.code, errorMessage: response.failureResponse);
        setErrorServices(errorServices);
      }
      setLoading(false);
    } else {
      showSnackBar();
    }
  }

  showSnackBar() {
    scaffoldKey.currentState!.showSnackBar(
      SnackBar(
        content: Text(
          'City name can not be empty',
          style: Theme.of(navKey.currentContext!).textTheme.subtitle1,
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
    getCurrentWeather();
  }
}
