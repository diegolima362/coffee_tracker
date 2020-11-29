import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/models/review_model.dart';

abstract class ILocalStorage {
  Future<List<RestaurantModel>> getAllRestaurants();

  Future<List<ReviewModel>> getAllReviews();

  Future<void> persistReview(ReviewModel review);

  Future<void> deleteReview(String id);

  Future<void> deleteRestaurant(String id);

  Future<void> persistRestaurant(RestaurantModel restaurant);
}
