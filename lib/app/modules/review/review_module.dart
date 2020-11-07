import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'review_controller.dart';
import 'review_page.dart';

class ReviewModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind((i) => ReviewController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => ReviewPage()),
      ];

  static Inject get to => Inject<ReviewModule>.of();

  Widget get view => ReviewPage();
}
