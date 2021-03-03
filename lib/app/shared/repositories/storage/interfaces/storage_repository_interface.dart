import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class IStorageRepository implements Disposable {
  Future<List<RestaurantModel>> getAllRestaurants();

  Future<List<ReviewModel>> getAllReviews();

  Future<void> persistRestaurant(RestaurantModel restaurant);

  Future<void> persistReview(ReviewModel review);

  Future<void> updateRestaurant(RestaurantModel restaurant);

  Future<void> updateReview(ReviewModel review);

  Future<void> deleteRestaurant(String id);

  Future<void> deleteReview(String id);

  void flushCache();
}
