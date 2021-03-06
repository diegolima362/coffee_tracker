import 'package:coffee_tracker/app/modules/profile/edit_profile.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'profile_controller.dart';
import 'profile_page.dart';

class ProfileModule extends WidgetModule {
  @override
  List<Bind> get binds => [Bind((i) => ProfileController())];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => ProfilePage()),
        ModularRouter('/edit', child: (_, args) => EditPage()),
      ];

  static Inject get to => Inject<ProfileModule>.of();

  Widget get view => ProfilePage();
}
