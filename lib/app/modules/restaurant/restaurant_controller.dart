import 'package:coffee_tracker/app/modules/restaurant/sort_by.dart';
import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/storage_repository_interface.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/media_cache.dart';
import 'package:coffee_tracker/app/utils/connection_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'search_delegate/restaurant_search.dart';

part 'restaurant_controller.g.dart';

@Injectable()
class RestaurantController = _RestaurantControllerBase
    with _$RestaurantController;

abstract class _RestaurantControllerBase with Store {
  _RestaurantControllerBase() {
    storage = Modular.get();
    mediaCache = Modular.get();
    loadData();
  }

  MediaCache mediaCache;
  IStorageRepository storage;

  RestaurantSearch searchDelegate;

  @observable
  ObservableList<RestaurantModel> restaurants;

  @observable
  bool isLoading;

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
    }
  }

  @action
  Future<void> loadData() async {
    isLoading = true;

    print('load');

    restaurants = ObservableList<RestaurantModel>();

    restaurants.addAll(await storage.getAllRestaurants());
    searchDelegate = RestaurantSearch(controller: this);

    restaurants
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    await mediaCache.loadCache();

    isLoading = false;
  }

  @action
  void showDetails({@required RestaurantModel restaurant}) {
    Modular.to.pushNamed('restaurant/details', arguments: restaurant);
  }

  @action
  Future<void> addRestaurant() async {
    try {
      if (await CheckConnection.checkConnection())
        Modular.to.pushNamed('restaurant/edit', arguments: null);
    } on PlatformException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }
}
