import '../models/models.dart';

extension AddressToMap on AddressInfo {
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "phone": phone,
      "street_name": streetName,
      "country": country,
      "city": city,
      "postal_code": postalCode,
    };
  }
}
