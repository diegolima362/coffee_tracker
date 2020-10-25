import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'repositories/interfaces/auth_repository_interface.dart';
part 'auth_controller.g.dart';

class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  final IAuthRepository _authRepository = Modular.get();

  @observable
  AuthStatus status = AuthStatus.loading;

  @observable
  User user;

  _AuthControllerBase() {
    _authRepository.getUser().listen((u) {
      setUser(u);
    });
  }

  @action
  setUser(User value) {
    user = value;
    status = user == null ? AuthStatus.loggedOut : AuthStatus.loggedOn;
  }

  @action
  Future loginWithGoogle() async {
    status = AuthStatus.loading;
    try {
      user = await _authRepository.getGoogleLogin();
      status = AuthStatus.loggedOn;
    } catch (e) {
      status = AuthStatus.loggedOut;
    }
  }

  @action
  Future loginWithEmail({
    @required String email,
    @required String password,
  }) async {
    status = AuthStatus.loading;
    try {
      user = await _authRepository.getEmailPasswordLogin(
        email: email,
        password: password,
      );
      status = AuthStatus.loggedOn;
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
    status = AuthStatus.loading;
    try {
      user = await _authRepository.getEmailPasswordSignup(
        email: email,
        password: password,
      );
      status = AuthStatus.loggedOn;
    } on PlatformException {
      status = AuthStatus.loggedOut;
      rethrow;
    }
  }

  Future logout() {
    return _authRepository.getLogout();
  }
}

enum AuthStatus { loading, loggedOn, loggedOut }
