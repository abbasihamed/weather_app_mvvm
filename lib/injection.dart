import 'package:get_it/get_it.dart';
import 'package:weather_mvvm/src/data/weather_api.dart';

var injection = GetIt.I;

void setup() {
  injection.registerLazySingleton(() => WeatherServices());
}
