import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class IMediaStorageRepository implements Disposable {
  int get numberOfPhotos;

  int get numberOfNotSynced;

  int get storageUsage;

  String getFullPath(String photoId);

  Future<void> loadCache();

  Future<Image> fetchRestaurantImage({String restaurantId, String photoId});

  void persistRestaurantImage({String restaurantId, File file});

  void deleteRestaurantImage({String restaurantId, String photoId});

  Future<void> synchronize();

  void flushCache();
}
