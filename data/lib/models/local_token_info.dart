import 'package:intl/intl.dart';

import 'token_info.dart';

class LocalTokenInfo {
  late String _name;
  late String _phoneNumber;
  late String _email;
  String? _logoUrl;
  late TokenInfo _token;
  late String _userId;

  LocalTokenInfo({
    required TokenInfo token,
    required String name,
    required String phoneNumber,
    String? logoUrl,
    required String email,
    required String userId,
  }) {
    _token = token;
    _name = name;
    _phoneNumber = phoneNumber;
    _logoUrl = logoUrl;
    _email = email;
    _userId = userId;
  }

  ///the user session's token
  TokenInfo get token => _token;

  ///the user name
  String get name => _name;

  ///the user phone number
  String get phoneNumber => _phoneNumber;

  ///the user's email
  String get email => _email;

  ///the user's profile picture
  String? get logoUrl => _logoUrl;

  ///the user's id
  String get userId => _userId;

  LocalTokenInfo.fromMap(Map<String, dynamic> data) {
    _token = TokenInfo.fromJson(data["token"]);
    _name = data["name"];
    _phoneNumber = data["phone_number"];
    _email = data["email"];
    _logoUrl = data["logo_url"];
    _userId = data["user-id"];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "token": <String, dynamic>{
        // ignore: deprecated_member_use_from_same_package
        "token": token.token,
        // ignore: deprecated_member_use_from_same_package
        "token_type": token.tokenType,
        "user_name": name,
        "token_expires_at":
            DateFormat("yyyy-MM-dd hh:mm:ss").format(token.expiresAt),
      },
      "user-id": userId,
      "name": name,
      "email": email,
      "phone_number": phoneNumber,
      if (logoUrl != null) "logo_url": logoUrl,
    };
  }

  @override
  String toString() {
    return 'LocalTokenInfo(_name: $_name, _phoneNumber: $_phoneNumber, _email: $_email, _logoUrl: $_logoUrl, _token: $_token, _userId: $_userId)';
  }
}
