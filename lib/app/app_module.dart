import 'package:coffee_tracker/app/shared/repositories/local_storage/local_storage_mock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'modules/home/home_module.dart';
import 'modules/landing/landing_page.dart';
import 'modules/login/login_module.dart';
import 'modules/settings/settings_module.dart';
import 'shared/auth/auth_controller.dart';
import 'shared/auth/repositories/auth_repository.dart';
import 'shared/repositories/storage/storage_repository.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => StorageRepository()),
        Bind((i) => LocalStorageMock()),
        Bind((i) => AuthRepository()),
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
        ModularRouter('/settings', module: SettingsModule()),
      ];

  @override
  Widget get bootstrap => AppWidget(controller: to.get());

  static Inject get to => Inject<AppModule>.of();
}
