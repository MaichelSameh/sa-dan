import 'about_info.dart';
import 'basic_info.dart';
import 'social_info.dart';

class GeneralInfo {
  late AboutInfo _about;
  late BasicInfo _basic;
  late SocialInfo _social;
  late List<String> _currencies;

  GeneralInfo({
    required AboutInfo about,
    required BasicInfo basic,
    required SocialInfo social,
    required List<String> currencies,
  }) {
    _about = about;
    _basic = basic;
    _social = social;
    _currencies = currencies;
  }

  GeneralInfo.fromJson(Map<String, dynamic> data) {
    _about = AboutInfo.fromJson(data["about"]);
    _basic = BasicInfo.fromJson(data["basic"]);
    _social = SocialInfo.fromJson(data["social"]);
    _currencies = <String>[];
    for (dynamic item in (data["available_currencies"] ?? <dynamic>[])) {
      currencies.add(item.toString());
    }
  }

  ///the about us information
  AboutInfo get about => _about;

  ///the basic information about the company
  BasicInfo get basic => _basic;

  ///the social network links of the company
  SocialInfo get social => _social;

  ///the available currencies for the app
  List<String> get currencies => _currencies;

  @override
  String toString() {
    return 'GeneralInfo(_about: $_about, _basic: $_basic, _social: $_social, _currencies: $_currencies)';
  }
}
