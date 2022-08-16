import 'package:weather_mvvm/src/models/weather_models.dart';

class Success {
  int? code;
  WeatherModel? successResponse;

  Success({this.code, this.successResponse});
}

class Failure {
  int? code;
  String? failureResponse;

  Failure({this.code, this.failureResponse});
}
