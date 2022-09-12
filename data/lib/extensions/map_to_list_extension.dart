import '../models/models.dart';

extension MapToList on List<dynamic> {
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
}
