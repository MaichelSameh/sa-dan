class CategoryInfo {
  late String _icon;
  late String _id;
  late String _name;

  CategoryInfo({
    required String icon,
    required String id,
    required String name,
  }) {
    _icon = icon;
    _id = id;
    _name = name;
  }

  CategoryInfo.fromJson(Map<String, dynamic> data) {
    _icon = data["icon"];
    _id = data["id"];
    _name = data["name_by_lang"];
  }

  ///the category's icon url
  String get icon => _icon;

  ///the category's id
  String get id => _id;

  ///the category's name
  String get name => _name;

  @override
  String toString() =>
      'CategorizationInfo(_icon: $_icon, _id: $_id, _name: $_name)';
}
