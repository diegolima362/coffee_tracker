import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  AuthController auth = Modular.get();

  @observable
  bool loading = false;

  @action
  Future loginWithGoogle() async {
    loading = true;

    try {
      await auth.signInWithGoogle();

      loading = false;

      if (auth.status == AuthStatus.loggedOn) {
        Modular.to.pushReplacementNamed('/home');
      }
    } on PlatformException {
      loading = false;
      rethrow;
    } catch (e) {
      loading = false;
      rethrow;
    }
  }

  @action
  void loginWithEmail() {
    Modular.to.pushReplacementNamed('/login/email_sign_in', arguments: auth);
  }
}
