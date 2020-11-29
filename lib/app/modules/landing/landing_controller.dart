import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'landing_controller.g.dart';

@Injectable()
class LandingController = _LandingControllerBase with _$LandingController;

abstract class _LandingControllerBase with Store {
  _LandingControllerBase() {
    final auth = Modular.get<AuthController>();

    auth.onAuthStateChanged.listen((e) {
      if (e == null) {
        goToLogin();
      } else {
        goToHome();
      }
    });
  }

  @action
  void goToHome() {
    Modular.to.pushReplacementNamed('/home');
  }

  @action
  void goToLogin() {
    Modular.to.pushReplacementNamed('/login');
  }
}
