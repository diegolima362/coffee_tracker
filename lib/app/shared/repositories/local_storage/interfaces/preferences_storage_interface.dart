import 'package:flutter_modular/flutter_modular.dart';

abstract class ILocalStorage implements Disposable {
  setDarkTheme(bool value);

  Future<bool> isDarkTheme();

  Future<void> clearData();
}
