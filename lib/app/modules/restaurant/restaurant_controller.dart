import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/repositories/local_storage/local_storage_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'restaurant_controller.g.dart';

@Injectable()
class RestaurantController = _RestaurantControllerBase
    with _$RestaurantController;

abstract class _RestaurantControllerBase with Store {
  _RestaurantControllerBase() {
    _loadRestaurants();
  }

  @observable
  List<RestaurantModel> _restaurants;

  @action
  Future<void> _loadRestaurants() async {
    final ILocalStorage storage = Modular.get();
    _restaurants = await storage.getAllRestaurants();
  }

  @computed
  Future<List<RestaurantModel>> get restaurants async {
    if (_restaurants == null) {
      final ILocalStorage storage = Modular.get();
      _restaurants = await storage.getAllRestaurants();
    }

    _restaurants.sort((a, b) => a.name.compareTo(b.name));

    return _restaurants;
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
