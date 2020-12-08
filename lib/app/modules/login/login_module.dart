import 'package:coffee_tracker/app/modules/login/email_sign_in/sign_in_form.dart';
import 'package:coffee_tracker/app/modules/login/password_reset_form/password_reset_form.dart';
import 'package:coffee_tracker/app/shared/guards/auth_guard.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login_controller.dart';
import 'login_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [$LoginController];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(
          '/',
          child: (_, args) => LoginPage(),
          guards: [AuthGuard()],
        ),
        ModularRouter('/email_sign_in',
            child: (_, args) => SignInForm(), guards: [AuthGuard()]),
        ModularRouter(
          '/reset_password',
          child: (_, args) => PasswordResetForm(),
          guards: [AuthGuard()],
        ),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
