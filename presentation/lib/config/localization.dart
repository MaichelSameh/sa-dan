import 'dart:convert';

import 'package:data/models/language_info.dart';
import 'package:domain/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Localization extends Translations {
  static const String _tag = "Localization";

  @override
  Map<String, Map<String, String>> get keys => lang;

  final Map<String, Map<String, String>> lang;

  List<Locale> get supportedLocales => supportedLanguages
      .map<Locale>((LanguageInfo language) => language.getLocale())
      .toList();

  Localization._(this.lang);

  static Future<void> initialize() async {
    if (_instance == null) {
      await Localization._restoreLocale();
      Map<String, Map<String, String>> lang = await _loadLanguages();
      _instance = Localization._(lang);
    }
  }

  static Localization getInstance() {
    if (_instance == null) {
      throw "you need to call initialize in the main first";
    }
    return _instance!;
  }

  static Localization? _instance;

  final List<LanguageInfo> _supportedLanguages = <LanguageInfo>[
    LanguageInfo(
      languageCode: "ar",
      languageFlag: "🇸🇦",
      languageTitle: "arabic",
      languageCountryCode: "EG",
    ),
    LanguageInfo(
      languageCode: "en",
      languageFlag: "🇺🇸",
      languageTitle: "english",
      languageCountryCode: "US",
    ),
  ];

  List<LanguageInfo> get supportedLanguages => _supportedLanguages;

  Future<void> setLocale(Locale locale) async {
    await _saveLocale(locale);
    await Get.updateLocale(locale);
  }

  Future<void> _saveLocale(Locale locale) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString("locale", json.encode(locale.toMap()));
      _restoreLocale();
    } catch (error) {
      log(_tag, error);
    }
  }

  static Future<void> _restoreLocale() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? encodedLocale = pref.getString("locale");
      if (encodedLocale != null) {
        Map<String, dynamic> localeData = json.decode(encodedLocale);
        await Get.updateLocale(
          Locale(
            localeData["language_code"],
            localeData["country_code"],
          ),
        );
      }
    } catch (error) {
      log(_tag, error);
    }
  }

  static Future<Map<String, Map<String, String>>> _loadLanguages() async {
    try {
      String arEG = await rootBundle.loadString("assets/lang/ar_eg.json");
      String enUS = await rootBundle.loadString("assets/lang/en_us.json");
      Map<String, dynamic> arTemp = json.decode(arEG);
      Map<String, dynamic> enTemp = json.decode(enUS);
      Map<String, String> arEgMap = <String, String>{};
      Map<String, String> enUsMap = <String, String>{};
      arTemp.forEach((String key, dynamic value) {
        arEgMap.putIfAbsent(key, () => value.toString());
      });
      enTemp.forEach((String key, dynamic value) {
        enUsMap.putIfAbsent(key, () => value.toString());
      });
      return <String, Map<String, String>>{
        "ar_Sa": arEgMap,
        "en_US": enUsMap,
      };
    } catch (error) {
      log(_tag, error);
      return <String, Map<String, String>>{};
    }
  }
}

extension _GetToMap on Locale {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "language_code": languageCode,
      "country_code": countryCode,
    };
  }
}
