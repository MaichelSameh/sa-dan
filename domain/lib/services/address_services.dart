import 'dart:convert';

import 'package:data/extensions/map_to_list_extension.dart';
import 'package:data/extensions/to_map_extension.dart';
import 'package:data/models/address_info.dart';
import 'package:http/http.dart' as http;

import '../api_constants.dart';
import '../http_config.dart';
import '../interfaces/interfaces.dart';
import '../logger.dart';

class AddressServices
    with GeneralInterface<AddressInfo>, EditableGeneralInterface<AddressInfo> {
  String _tag(String functionName, String variableName) {
    return "AddressServices: $functionName $variableName";
  }

  final HttpConfig _httpConfig = HttpConfig.instance();

  String link = ApiConstants.address_path;

  @override
  Future<List<AddressInfo>> getAll({
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
        return (resData["payload"] as List<dynamic>).listAddresses();
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
  Future<AddressInfo?> getById({
    required String id,
    String? token,
    String? lang,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<AddressInfo> addNew({
    required AddressInfo item,
    required String token,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        link,
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.post(
        localLink,
        body: json.encode(item.toMap()),
        headers: _httpConfig.getHeader(token: token),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return AddressInfo.fromJson(resData["payload"]);
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("addNew", "error"), errorMessage);
      throw errorMessage;
    }
  }

  @override
  Future<bool> deleteItem({
    required String id,
    required String token,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        "$link/destroy/$id",
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.delete(
        localLink,
        headers: _httpConfig.getHeader(token: token),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return true;
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("deleteItem", "error"), errorMessage);
      throw errorMessage;
    }
  }

  @override
  Future<AddressInfo> updateItem({
    required AddressInfo item,
    required String token,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        "$link/update",
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.patch(
        localLink,
        body: json.encode(
          <String, dynamic>{
            "address_id": item.id,
            ...item.toMap(),
          },
        ),
        headers: _httpConfig.getHeader(token: token),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return AddressInfo.fromJson(resData["payload"]);
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("updateItem", "error"), errorMessage);
      throw errorMessage;
    }
  }
}
