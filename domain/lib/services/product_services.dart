import 'dart:convert';

import 'package:data/enums.dart';
import 'package:data/extensions/map_to_list_extension.dart';
import 'package:data/models/filter_info.dart';
import 'package:data/models/product_info.dart';
import 'package:data/models/review_info.dart';
import 'package:http/http.dart' as http;

import '../api_constants.dart';
import '../http_config.dart';
import '../interfaces/interfaces.dart';
import '../logger.dart';

class ProductServices
    with
        GeneralInterface<ProductInfo>,
        ReviewInterface,
        FavoriteInterface<ProductInfo> {
  String _tag(String functionName, String variableName) {
    return "ProductServices: $functionName $variableName";
  }

  final HttpConfig _httpConfig = HttpConfig.instance();

  final String link = ApiConstants.category_path;

  @override
  Future<List<ProductInfo>> getAll({
    String? token,
    String? lang,
    int page = 1,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.category_path,
        <String, String>{"lang": lang ?? "en"},
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
      log(_tag("getAll", "error"), errorMessage);
      throw errorMessage;
    }
  }

  @override
  Future<ProductInfo> getById({
    required String id,
    String? token,
    String? lang,
    int page = 1,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        "$link/$id",
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.get(
        localLink,
        headers: _httpConfig.getHeader(token: token),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return ProductInfo.fromJson(resData["payload"]);
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("getById", "error"), errorMessage);
      throw errorMessage;
    }
  }

  @override
  Future<bool> favorite({
    required String id,
    required String token,
    String? lang,
    String? currency,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        "$link/$id/mark-as-favorite",
        <String, String>{
          "lang": lang ?? "en",
          "currency": currency?.toLowerCase() ?? "aed",
        },
      );
      http.Response res = await http.post(
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
      log(_tag("favorite", "error"), errorMessage);
      throw errorMessage;
    }
  }

  @override
  Future<List<ReviewInfo>> getReviews({
    required String token,
    required String id,
    int? page,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink("$link/$id/reviews");
      http.Response res = await http.get(
        localLink,
        headers: _httpConfig.getHeader(token: token),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return (resData["payload"] as List<dynamic>).listReviews();
      } else if (res.statusCode == 404) {
        return <ReviewInfo>[];
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("getReviews", "error"), errorMessage);
      throw errorMessage;
    }
  }

  @override
  Future<List<ProductInfo>> listAllFavorites({
    required String token,
    int? page,
    String? lang,
    String? currency,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.favorites_path,
        <String, String>{
          "lang": lang ?? "en",
          "page": page.toString(),
          "currency": currency?.toLowerCase() ?? "aed",
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
      log(_tag("listAllFavorites", "error"), errorMessage);
      throw errorMessage;
    }
  }

  @override
  Future<bool> submitReview({
    required String token,
    required String id,
    required String review,
    required double rate,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink("$link/$id/submit-review");
      http.Response res = await http.post(
        localLink,
        headers: _httpConfig.getHeader(token: token),
        body: json.encode(
          <String, dynamic>{
            "review": review,
            "rate": rate,
          },
        ),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return true;
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("submitReview", "error"), errorMessage);
      throw errorMessage;
    }
  }

  @override
  Future<bool> unfavorite({
    required String id,
    required String token,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        "$link/$id/mark-as-un-favorite",
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
      log(_tag("unfavorite", "error"), errorMessage);
      throw errorMessage;
    }
  }

  ///this function will fetch the top rated products
  Future<List<ProductInfo>> getTopRated({
    required String id,
    String? token,
    int? page,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.top_rated_product_path,
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
      log(_tag("getTopRated", "error"), errorMessage);
      throw errorMessage;
    }
  }

  ///this function will fetch the top rated selling
  Future<List<ProductInfo>> getTopSelling({
    required String id,
    String? token,
    int? page,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.top_rated_product_path,
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
      log(_tag("getTopSelling", "error"), errorMessage);
      throw errorMessage;
    }
  }

  ///this function will search in all products to get you the desired products
  ///you can use any of them or all of them as the client require.
  ///don't worry you can't mess it up if you kept it like this
  Future<List<ProductInfo>> searchProducts({
    String? token,
    String? lang,
    int? page,
    FilterInfo? filters,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.search_products_path,
        <String, String>{
          "lang": lang ?? "en",
          "page": page.toString(),
          if (filters?.categorizationId != null)
            "categorization": filters!.categorizationId.toString(),
          if (filters?.storeId != null) "store": filters!.storeId.toString(),
          if (filters?.sorting == ProductSorting.mostPopular)
            "most_popular": true.toString(),
          if (filters?.sorting == ProductSorting.mostRecent)
            "most_recently": true.toString(),
          if (filters?.keyword != null) "search_with_key": filters!.keyword!,
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
      log(_tag("searchProducts", "error"), errorMessage);
      throw errorMessage;
    }
  }
}
