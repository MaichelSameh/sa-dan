class SocialInfo {
  late String? _facebook;
  late String? _twitter;
  late String? _linkedin;
  late String? _instagram;
  late String? _snapchat;
  late String? _youtube;

  SocialInfo({
    String? facebook,
    String? twitter,
    String? linkedin,
    String? instagram,
    String? snapchat,
    String? youtube,
  }) {
    _facebook = facebook;
    _twitter = twitter;
    _linkedin = linkedin;
    _instagram = instagram;
    _snapchat = snapchat;
    _youtube = youtube;
  }

  SocialInfo.fromJson(Map<String, dynamic> data) {
    _facebook = data["facebook"];
    _twitter = data["twitter"];
    _linkedin = data["linkedin"];
    _instagram = data["instagram"];
    _snapchat = data["snapchat"];
    _youtube = data["youtube"];
  }

  ///the company facebook link
  String? get facebook => _facebook;

  ///the company twitter link
  String? get twitter => _twitter;

  ///the company linkedin link
  String? get linkedin => _linkedin;

  ///the company instagram link
  String? get instagram => _instagram;

  ///the company snapchat link
  String? get snapchat => _snapchat;

  ///the company youtube link
  String? get youtube => _youtube;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SocialInfo &&
        other.facebook == facebook &&
        other.twitter == twitter &&
        other.linkedin == linkedin &&
        other.instagram == instagram &&
        other.snapchat == snapchat &&
        other.youtube == youtube;
  }

  @override
  int get hashCode {
    return facebook.hashCode ^
        twitter.hashCode ^
        linkedin.hashCode ^
        instagram.hashCode ^
        snapchat.hashCode ^
        youtube.hashCode;
  }

  @override
  String toString() {
    return 'SocialInfo(facebook: $facebook, twitter: $twitter, linkedin: $linkedin, instagram: $instagram, snapchat: $snapchat, youtube: $youtube)';
  }
}
