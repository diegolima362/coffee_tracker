
import 'package:flutter_modular/flutter_modular.dart';

abstract class ILocalStorage implements Disposable {
  Stream<bool> get onThemeChanged;

  Future<void> clearData();

  bool isDarkTheme();

  String loadCache();

  String loadImageAsString(String key);

  void removeAllImages();

  Future<void> removeImageIfExist(String key);

  Future<void> saveCache(String value);

  Future<void> saveRestaurantImage(String id, String value);

  Future<void> setDarkTheme(bool value);

  Future<void> saveProfileImage(String value);
}
