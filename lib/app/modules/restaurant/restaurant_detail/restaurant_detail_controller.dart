import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'restaurant_detail_controller.g.dart';

@Injectable()
class RestaurantDetailController = _RestaurantDetailControllerBase
    with _$RestaurantDetailController;

abstract class _RestaurantDetailControllerBase with Store {
  @observable
  RestaurantModel restaurant;
}
