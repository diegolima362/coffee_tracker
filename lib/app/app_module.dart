import 'package:coffee_tracker/app/modules/landing/landing_module.dart';
import 'package:coffee_tracker/app/modules/restaurant/restaurant_module.dart';
import 'package:coffee_tracker/app/shared/guards/auth_guard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'modules/home/home_module.dart';
import 'modules/login/login_module.dart';
import 'modules/review/review_module.dart';
import 'shared/auth/auth_controller.dart';
import 'shared/auth/repositories/firebase_auth_repository.dart';
import 'shared/repositories/local_storage/shared_preferences_storage.dart';
import 'shared/repositories/storage/firebase_media_storage_repository.dart';
import 'shared/repositories/storage/firestore_storage_repository.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $AppController,
        $FireStoreStorageRepository,
        $FirebaseStorage,
        $FirebaseAuthRepository,
        $AuthController,
        $SharedPreferencesStorage,
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
