import 'package:flutter/cupertino.dart';

class LanguageInfo {
  late String _languageCode;
  late String _languageFlag;
  late String _languageTitle;
  late String _languageCountryCode;

  LanguageInfo({
    required String languageCode,
    required String languageFlag,
    required String languageTitle,
    required String languageCountryCode,
  }) {
    _languageCode = languageCode;
    _languageCountryCode = languageCountryCode;
    _languageFlag = languageFlag;
    _languageTitle = languageTitle;
  }

  Locale getLocale() {
    return Locale(_languageCode, _languageCountryCode);
  }

  ///the language code
  String get languageCode => _languageCode;

  ///the language's country's code
  String get languageCountryCode => _languageCountryCode;

  ///the language's country's flag
  String get languageFlag => _languageFlag;

  ///the language name
  String get languageTitle => _languageTitle;
}
