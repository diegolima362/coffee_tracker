import 'package:coffee_tracker/app/utils/connection_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'interfaces/auth_repository_interface.dart';

class AuthRepository implements IAuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<String> getToken() async {
    return await _auth.currentUser.getIdToken();
  }

  @override
  Future<User> getGoogleLogin() async {
    User user;
    if (!kIsWeb) {
      try {
        if (!await CheckConnection.checkConnection()) {
          throw PlatformException(
            message: 'Sem conexão com a internet',
            code: 'error_connection',
          );
        }
      } catch (e) {
        rethrow;
      }
    }

    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      user = (await _auth.signInWithCredential(credential)).user;
    } on PlatformException {
      rethrow;
    } catch (e) {
      rethrow;
    }

    return user;
  }

  @override
  Future<void> getLogout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } on PlatformException {
      rethrow;
    }
  }

  @override
  Stream<User> getUser() {
    return _auth.authStateChanges();
  }

  @override
  Future<User> getEmailPasswordLogin({String email, String password}) async {
    UserCredential authResult;
    if (!kIsWeb) {
      try {
        if (!await CheckConnection.checkConnection()) {
          throw PlatformException(
            message: 'Sem conexão com a internet',
            code: 'error_connection',
          );
        }
      } catch (e) {
        rethrow;
      }
    }

    try {
      authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!authResult.user.emailVerified) {
        await authResult.user.sendEmailVerification();
      }
    } on PlatformException {
      rethrow;
    } on Exception catch (e) {
      print(e);
      throw PlatformException(
        message: e.toString(),
        code: 'EMAIL_SIGN_IN_ERROR',
      );
    } catch (e) {
      print(e);
    }

    return authResult.user;
  }

  @override
  Future<User> getEmailPasswordSignUp({String email, String password}) async {
    UserCredential authResult;
    if (!kIsWeb) {
      try {
        if (!await CheckConnection.checkConnection()) {
          throw PlatformException(
            message: 'Sem conexão com a internet',
            code: 'error_connection',
          );
        }
      } catch (e) {
        rethrow;
      }
    }

    try {
      authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await authResult.user.sendEmailVerification();
    } on PlatformException {
      rethrow;
    } on Exception catch (e) {
      print(e);
      throw PlatformException(
        message: e.toString(),
        code: 'EMAIL_SIGN_IN_ERROR',
      );
    } catch (e) {
      print(e);
    }

    return authResult.user;
  }

  @override
  Future<void> resetPassword(String email) async {
    if (!kIsWeb) {
      try {
        if (!await CheckConnection.checkConnection()) {
          throw PlatformException(
            message: 'Sem conexão com a internet',
            code: 'error_connection',
          );
        }
      } catch (e) {
        rethrow;
      }
    }

    try {
      final List<String> exist = await _auth.fetchSignInMethodsForEmail(email);

      if (exist.isNotEmpty)
        await _auth.sendPasswordResetEmail(email: email);
      else
        throw PlatformException(
          code: 'ERROR_EMAIL_NOT_EXIST',
          message: 'Email não encontrado.',
        );
    } on PlatformException {
      rethrow;
    } catch (e) {
      print(e);
    }
  }

  Future<void> validateEmail(String code) async {
    if (!kIsWeb) {
      try {
        if (!await CheckConnection.checkConnection()) {
          throw PlatformException(
            message: 'Sem conexão com a internet',
            code: 'error_connection',
          );
        }
      } catch (e) {
        rethrow;
      }
    }

    try {
      await _auth.checkActionCode(code);
      await _auth.applyActionCode(code);

      _auth.currentUser.reload();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-action-code') {
        print('The code is invalid.');
      }
    }
  }

  @override
  bool emailVerified() => _auth.currentUser.emailVerified;

  @override
  Future<bool> validateCode(String code) async {
    if (!kIsWeb) {
      try {
        if (!await CheckConnection.checkConnection()) {
          throw PlatformException(
            message: 'Sem conexão com a internet',
            code: 'error_connection',
          );
        }
      } catch (e) {
        rethrow;
      }
    }

    try {
      await _auth.checkActionCode(code);
      await _auth.applyActionCode(code);

      _auth.currentUser.reload();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-action-code') {
        print('The code is invalid.');
      }
    }

    return true;
  }

  @override
  void dispose() {}

  @override
  Stream<User> get onAuthStateChanged => _auth.authStateChanges();
}
