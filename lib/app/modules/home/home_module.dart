import 'package:coffee_tracker/app/modules/login/login_page.dart';
import 'package:coffee_tracker/app/shared/guards/auth_guard.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_content/home_content_controller.dart';
import 'home_controller.dart';
import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [$HomeContentController, $HomeController];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/',
            child: (_, args) => HomePage(), guards: [AuthGuard()]),
        ModularRouter('/login',
            child: (_, args) => LoginPage(), guards: [AuthGuard()]),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
