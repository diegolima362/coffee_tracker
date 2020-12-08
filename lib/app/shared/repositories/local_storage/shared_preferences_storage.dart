import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'interfaces/preferences_storage_interface.dart';

part 'shared_preferences_storage.g.dart';

@Injectable()
class SharedPreferencesStorage implements ILocalStorage {
  static const _THEME_STATUS = "THEME_STATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_THEME_STATUS, value);
  }

  Future<bool> isDarkTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_THEME_STATUS) ?? false;
  }

  Future<void> clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('> clearing data');
    await prefs.clear();
    print('> data cleared');
  }

  @override
  void dispose() {}
}
