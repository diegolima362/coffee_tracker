import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'repositories/interfaces/auth_repository_interface.dart';

part 'auth_controller.g.dart';

enum AuthStatus { waiting, loggedOn, loggedOut }

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  _AuthControllerBase() {
    _authRepository = Modular.get();

    status = _authRepository.currentUser == null
        ? AuthStatus.loggedOut
        : AuthStatus.loggedOn;

    print('> user : ${_authRepository.currentUser}');

    _authRepository.getUser().listen((u) {
      setUser(u);
    });
  }

  IAuthRepository _authRepository;

  @observable
  AuthStatus status;

  @observable
  User user;

  bool get isEmailVerified => _authRepository.emailVerified();

  Future<bool> validateCode(String code) async =>
      await _authRepository.validateCode(code);

  @action
  void setUser(User value) => user = value;

  @action
  void alertHandled() => status = AuthStatus.loggedOut;

  @action
  Future loginWithGoogle() async {
    status = AuthStatus.waiting;
    try {
      user = await _authRepository.getGoogleLogin();
      if (user?.uid != null)
        status = AuthStatus.loggedOn;
      else
        status = AuthStatus.loggedOut;
    } on PlatformException {
      status = AuthStatus.loggedOut;
      rethrow;
    } catch (e) {
      status = AuthStatus.loggedOut;
      rethrow;
    }
  }

  @action
  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    status = AuthStatus.waiting;

    try {
      user = await _authRepository.getEmailPasswordLogin(
        email: email,
        password: password,
      );

      if (user.emailVerified) {
        status = AuthStatus.loggedOn;
      } else {
        // user.sendEmailVerification();
        // status = AuthStatus.loggedOut;
      }
    } on PlatformException {
      status = AuthStatus.loggedOut;
      rethrow;
    }
  }

  @action
  Future signUpWithEmail({
    @required String email,
    @required String password,
  }) async {
    status = AuthStatus.waiting;
    try {
      user = await _authRepository.getEmailPasswordSignUp(
        email: email,
        password: password,
      );
    } on PlatformException {
      status = AuthStatus.loggedOut;
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  @action
  Future resetPassword(String email) async {
    status = AuthStatus.waiting;
    try {
      await _authRepository.resetPassword(email);
      status = AuthStatus.loggedOut;
    } on PlatformException {
      status = AuthStatus.loggedOut;
      rethrow;
    }
  }

  @action
  Future<void> logout() async {
    try {
      status = AuthStatus.waiting;
      await _authRepository.getLogout();
      status = AuthStatus.loggedOut;
    } on PlatformException {
      status = AuthStatus.loggedOut;
      rethrow;
    }
  }

  Stream<User> get onAuthStateChanged => _authRepository.onAuthStateChanged;
}

class VerifyEmailAlert implements Exception {}
