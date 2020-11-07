import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'restaurant_controller.g.dart';

@Injectable()
class RestaurantController = _RestaurantControllerBase
    with _$RestaurantController;

abstract class _RestaurantControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
