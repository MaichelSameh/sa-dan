import 'dart:convert';

import 'package:data/extensions/map_to_list_extension.dart';
import 'package:data/models/notification_info.dart';
import 'package:http/http.dart' as http;

import '../api_constants.dart';
import '../http_config.dart';
import '../logger.dart';

class NotificationServices {
  String _tag(String functionName, String variableName) {
    return "NotificationServices: $functionName $variableName";
  }

  final HttpConfig _httpConfig = HttpConfig.instance();

  Future<List<NotificationInfo>> getAllNotification({
    required String token,
    String? lang,
    int page = 1,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.notification_path,
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.get(
        localLink,
        headers: _httpConfig.getHeader(token: token),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return (resData["payload"] as List<dynamic>).listNotifications();
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("getAllNotification", "error"), errorMessage);
      throw errorMessage;
    }
  }

  Future<NotificationInfo> getSingleNotification({
    required String token,
    required String id,
    String? lang,
    int page = 1,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        "${ApiConstants.notification_path}/$id",
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.get(
        localLink,
        headers: _httpConfig.getHeader(token: token),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return NotificationInfo.fromJson(resData["payload"]);
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("getSingleNotification", "error"), errorMessage);
      throw errorMessage;
    }
  }
}
