import 'dart:convert';

import 'package:data/models/profile_info.dart';
import 'package:http/http.dart' as http;

import '../api_constants.dart';
import '../http_config.dart';
import '../logger.dart';
import 'token_services.dart';

class ProfileServices {
  String _tag(String functionName, String variableName) {
    return "ProfileServices: $functionName $variableName";
  }

  final HttpConfig _httpConfig = HttpConfig.instance();

  Future<ProfileInfo> updateProfileData({
    required String token,
    required String email,
    required String fullName,
    required String phone,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.profile_update_path,
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.patch(
        localLink,
        body: json.encode(<String, dynamic>{
          "full_name": fullName,
          "email": email,
          "phone": phone,
        }),
        headers: _httpConfig.getHeader(token: token),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return ProfileInfo.fromJson(resData["payload"]);
      } else {
        if (res.statusCode == 401) {
          await TokenServices().discardAuthData();
        }
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("updateProfileData", "error"), errorMessage);
      throw errorMessage;
    }
  }

  Future<ProfileInfo> updateProfileLogo({
    required String token,
    required String filePath,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.profile_logo_path,
        <String, String>{"lang": lang ?? "en"},
      );
      http.MultipartRequest request = http.MultipartRequest("POST", localLink)
        ..headers.addAll(
          _httpConfig.getHeader(
            token: token,
            contentType:
                "multipart/form-data; boundary=<calculated when request is sent>",
          ),
        )
        ..files.add(
          await http.MultipartFile.fromPath(
            "logo",
            filePath,
            filename: filePath.split("/").last,
          ),
        );
      http.StreamedResponse streamRes = await request.send();
      http.Response res = await http.Response.fromStream(streamRes);
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return ProfileInfo.fromJson(resData["payload"]);
      } else {
        if (res.statusCode == 401) {
          await TokenServices().discardAuthData();
        }
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("updateProfileLogo", "error"), errorMessage);
      throw errorMessage;
    }
  }

  Future<ProfileInfo> getProfile({
    required String token,
    String? lang,
  }) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.profile_path,
        <String, String>{"lang": lang ?? "en"},
      );
      http.Response res = await http.get(
        localLink,
        headers: _httpConfig.getHeader(token: token),
      );
      Map<String, dynamic> resData = json.decode(res.body);
      if (_httpConfig.validateStatusCode(res.statusCode)) {
        return ProfileInfo.fromJson(resData["payload"]);
      } else {
        if (res.statusCode == 401) {
          await TokenServices().discardAuthData();
        }
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("getProfile", "error"), errorMessage);
      throw errorMessage;
    }
  }

  Future<bool> deleteAccount({required String token, String? lang}) async {
    try {
      await HttpConfig.instance().checkConnectivity();
      Uri localLink = _httpConfig.getApiLink(
        ApiConstants.delete_account_path,
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
        if (res.statusCode == 401) {
          await TokenServices().discardAuthData();
        }
        throw resData["messages"];
      }
    } catch (error) {
      String errorMessage = _httpConfig.handleError(error);
      log(_tag("deleteAccount", "error"), errorMessage);
      throw errorMessage;
    }
  }
}
