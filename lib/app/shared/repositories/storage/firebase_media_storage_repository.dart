import 'dart:convert';
import 'dart:typed_data';

import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:coffee_tracker/app/shared/models/media_info.dart';
import 'package:coffee_tracker/app/shared/models/user_model.dart';
import 'package:coffee_tracker/app/shared/repositories/local_storage/interfaces/preferences_storage_interface.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_modular/flutter_modular.dart';

import 'interfaces/media_storage_repository_interface.dart';

@Injectable()
class FirebaseStorage implements IMediaStorageRepository {
  UserModel _user;

  Map<String, MediaInfo> _cache;

  ILocalStorage _storage;

  FirebaseStorage() {
    _user = Modular.get<AuthController>().user;

    _storage = Modular.get();

    final auth = Modular.get<AuthController>();
    auth.onAuthStateChanged.listen((u) {
      _user = u;
      if (auth.status == AuthStatus.loggedOut)
        flushCache();
      else
        loadCache();
    });

    loadCache();
  }

  int get numberOfNotSynced {
    int pending = 0;
    for (MediaInfo mi in _cache.values) if (!mi.synced) pending++;
    return pending;
  }

  int get numberOfPhotos => _cache.keys.length;

  int get storageUsage {
    int s = 0;
    for (MediaInfo mi in _cache.values) s += mi.size;
    return s;
  }

  void deleteRestaurantImage({String photoId, String restaurantId}) {
    if (_cache.containsKey(photoId)) {
      final uid = _user.id;

      final ref = firebase_storage.FirebaseStorage.instance
          .ref('users/$uid/restaurants/$photoId.jpg');

      try {
        _cache.remove(photoId);

        Future.wait([
          _storage.removeImageIfExist(photoId),
          ref.delete(),
        ]);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void dispose() {
    print('> dispose media cache');
  }

  Future<Uint8List> _fetchRemoteRestaurantImage(String restaurantId) async {
    try {
      return await firebase_storage.FirebaseStorage.instance
          .ref('users/${_user.id}/restaurants/')
          .child('$restaurantId.jpg')
          .getData(10000000);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<Uint8List> fetchRestaurantImage(
      {String restaurantId, String photoId}) {
    return _fetch(restaurantId, 1, photoId);
  }

  void flushCache() {
    _cache.clear();

    _storage.removeAllImages();
  }

  void loadCache() {
    _cache = {};

    final data = _storage.loadCache();

    if (data.isNotEmpty) {
      Map<String, dynamic> map = json.decode(data);
      map.forEach((key, value) => _cache[key] = MediaInfo.fromMap(value));
    }

    return;
  }

  void persistRestaurantImage({String restaurantId, Uint8List file}) {
    _add(restaurantId, file, 1, 'image/jpeg');
  }

  Future<void> synchronize() async {
    _synchronizeImage();
  }

  Future<void> _add(
    String restaurantId,
    Uint8List file,
    int source,
    String type,
  ) async {
    await _storage.removeImageIfExist(restaurantId);

    await _storage.saveRestaurantImage(restaurantId, base64Encode(file));

    _cache[restaurantId] = MediaInfo(
      id: restaurantId,
      source: source,
      restaurantId: restaurantId,
      size: file.elementSizeInBytes,
      accessed: DateTime.now(),
      type: type,
      synced: false,
    );

    _saveCache();
    synchronize();
  }

  Future<Uint8List> _fetch(String restaurantId, int source, String id) async {
    if (_cache.containsKey(id)) {
      String _image = _storage.loadImageAsString(restaurantId);
      Uint8List file;

      if (_image != null) {
        _cache[id].accessed = DateTime.now();
        file = Uint8List.fromList(base64Decode(_image));
      } else {
        _cache.remove(id);
      }

      _saveCache();

      return file;
    } else {
      final data = await _fetchRemoteRestaurantImage(restaurantId);

      if (data != null) {
        _cache[id] = MediaInfo(
          id: id,
          source: source,
          restaurantId: restaurantId,
          type: 'image/jpeg',
          size: data.elementSizeInBytes,
          accessed: DateTime.now(),
          synced: true,
        );

        await Future.wait([
          _storage.saveRestaurantImage(
            restaurantId,
            base64Encode(data),
          ),
        ]);
        _saveCache();
      }

      return data;
    }
  }

  MediaInfo _getNotSynced() {
    for (MediaInfo mi in _cache.values) if (!mi.synced) return mi;
    return null;
  }

  Future<void> _saveCache() async {
    Map<String, dynamic> tmp = {};

    _cache.forEach((key, value) {
      tmp[key] = value.toMap();
    });

    final data = jsonEncode(tmp);

    await _storage.saveCache(data);
  }

  Future<void> _synchronizeImage() async {
    MediaInfo mediaInfo = _getNotSynced();

    if (mediaInfo != null) {
      final data = await fetchRestaurantImage(
        restaurantId: mediaInfo.restaurantId,
        photoId: mediaInfo.id,
      );

      final storage = firebase_storage.FirebaseStorage.instance;

      final uid = _user.id;

      final imagePath = mediaInfo.source == 0
          ? 'users/${mediaInfo.id}.jpg'
          : 'users/$uid/restaurants/${mediaInfo.id}.jpg';

      final imageRef = storage.ref().child(imagePath);

      try {
        final uploadTask = imageRef.putData(data);
        await uploadTask.whenComplete(() {
          if (_cache.containsKey(mediaInfo.id)) {
            _cache[mediaInfo.id].accessed = DateTime.now();
            _cache[mediaInfo.id].synced = true;
            _saveCache();
            _synchronizeImage();
          }
        });
      } catch (error) {
        print('> upload error: $error');
      }
    }
  }

  Uint8List _profilePhoto;

  @override
  Future<Uint8List> fetchProfileImage() async {
    if (_profilePhoto != null) {
      return _profilePhoto;
    }

    String _image = _storage.loadImageAsString('profile');

    if (_image != null) {
      _profilePhoto = Uint8List.fromList(base64Decode(_image));

      return _profilePhoto;
    }

    try {
      _profilePhoto = await firebase_storage.FirebaseStorage.instance
          .ref('users/${_user.id}/profile/')
          .child('avatar.jpg')
          .getData(10000000);

      if (_profilePhoto != null)
        _storage.saveProfileImage(
          base64Encode(_profilePhoto),
        );

      return _profilePhoto;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
