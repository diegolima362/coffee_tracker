import 'dart:convert';
import 'dart:io';

import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:coffee_tracker/app/shared/models/media_info.dart';
import 'package:coffee_tracker/app/shared/models/user_model.dart';
import 'package:coffee_tracker/app/utils/connection_state.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:path_provider/path_provider.dart';

import 'interfaces/media_storage_repository_interface.dart';

part 'firebase_media_storage_repository.g.dart';

@Injectable()
class FirebaseStorage implements IMediaStorageRepository {
  FirebaseStorage() {
    _user = Modular.get<AuthController>().user;
    Modular.get<AuthController>().onAuthStateChanged.listen((u) {
      _user = u;
      if (u == null)
        flushCache();
      else
        loadCache();
    });

    loadCache();
  }

  UserModel _user;

  Directory _tempDir;
  Directory _docsDir;
  Directory _imagesDir;
  Directory _cachePath;
  File _cacheFile;
  Map<String, MediaInfo> _cache;

  String getFullPath(String id) => '${_imagesDir.path}/$id.jpg';

  int get numberOfPhotos => _cache.keys.length;

  int get numberOfNotSynced {
    int pending = 0;
    for (MediaInfo mi in _cache.values) if (!mi.synced) pending++;
    return pending;
  }

  int get storageUsage {
    int s = 0;
    for (MediaInfo mi in _cache.values) s += mi.size;
    return s;
  }

  Future<void> loadCache() async {
    print('> loading cache ...');

    _tempDir = await getTemporaryDirectory();
    _docsDir = await getApplicationDocumentsDirectory();
    _imagesDir = Directory('${_docsDir.path}/mediacache/images');
    _cachePath = Directory('${_docsDir.path}/mediacache');

    _cache = {};

    if (!_cachePath.existsSync()) {
      _cachePath.createSync();
      print('> create cache path: ${_cachePath.path}');
    }

    if (!_imagesDir.existsSync()) {
      _imagesDir.createSync();
      print('> create images path: ${_imagesDir.path}');
    }

    _cacheFile = File('${_cachePath.path}/cache.json');

    if (_cacheFile.existsSync()) {
      String contents = await _cacheFile.readAsString();
      Map<String, dynamic> data = json.decode(contents);

      data.forEach((key, value) => _cache[key] = MediaInfo.fromMap(value));
    } else {
      this._saveCache();
    }
    return;
  }

  Future<Image> fetchRestaurantImage({String restaurantId, String photoId}) {
    return _fetch(restaurantId, 1, photoId);
  }

  void persistRestaurantImage({String restaurantId, File file}) {
    _add(restaurantId, file, 1, 'image/jpeg');
  }

  void deleteRestaurantImage({String photoId, String restaurantId}) {
    print('> file ${_imagesDir.path}/$photoId.jpg');

    if (_cache.containsKey(photoId)) {
      final file = File('${_imagesDir.path}/$photoId');

      final uid = _user.id;

      final ref = firebase_storage.FirebaseStorage.instance
          .ref('users/$uid/restaurants/$photoId.jpg');

      try {
        final deleteTask = ref.delete();
        deleteTask.whenComplete(() {
          print('> delete succeeded');
          if (_cache.containsKey(photoId)) {
            _cache.remove(photoId);
            if (file.existsSync()) file.deleteSync();
            loadCache();
          }
        });
      } catch (e) {
        print(e);
      }
    }
  }

  Future<void> synchronize() async {
    print('> synchronizing the cache...');
    if (await CheckConnection.checkConnection())
      _synchronizeImage();
    else
      print('> offline');
  }

  void flushCache() {
    print('> flush cache');

    if (_tempDir.existsSync()) {
      _tempDir.deleteSync(recursive: true);
    }

    if (_imagesDir.existsSync()) {
      _imagesDir.deleteSync(recursive: true);
    }

    if (_cachePath.existsSync()) {
      _cachePath.deleteSync(recursive: true);
    }

    _cache.clear();
    print('> cache clear');
  }

  void _saveCache() {
    Map<String, dynamic> tmp = {};

    _cache.forEach((key, value) {
      tmp[key] = value.toMap();
    });
    _cacheFile.writeAsStringSync(jsonEncode(tmp));
  }

  Future<Image> _fetch(String restaurantId, int source, String id) async {
    File file = File('${_imagesDir.path}/$id.jpg');

    print('> fetch file: ${_imagesDir.path}/$id.jpg');

    if (file.existsSync()) {
      print('> file exists');
      if (_cache.containsKey(id)) {
        _cache[id].accessed = DateTime.now();
      } else {
        _cache[id] = MediaInfo(
          id: id,
          source: source,
          restaurantId: restaurantId,
          type: 'image/jpeg',
          size: await file.length(),
          accessed: DateTime.now(),
          synced: true,
        );
      }
      return Image.file(file, fit: BoxFit.cover);
    } else {
      print('> file not exists');

      try {
        final uid = _user.id;
        print('> get on firebase: ${'users/$uid/restaurants/$id.jpg'}');

        await firebase_storage.FirebaseStorage.instance
            .ref('users/$uid/restaurants/')
            .child('$id.jpg')
            .writeToFile(file);
      } catch (e) {
        print(e);
      }

      _cache[id] = MediaInfo(
        id: id,
        source: source,
        restaurantId: restaurantId,
        type: 'image/jpeg',
        size: await file.length(),
        accessed: DateTime.now(),
        synced: true,
      );

      this._saveCache();
      this.loadCache();

      return Image.file(file, fit: BoxFit.cover);
    }
  }

  Future<void> _add(
    String restaurantId,
    File file,
    int source,
    String type,
  ) async {
    print('> saving image');

    final t = File('${_imagesDir.path}/$restaurantId.jpg');

    if (t.existsSync()) {
      print('> delete local file');
      t.deleteSync();
      loadCache();
    }

    final size = file.lengthSync();

    print('> file: ${_imagesDir.path}/$restaurantId.jpg');
    file.copySync('${_imagesDir.path}/$restaurantId.jpg');

    file.deleteSync();

    _cache[restaurantId] = MediaInfo(
      id: restaurantId,
      source: source,
      restaurantId: restaurantId,
      size: size,
      accessed: DateTime.now(),
      type: type,
      synced: false,
    );

    _saveCache();
    synchronize();
  }

  MediaInfo _getNotSynced() {
    for (MediaInfo mi in _cache.values) if (!mi.synced) return mi;
    return null;
  }

  Future<void> _synchronizeImage() async {
    MediaInfo mediaInfo = _getNotSynced();

    if (mediaInfo != null) {
      print('> sync file: ${_imagesDir.path}/${mediaInfo.id}.jpg');

      final file = File('${_imagesDir.path}/${mediaInfo.id}.jpg');

      if (file.existsSync()) {
        print('> exists');
      } else {
        print('> not exists');
      }

      final storage = firebase_storage.FirebaseStorage.instance;

      final uid = _user.id;

      final imagePath = mediaInfo.source == 0
          ? 'users/${mediaInfo.id}.jpg'
          : 'users/$uid/restaurants/${mediaInfo.id}.jpg';

      final imageRef = storage.ref().child(imagePath);

      try {
        final uploadTask = imageRef.putFile(file);
        print('> trying to upload...');
        await uploadTask.whenComplete(() {
          if (_cache.containsKey(mediaInfo.id)) {
            _cache[mediaInfo.id].accessed = DateTime.now();
            _cache[mediaInfo.id].synced = true;
            print('> upload succeeded');
            _saveCache();
            _synchronizeImage();
          }
        });
      } catch (error) {
        print('> upload error: $error');
      }
    }

    print('> done synchronizing');
  }

  @override
  void dispose() {
    print('> dispose media cache');
  }
}
