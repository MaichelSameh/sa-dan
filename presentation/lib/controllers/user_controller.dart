import 'package:data/models/local_token_info.dart';
import 'package:domain/services/auth_services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends GetxController {
  LocalTokenInfo? _localTokenInfo;

  bool _logged = false;

  void setToken(LocalTokenInfo? token) {
    _localTokenInfo = token;
    update();
  }

  bool get logged => _logged;

  LocalTokenInfo? get token => _localTokenInfo;

  void logIn() {
    _logged = true;
    SharedPreferences.getInstance()
        .then((SharedPreferences pref) => pref.setBool("logged", _logged));
  }

  Future<void> init() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _logged = pref.getBool("logged") == true;
    LocalTokenInfo? token = await AuthServices().autoLogin();
    if (token != null) {
      setToken(token);
    }
  }
}
