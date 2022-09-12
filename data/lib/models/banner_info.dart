class BannerInfo {
  late String _id;
  late String? _url;
  late String _titleByLang;
  late String _mainMediaUrl;

  BannerInfo({
    required String id,
    String? url,
    required String titleByLang,
    required String mainMediaUrl,
  }) {
    _id = id;
    _url = url;
    _titleByLang = titleByLang;
    _mainMediaUrl = mainMediaUrl;
  }

  ///the banner id
  String get id => _id;

  ///the url used in the eb
  String? get url => _url;

  ///the title by language sent in the request
  String get titleByLang => _titleByLang;

  ///the banner main media path to be displayed
  String get mainMediaUrl => _mainMediaUrl;

  BannerInfo.fromJson(Map<String, dynamic> data) {
    _id = data['id'];
    _url = data['url'];
    _titleByLang = data['title_by_lang'];
    _mainMediaUrl = data['main_media_url'];
  }
}
