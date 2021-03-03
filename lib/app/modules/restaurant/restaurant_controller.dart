import 'package:coffee_tracker/app/modules/restaurant/sort_by.dart';
import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/media_storage_repository_interface.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/storage_repository_interface.dart';
import 'package:coffee_tracker/app/utils/connection_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'restaurant_controller.g.dart';

@Injectable()
class RestaurantController = _RestaurantControllerBase
    with _$RestaurantController;

abstract class _RestaurantControllerBase with Store {
  IMediaStorageRepository mediaStorage;

  IStorageRepository storage;

  @observable
  ObservableList<RestaurantModel> restaurants;

  @observable
  bool isLoading;

  @observable
  String filter = '';

  _RestaurantControllerBase() {
    storage = Modular.get();

    mediaStorage = Modular.get();

    loadData();
  }

  @action
  Future<void> addRestaurant() async {
    try {
      if (kIsWeb || await CheckConnection.checkConnection())
        Modular.to.pushNamed('/restaurants/edit', arguments: null);
    } on PlatformException {
      rethrow;
    } catch (error) {
      print(error);
    }
  }

  @action
  Future<void> loadData() async {
    isLoading = true;

    restaurants = ObservableList<RestaurantModel>();

    restaurants.addAll(await storage.getAllRestaurants());

    restaurants
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    mediaStorage.loadCache();

    isLoading = false;
  }

  @action
  void showDetails(RestaurantModel restaurant) {
    Modular.to.pushNamed('/restaurants/details', arguments: restaurant);
  }

  @action
  void setFilter(String value) {
    filter = value;
  }

  @action
  void sortBy(SortBy value) {
    if (restaurants == null || restaurants.isEmpty) return;
    if (value == SortBy.ALPHABETIC) {
      restaurants
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    } else if (value == SortBy.RATE) {
      restaurants.sort((a, b) => b.rate.compareTo(a.rate));
    } else if (value == SortBy.CITY) {
      restaurants
          .sort((a, b) => a.city.toLowerCase().compareTo(b.city.toLowerCase()));
    } else if (value == SortBy.DATE) {
      restaurants.sort((a, b) => a.registerDate.compareTo(b.registerDate));
    } else if (value == SortBy.NUM_REVIEWS) {
      restaurants.sort((a, b) => b.totalVisits.compareTo(a.totalVisits));
    }
  }
}
