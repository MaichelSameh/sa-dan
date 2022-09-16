import '../extensions/map_to_list_extension.dart';
import '../utils/numbers_util.dart';
import 'classification_info.dart';

class ProductInfo {
  late double _averageRate;
  late String _categoryId;
  late DateTime _createdAt;
  late String _creatorId;
  late List<ClassificationInfo> _classification;
  late String _description;
  late String _id;
  late List<String> _mainMedia;
  late String _mainMediaUrl;
  late String _name;
  late int _viewCount;

  ProductInfo({
    required double averageRate,
    required String categoryId,
    required DateTime createdAt,
    required String creatorId,
    required List<ClassificationInfo> classification,
    required String description,
    required String id,
    required List<String> mainMedia,
    required String mainMediaUrl,
    required String name,
    required int viewCount,
  }) {
    _averageRate = averageRate;
    _categoryId = categoryId;
    _createdAt = createdAt;
    _creatorId = creatorId;
    _classification = classification;
    _description = description;
    _id = id;
    _mainMedia = mainMedia;
    _mainMediaUrl = mainMediaUrl;
    _name = name;
    _viewCount = viewCount;
  }

  ProductInfo.fromJson(Map<String, dynamic> data) {
    _averageRate = data["average_rate"].toString().toDouble() ?? 0;
    _categoryId = data["categorization_id"];
    _createdAt = DateTime.parse(data["created_at"]);
    _creatorId = data["creator_id"];
    _classification = (data["product_classifications"] as List<dynamic>)
        .listClassifications();
    _description = data["overview_by_lang"];
    _id = data["id"];
    _mainMediaUrl = data["main_media_url"];
    _name = data["name_by_lang"];
    _viewCount = data["views_count"].toString().toInt() ?? 0;
    _mainMedia = <String>[];
    for (dynamic item in (data["media_links"] ?? <dynamic>[])) {
      _mainMedia.add(item.toString());
    }
  }

  ///the product's average rate
  double get averageRate => _averageRate;

  ///the product's parent category's id
  String get categoryId => _categoryId;

  ///the product's creation date
  DateTime get createdAt => _createdAt;

  ///the product's creator's id
  String get creatorId => _creatorId;

  ///the product's available classifications
  List<ClassificationInfo> get classification => _classification;

  ///the product's description
  String get description => _description;

  ///the product's id
  String get id => _id;

  ///the product's main media links
  List<String> get mainMedia => _mainMedia;

  ///the product's main media url
  String get mainMediaUrl => _mainMediaUrl;

  ///the product's name
  String get name => _name;

  ///the product's view count
  int get viewCount => _viewCount;

  @override
  String toString() {
    return 'ProductInfo(_averageRate: $_averageRate, _categoryId: $_categoryId, _createdAt: $_createdAt, _creatorId: $_creatorId, _classification: $_classification, _description: $_description, _id: $_id, _mainMedia: $_mainMedia, _mainMediaUrl: $_mainMediaUrl, _name: $_name, _viewCount: $_viewCount)';
  }
}
