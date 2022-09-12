import 'package:data/models/local_token_info.dart';
import 'package:data/models/location_info.dart';
import 'package:domain/services/auth_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  LocalTokenInfo? _localTokenInfo;

  bool _logged = false;

  LocationInfo? _currentLocation;

  void setToken(LocalTokenInfo? token) {
    _localTokenInfo = token;
    update();
  }

  bool get logged => _logged;

  LocalTokenInfo? get token => _localTokenInfo;

  ///The users current position, can be null if the user denied the location permission
  LocationInfo? get currentLocation => _currentLocation;

  void logIn() {
    _logged = true;
    SharedPreferences.getInstance()
        .then((SharedPreferences pref) => pref.setBool("logged", _logged));
  }

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      Position location = await Geolocator.getCurrentPosition();
      _currentLocation = LocationInfo(
        latitude: location.latitude,
        longitude: location.longitude,
      );
      update();
    } else if (permission == LocationPermission.deniedForever) {
      return;
    } else {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        Position location = await Geolocator.getCurrentPosition();
        _currentLocation = LocationInfo(
          latitude: location.latitude,
          longitude: location.longitude,
        );
        update();
      }
    }
  }

  Future<void> init() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _logged = pref.getBool("logged") == true;
    LocalTokenInfo? token = await AuthServices().autoLogin();
    await getCurrentLocation();
    if (token != null) {
      setToken(token);
    }
  }
}
