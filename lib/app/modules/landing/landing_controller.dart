import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:coffee_tracker/app/shared/models/user_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'landing_controller.g.dart';

@Injectable()
class LandingController = _LandingControllerBase with _$LandingController;

abstract class _LandingControllerBase with Store {
  _LandingControllerBase() {
    auth = Modular.get<AuthController>();

    auth.onAuthStateChanged.listen((UserModel user) {
      print('> authentication: ${auth.status == AuthStatus.loggedOn}');

      if (user != null) {
        if (auth.status == AuthStatus.loggedOn) {
          goToHome();
        } else if (auth.status == AuthStatus.loggedOut) {
          goToLogin();
        }
      } else {
        goToLogin();
      }
    });
  }

  AuthController auth;

  @action
  void goToHome() {
    Modular.to.pushReplacementNamed('/home');
  }

  @action
  void goToLogin() {
    Modular.to.pushReplacementNamed('/login');
  }
}
