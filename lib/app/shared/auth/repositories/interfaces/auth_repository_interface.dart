import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class IAuthRepository implements Disposable {
  Future<User> getGoogleLogin();

  Stream<User> get onAuthStateChanged;

  Future<User> getEmailPasswordLogin({String email, String password});

  Future<User> getEmailPasswordSignUp({String email, String password});

  Future<String> getToken();

  Future<void> getLogout();

  Stream<User> getUser();

  Future<void> resetPassword(String email);

  bool emailVerified();

  Future<bool> validateCode(String code);
}
