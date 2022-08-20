import 'package:shared_preferences/shared_preferences.dart';

class SettingController {
  setDefualtCity({required String cityName}) async {
    final pref = await SharedPreferences.getInstance();
    if (cityName.isNotEmpty) {
      await pref.setString('city', cityName);
    }
  }

  getDefaultCity() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('city');
  }
}
