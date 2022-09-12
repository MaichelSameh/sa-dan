import 'package:get/get.dart';

class PriceInfo {
  late double _price;
  late String? _currency;

  PriceInfo({
    required double price,
    String? currency,
  }) {
    _price = price;
    _currency = currency;
  }

  ///the amount of money
  double get price => _price;

  ///the price currency
  String get currency => _currency ?? "sar";

  String get getPrice {
    return "${price.toStringAsFixed(2)} ${currency.tr}";
  }

  @override
  @Deprecated("Please use the getPrice method instead")
  String toString() => 'PriceInfo(_price: $_price, _currency: $_currency)';
}
