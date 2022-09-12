class TokenInfo {
  late String _tokenType;
  late String _token;
  late DateTime _expiresAt;

  TokenInfo({
    required String tokenType,
    required String token,
    required DateTime expiresAt,
  }) {
    _token = token;
    _tokenType = tokenType;
    _expiresAt = expiresAt;
  }

  TokenInfo.fromJson(Map<String, dynamic> data) {
    _token = data["token"];
    _tokenType = data["token_type"];
    _expiresAt = DateTime.parse(data["token_expires_at"]);
  }

  ///the token type, to be used in the auth operation
  @Deprecated("You can't use this getter")
  String get tokenType => _tokenType;

  ///the token key
  @Deprecated("You can't use this getter")
  String get token => _token;

  ///the token expire date
  DateTime get expiresAt => _expiresAt;

  ///the token to be used in the request's header
  String get combinedToken => "$_tokenType $_token";

  @override
  String toString() =>
      'TokenInfo(tokenType: $_tokenType, token: $_token, expiresAt: $expiresAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TokenInfo &&
        other._tokenType == _tokenType &&
        other._token == _token &&
        other.expiresAt == expiresAt;
  }

  @override
  int get hashCode =>
      _tokenType.hashCode ^ _token.hashCode ^ expiresAt.hashCode;
}
