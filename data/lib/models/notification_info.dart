class NotificationInfo {
  late String _id;
  late String _message;
  late DateTime _createdAt;

  NotificationInfo({
    required String id,
    required String message,
    required DateTime createdAt,
  }) {
    _id = id;
    _message = message;
    _createdAt = createdAt;
  }

  ///the notification id
  String get id => _id;

  ///the notification body data
  String get message => _message;

  ///the date when this message was created
  DateTime get createdAt => _createdAt;

  NotificationInfo.fromJson(Map<String, dynamic> data) {
    _id = data['id'];
    _message = data['data']["message"];
    _createdAt = DateTime.parse(data["created_at"]);
  }
}
