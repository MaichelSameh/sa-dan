import '../enums.dart';

class ProfileInfo {
  late String _email;
  late String _id;
  late String _name;
  String? _logoUrl;
  late String _phoneNumber;
  late String? _bio;
  late UserType _type;

  ProfileInfo({
    required String email,
    required String id,
    required String name,
    String? logoUrl,
    required String phoneNumber,
    required UserType type,
    String? fcm = "",
    String? bio,
  }) {
    _email = email;
    _id = id;
    _name = name;
    _logoUrl = logoUrl;
    _phoneNumber = phoneNumber;
    _bio = bio;
    _type = type;
  }

  ProfileInfo.fromJson(Map<String, dynamic> data) {
    _email = data["email"];
    _name = data["full_name"];
    _id = data["id"];
    _logoUrl = data["logo_url"];
    _phoneNumber = data["phone"] ?? "";
    _bio = data["bio"];
    _type = UserType.values.firstWhere(
      (UserType element) => element.name == data["type"],
      orElse: () => UserType.customer,
    );
  }

  ///the email address associated with the email
  String get email => _email;

  ///the user's full name
  String get name => _name;

  ///the user Id
  String get id => _id;

  ///the user logo avatar
  String? get logoUrl => _logoUrl;

  ///the user's phone code
  String get phoneNumber => _phoneNumber;

  ///profile's bio
  String? get bio => _bio;

  ///the user's type
  UserType get type => _type;

  @override
  String toString() {
    return 'ProfileInfo(_email: $_email, _id: $_id, _name: $_name, _logoUrl: $_logoUrl, _phoneNumber: $_phoneNumber, _bio: $_bio, _type: $_type)';
  }
}
