class BasicInfo {
  late String _phoneNumber;
  late String _email;
  late String? _address;

  BasicInfo({
    required String phoneNumber,
    required String email,
    required String? address,
  }) {
    _phoneNumber = phoneNumber;
    _email = email;
    _address = address;
  }

  BasicInfo.fromJson(Map<String, dynamic> data) {
    _phoneNumber = data["phone"];
    _email = data["email"];
    _address = data["address"];
  }

  ///the company phone number
  String get phoneNumber => _phoneNumber;

  ///the company email address
  String get email => _email;

  ///the company real address
  String? get address => _address;

  @override
  String toString() {
    return 'BasicInfo(phoneNumber: $phoneNumber, email: $email, address: $address)';
  }
}
