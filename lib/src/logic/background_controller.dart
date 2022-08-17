import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackgroundController extends GetxController {
  List<Color> _colorList = [
    Colors.blue[800]!,
    Colors.blue[700]!,
    Colors.blue[500]!,
    Colors.blue[400]!
  ];
  Color _appBarColor = Colors.blue;

  List<Color> get colorList => _colorList;
  Color get appBarColor => _appBarColor;

  weatherConditions(String condition) {
    switch (condition) {
      case 'Clear':
        _colorList = [
          Colors.yellow[800]!,
          Colors.yellow[700]!,
          Colors.yellow[500]!,
          Colors.yellow[400]!
        ];
        _appBarColor = Colors.yellow[800]!;
        break;
      case 'Clouds':
        _colorList = [
          Colors.indigo[700]!,
          Colors.indigo[600]!,
          Colors.indigo[500]!,
          Colors.indigo[400]!
        ];
        _appBarColor = Colors.indigo[700]!;
        break;
      case 'Snow':
        _colorList = [
          Colors.blue[600]!,
          Colors.blue[500]!,
          Colors.blue[400]!,
          Colors.blue[300]!
        ];
        _appBarColor = Colors.blue[600]!;
        break;
      case 'Rain':
        _colorList = [
          Colors.indigo[900]!,
          Colors.indigo[700]!,
          Colors.indigo[600]!,
          Colors.indigo[500]!
        ];
        _appBarColor = Colors.indigo[900]!;
        break;
      case 'Drizzle':
        _colorList = [
          Colors.indigo[900]!,
          Colors.indigo[700]!,
          Colors.indigo[600]!,
          Colors.indigo[500]!
        ];
        _appBarColor = Colors.indigo[900]!;
        break;
      case 'Thunderstorm':
        _colorList = [
          Colors.purple[900]!,
          Colors.purple[800]!,
          Colors.purple[700]!,
          Colors.purple[600]!
        ];
        _appBarColor = Colors.purple[900]!;
        break;
      default:
    }
    update();
  }
}
