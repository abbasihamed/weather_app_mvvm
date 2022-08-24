import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_mvvm/injection.dart';
import 'package:weather_mvvm/src/components/app_textfield.dart';
import 'package:weather_mvvm/src/logic/setting_controller.dart';
import 'package:weather_mvvm/src/utils/constans.dart';
import 'package:weather_mvvm/src/view_model/weather_view_model.dart';
import 'package:weather_mvvm/src/views/home_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _switchValue = false;
  @override
  void initState() {
    super.initState();
    getDefaultCity();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  getDefaultCity() async {
    _controller.text =
        await injection.get<SettingController>().getDefaultCity();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          style: theme.subtitle1,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WeatherTextField(
              controller: _controller,
              textStyle: theme.headline1!.copyWith(
                color: Colors.black,
                fontSize: 24,
              ),
              hintStyle: theme.subtitle1!.copyWith(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: InkWell(
          onTap: () async {
            await injection
                .get<SettingController>()
                .setDefualtCity(cityName: _controller.text);
            Get.find<WeatherViewModel>().getWeather();
            navKey.currentState!.pop();
          },
          child: Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.blue,
            ),
            child: Center(
              child: Text(
                'Save',
                style: theme.headline1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
