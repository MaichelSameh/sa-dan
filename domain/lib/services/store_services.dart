import 'dart:convert';

import 'package:data/extensions/map_to_list_extension.dart';
import 'package:data/models/product_info.dart';
import 'package:data/models/store_info.dart';
import 'package:http/http.dart' as http;

import '../api_constants.dart';
import '../http_config.dart';
import '../interfaces/general_interface.dart';
import '../logger.dart';

class StoreServices with GeneralInterface<StoreInfo> {
  String _tag(String functionName, String variableName) {
    return "StoreServices: $functionName $variableName";
  }

  final HttpConfig _httpConfig = HttpConfig.instance();

  @override
  Future<List<StoreInfo>> getAll({
    String? token,
    String? lang,
    int page = 1,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.store_path,
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.get(
        localLink,
        headers: _httpConfig.getHeader(token: token),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return (resData["payload"] as List<dynamic>).listStores();
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
  Future<StoreInfo> getById({
    required String id,
    String? token,
    String? lang,
    int page = 1,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        "${ApiConstants.store_path}/$id",
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.get(
        localLink,
        headers: _httpConfig.getHeader(token: token),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return StoreInfo.fromJson(resData["payload"]);
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("getById", "error"), errorMessage);
      throw errorMessage;
    }
  }

  ///this function will get all the products that are part of the store's id
  Future<List<ProductInfo>> getStoreProducts({
    required String id,
    String? token,
    int? page,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        "${ApiConstants.store_path}/$id/products",
        <String, String>{
          "lang": lang ?? "en",
          "page": (page ?? 1).toString(),
        },
      );
      http.Response res = await http.get(
        localLink,
        headers: _httpConfig.getHeader(token: token),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return (resData["payload"] as List<dynamic>).listProducts();
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("getStoreProducts", "error"), errorMessage);
      throw errorMessage;
    }
  }
}
