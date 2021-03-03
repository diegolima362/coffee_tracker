import 'package:coffee_tracker/app/shared/repositories/local_storage/interfaces/preferences_storage_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

@Injectable()
class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  _AppControllerBase() {
    themeType = ThemeData.light();
    themeMode = ThemeMode.light;

    _localStorage = Modular.get();

    _localStorage.onThemeChanged.listen((e) => loadTheme());

    loadTheme();
  }

  ILocalStorage _localStorage;

  @observable
  ThemeData themeType;

  @observable
  ThemeMode themeMode;

  @computed
  bool get isDark => themeType.brightness == Brightness.dark;

  @action
  Future<void> loadTheme() async {
    final prefs = _localStorage.isDarkTheme();

    if (prefs) {
      themeType = ThemeData.dark();
      themeMode = ThemeMode.dark;
    } else {
      themeType = ThemeData.light();
      themeMode = ThemeMode.light;
    }
  }
}
