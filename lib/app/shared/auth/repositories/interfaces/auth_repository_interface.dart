import 'dart:typed_data';

import 'package:coffee_tracker/app/shared/models/user_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class IAuthRepository implements Disposable {
  UserModel get currentUser;

  Stream<UserModel> get onAuthStateChanged;

  Future<UserModel> signInWithGoogle();

  Future<UserModel> signInWithEmailPassword({String email, String password});

  Future<void> signUpWithEmailPassword({String email, String password});

  Future<void> requestResetPassword(String email);

  Future<void> signOut();

  void updateProfile(String name, Uint8List image);

  void removeProfilePhoto();
}
