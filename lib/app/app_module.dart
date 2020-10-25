import 'package:coffee_tracker/app/modules/landing/landing_page.dart';
import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:coffee_tracker/app/shared/auth/repositories/auth_repository.dart';
import 'package:coffee_tracker/app/shared/auth/repositories/interfaces/auth_repository_interface.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/storage_repository_interface.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'modules/home/home_module.dart';
import 'modules/login/login_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind<IStorageRepository>((i) => StorageRepository()),
        Bind<IAuthRepository>((i) => AuthRepository()),
        Bind((i) => AuthController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => LandingPage()),
        ModularRouter(
          '/login',
          module: LoginModule(),
          transition: TransitionType.noTransition,
        ),
        ModularRouter('/home', module: HomeModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject.of();
}
