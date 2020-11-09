import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:coffee_tracker/app/shared/repositories/local_storage/local_storage_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'home_content_controller.g.dart';

class HomeContentController = _HomeContentBase with _$HomeContentController;

abstract class _HomeContentBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }

  @observable
  List<RestaurantModel> _restaurants;

  @observable
  List<ReviewModel> _reviews;

  _HomeContentBase() {
    _loadRestaurants();
    _loadReviews();
  }

  @action
  Future<void> _loadRestaurants() async {
    final ILocalStorage storage = Modular.get();
    _restaurants = await storage.getAllRestaurants();
  }

  @action
  Future<void> _loadReviews() async {
    final ILocalStorage storage = Modular.get();
    _reviews = await storage.getAllReviews();
  }

  @computed
  Future<List<ReviewModel>> get last async {
    if (_reviews == null) {
      final ILocalStorage storage = Modular.get();
      _reviews = await storage.getAllReviews();
    }

    _reviews.sort((a, b) => a.reviewDate.compareTo(b.reviewDate));

    return _reviews.reversed.toList().sublist(0, 5);
  }

  @computed
  Future<List<RestaurantModel>> get favorites async {
    if (_restaurants == null) {
      final ILocalStorage storage = Modular.get();
      _restaurants = await storage.getAllRestaurants();
    }

    _restaurants.sort((a, b) => a.rate.compareTo(b.rate));

    return _restaurants.reversed.toList().sublist(0, 5);
  }
}
