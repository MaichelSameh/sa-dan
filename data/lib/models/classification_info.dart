import '../utils/numbers_util.dart';
import 'price_info.dart';
import 'size_info.dart';

class ClassificationInfo {
  late String _classificationId;
  late DateTime _createdAt;
  late String _id;
  late PriceInfo _price;
  late String _productId;
  late int _quantity;
  late SizeInfo _size;

  ClassificationInfo({
    required String classificationId,
    required DateTime createdAt,
    required String id,
    required PriceInfo price,
    required String productId,
    required int quantity,
    required SizeInfo size,
  }) {
    _classificationId = classificationId;
    _createdAt = createdAt;
    _id = id;
    _price = price;
    _productId = productId;
    _quantity = quantity;
    _size = size;
  }

  ClassificationInfo.fromJson(Map<String, dynamic> data) {
    _classificationId = data["classification_id"];
    _createdAt = DateTime.parse(data["created_at"]);
    _id = data["id"];
    _price = PriceInfo(price: data["price"].toString().toDouble() ?? 0);
    _productId = data["product_id"];
    _quantity = data["quantity"].toString().toInt() ?? 0;
    _size = SizeInfo.fromJson(data["size"]);
  }

  ///the product classification id
  String get classificationId => _classificationId;

  ///the date when this classification was created
  DateTime get createdAt => _createdAt;

  String get id => _id;

  ///the price of the given classification
  PriceInfo get price => _price;

  ///the classification's product's id
  String get productId => _productId;

  ///the available classification quantity
  int get quantity => _quantity;

  ///the classification's size
  SizeInfo get size => _size;

  @override
  String toString() {
    return 'ClassificationInfo(_classificationId: $_classificationId, _createdAt: $_createdAt, _id: $_id, _price: $_price, _productId: $_productId, _quantity: $_quantity, _size: $_size)';
  }
}
