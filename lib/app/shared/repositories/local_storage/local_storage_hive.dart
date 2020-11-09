import 'dart:async';

import 'package:coffee_tracker/app/shared/models/restaurant_model.dart';
import 'package:coffee_tracker/app/shared/models/review_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'local_storage_interface.dart';

class BoxesName {
  static const PREFERENCES_BOX = 'preferences';
  static const LOGIN_BOX = 'login';
  static const RESTAURANTS_BOX = 'restaurants';
  static const REVIEWS_BOX = 'reviews';
  static const PROFILE_BOX = 'profile';
}

class LocalStorageHive implements ILocalStorage {
  Completer<Box> _instance = Completer<Box>();

  _init() async {
    var dir = await path_provider.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    var box = await Hive.openBox(BoxesName.PREFERENCES_BOX);
    _instance.complete(box);
  }

  LocalStorageHive() {
    _init();
  }

  @override
  Future<bool> get isDarkMode async {
    var box = await _instance.future;
    return box.get('isDark', defaultValue: false);
  }

  @override
  Future<void> setDarkMode(bool isDark) async {
    var box = await _instance.future;
    box.put('isDark', isDark);

    print(box.get('isDark'));
  }

  @override
  Future<List<RestaurantModel>> getAllRestaurants() {
    // TODO: implement getAllRestaurants
    throw UnimplementedError();
  }

  @override
  Future<List<ReviewModel>> getAllReviews() {
    // TODO: implement getAllReviews
    throw UnimplementedError();
  }
}
