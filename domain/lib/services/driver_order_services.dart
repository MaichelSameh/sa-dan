import 'dart:convert';

import 'package:data/extensions/map_to_list_extension.dart';
import 'package:data/models/order_info.dart';
import 'package:http/http.dart' as http;

import '../api_constants.dart';
import '../http_config.dart';
import '../logger.dart';

class DriverOrderServices {
  String _tag(String functionName, String variableName) {
    return "DriverOrderServices: $functionName $variableName";
  }

  final HttpConfig _httpConfig = HttpConfig.instance();

  ///this function will fetch all the orders that the driver can take
  Future<List<OrderInfo>> getAll({
    String? lang,
    String? token,
    int page = 1,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.driver_running_orders,
        <String, String>{
          "lang": lang ?? "en",
          "page": page.toString(),
        },
      );
      http.Response res = await http.get(
        localLink,
        headers: _httpConfig.getHeader(token: token),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return (resData["payload"] as List<dynamic>).listOrders();
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("getAll", "error"), errorMessage);
      throw errorMessage;
    }
  }

  ///this function will mark the given order as paid
  Future<bool> acceptOrder({
    required String token,
    required String orderId,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        "${ApiConstants.order_path}/$orderId/accept-order-request",
        <String, String>{
          "lang": lang ?? "en",
        },
      );
      http.Response res = await http.patch(
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
      log(_tag("markOrderAsPaid", "error"), errorMessage);
      throw errorMessage;
    }
  }
}
