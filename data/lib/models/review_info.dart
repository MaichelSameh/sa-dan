import '../utils/numbers_util.dart';
import 'profile_info.dart';

class ReviewInfo {
  late DateTime _createdAt;
  late String _id;
  late double _rate;
  late String _review;
  late String _userId;
  late ProfileInfo? _user;

  ReviewInfo({
    required DateTime createdAt,
    required String id,
    required double rate,
    required String review,
    required String userId,
    ProfileInfo? user,
  }) {
    _createdAt = createdAt;
    _id = id;
    _rate = rate;
    _review = review;
    _userId = userId;
    _user = user;
  }

  ReviewInfo.fromJson(Map<String, dynamic> data) {
    _createdAt = DateTime.parse(data["created_at"]);
    _id = data["id"];
    _rate = data["rate"].toString().toDouble() ?? 0;
    _review = data["review"];
    _userId = data["customer_id"];
    _user = data["customer"] != null
        ? ProfileInfo.fromJson(data["customer"])
        : null;
  }

  ///the date when this review was written
  DateTime get createdAt => _createdAt;

  ///the id of the review
  String get id => _id;

  ///the rate of the review
  double get rate => _rate;

  ///the review text
  String get review => _review;

  ///the review's creator id
  String get userId => _userId;

  ///the review's owner
  ProfileInfo? get user => _user;

  @override
  String toString() {
    return 'ReviewInfo(_createdAt: $_createdAt, _id: $_id, _rate: $_rate, _review: $_review, _userId: $_userId, _user: $_user)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReviewInfo &&
        other._createdAt == _createdAt &&
        other._id == _id &&
        other._rate == _rate &&
        other._review == _review &&
        other._userId == _userId &&
        other._user == _user;
  }

  @override
  int get hashCode {
    return _createdAt.hashCode ^
        _id.hashCode ^
        _rate.hashCode ^
        _review.hashCode ^
        _userId.hashCode ^
        _user.hashCode;
  }
}
