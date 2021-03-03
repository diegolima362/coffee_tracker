import 'dart:typed_data';

import 'package:flutter_modular/flutter_modular.dart';

abstract class IMediaStorageRepository implements Disposable {
  int get numberOfNotSynced;

  int get numberOfPhotos;

  int get storageUsage;

  void deleteRestaurantImage({String restaurantId, String photoId});

  Future<Uint8List> fetchRestaurantImage({String restaurantId, String photoId});

  void flushCache();

  void loadCache();

  void persistRestaurantImage({String restaurantId, Uint8List file});

  Future<void> synchronize();

  Future<Uint8List> fetchProfileImage();
}
