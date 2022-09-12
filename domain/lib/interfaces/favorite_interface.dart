mixin FavoriteInterface<T> {
  ///this function will mark the [T] with the given [id] as favorite
  Future<bool> favorite({
    required String id,
    required String token,
    String? lang,
  });

  ///this function will mark the [T] with the given [id] as unfavorite
  Future<bool> unfavorite({
    required String id,
    required String token,
    String? lang,
  });

  ///this function will list all the favorites [T] that the user with the given [token]
  ///had marked
  Future<List<T>> listAllFavorites({
    required String token,
    int? page,
    String? lang,
  });
}
