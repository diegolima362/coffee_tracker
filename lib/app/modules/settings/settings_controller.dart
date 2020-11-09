import 'package:coffee_tracker/app/app_controller.dart';
import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:coffee_tracker/app/shared/repositories/local_storage/local_storage_interface.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'settings_controller.g.dart';

@Injectable()
class SettingsController = _SettingsControllerBase with _$SettingsController;

abstract class _SettingsControllerBase with Store {
  @observable
  bool dark = Modular.get<AppController>().isDark;

  @action
  Future<void> setDark(bool dark) async {
    this.dark = dark;
    final ILocalStorage storage = Modular.get();
    await storage.setDarkMode(dark);
    await Modular.get<AppController>().loadTheme();
  }

  @action
  Future<void> logout() async {
    await Modular.get<AuthController>().logout();
    Modular.to.pushReplacementNamed('/login');
  }

  @action
  void close() {
    Modular.navigator.popAndPushNamed('/home');
  }
}
