import 'dart:convert';

import 'package:http/http.dart' as http;

import '../api_constants.dart';
import '../http_config.dart';
import '../logger.dart';

class AvailabilityServices {
  String _tag(String functionName, String variableName) {
    return "AvailabilityServices: $functionName $variableName";
  }

  final HttpConfig _httpConfig = HttpConfig.instance();

  Future<bool> checkPhoneAvailability({
    required String phone,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri link = _httpConfig.getApiLink(
        ApiConstants.check_phone_availability,
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.post(
        link,
        headers: _httpConfig.getHeader(),
        body: json.encode(<String, String>{
          "phone": phone,
        }),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return true;
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("checkPhoneAvailability", "error"), errorMessage);
      throw errorMessage;
    }
  }

  ///returns true of the email os used/registered
  Future<bool> checkEmailAvailability({
    required String email,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri link = _httpConfig.getApiLink(
        ApiConstants.check_email_availability,
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.post(
        link,
        headers: _httpConfig.getHeader(),
        body: json.encode(<String, String>{
          "email": email,
        }),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return true;
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("checkEmailAvailability", "error"), errorMessage);
      throw errorMessage;
    }
  }
}
