import '../utils/numbers_util.dart';
import 'price_info.dart';
import 'product_info.dart';

class CartItemInfo {
  late DateTime _createdAt;
  late String? _customerId;
  late String _id;
  late PriceInfo _price;
  late ProductInfo _product;
  late int _quantity;
  late PriceInfo _totalPrice;

  CartItemInfo({
    required DateTime createdAt,
    String? customerId,
    required String id,
    required PriceInfo price,
    required ProductInfo product,
    required int quantity,
    required PriceInfo totalPrice,
  }) {
    _createdAt = createdAt;
    _customerId = customerId;
    _id = id;
    _price = price;
    _product = product;
    _quantity = quantity;
    _totalPrice = totalPrice;
  }

  CartItemInfo.fromJson(Map<String, dynamic> data) {
    Map<String, dynamic> productData = <String, dynamic>{};
    for (dynamic key in (data["product"] as Map<dynamic, dynamic>).keys) {
      productData.putIfAbsent(key.toString(), () => data["product"][key]);
    }
    _createdAt = DateTime.parse(data["created_at"]);
    _customerId = data["creator_id"];
    _id = data["id"];
    _product = ProductInfo.fromJson(productData);
    _price = PriceInfo(
      price: data["price"].toString().toDouble() ?? 0,
    );
    _totalPrice = PriceInfo(
      price: data["final_price"].toString().toDouble() ?? 0,
    );
    _quantity = data["quantity"].toString().toInt() ?? 0;
  }

  ///the time when the product was added to the cart
  DateTime get createdAt => _createdAt;

  ///the customer who added this product to his cart, basically me :)
  String? get customerId => _customerId;

  ///the cart item id
  String get id => _id;

  ///the single product price with the discount
  PriceInfo get price => _price;

  ///the cart total price
  PriceInfo get totalPrice => _totalPrice;

  ///the cart product
  ProductInfo get product => _product;

  ///the quantity of the product in the cart
  int get quantity => _quantity;

  @override
  String toString() {
    return 'CartItemInfo(_createdAt: $_createdAt, _customerId: $_customerId, _id: $_id, _price: $_price, _product: $_product, _quantity: $_quantity, _totalPrice: $_totalPrice)';
  }

  CartItemInfo copyWith({
    DateTime? createdAt,
    String? customerId,
    String? id,
    PriceInfo? price,
    ProductInfo? product,
    int? quantity,
    PriceInfo? totalPrice,
  }) {
    return CartItemInfo(
      createdAt: createdAt ?? this.createdAt,
      customerId: customerId ?? this.customerId,
      id: id ?? this.id,
      price: price ?? this.price,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
