import 'package:get_it/get_it.dart';
import 'package:weather_mvvm/src/data/weather_api.dart';
import 'package:weather_mvvm/src/logic/location_manager.dart';

var injection = GetIt.I;

void setup() {
  injection.registerLazySingleton(() => WeatherServices());
  injection.registerSingleton(LocationManager());
}
