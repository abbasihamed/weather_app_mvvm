import 'package:location/location.dart';

class LocationManager {
  Location location = Location();
  LocationData? _locationData;

  getPermission() async {
    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  getLocation() async {
    _locationData = await location.getLocation();
    return _locationData;
  }
}
