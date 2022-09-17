import '../enums.dart';

class FilterInfo {
  ProductSorting? _sorting;
  late String? _storeId;
  String? _categorizationId;
  String? _keyword;

  FilterInfo({
    ProductSorting? sorting,
    String? storeId,
    String? categorizationId,
    String? keyword,
  }) {
    _sorting = sorting;
    _storeId = storeId;
    _categorizationId = categorizationId;
    _keyword = keyword;
  }

  ProductSorting? get sorting => _sorting;
  String? get categorizationId => _categorizationId;
  String? get storeId => _storeId;
  String? get keyword => _keyword;

  @override
  String toString() =>
      'FilterInfo(_sorting: $_sorting, _categorizationId: $_categorizationId, _keyword: $_keyword)';

  FilterInfo copyWith({
    ProductSorting? sorting,
    String? categorizationId,
    String? storeId,
    String? keyword,
  }) {
    return FilterInfo(
      sorting: sorting ?? this.sorting,
      categorizationId: categorizationId ?? this.categorizationId,
      storeId: storeId ?? this.storeId,
      keyword: keyword ?? this.keyword,
    );
  }

  FilterInfo copyFrom({FilterInfo? filter}) {
    return FilterInfo(
      sorting: filter?.sorting,
      categorizationId: filter?.categorizationId,
      storeId: filter?.storeId,
      keyword: filter?.keyword,
    );
  }
}
