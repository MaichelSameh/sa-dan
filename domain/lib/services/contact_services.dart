import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart' as url_launcher;

import '../api_constants.dart';
import '../http_config.dart';
import '../logger.dart';
import 'services.dart';

class ContactServices {
  String _tag(String functionName, String variableName) {
    return "ContactServices: $functionName $variableName";
  }

  final HttpConfig _httpConfig = HttpConfig.instance();

  Future<void> contactViaWhatsApp({required String phoneNumber}) async {
    await url_launcher
        .launchUrl(Uri.parse("whatsapp://send?phone=$phoneNumber"));
  }

  Future<void> contactViaMail({required String receiver}) async {
    await url_launcher.launchUrl(Uri.parse("mailto:$receiver"));
  }

  ///this function will list send a contact message
  Future<bool> sendContactMessage({
    required String name,
    required String email,
    required String phone,
    required String message,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.contact_path,
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.post(
        localLink,
        body: json.encode(
          <String, dynamic>{
            "name": name,
            "email": email,
            "phone": phone,
            "message": message,
          },
        ),
        headers: _httpConfig.getHeader(),
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
      log(_tag("sendContactMessage", "error"), errorMessage);
      throw errorMessage;
    }
  }
}
