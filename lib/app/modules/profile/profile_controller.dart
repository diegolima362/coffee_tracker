import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:coffee_tracker/app/shared/repositories/preferences/theme_preferences.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/media_cache.dart';
import 'package:coffee_tracker/app/utils/connection_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    mediaCache = Modular.get();
    darkThemePreference = Modular.get();

    user = auth.user;

    _loadTheme();
    _checkConnection();
  }

  DarkThemePreference darkThemePreference;

  MediaCache mediaCache;

  @observable
  User user;

  @observable
  bool isOffline;

  @observable
  bool dark;

  @action
  Future<void> logout() async {
    await _clearData();

    await Modular.get<AuthController>().logout();
    Modular.to.pushReplacementNamed('/login');
  }

  Future<void> _clearData() async {
    mediaCache.flush();
    await darkThemePreference.clearData();
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
      darkThemePreference.getTheme().then((value) => setDark(value));
    } on PlatformException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }
}
