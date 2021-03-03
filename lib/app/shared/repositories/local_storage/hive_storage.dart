import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';

import 'interfaces/preferences_storage_interface.dart';

@Injectable()
class HiveStorage implements ILocalStorage {
  static const PREFERENCES_BOX = 'preferences';
  static const COURSES_BOX = 'courses';
  static const TASKS_BOX = 'tasks';
  static const PROFILE_BOX = 'profile';
  static const HISTORY_BOX = 'history';
  static const IMAGE_BOX = 'images';

  Stream<bool> get onThemeChanged => Hive.box(PREFERENCES_BOX)
      .watch(key: 'themeMode')
      .map((e) => e.value ?? false);

  Future<void> clearData() async {
    print('> HiveStorage: clear data');

    await Hive.box(PREFERENCES_BOX).clear();
    await Hive.box(COURSES_BOX).clear();
    await Hive.box(TASKS_BOX).clear();
    await Hive.box(PROFILE_BOX).clear();
    await Hive.box(HISTORY_BOX).clear();
    await Hive.box(IMAGE_BOX).clear();

    print('> HiveStorage: data deleted');
  }

  Future<void> dispose() async {
    await Hive.box(PREFERENCES_BOX).close();
    await Hive.box(COURSES_BOX).close();
    await Hive.box(TASKS_BOX).close();
    await Hive.box(PROFILE_BOX).close();
    await Hive.box(HISTORY_BOX).close();
    await Hive.box(IMAGE_BOX).close();
  }

  bool isDarkTheme() {
    return Hive.box(PREFERENCES_BOX).get('themeMode', defaultValue: false);
  }

  String loadCache() {
    return Hive.box(IMAGE_BOX).get('cache', defaultValue: '');
  }

  String loadImageAsString(String key) {
    return Hive.box(IMAGE_BOX).get(key);
  }

  void removeAllImages() {
    Hive.box(IMAGE_BOX).clear();
  }

  Future<void> removeImageIfExist(String key) async {
    await Hive.box(IMAGE_BOX).delete(key);
  }

  Future<void> saveCache(String value) async {
    await Hive.box(IMAGE_BOX).put('cache', value);
  }

  Future<void> saveRestaurantImage(String id, String value) async {
    await Hive.box(IMAGE_BOX).put(id, value);
  }

  @override
  Future<void> saveProfileImage(String value) async {
    await Hive.box(IMAGE_BOX).put('profile', value);
  }

  Future<void> setDarkTheme(bool value) async {
    await Hive.box(PREFERENCES_BOX).put('themeMode', value);
  }

  static Future<void> initDatabase() async {
    await Hive.openBox(PREFERENCES_BOX);
    await Hive.openBox(COURSES_BOX);
    await Hive.openBox(TASKS_BOX);
    await Hive.openBox(PROFILE_BOX);
    await Hive.openBox(HISTORY_BOX);
    await Hive.openBox(IMAGE_BOX);
  }
}
