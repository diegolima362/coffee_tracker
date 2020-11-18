import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'restaurant_details_controller.g.dart';

@Injectable()
class RestaurantDetailsController = _RestaurantDetailsControllerBase
    with _$RestaurantDetailController;

abstract class _RestaurantDetailsControllerBase with Store {
  @observable
  RestaurantModel restaurant;
}
