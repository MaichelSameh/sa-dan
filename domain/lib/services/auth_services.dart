import 'dart:convert';

import 'package:data/enums.dart';
import 'package:data/models/local_token_info.dart';
import 'package:data/models/token_info.dart';
import 'package:http/http.dart' as http;

import '../api_constants.dart';
import '../http_config.dart';
import '../logger.dart';
import 'token_services.dart';

class AuthServices {
  String _tag(String functionName, String variableName) {
    return "AuthServices: $functionName $variableName";
  }

  final HttpConfig _httpConfig = HttpConfig.instance();

  ///this function will log the user in by a the email and password
  ///if the user is already registered on the system
  Future<LocalTokenInfo> login({
    required String email,
    required String password,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(ApiConstants.login_path);
      http.Response res = await http.post(
        localLink,
        body: json.encode(
          <String, dynamic>{
            "email": email,
            "password": password,
          },
        ),
        headers: _httpConfig.getHeader(),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        TokenInfo token = TokenInfo.fromJson(resData["payload"]);
        await TokenServices().saveAuthData(email, password);
        return await TokenServices().saveToken(token);
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("login", "error"), errorMessage);
      throw errorMessage;
    }
  }

  ///this function will log the user out of the system and delete all the saved data
  Future<bool> logout({
    required String token,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      await TokenServices().discardTokenData();
      await TokenServices().discardAuthData();
      Uri logoutLink = _httpConfig.getApiLink(
        ApiConstants.logout_path,
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.post(
        logoutLink,
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
      log(_tag("logout", "error"), errorMessage);
      throw errorMessage;
    }
  }

  ///this function will create another user in case the email is not used by
  ///another user
  Future<LocalTokenInfo> customerSignUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.register_path,
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.post(
        localLink,
        body: json.encode(<String, dynamic>{
          "full_name": fullName,
          "email": email,
          "password": password,
          "phone": int.tryParse(phone),
          "phone_code": "",
          "type": UserType.customer.name,
        }),
        headers: _httpConfig.getHeader(),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        TokenInfo token = TokenInfo.fromJson(resData["payload"]);
        await TokenServices().saveAuthData(email, password);
        return await TokenServices().saveToken(token);
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("signUp", "error"), errorMessage);
      throw errorMessage;
    }
  }

  ///this function will create another user in case the email is not used by
  ///another user
  Future<LocalTokenInfo> driverSignUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,

    ///the id card
    required String nationalId,
    required String country,
    required String city,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.register_path,
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.post(
        localLink,
        body: json.encode(
          <String, dynamic>{
            "full_name": fullName,
            "email": email,
            "password": password,
            "phone": int.tryParse(phone),
            "phone_code": "",
            "type": UserType.driver.name,
            "national_id": nationalId,
            "country": country,
            "city": city,
          },
        ),
        headers: _httpConfig.getHeader(),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        TokenInfo token = TokenInfo.fromJson(resData["payload"]);
        await TokenServices().saveAuthData(email, password);
        return await TokenServices().saveToken(token);
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("signUp", "error"), errorMessage);
      throw errorMessage;
    }
  }

  ///this function will try to log the user in without any credentials
  Future<LocalTokenInfo?> autoLogin() async {
    try {
      LocalTokenInfo? localData = await TokenServices().restoreToken();
      if (localData == null ||
          localData.token.expiresAt.isBefore(DateTime.now())) {
        localData = await TokenServices().reAuth();
        return localData;
      } else {
        return localData;
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("autoLogin", "error"), errorMessage);
      throw errorMessage;
    }
  }

  ///this function will log the user in by a the social media account, if the email is not deleted
  Future<LocalTokenInfo> socialLogin({
    required String name,
    required String email,
    required SocialAuthMethod socialProvider,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(ApiConstants.social_login_path,
          <String, String>{"lang": lang ?? "en"});
      http.Response res = await http.post(
        localLink,
        body: json.encode(
          <String, dynamic>{
            "name": name,
            "email": email,
            "account_social_provider": socialProvider.name,
          },
        ),
        headers: _httpConfig.getHeader(),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        TokenInfo token = TokenInfo.fromJson(resData["payload"]);
        await TokenServices().saveAuthData(email, "", name, socialProvider);
        LocalTokenInfo local = await TokenServices().saveToken(token);
        return local;
      } else {
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("socialLogin", "error"), errorMessage);
      throw errorMessage;
    }
  }
}
