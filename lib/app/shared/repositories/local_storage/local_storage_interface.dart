import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/models/review_model.dart';

abstract class ILocalStorage {
  Future<bool> get isDarkMode;

  Future<void> setDarkMode(bool isDark);

  Future<List<RestaurantModel>> getAllRestaurants();

  Future<List<ReviewModel>> getAllReviews();
}
