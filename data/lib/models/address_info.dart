import '../enums.dart';
import '../utils/numbers_util.dart';

class AddressInfo {
  late int? _blockNumber;
  late String _city;
  late DateTime _createdAt;
  late int? _flatNumber;
  late int? _floorNumber;
  late String _id;
  late String _name;
  late String _ownerId;
  late String _phone;
  late String _postalCode;
  late String _streetName;
  late AddressType _type;

  AddressInfo({
    int? blockNumber,
    required String city,
    required DateTime createdAt,
    int? flatNumber,
    int? floorNumber,
    required String id,
    required String name,
    required String ownerId,
    required String phone,
    required String postalCode,
    required String streetName,
    required AddressType type,
  }) {
    _blockNumber = blockNumber;
    _city = city;
    _createdAt = createdAt;
    _flatNumber = flatNumber;
    _floorNumber = floorNumber;
    _id = id;
    _name = name;
    _ownerId = ownerId;
    _phone = phone;
    _postalCode = postalCode;
    _streetName = streetName;
    _type = type;
  }

  AddressInfo.fromJson(Map<String, dynamic> data) {
    _blockNumber = data["block_number"].toString().toInt();
    _city = data["city"];
    _createdAt = DateTime.parse(data["created_at"]);
    _flatNumber = data["flat_number"].toString().toInt();
    _floorNumber = data["floor_number"].toString().toInt();
    _id = data["address_id"] ?? data["id"];
    _name = data["name"];
    _ownerId = data["owner_id"];
    _phone = data["phone"];
    _postalCode = data["postal_code"];
    _streetName = data["street_name"];
    _type = AddressType.values.firstWhere(
      (AddressType element) => element.name == data["type"],
      orElse: () => AddressType.home,
    );
  }

  ///the address's block number
  int? get blockNumber => _blockNumber;

  ///the address's city
  String get city => _city;

  ///the date when the address is created
  DateTime get createdAt => _createdAt;

  ///the address's flat number
  int? get flatNumber => _flatNumber;

  ///the address's floor number
  int? get floorNumber => _floorNumber;

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

  @override
  String toString() {
    return 'AddressInfo(_blockNumber: $_blockNumber, _city: $_city, _createdAt: $_createdAt, _flatNumber: $_flatNumber, _floorNumber: $_floorNumber, _id: $_id, _name: $_name, _ownerId: $_ownerId, _phone: $_phone, _postalCode: $_postalCode, _streetName: $_streetName, _type: $_type)';
  }
}
