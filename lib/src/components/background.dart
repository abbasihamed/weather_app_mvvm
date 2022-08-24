import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_mvvm/src/logic/background_controller.dart';

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