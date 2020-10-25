import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';

import 'interfaces/auth_repository_interface.dart';

class AuthRepository implements IAuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<String> getToken() {
    return _auth.currentUser.getIdToken();
  }

  @override
  Future<User> getGoogleLogin() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final User user = (await _auth.signInWithCredential(credential)).user;
    return user;
  }

  @override
  Future getLogout() {
    return _auth.signOut();
  }

  @override
  void dispose() {}

  @override
  Stream<User> getUser() {
    return _auth.authStateChanges();
  }

  @override
  Future<User> getEmailPasswordLogin({String email, String password}) async {
    UserCredential authResult;

    try {
      authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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
  Future<User> getEmailPasswordSignup({String email, String password}) async {
    UserCredential authResult;

    try {
      authResult = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
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
}
