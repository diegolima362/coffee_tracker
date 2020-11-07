import 'package:coffee_tracker/app/modules/login/email_sign_in/sign_in_form.dart';
import 'package:coffee_tracker/app/modules/login/password_reset_form/password_reset_form.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login_controller.dart';
import 'login_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginController()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter('/', child: (_, args) => LoginPage()),
        ModularRouter('/email_sign_in', child: (_, args) => SignInForm()),
        ModularRouter('/email_sign_in/reset_password',
            child: (_, args) => PasswordResetForm()),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
