import 'package:coffee_tracker/app/shared/repositories/preferences/theme_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'app_controller.g.dart';

@Injectable()
class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  _AppControllerBase() {
    darkThemePreference = Modular.get();
    loadTheme();
  }

  DarkThemePreference darkThemePreference;

  @observable
  ThemeData themeType;

  @observable
  ThemeMode themeMode;

  @computed
  bool get isDark => themeType.brightness == Brightness.dark;

  @action
  Future<void> loadTheme() async {
    final prefs = await darkThemePreference.getTheme();

    if (prefs) {
      themeType = ThemeData.dark();
      themeMode = ThemeMode.dark;
    } else {
      themeType = ThemeData.light();
      themeMode = ThemeMode.light;
    }
  }
}
