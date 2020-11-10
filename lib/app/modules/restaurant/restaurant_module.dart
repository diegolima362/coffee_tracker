import 'package:coffee_tracker/app/modules/restaurant/restaurant_detail/restaurant_detail_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'restaurant_controller.dart';
import 'restaurant_detail/restaurant_detail_controller.dart';
import 'restaurant_page.dart';

class RestaurantModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind((i) => RestaurantDetailController()),
        Bind((i) => RestaurantController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => RestaurantPage()),
        ModularRouter('/detail',
            child: (_, args) => RestaurantDetailPage(restaurant: args.data)),
      ];

  static Inject get to => Inject<RestaurantModule>.of();

  Widget get view => RestaurantPage();
}
