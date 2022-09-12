import 'dart:convert';

import 'package:data/enums.dart';
import 'package:data/models/local_token_info.dart';
import 'package:data/models/profile_info.dart';
import 'package:data/models/token_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../logger.dart';
import 'auth_services.dart';
import 'profile_services.dart';

class TokenServices {
  String _tag(String functionName, String variableName) {
    return "TokenServices: $variableName $functionName";
  }

  ///trying to login the user again by the saved credentials
  Future<LocalTokenInfo?> reAuth() async {
    try {
      Map<String, String>? authData = await restoreAuthData();
      if (authData == null ||
          !authData.containsKey("email") ||
          !authData.containsKey("password")) {
        return null;
      } else if (authData.containsKey("social_auth_provider")) {
        AuthServices().socialLogin(
            name: authData["name"] ?? "",
            email: authData["email"]!,
            socialProvider: SocialAuthMethod.values.firstWhere(
                (SocialAuthMethod element) =>
                    element.name == authData["social_auth_provider"]));
      }
      {
        return await AuthServices().login(
          email: authData["email"]!,
          password: authData["password"]!,
        );
      }
    } catch (error) {
      log(_tag("reAuth", "error"), error);
      rethrow;
    }
  }

  ///this function will save the save [TokenInfo] in the [SharedPreferences]
  Future<LocalTokenInfo> saveToken(TokenInfo token) async {
    try {
      ProfileInfo profile =
          await ProfileServices().getProfile(token: token.combinedToken);
      LocalTokenInfo localData = LocalTokenInfo(
        token: token,
        name: profile.name,
        phoneNumber: profile.phoneNumber,
        email: profile.email,
        logoUrl: profile.logoUrl,
        userId: profile.id,
      );
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("token", json.encode(localData.toMap()));
      return localData;
    } catch (error) {
      log(_tag("saveToken", "error"), error);
      rethrow;
    }
  }

  Future<LocalTokenInfo> updateLocalToken(ProfileInfo profile) async {
    ///this function will save the save [TokenInfo] in the [SharedPreferences]
    try {
      LocalTokenInfo? temp = await restoreToken();
      LocalTokenInfo localData = LocalTokenInfo(
        token: temp!.token,
        name: profile.name,
        phoneNumber: profile.phoneNumber,
        email: profile.email,
        logoUrl: profile.logoUrl,
        userId: profile.id,
      );
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("token", json.encode(localData.toMap()));
      return localData;
    } catch (error) {
      log(_tag("updateLocalToken", "error"), error);
      rethrow;
    }
  }

  ///this function will delete the saved [TokenInfo] from the [SharedPreferences]
  Future<bool> discardTokenData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove("token");
      return true;
    } catch (error) {
      log(_tag("discardTokenData", "error"), error);
      rethrow;
    }
  }

  ///this function will restore the saved [TokenInfo] from the [SharedPreferences]
  Future<LocalTokenInfo?> restoreToken() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString("token");
      if (token == null) {
        return null;
      }
      Map<String, dynamic> tokenData = json.decode(token);
      LocalTokenInfo temp = LocalTokenInfo.fromMap(tokenData);
      return await saveToken(temp.token);
    } catch (error) {
      log(_tag("restoreToken", "error"), error);
      rethrow;
    }
  }

  ///saving the auth data in the [SharedPreferences]
  Future<bool> saveAuthData(
    String email,
    String password, [
    String? name,
    SocialAuthMethod? socialAuthMethod,
  ]) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("email", email);
      pref.setString("password", password);
      if (socialAuthMethod != null) {
        pref.setString("social_auth_provider", socialAuthMethod.name);
      }
      if (name != null) {
        pref.setString("name", name);
      }
      return true;
    } catch (error) {
      log(_tag("saveAuthData", "error"), error);
      rethrow;
    }
  }

  ///restoring the removing auth data from the [SharedPreferences]
  Future<bool> discardAuthData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove("email");
      pref.remove("password");
      pref.remove("social_auth_provider");
      return true;
    } catch (error) {
      log(_tag("discardAuthData", "error"), error);
      rethrow;
    }
  }

  ///restoring the saved auth data from the [SharedPreferences]
  Future<Map<String, String>?> restoreAuthData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? email = pref.getString("email");
      String? password = pref.getString("password");
      if (email == null || password == null) {
        return null;
      }
      return <String, String>{
        "email": email,
        "password": password,
      };
    } catch (error) {
      log(_tag("restoreAuthData", "error"), error);
      rethrow;
    }
  }
}
