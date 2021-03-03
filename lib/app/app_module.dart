import 'package:coffee_tracker/app/modules/landing/landing_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';
import 'app_widget.dart';
import 'shared/auth/auth_controller.dart';
import 'shared/auth/repositories/firebase_auth_repository.dart';
import 'shared/repositories/local_storage/hive_storage.dart';
import 'shared/repositories/storage/firebase_media_storage_repository.dart';
import 'shared/repositories/storage/firestore_storage_repository.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AppController()),
        Bind((i) => FireStoreStorageRepository()),
        Bind((i) => FirebaseStorage()),
        Bind((i) => FirebaseAuthRepository()),
        Bind((i) => AuthController()),
        Bind((i) => HiveStorage()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          '/',
          module: LandingModule(),
          transition: TransitionType.noTransition,
        ),
      ];

  @override
  Widget get bootstrap => AppWidget(controller: to.get());

  static Inject get to => Inject<AppModule>.of();
}
