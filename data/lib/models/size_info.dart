class SizeInfo {
  late String _categorizationId;
  late DateTime _createdAt;
  late String _creatorId;
  late String _id;
  late String _name;

  SizeInfo({
    required String categorizationId,
    required DateTime createdAt,
    required String creatorId,
    required String id,
    required String name,
  }) {
    _categorizationId = categorizationId;
    _createdAt = createdAt;
    _creatorId = creatorId;
    _id = id;
    _name = name;
  }

  SizeInfo.fromJson(Map<String, dynamic> data) {
    _categorizationId = data["categorization_id"];
    _createdAt = DateTime.parse(data["created_at"]);
    _creatorId = data["creator_id"];
    _id = data["id"];
    _name = data["name_by_lang"];
  }

  ///the size's categorization id
  String get categorizationId => _categorizationId;

  ///the date when this size was added
  DateTime get createdAt => _createdAt;

  ///the size's creator id
  String get creatorId => _creatorId;

  ///the size's id
  String get id => _id;

  ///the size's name
  String get name => _name;

  @override
  String toString() {
    return 'SizeInfo(_categorizationId: $_categorizationId, _createdAt: $_createdAt, _creatorId: $_creatorId, _id: $_id, _name: $_name)';
  }
}
