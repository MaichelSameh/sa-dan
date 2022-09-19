import 'dart:convert';

import 'package:data/models/profile_info.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

import '../api_constants.dart';
import '../http_config.dart';
import '../logger.dart';

class FcmServices {
  String _tag(String functionName, String variableName) {
    return "FcmServices: $functionName $variableName";
  }

  Future<ProfileInfo?> updateFcm({
    required String token,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      String? fcm = await FirebaseMessaging.instance.getToken();
      if (fcm == null) {
        return null;
      }
      Uri localLink = HttpConfig.instance().getApiLink(
        ApiConstants.profile_fcm_path,
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.patch(
        localLink,
        body: json.encode(<String, dynamic>{
          "user_token": fcm,
        }),
        headers: HttpConfig.instance().getHeader(token: token),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (HttpConfig.instance().validateStatusCode(res.statusCode)) {
        return ProfileInfo.fromJson(resData["payload"]["user"]);
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = HttpConfig.instance().handleError(error);
      log(_tag("getAll", "error"), errorMessage);
      throw errorMessage;
    }
  }

  Future<void> deleteFcm({
    required String token,
    String? lang,
  }) async {
    try {
      Uri localLink = HttpConfig.instance().getApiLink(
        ApiConstants.profile_fcm_path,
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.patch(
        localLink,
        body: json.encode(<String, dynamic>{
          "user_token": null,
        }),
        headers: HttpConfig.instance().getHeader(token: token),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (HttpConfig.instance().validateStatusCode(res.statusCode)) {
        return;
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = HttpConfig.instance().handleError(error);
      log(_tag("getAll", "error"), errorMessage);
      throw errorMessage;
    }
  }
}
