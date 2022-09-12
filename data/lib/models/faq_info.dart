class FaqInfo {
  late String _id;
  late String _status;
  late String _creatorId;
  late String _questionByLang;
  late String _answerByLang;

  FaqInfo({
    required String id,
    required String status,
    required String creatorId,
    required String questionByLang,
    required String answerByLang,
  }) {
    _id = id;
    _status = status;
    _creatorId = creatorId;
    _questionByLang = questionByLang;
    _answerByLang = answerByLang;
  }

  ///the faq id in the database
  String get id => _id;

  ///the faq status
  String get status => _status;

  ///the question's creator id
  String get creatorId => _creatorId;

  ///the faq question by language
  String get questionByLang => _questionByLang;

  ///the faq answer by language
  String get answerByLang => _answerByLang;

  FaqInfo.fromJson(Map<String, dynamic> data) {
    _id = data['id'];
    _status = data['status'];
    _creatorId = data['creator_id'];
    _questionByLang = data['question_by_lang'];
    _answerByLang = data['answer_by_lang'];
  }

  @override
  String toString() {
    return 'FaqInfo(_id: $_id, _status: $_status, _creatorId: $_creatorId, _questionByLang: $_questionByLang, _answerByLang: $_answerByLang)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FaqInfo &&
        other._id == _id &&
        other._status == _status &&
        other._creatorId == _creatorId &&
        other._questionByLang == _questionByLang &&
        other._answerByLang == _answerByLang;
  }

  @override
  int get hashCode {
    return _id.hashCode ^
        _status.hashCode ^
        _creatorId.hashCode ^
        _questionByLang.hashCode ^
        _answerByLang.hashCode;
  }
}
