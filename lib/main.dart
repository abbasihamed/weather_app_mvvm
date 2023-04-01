import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:weather_mvvm/injection.dart';
import 'package:weather_mvvm/src/utils/app_theme.dart';
import 'package:weather_mvvm/src/utils/constans.dart';
import 'package:weather_mvvm/src/views/home_screen.dart';

import 'src/view_model/weather_view_model.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  setPathUrlStrategy();
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => WeatherViewModel());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navKey,
      scaffoldMessengerKey: scaffoldKey,
      title: 'Weather',
      theme: AppTheme.appTheme,
      home: const HomeScreen(),
    );
  }
}
