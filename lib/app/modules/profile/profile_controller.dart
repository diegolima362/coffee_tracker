import 'dart:typed_data';

import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:coffee_tracker/app/shared/models/user_model.dart';
import 'package:coffee_tracker/app/shared/repositories/local_storage/interfaces/preferences_storage_interface.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/media_storage_repository_interface.dart';
import 'package:coffee_tracker/app/shared/repositories/storage/interfaces/storage_repository_interface.dart';
import 'package:coffee_tracker/app/utils/connection_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../app_controller.dart';

part 'profile_controller.g.dart';

@Injectable()
class ProfileController = _ProfileControllerBase with _$ProfileController;

abstract class _ProfileControllerBase with Store {
  _ProfileControllerBase() {
    _auth = Modular.get();

    mediaStorage = Modular.get();

    darkThemePreference = Modular.get();

    user = _auth.user;

    loadProfile();

    _loadTheme();

    if (kIsWeb)
      isOffline = false;
    else
      _checkConnection();
  }

  AuthController _auth;

  ILocalStorage darkThemePreference;

  IMediaStorageRepository mediaStorage;

  @observable
  Uint8List savedImage;

  @action
  Future<void> setImage(Uint8List value) async {
    _editImage = true;
    savedImage = value != null && value.isNotEmpty ? value : null;
  }

  @observable
  UserModel user;

  bool _editImage = false;

  bool _editName = false;

  @observable
  String name;

  @observable
  bool isOffline;

  @observable
  bool dark;

  @action
  Future<void> logout() async {
    await _clearData();

    await _auth.signOut();
    Modular.to.pushReplacementNamed('/login');
  }

  @computed
  bool get hasImage => savedImage != null;

  @action
  void setName(String value) {
    _editName = true;
    name = value;
  }

  Future<void> _clearData() async {
    if (!kIsWeb) {
      mediaStorage.flushCache();
      mediaStorage.dispose();
    }

    Modular.get<IStorageRepository>().flushCache();

    await setDark(false);
    await darkThemePreference.clearData();
    darkThemePreference.dispose();
  }

  @action
  void setOffline(bool value) {
    isOffline = value;
    print('offline: $value');
  }

  @action
  Future<void> setDark(bool value) async {
    dark = value;
    await darkThemePreference.setDarkTheme(dark);
    await Modular.get<AppController>().loadTheme();
  }

  Future<void> _checkConnection() async {
    try {
      CheckConnection.checkConnection().then((value) => setOffline(!value));
    } on PlatformException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  void updateProfile() async {
    _auth.updateProfile(
      name: _editName
          ? name.isNotEmpty
              ? name
              : null
          : null,
      image: _editImage ? savedImage : null,
    );

    if (_editImage && savedImage == null) _auth.removeProfileImage();

    Modular.navigator.pop();
  }

  void _loadTheme() {
    setDark(Modular.get<AppController>().isDark);

    try {
      setDark(darkThemePreference.isDarkTheme());
    } on PlatformException catch (e) {
      print(e);
    } catch (error) {
      print(error);
    }
  }

  void showEditPage() {
    Modular.to.pushNamed('/profile/edit');
  }

  @action
  Future<void> loadProfile() async {
    name = user.displayName;
    savedImage = await mediaStorage.fetchProfileImage();
  }
}
