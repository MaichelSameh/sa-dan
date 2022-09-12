mixin EditableGeneralInterface<T> {
  ///this function will add a new [T] to the database
  ///the method used for this function will be post
  Future<T> addNew({
    required T item,
    required String token,
    String? lang,
  });

  ///this function will update the [T] info in the database the database
  ///the method used for this function will be patch
  Future<T> updateItem({
    required T item,
    required String token,
    String? lang,
  });

  ///this function will delete the [T] item from the database by its [id]
  ///the method used for this function will be delete
  Future<bool> deleteItem({
    required String id,
    required String token,
    String? lang,
  });
}
