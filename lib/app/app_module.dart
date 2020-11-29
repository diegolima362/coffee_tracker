import 'package:coffee_tracker/app/modules/landing/landing_module.dart';
import 'package:coffee_tracker/app/modules/restaurant/restaurant_module.dart';
import 'package:coffee_tracker/app/shared/guards/auth_guard.dart';
import 'package:coffee_tracker/app/shared/repositories/preferences/theme_preferences.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/media_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'modules/home/home_module.dart';
import 'modules/login/login_module.dart';
import 'modules/review/review_module.dart';
import 'shared/auth/auth_controller.dart';
import 'shared/auth/repositories/auth_repository.dart';
import 'shared/repositories/storage/firestore_storage_repository.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $AppController,
        $FireStoreStorageRepository,
        Bind(
          (i) => AuthRepository(),
          singleton: true,
          lazy: true,
        ),
        Bind(
          (i) => AuthController(),
          singleton: true,
          lazy: true,
        ),
        Bind(
          (i) => MediaCache(),
          singleton: true,
          lazy: true,
        ),
        Bind(
          (i) => DarkThemePreference(),
          singleton: true,
          lazy: true,
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          '/',
          module: LandingModule(),
          transition: TransitionType.noTransition,
        ),
        ModularRouter(
          '/login',
          module: LoginModule(),
          transition: TransitionType.noTransition,
          guards: [AuthGuard()],
        ),
        ModularRouter(
          '/home',
          module: HomeModule(),
          transition: TransitionType.noTransition,
          guards: [AuthGuard()],
        ),
        ModularRouter(
          '/restaurant',
          module: RestaurantModule(),
          transition: TransitionType.noTransition,
          guards: [AuthGuard()],
        ),
        ModularRouter(
          '/review',
          module: ReviewModule(),
          transition: TransitionType.noTransition,
          guards: [AuthGuard()],
        ),
      ];

  @override
  Widget get bootstrap => AppWidget(controller: to.get());

  static Inject get to => Inject<AppModule>.of();
}
