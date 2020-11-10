import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/repositories/local_storage/local_storage_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'search_delegate/restaurant_search.dart';

part 'restaurant_controller.g.dart';

@Injectable()
class RestaurantController = _RestaurantControllerBase
    with _$RestaurantController;

abstract class _RestaurantControllerBase with Store {
  _RestaurantControllerBase() {
    _loadData();
  }

  RestaurantSearch searchDelegate;

  @observable
  List<RestaurantModel> restaurants;

  @observable
  bool isDark;

  @action
  Future<void> _loadData() async {
    final ILocalStorage storage = Modular.get();
    isDark = await storage.isDarkMode;
    restaurants = await storage.getAllRestaurants();
    searchDelegate = RestaurantSearch(controller: this);
  }

  @computed
  Future<List<RestaurantModel>> get allRestaurants async {
    if (restaurants == null) {
      final ILocalStorage storage = Modular.get();
      restaurants = await storage.getAllRestaurants();
    }

    restaurants.sort((a, b) => a.name.compareTo(b.name));

    return restaurants;
  }

  @action
  void showDetails({@required RestaurantModel restaurant}) {
    Modular.to.pushNamed('/restaurant/detail', arguments: restaurant);
  }
}
