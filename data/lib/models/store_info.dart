import '../enums.dart';

class StoreInfo {
  late String _email;
  late String _id;
  late String _logoUrl;
  late String _name;
  late String _phone;
  late UserType _type;
  late String _username;

  StoreInfo({
    required String email,
    required String id,
    required String logoUrl,
    required String name,
    required String phone,
    required UserType type,
    required String username,
  }) {
    _email = email;
    _id = id;
    _logoUrl = logoUrl;
    _name = name;
    _phone = phone;
    _type = type;
    _username = username;
  }

  StoreInfo.fromJson(Map<String, dynamic> data) {
    _email = data["email"];
    _id = data["id"];
    _logoUrl = data["logo_url"];
    _name = data["full_name"];
    _phone = data["phone"];
    _type = UserType.values.firstWhere(
        (UserType element) => element.name == data["type"],
        orElse: () => UserType.company);
    _username = data["username"];
  }

  ///the store contact email
  String get email => _email;

  ///the store's id
  String get id => _id;

  ///the store's logo
  String get logoUrl => _logoUrl;

  ///the store's name
  String get name => _name;

  ///the store's phone
  String get phone => _phone;

  ///the store's type
  UserType get type => _type;

  ///the store's username
  String get username => _username;

  @override
  String toString() {
    return 'StoreInfo(_email: $_email, _id: $_id, _logoUrl: $_logoUrl, _name: $_name, _phone: $_phone, _type: $_type, _username: $_username)';
  }
}
