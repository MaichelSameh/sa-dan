import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../api_constants.dart';
import '../http_config.dart';
import '../logger.dart';
import 'notification_channel_services.dart';
import 'token_services.dart';

class ResetPasswordServices {
  String _tag(String functionName, String variableName) {
    return "ResetPasswordServices: $functionName $variableName";
  }

  final HttpConfig _httpConfig = HttpConfig.instance();

  Future<bool> updatePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
    required String token,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(ApiConstants.update_password_path,
          <String, String>{"lang": lang ?? "en"});
      http.Response res = await http.patch(
        localLink,
        body: json.encode(
          <String, dynamic>{
            "old_password": oldPassword,
            "password": newPassword,
            "password_confirmation": confirmPassword,
          },
        ),
        headers: _httpConfig.getHeader(token: token),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return true;
      } else {
        if (res.statusCode == 401) {
          await TokenServices().discardAuthData();
        }
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("updatePassword", "error"), errorMessage);
      throw errorMessage;
    }
  }

  Future<bool> resetPasswordByEmail({
    required String email,
    required String confirmPassword,
    required String password,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(ApiConstants.reset_password_path,
          <String, String>{"lang": lang ?? "en"});
      http.Response res = await http.patch(
        localLink,
        body: json.encode(
          <String, dynamic>{
            "email": email,
            "password": password,
            "password_confirmation": confirmPassword,
          },
        ),
        headers: _httpConfig.getHeader(),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return true;
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("resetPasswordByEmail", "error"), errorMessage);
      throw errorMessage;
    }
  }

  Future<bool> sendEmailVerificationCode({
    required String email,
    required String verificationCode,
    String? lang,
  }) =>
      NotificationChannelServices().sendNotificationViaEmail(
        email: email,
        title: "verification-code".tr,
        message: verificationCode,
        lang: lang,
      );

  Future<bool> sendPhoneVerificationCode({
    required String phoneNumber,
    required String verificationCode,
    String? lang,
  }) =>
      NotificationChannelServices().sendNotificationViaPhone(
        phone: phoneNumber,
        title: "verification_code".tr,
        message: verificationCode,
        lang: lang,
      );

  String generateRandomNumbersString([int digitsCount = 4]) {
    String result = "";
    Random rand = Random();
    for (int i = 0; i < digitsCount; i++) {
      result += (rand.nextInt(1000) % 10).toString();
    }
    return result;
  }
}
