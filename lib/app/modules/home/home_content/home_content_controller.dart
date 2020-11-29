import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/storage_repository_interface.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/media_cache.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_content_controller.g.dart';

class HomeContentController = _HomeContentBase with _$HomeContentController;

abstract class _HomeContentBase with Store {
  @observable
  ObservableList<RestaurantModel> restaurants;

  @observable
  bool loadingRestaurants;

  @observable
  bool loadingReviews;

  @observable
  ObservableList<ReviewModel> reviews;

  IStorageRepository _storage;

  _HomeContentBase() {
    _storage = Modular.get();
    mediaCache = Modular.get();

    mediaCache.loadCache();

    _loadRestaurants();
    _loadReviews();
  }

  MediaCache mediaCache;

  @action
  Future<void> _loadRestaurants() async {
    loadingRestaurants = true;
    restaurants = ObservableList<RestaurantModel>();

    final _restaurants = await _storage.getAllRestaurants();

    restaurants.addAll(_restaurants.where((r) => r.favorite).toList());

    restaurants
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    loadingRestaurants = false;
  }

  @action
  Future<void> _loadReviews() async {
    loadingReviews = true;
    reviews = ObservableList<ReviewModel>();

    final _reviews = await _storage.getAllReviews();
    if (_reviews.isNotEmpty) {
      _reviews.sort((a, b) => a.reviewDate.compareTo(b.reviewDate));
      final limit = _reviews.length < 5 ? _reviews.length : 5;
      reviews.addAll(_reviews.reversed.toList().sublist(0, limit));
    }

    loadingReviews = false;
  }

  @action
  void showRestaurantDetails(RestaurantModel restaurant) {
    Modular.to.pushNamed('/restaurant/details', arguments: restaurant);
  }

  @action
  void showReviewsDetails(ReviewModel review) {
    Modular.to.pushNamed('/review/details', arguments: review);
  }
}
