import '../enums.dart';
import '../utils/numbers_util.dart';
import '../utils/string_util.dart';
import 'address_info.dart';
import 'price_info.dart';

class OrderInfo {
  late AddressInfo _address;
  late String? _comment;
  late DateTime _createdAt;
  late String _customerId;
  late String? _driverId;
  late String _email;
  late String _id;
  late bool _inShipping;
  late String _invoiceId;
  late bool _isApproved;
  late bool _isCancelled;
  late bool _isDelivered;
  late bool _isPaid;
  late bool _isPreparing;
  late String _name;
  late String? _paymentId;
  late PaymentMethod _paymentMethod;
  late String _phone;
  late String? _promoCode;
  late String? _refundId;
  late OrderStatus _status;
  late PriceInfo _total;
  late PriceInfo _totalBeforePromoCode;

  OrderInfo({
    required AddressInfo address,
    String? comment,
    required DateTime createdAt,
    required String customerId,
    String? driverId,
    required String email,
    required String id,
    required bool inShipping,
    required String invoiceId,
    required bool isApproved,
    required bool isCancelled,
    required bool isDelivered,
    required bool isPaid,
    required bool isPreparing,
    required String name,
    String? paymentId,
    required PaymentMethod paymentMethod,
    required String phone,
    String? promoCode,
    String? refundId,
    required OrderStatus status,
    required PriceInfo total,
    required PriceInfo totalBeforePromoCode,
  }) {
    _address = address;
    _comment = comment;
    _createdAt = createdAt;
    _customerId = customerId;
    _driverId = driverId;
    _email = email;
    _id = id;
    _inShipping = inShipping;
    _invoiceId = invoiceId;
    _isApproved = isApproved;
    _isCancelled = isCancelled;
    _isDelivered = isDelivered;
    _isPaid = isPaid;
    _isPreparing = isPreparing;
    _name = name;
    _paymentId = paymentId;
    _paymentMethod = paymentMethod;
    _phone = phone;
    _promoCode = promoCode;
    _refundId = refundId;
    _status = status;
    _total = total;
    _totalBeforePromoCode = totalBeforePromoCode;
  }

  OrderInfo.fromJson(Map<String, dynamic> data) {
    _address = AddressInfo.fromJson(data);
    _comment = data["comment"];
    _createdAt = DateTime.parse(data["created_at"]);
    _customerId = data["customer_id"];
    _driverId = data["driver_id"] ?? "";
    _email = data["email"];
    _id = data["id"];
    _inShipping = data["in_shipping"] == true;
    _invoiceId = data["invoice_id"];
    _isApproved = data["is_approved"] == true;
    _isCancelled = data["is_cancelled"] == true;
    _isDelivered = data["is_delivered"] == true;
    _isPaid = data["is_paid"] == true;
    _isPreparing = data["is_preparing"] == true;
    _name = data["name"];
    _paymentId = data["payment_id"];
    _paymentMethod = PaymentMethod.values.firstWhere(
      (PaymentMethod element) =>
          element.name ==
          data["payment_method"].toString().convertCamelCaseToUnderscore(),
      orElse: () => PaymentMethod.cash,
    );
    _phone = data["phone"];
    _promoCode = data["promo_code"];
    _refundId = data["refund_id"];
    _status = OrderStatus.values.firstWhere(
        (OrderStatus element) =>
            element.name ==
            data["order_status"].toString().convertCamelCaseToUnderscore(),
        orElse: () => OrderStatus.orderIsCancelled);
    _total = PriceInfo(price: data["total"].toString().toDouble() ?? 0);
    _totalBeforePromoCode = PriceInfo(
        price: data["total_before_promo_code"].toString().toDouble() ?? 0);
  }

  ///the order's delivering address
  AddressInfo get address => _address;

  ///the order's additional comment
  String? get comment => _comment;

  ///the order's creation date
  DateTime get createdAt => _createdAt;

  ///the order's creator's id
  String get customerId => _customerId;

  ///the order's driver id
  String? get driverId => _driverId;

  ///the order's creator's email
  String get email => _email;

  ///the order's id
  String get id => _id;

  ///wether the order is in shipping phase or not
  bool get inShipping => _inShipping;

  ///the order's invoice id
  String get invoiceId => _invoiceId;

  ///wether the order is approved or not
  bool get isApproved => _isApproved;

  ///wether the order is cancelled or not
  bool get isCancelled => _isCancelled;

  ///wether the order is delivered or not
  bool get isDelivered => _isDelivered;

  ///wether the order is paid or not
  bool get isPaid => _isPaid;

  ///wether the order is in preparing phase or not
  bool get isPreparing => _isPreparing;

  ///the order's creator's name
  String get name => _name;

  ///the order's payment id.
  ///used only if the [paymentMethod] is set to [PaymentMethod.tap]
  String? get paymentId => _paymentId;

  ///the payment method used for this order
  PaymentMethod get paymentMethod => _paymentMethod;

  ///the order's creator's phone
  String get phone => _phone;

  ///the promo code used for this order
  String? get promoCode => _promoCode;

  ///the order's refund id
  String? get refundId => _refundId;

  ///the order's status
  OrderStatus get status => _status;

  ///the order's total price after the promo code discount
  PriceInfo get total => _total;

  ///the order's total price before the promo code discount
  PriceInfo get totalBeforePromoCode => _totalBeforePromoCode;

  @override
  String toString() {
    return 'OrderInfo(_address: $_address, _comment: $_comment, _createdAt: $_createdAt, _customerId: $_customerId, _driverId: $_driverId, _email: $_email, _id: $_id, _inShipping: $_inShipping, _invoiceId: $_invoiceId, _isApproved: $_isApproved, _isCancelled: $_isCancelled, _isDelivered: $_isDelivered, _isPaid: $_isPaid, _isPreparing: $_isPreparing, _name: $_name, _paymentId: $_paymentId, _paymentMethod: $_paymentMethod, _phone: $_phone, _promoCode: $_promoCode, _refundId: $_refundId, _status: $_status, _total: $_total, _totalBeforePromoCode: $_totalBeforePromoCode)';
  }
}
