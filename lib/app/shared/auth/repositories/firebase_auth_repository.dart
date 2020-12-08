import 'package:coffee_tracker/app/shared/models/user_model.dart';
import 'package:coffee_tracker/app/utils/connection_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'interfaces/auth_repository_interface.dart';

part 'firebase_auth_repository.g.dart';

@Injectable()
class FirebaseAuthRepository implements IAuthRepository {
  FirebaseAuthRepository() {
    _googleSignIn = GoogleSignIn();
    _auth = FirebaseAuth.instance;
  }

  GoogleSignIn _googleSignIn;
  FirebaseAuth _auth;

  @override
  UserModel get currentUser => _userFromFirebase(_auth.currentUser);

  @override
  Stream<UserModel> get onAuthStateChanged {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    User user;

    try {
      await _checkConnection();

      final googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        final googleAuth = await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        user = (await _auth.signInWithCredential(credential)).user;
      }
    } on PlatformException {
      rethrow;
    } catch (e) {
      rethrow;
    }

    return _userFromFirebase(user);
  }

  @override
  Future<UserModel> signInWithEmailPassword({
    String email,
    String password,
  }) async {
    User user;

    try {
      await _checkConnection();

      UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = authResult?.user;

      if (user != null && !user.emailVerified) {
        user.sendEmailVerification();
      }
    } on PlatformException {
      rethrow;
    } on Exception catch (e) {
      throw PlatformException(
        message: e.toString(),
        code: 'EMAIL_SIGN_IN_ERROR',
      );
    } catch (e) {
      rethrow;
    }

    return _userFromFirebase(user);
  }

  @override
  Future<void> signUpWithEmailPassword({String email, String password}) async {
    UserCredential authResult;
    try {
      await _checkConnection();

      authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      authResult.user.sendEmailVerification();
    } on PlatformException {
      rethrow;
    } on Exception catch (e) {
      throw PlatformException(
        message: e.toString(),
        code: 'EMAIL_SIGN_IN_ERROR',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> requestResetPassword(String email) async {
    try {
      await _checkConnection();

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
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } on PlatformException {
      rethrow;
    }
  }

  @override
  void dispose() {}

  Future _checkConnection() async {
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
  }

  UserModel _userFromFirebase(User user) {
    if (user == null) return null;

    return UserModel(
      id: user.uid,
      displayName: user.displayName,
      photoURL: user.photoURL,
      emailVerified: user.emailVerified,
    );
  }
}
