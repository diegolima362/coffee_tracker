import 'package:coffee_tracker/app/modules/restaurant/edit/edit_controller.dart';
import 'package:coffee_tracker/app/modules/restaurant/edit/edit_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'restaurant_controller.dart';
import 'restaurant_details/restaurant_details_controller.dart';
import 'restaurant_details/restaurant_details_page.dart';
import 'restaurant_page.dart';

class RestaurantModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind((i) => EditController()),
        Bind((i) => RestaurantDetailsController()),
        Bind((i) => RestaurantController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => RestaurantPage()),
        ModularRouter('/details', child: (_, args) => RestaurantDetailsPage()),
        ModularRouter('/edit', child: (_, args) => EditPage()),
      ];

  static Inject get to => Inject<RestaurantModule>.of();

  Widget get view => RestaurantPage();
}
