import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:flutter/services.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  AuthController auth = Modular.get();

  @observable
  bool loading = false;

  @action
  Future loginWithGoogle() async {
    try {
      loading = true;
      await auth.loginWithGoogle();
      if (auth.status == AuthStatus.loggedOn)
        Modular.to.pushReplacementNamed('/home');
    } on PlatformException {
      loading = false;
      rethrow;
    } catch (e) {
      loading = false;
      print(e);
    }
  }

  @action
  void loginWithEmail() {
    Modular.to.pushReplacementNamed('/login/email_sign_in', arguments: auth);
  }
}
