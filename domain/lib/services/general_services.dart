import 'dart:convert';

import 'package:data/models/general/general_info.dart';
import 'package:http/http.dart' as http;

import '../api_constants.dart';
import '../http_config.dart';
import '../logger.dart';
import 'token_services.dart';

class GeneralServices {
  String _tag(String functionName, String variableName) {
    return "GeneralServices: $variableName $functionName";
  }

  final HttpConfig _httpConfig = HttpConfig.instance();

  ///this function will list the general data
  Future<GeneralInfo> getGeneralData({
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.general_path,
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.get(
        localLink,
        headers: _httpConfig.getHeader(),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return GeneralInfo.fromJson(resData["payload"]);
      } else {
        if (res.statusCode == 401) {
          await TokenServices().discardAuthData();
        }
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("getGeneralData", "error"), errorMessage);
      throw errorMessage;
    }
  }
}
