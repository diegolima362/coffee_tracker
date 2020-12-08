import 'package:coffee_tracker/app/shared/models/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'repositories/interfaces/auth_repository_interface.dart';

part 'auth_controller.g.dart';

enum AuthStatus { waiting, loggedOn, loggedOut }

@Injectable()
class AuthController = _AuthControllerBase with _$AuthController;

abstract class _AuthControllerBase with Store {
  _AuthControllerBase() {
    _authRepository = Modular.get();

    status = _authRepository.currentUser == null
        ? AuthStatus.loggedOut
        : AuthStatus.loggedOn;

    _authRepository.onAuthStateChanged.listen((u) {
      setUser(u);
    });
  }

  IAuthRepository _authRepository;

  @observable
  AuthStatus status;

  @observable
  UserModel user;

  bool get isEmailVerified => _authRepository.currentUser.emailVerified;

  Stream<UserModel> get onAuthStateChanged {
    return _authRepository.onAuthStateChanged;
  }

  @action
  void setUser(UserModel value) => user = value;

  @action
  void alertHandled() => status = AuthStatus.loggedOut;

  @action
  Future signInWithGoogle() async {
    status = AuthStatus.waiting;
    try {
      user = await _authRepository.signInWithGoogle();
      if (user?.id != null)
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
  Future signInWithEmailPassword({
    @required String email,
    @required String password,
  }) async {
    status = AuthStatus.waiting;

    try {
      user = await _authRepository.signInWithEmailPassword(
        email: email,
        password: password,
      );

      if (user.emailVerified) {
        status = AuthStatus.loggedOn;
        setUser(user);
      } else {
        status = AuthStatus.loggedOut;
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
      await _authRepository.signUpWithEmailPassword(
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
  Future requestResetPassword(String email) async {
    status = AuthStatus.waiting;
    try {
      await _authRepository.requestResetPassword(email);
      setUser(null);
      status = AuthStatus.loggedOut;
    } on PlatformException {
      status = AuthStatus.loggedOut;
      rethrow;
    }
  }

  @action
  Future<void> signOut() async {
    try {
      status = AuthStatus.waiting;
      await _authRepository.signOut();
      status = AuthStatus.loggedOut;
    } on PlatformException {
      status = AuthStatus.loggedOut;
      rethrow;
    }
  }
}

class VerifyEmailAlert implements Exception {}
