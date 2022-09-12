import 'dart:convert';

import 'package:data/extensions/map_to_list_extension.dart';
import 'package:data/models/faq_info.dart';
import 'package:http/http.dart' as http;

import '../api_constants.dart';
import '../http_config.dart';
import '../interfaces/general_interface.dart';
import '../logger.dart';

class FaqServices with GeneralInterface<FaqInfo> {
  String _tag(String functionName) {
    return "FaqServices: $functionName";
  }

  final HttpConfig _httpConfig = HttpConfig.instance();

  String link = ApiConstants.faq_path;

  @override
  Future<List<FaqInfo>> getAll({
    String? lang,
    String? token,
    int page = 1,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri getAllCities = _httpConfig.getApiLink(
        link,
        <String, String>{"lang": lang ?? "en", "page": page.toString()},
      );
      http.Response res = await http.get(getAllCities,
          headers: _httpConfig.getHeader(token: token));
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return (resData["payload"] as List<dynamic>).listFaqs();
      } else {
        throw _httpConfig.handleError(resData["messages"]);
      }
    } catch (error) {
      log(_tag("getAll"), error);
      rethrow;
    }
  }

  @override
  Future<FaqInfo?> getById({
    required String id,
    String? token,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri getAllCities = _httpConfig.getApiLink(
        link,
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.get(getAllCities,
          headers: _httpConfig.getHeader(token: token));
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return FaqInfo.fromJson(resData["payload"]);
      } else {
        throw _httpConfig.handleError(resData["messages"]);
      }
    } catch (error) {
      log(_tag("getAll"), error);
      rethrow;
    }
  }
}
