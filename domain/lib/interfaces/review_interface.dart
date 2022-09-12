import 'package:data/models/models.dart';

mixin ReviewInterface {
  Future<bool> submitReview({
    required String token,
    required String id,
    required String review,
    required double rate,
  });

  Future<List<ReviewInfo>> getReviews({
    required String token,
    required String id,
    int? page,
  });
}
