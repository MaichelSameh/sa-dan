import 'dart:convert';

import 'package:data/enums.dart';
import 'package:data/extensions/map_to_list_extension.dart';
import 'package:data/models/order_info.dart';
import 'package:http/http.dart' as http;

import '../api_constants.dart';
import '../http_config.dart';
import '../logger.dart';

class OrderServices {
  String _tag(String functionName, String variableName) {
    return "OrderServices: $functionName $variableName";
  }

  final HttpConfig _httpConfig = HttpConfig.instance();

  ///this function will fetch all the orders with the given status
  Future<List<OrderInfo>> getAll({
    required OrderStatus status,
    String? lang,
    String? token,
    int page = 1,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        status == OrderStatus.orderIsDelivered
            ? ApiConstants.delivered_orders_path
            : ApiConstants.active_orders_path,
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

  ///this function will create a new order with the given information
  Future<OrderInfo> makeOrder({
    required String token,
    required String addressId,
    required String classificationId,
    required String productId,
    required int quantity,
    required PaymentMethod paymentMethod,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.make_order_path,
        <String, String>{
          "lang": lang ?? "en",
        },
      );
      http.Response res = await http.post(
        localLink,
        headers: _httpConfig.getHeader(token: token),
        body: json.encode(
          <String, dynamic>{
            "address_id": addressId,
            "product_id": productId,
            "classification_id": classificationId,
            "quantity": quantity,
            "payment_method": paymentMethod.name,
          },
        ),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return OrderInfo.fromJson(resData["payload"]);
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("makeOrder", "error"), errorMessage);
      throw errorMessage;
    }
  }

  ///this function will mark the given order as paid
  Future<bool> markOrderAsPaid({
    required String token,
    required String orderId,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        "${ApiConstants.mark_order_as_paid_path}/$orderId/mark-as-paid",
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

  ///this function will mark the given order as cancelled
  Future<bool> markOrderAsCancelled({
    required String token,
    required String orderId,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        "${ApiConstants.cancel_order_path}/$orderId",
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
      log(_tag("markOrderAsCancelled", "error"), errorMessage);
      throw errorMessage;
    }
  }
}
