import 'dart:convert';

import 'package:data/extensions/map_to_list_extension.dart';
import 'package:data/models/banner_info.dart';
import 'package:http/http.dart' as http;

import '../api_constants.dart';
import '../http_config.dart';
import '../interfaces/general_interface.dart';
import '../logger.dart';

class BannerServices with GeneralInterface<BannerInfo> {
  String _tag(String functionName, String variableName) {
    return "BannerServices: $functionName $variableName";
  }

  final HttpConfig _httpConfig = HttpConfig.instance();

  String link = ApiConstants.banner_path;

  @override
  Future<List<BannerInfo>> getAll({
    String? lang,
    String? token,
    int page = 1,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        link,
        <String, String>{
          "lang": lang ?? "en",
          "page": page.toString(),
        },
      );
      http.Response res = await http.get(localLink,
          headers: _httpConfig.getHeader(token: token));
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return (resData["payload"] as List<dynamic>).listBanners();
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("getAll", "error"), errorMessage);
      throw errorMessage;
    }
  }

  @override
  Future<BannerInfo?> getById({
    required String id,
    String? token,
    String? lang,
  }) async {
    throw UnimplementedError();
  }
}
