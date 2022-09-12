import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_constants.dart';
import '../http_config.dart';
import '../logger.dart';

class NotificationChannelServices {
  String _tag(String functionName, String variableName) {
    return "NotificationChannelServices: $variableName $functionName";
  }

  final HttpConfig _httpConfig = HttpConfig.instance();

  Future<bool> sendNotificationViaEmail({
    required String email,
    required String title,
    required String message,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.email_notification_channel,
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.post(
        localLink,
        body: json.encode(
          <String, dynamic>{
            "email": email,
            "title": title,
            "message": message,
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
      log(_tag("sendNotificationViaEmail", "error"), errorMessage);
      throw errorMessage;
    }
  }

  Future<bool> sendNotificationViaPhone({
    required String phone,
    required String title,
    required String message,
    String? lang,
  }) async {
    throw UnimplementedError();
  }
}
