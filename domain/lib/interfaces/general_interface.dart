mixin GeneralInterface<T> {
  ///this function will search for a specific [T] by it's [id]
  Future<T?> getById({
    required String id,
    String? token,
    String? lang,
  });

  ///this function will return a list of [T] paginated by [page]
  Future<List<T>> getAll({
    String? lang,
    String? token,
    int page = 1,
  });
}
