import '../enums.dart';

class AddressInfo {
  late String _country;
  late String _city;
  late DateTime _createdAt;
  late String _id;
  late String _name;
  late String _ownerId;
  late String _phone;
  late String _postalCode;
  late String _streetName;
  late AddressType _type;

  AddressInfo({
    required String country,
    required String city,
    required DateTime createdAt,
    required String id,
    required String name,
    required String ownerId,
    required String phone,
    required String postalCode,
    required String streetName,
    required AddressType type,
  }) {
    _country = country;
    _city = city;
    _createdAt = createdAt;
    _id = id;
    _name = name;
    _ownerId = ownerId;
    _phone = phone;
    _postalCode = postalCode;
    _streetName = streetName;
    _type = type;
  }

  AddressInfo.fromJson(Map<String, dynamic> data) {
    _country = data["country"];
    _city = data["city"];
    _createdAt = DateTime.parse(data["created_at"]);
    _id = data["address_id"] ?? data["id"];
    _name = data["name"];
    _ownerId = data["customer_id"] ?? data["owner_id"];
    _phone = data["phone"];
    _postalCode = data["postal_code"] ?? "";
    _streetName = data["street_name"];
    _type = AddressType.values.firstWhere(
      (AddressType element) => element.name == data["type"],
      orElse: () => AddressType.home,
    );
  }

  ///the address's country
  String get country => _country;

  ///the address's city
  String get city => _city;

  ///the date when the address is created
  DateTime get createdAt => _createdAt;

  ///the address's id
  String get id => _id;

  ///the address's owner's name
  String get name => _name;

  ///the address's owner's id
  String get ownerId => _ownerId;

  ///the address's owner's phone number
  String get phone => _phone;

  ///the address's postal code
  String get postalCode => _postalCode;

  ///the address's street name
  String get streetName => _streetName;

  ///the address's type
  AddressType get type => _type;

  String get address {
    String result = "";
    if (city.isNotEmpty) {
      result += "$city ";
    }
    if (country.isNotEmpty) {
      result += "$country ";
    }
    return result;
  }

  @override
  String toString() {
    return 'AddressInfo(_country: $_country, _city: $_city, _createdAt: $_createdAt, _id: $_id, _name: $_name, _ownerId: $_ownerId, _phone: $_phone, _postalCode: $_postalCode, _streetName: $_streetName, _type: $_type)';
  }
}
