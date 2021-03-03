import 'package:coffee_tracker/app/modules/review/edit/edit_page.dart';
import 'package:coffee_tracker/app/modules/review/review_details/review_details_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'edit/edit_controller.dart';
import 'review_controller.dart';
import 'review_details/review_details_page.dart';
import 'review_page.dart';

class ReviewModule extends WidgetModule {
  @override
  List<Bind> get binds => [
        Bind((i) => EditController()),
        Bind((i) => ReviewController()),
        Bind((i) => ReviewDetailsController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => ReviewPage()),
        ModularRouter('details', child: (_, args) => ReviewDetailsPage()),
        ModularRouter('edit', child: (_, args) => EditPage()),
        ModularRouter('create', child: (_, args) => EditPage()),
      ];

  static Inject get to => Inject<ReviewModule>.of();

  Widget get view => ReviewPage();
}
