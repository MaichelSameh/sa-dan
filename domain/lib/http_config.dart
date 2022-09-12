import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'api_constants.dart';
import 'logger.dart';

enum FlavorEnvironment { development, production }

class HttpConfig {
  static String _baseUrl = "";

  static HttpConfig? _instance;

  static late FlavorEnvironment environment;

  static String get baseUrl => "${ApiConstants.server_protocol}$_baseUrl";

  HttpConfig._production() {
    _baseUrl = "";
  }

  HttpConfig._development() {
    _baseUrl = "";
  }

  ///this function is responsible of all the server requests
  static HttpConfig instance() {
    //checking if the http class was already initialized or not
    if (_instance == null) {
      //getting the environment variable  from the command run
      String flavor = const String.fromEnvironment(
        "FLAVOR",
        defaultValue: "development",
      );
      //checking if the inserted environment name is right or not
      if (FlavorEnvironment.values.any((FlavorEnvironment element) =>
          element.name == flavor.toLowerCase())) {
        //getting the environment enum
        environment = FlavorEnvironment.values.firstWhere(
            (FlavorEnvironment element) =>
                element.name == flavor.toLowerCase());
        //setting an instance from the http class
        switch (environment) {
          case FlavorEnvironment.development:
            _instance = HttpConfig._development();
            break;
          case FlavorEnvironment.production:
            _instance = HttpConfig._production();
            break;
        }
      }
    }
    return _instance!;
  }

  ///recommended to use this function for the [getApiLink] for the http requests [Uri]
  ///the [path] parameter will have only the path in the server without / at the first
  ///you don't need to worry about the base url because this function will take care about
  ///every thing
  Uri getApiLink(
    String path, [
    Map<String, dynamic>? queryParameters,
  ]) {
    return Uri.https(_baseUrl, "/api/$path", queryParameters);
  }

  Uri getLink(String path) {
    if (_baseUrl.isEmpty) {
      throw "You need to initialize the HttpConfig class first";
    }
    return Uri.https(_baseUrl, path);
  }

  ///this function will return the header used for all the requests
  ///if [token] is set to null the @param Authorization will not be sent
  Map<String, String> getHeader({String? token, String? contentType}) {
    return <String, String>{
      "Accept": "application/json",
      "Content-Type": contentType ?? "application/json",
      if (token != null) "Authorization": token,
    };
  }

  ///this functions wil take care on handling all your Back-End errors
  ///if you going to use any package that requires additional Exceptions please add them here
  ///so all the apis are effected.
  ///You don't need to be so depressed on handling error for all those apis:
  ///- Add your exception in this function
  ///- hot reload the app
  ///- you are good to go ^_^
  String handleError(dynamic messages) {
    if (messages is String) {
      return messages;
    } else if (messages is Map<String, dynamic>) {
      String errors = "";
      for (dynamic error in (messages).values) {
        errors += error is List<dynamic> ? error.join(", ") : error.toString();
      }
      return errors;
    } else if (messages is SocketException) {
      log("handleError", messages.message);
      return "connection-failed";
    } else {
      log("handleError", messages);
      return "something-went-wrong";
    }
  }

  Future<void> checkConnectivity() async {
    ConnectivityResult con = await Connectivity().checkConnectivity();
    if (con == ConnectivityResult.none || con == ConnectivityResult.bluetooth) {
      throw "no-connection";
    }
  }

  bool validateStatusCode(int? statusCode) {
    return statusCode == 200 || statusCode == 201;
  }
}
