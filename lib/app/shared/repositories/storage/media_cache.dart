import 'dart:convert';
import 'dart:io';

import 'package:coffee_tracker/app/utils/connection_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

class MediaInfo {
  String id;
  int source;
  String restaurantId;
  String type;
  int size;
  DateTime accessed;
  bool synced = false;

  MediaInfo({
    this.id,
    this.source,
    this.restaurantId,
    this.type,
    this.size,
    this.accessed,
    this.synced,
  });

  factory MediaInfo.fromJson(Map<String, dynamic> json) {
    return MediaInfo(
      id: json['id'],
      source: json['source'],
      restaurantId: json['restaurantId'],
      type: json['type'],
      size: json['size'],
      accessed: DateTime.fromMicrosecondsSinceEpoch(
          (json['accessed'] * 100000).toInt()),
      synced: json['synced'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'source': source,
        'restaurantId': restaurantId,
        'type': type,
        'size': size,
        'accessed': (accessed.microsecondsSinceEpoch / 100000.0),
        'synced': synced,
      };
}

class MediaCache {
  Directory _tempDir;
  Directory _docsDir;
  Directory cachePath;
  File cacheFile;

  Map<String, MediaInfo> cache;

  Directory get tempDir => _tempDir;

  Directory get docsDir => _docsDir;

  Future<void> loadCache() async {
    print('> loading cache ...');
    _tempDir = await getTemporaryDirectory();
    _docsDir = await getApplicationDocumentsDirectory();

    cache = {};

    cachePath = Directory('${docsDir.path}/mediacache');
    if (!cachePath.existsSync()) {
      cachePath.createSync();
    }
    print('> cache path: $cachePath');

    cacheFile = File('${cachePath.path}/cache.json');
    if (cacheFile.existsSync()) {
      String contents = await cacheFile.readAsString();
      Map<String, dynamic> data = json.decode(contents);

      data.forEach((key, value) {
        cache[key] = MediaInfo.fromJson(value);
      });
    } else {
      this.saveCache();
    }
    return;
  }

  void saveCache() {
    Map<String, dynamic> tmp = {};

    cache.forEach((key, value) {
      tmp[key] = value.toJson();
    });
    cacheFile.writeAsStringSync(jsonEncode(tmp));
  }

  Future<Image> _fetch(String id, int source, String restaurantId) async {
    File file = File('${cachePath.path}/$id');

    print('> fetch file: ${cachePath.path}/$id');

    if (file.existsSync()) {
      print('> file exists');
      if (cache.containsKey(id)) {
        cache[id].accessed = DateTime.now();
      }
      return Image.file(file, fit: BoxFit.cover);
    } else {
      print('> file not exists');

      try {
        final uid = FirebaseAuth.instance.currentUser.uid;
        print('> get on firebase: ${'users/$uid/restaurants/$id'}');

        await firebase_storage.FirebaseStorage.instance
            .ref('users/$uid/restaurants/')
            .child('$id')
            .writeToFile(file);
      } on firebase_core.FirebaseException catch (e) {
        print(e);
      }

      cache[id] = MediaInfo(
        id: id,
        source: source,
        restaurantId: restaurantId,
        type: 'image/jpeg',
        size: await file.length(),
        accessed: DateTime.now(),
        synced: true,
      );

      this.saveCache();

      return Image.file(file, fit: BoxFit.cover);
    }
  }

  Future<Image> fetchRestaurantImage(String id, String restaurantId) {
    return _fetch(id, 1, restaurantId);
  }

  Future<void> _add(
    String id,
    int source,
    String restaurantId,
    File file,
    String type,
  ) async {
    print('> saving image');

    int size = file.lengthSync();

    print('> file: ${cachePath.path}/$id');
    file.copySync('${cachePath.path}/$id');

    file.deleteSync();

    cache[id] = MediaInfo(
      id: id,
      source: source,
      restaurantId: restaurantId,
      size: size,
      accessed: DateTime.now(),
      type: type,
      synced: false,
    );

    this.saveCache();
  }

  void deleteRestaurantImage({String id, String restaurantId}) {
    print('> file ${cachePath.path}/$id');

    if (cache.containsKey(id)) {
      final file = File('${cachePath.path}/$id');
      final uid = FirebaseAuth.instance.currentUser.uid;
      final ref = firebase_storage.FirebaseStorage.instance
          .ref('users/$uid/restaurants/$id');

      try {
        final deleteTask = ref.delete();
        deleteTask.whenComplete(() {
          print('> delete succeeded');
          if (cache.containsKey(id)) {
            if (file.existsSync()) file.deleteSync();
            cache.remove(id);
            loadCache();
          }
        });
      } on firebase_core.FirebaseException catch (e) {
        print(e);
      }
    }
  }

  void addRestaurantImage({
    String id,
    String restaurantId,
    File file,
    String type = 'image/jpeg',
  }) {
    _add(id, 1, restaurantId, file, type);
  }

  int get numberOfPhotos => cache.keys.length;

  int get numberOfPending {
    int pending = 0;
    for (MediaInfo mi in cache.values) if (!mi.synced) pending++;
    return pending;
  }

  int get size {
    int s = 0;
    for (MediaInfo mi in cache.values) s += mi.size;
    return s;
  }

  MediaInfo getNotSynced() {
    for (MediaInfo mi in cache.values) if (!mi.synced) return mi;
    return null;
  }

  Future<void> synchronizeImage() async {
    MediaInfo mediaInfo = getNotSynced();

    if (mediaInfo != null) {
      print('> sync file: ${cachePath.path}/${mediaInfo.id}');
      // ${cachePath.path}/$id

      final file = File('${cachePath.path}/${mediaInfo.id}');

      if (file.existsSync()) {
        print('> exists');
      } else {
        print('> not exists');
      }

      final storage = firebase_storage.FirebaseStorage.instance;

      final uid = FirebaseAuth.instance.currentUser.uid;

      final imagePath = mediaInfo.source == 0
          ? 'users/${mediaInfo.id}'
          : 'users/$uid/restaurants/${mediaInfo.id}';

      final imageRef = storage.ref().child(imagePath);

      try {
        final uploadTask = imageRef.putFile(file);
        print('> trying to upload...');
        await uploadTask.whenComplete(() {
          if (cache.containsKey(mediaInfo.id)) {
            cache[mediaInfo.id].accessed = DateTime.now();
            cache[mediaInfo.id].synced = true;
            print('> upload succeeded');
            saveCache();
            synchronizeImage();
          }
        });
      } catch (error) {
        print('> upload error: $error');
      }
    }

    print('> done synchronizing');
  }

  Future<void> synchronize() async {
    print('> synchronizing the cache...');
    if (await CheckConnection.checkConnection())
      synchronizeImage();
    else
      print('> offline');
  }

  void flush() {
    if (tempDir.existsSync()) {
      print('> flush cache');
      for (MediaInfo mi in cache.values) {
        final f = File('${cachePath.path}/${mi.id}');
        if (f.existsSync()) {
          print('> delete file: ${cachePath.path}/${mi.id}');
          f.deleteSync();
        }
      }

      cacheFile.deleteSync();
      loadCache();
    }
  }
}
