import 'package:coffee_tracker/app/modules/home/home_module.dart';
import 'package:coffee_tracker/app/modules/login/login_module.dart';
import 'package:coffee_tracker/app/modules/profile/profile_module.dart';
import 'package:coffee_tracker/app/modules/restaurant/restaurant_module.dart';
import 'package:coffee_tracker/app/modules/review/review_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'landing_controller.dart';
import 'landing_page.dart';

class LandingModule extends ChildModule {
  @override
  List<Bind> get binds => [Bind((i) => LandingController())];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => LandingPage()),
        ModularRouter(
          '/login',
          module: LoginModule(),
          transition: TransitionType.noTransition,
        ),
        ModularRouter(
          '/home',
          module: HomeModule(),
          transition: TransitionType.noTransition,
        ),
        ModularRouter(
          '/restaurants',
          module: RestaurantModule(),
          transition: TransitionType.noTransition,
        ),
        ModularRouter(
          '/reviews',
          module: ReviewModule(),
          transition: TransitionType.noTransition,
        ),
        ModularRouter(
          '/profile',
          module: ProfileModule(),
          transition: TransitionType.noTransition,
        ),
      ];

  static Inject get to => Inject<LandingModule>.of();
}
