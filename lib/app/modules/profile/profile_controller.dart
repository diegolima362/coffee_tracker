import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:coffee_tracker/app/shared/models/user_model.dart';
import 'package:coffee_tracker/app/shared/repositories/local_storage/interfaces/preferences_storage_interface.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/media_storage_repository_interface.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/storage_repository_interface.dart';
import 'package:coffee_tracker/app/utils/connection_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../app_controller.dart';

part 'profile_controller.g.dart';

@Injectable()
class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  _ProfileControllerBase() {
    final AuthController auth = Modular.get();
    mediaStorage = Modular.get();
    darkThemePreference = Modular.get();

    user = auth.user;

    _loadTheme();
    _checkConnection();
  }

  ILocalStorage darkThemePreference;

  IMediaStorageRepository mediaStorage;

  @observable
  UserModel user;

  @observable
  bool isOffline;

  @observable
  bool dark;

  @action
  Future<void> logout() async {
    await _clearData();

    await Modular.get<AuthController>().signOut();
    Modular.to.pushReplacementNamed('/login');
  }

  Future<void> _clearData() async {
    mediaStorage.flushCache();
    mediaStorage.dispose();

    Modular.get<IStorageRepository>().flushCache();

    await setDark(false);
    await darkThemePreference.clearData();
    darkThemePreference.dispose();
  }

  @action
  void setOffline(bool value) {
    isOffline = value;
  }

  @action
  Future<void> setDark(bool value) async {
    dark = value;
    await darkThemePreference.setDarkTheme(dark);
    await Modular.get<AppController>().loadTheme();
  }

  Future<void> _checkConnection() async {
    try {
      CheckConnection.checkConnection().then((value) => setOffline(value));
    } on PlatformException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  void _loadTheme() {
    setDark(Modular.get<AppController>().isDark);
    try {
      darkThemePreference.isDarkTheme().then((value) => setDark(value));
    } on PlatformException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }
}
