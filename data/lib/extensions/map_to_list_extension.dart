import '../models/models.dart';

extension MapToList on List<dynamic> {
  ///this function will convert a [List] of [Map] into [List] of [AddressInfo]
  List<AddressInfo> listAddresses() {
    //creating a local variable to store the list
    List<AddressInfo> list = <AddressInfo>[];
    //looping into the list
    for (dynamic item in this) {
      //converting the map into the object
      list.add(AddressInfo.fromJson(item));
    }
    //returning the list
    return list;
  }

  ///this function will convert a [List] of [Map] into [List] of [BannerInfo]
  List<BannerInfo> listBanners() {
    //creating a local variable to store the list
    List<BannerInfo> list = <BannerInfo>[];
    //looping into the list
    for (dynamic item in this) {
      //converting the map into the object
      list.add(BannerInfo.fromJson(item));
    }
    //returning the list
    return list;
  }

  ///this function will convert a [List] of [Map] into [List] of [CategoryInfo]
  List<CategoryInfo> listCategories() {
    //creating a local variable to store the list
    List<CategoryInfo> list = <CategoryInfo>[];
    //looping into the list
    for (dynamic item in this) {
      //converting the map into the object
      list.add(CategoryInfo.fromJson(item));
    }
    //returning the list
    return list;
  }

  ///this function will convert a [List] of [Map] into [List] of [ClassificationInfo]
  List<ClassificationInfo> listClassifications() {
    //creating a local variable to store the list
    List<ClassificationInfo> list = <ClassificationInfo>[];
    //looping into the list
    for (dynamic item in this) {
      //converting the map into the object
      list.add(ClassificationInfo.fromJson(item));
    }
    //returning the list
    return list;
  }

  ///this function will convert a [List] of [Map] into [List] of [FaqInfo]
  List<FaqInfo> listFaqs() {
    //creating a local variable to store the list
    List<FaqInfo> list = <FaqInfo>[];
    //looping into the list
    for (dynamic item in this) {
      //converting the map into the object
      list.add(FaqInfo.fromJson(item));
    }
    //returning the list
    return list;
  }

  ///this function will convert a [List] of [Map] into [List] of [NotificationInfo]
  List<NotificationInfo> listNotifications() {
    //creating a local variable to store the list
    List<NotificationInfo> list = <NotificationInfo>[];
    //looping into the list
    for (dynamic item in this) {
      //converting the map into the object
      list.add(NotificationInfo.fromJson(item));
    }
    //returning the list
    return list;
  }

  ///this function will convert a [List] of [Map] into [List] of [OrderInfo]
  List<OrderInfo> listOrders() {
    //creating a local variable to store the list
    List<OrderInfo> list = <OrderInfo>[];
    //looping into the list
    for (dynamic item in this) {
      //converting the map into the object
      list.add(OrderInfo.fromJson(item));
    }
    //returning the list
    return list;
  }

  ///this function will convert a [List] of [Map] into [List] of [ProductInfo]
  List<ProductInfo> listProducts() {
    //creating a local variable to store the list
    List<ProductInfo> list = <ProductInfo>[];
    //looping into the list
    for (dynamic item in this) {
      //converting the map into the object
      list.add(ProductInfo.fromJson(item));
    }
    //returning the list
    return list;
  }

  ///this function will convert a [List] of [Map] into [List] of [ReviewInfo]
  List<ReviewInfo> listReviews() {
    //creating a local variable to store the list
    List<ReviewInfo> list = <ReviewInfo>[];
    //looping into the list
    for (dynamic item in this) {
      //converting the map into the object
      list.add(ReviewInfo.fromJson(item));
    }
    //returning the list
    return list;
  }

  ///this function will convert a [List] of [Map] into [List] of [StoreInfo]
  List<StoreInfo> listStores() {
    //creating a local variable to store the list
    List<StoreInfo> list = <StoreInfo>[];
    //looping into the list
    for (dynamic item in this) {
      //converting the map into the object
      list.add(StoreInfo.fromJson(item));
    }
    //returning the list
    return list;
  }
}
