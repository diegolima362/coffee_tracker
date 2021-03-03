import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_content_controller.dart';
import 'home_content_page.dart';

class HomeContentModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        BindInject(
          (i) => HomeContentController(),
          singleton: true,
          lazy: true,
        ),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute,
            child: (_, args) => HomeContentPage()),
      ];

  static Inject get to => Inject<HomeContentModule>.of();

  @override
  Widget get view => HomeContentPage();
}
