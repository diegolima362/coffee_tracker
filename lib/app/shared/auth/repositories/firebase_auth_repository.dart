import 'dart:typed_data';

import 'package:coffee_tracker/app/shared/models/user_model.dart';
import 'package:coffee_tracker/app/utils/connection_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'interfaces/auth_repository_interface.dart';

@Injectable()
class FirebaseAuthRepository implements IAuthRepository {
  GoogleSignIn _googleSignIn;

  FirebaseAuth _auth;
  final Map<String, String> _message = {
    'sign_in_canceled': 'Login cancelado pelo usuário',
    'user-not-found': 'Não há registro de usuário para o email informado',
    'invalid-password':
        'Senha inválida, senha deve conter pelo menos seis caracteres.',
    'wrong-password': 'Senha inválida ou o usuário não possui senha.'
  };

  FirebaseAuthRepository() {
    _googleSignIn = GoogleSignIn();
    _auth = FirebaseAuth.instance;
  }

  @override
  UserModel get currentUser => _userFromFirebase(_auth.currentUser);

  @override
  Stream<UserModel> get onAuthStateChanged {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  @override
  void dispose() {}

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
    } on FirebaseAuthException catch (e) {
      print('> FirebaseAuthRepository: ');
      print(e.code);
      print(e);

      throw PlatformException(
        message: _message[e.code],
        code: e.code,
        details: e.message,
      );
    } catch (e) {
      print('exception');
      print(e);

      throw PlatformException(
        message: e.toString(),
        code: 'EMAIL_SIGN_IN_ERROR',
      );
    }
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
    } on FirebaseAuthException catch (e) {
      print('> FirebaseAuthRepository: ');
      print(e.code);
      print(e);

      throw PlatformException(
        message: _message[e.code],
        code: e.code,
        details: e.message,
      );
    } catch (e) {
      print('exception');
      print(e);

      throw PlatformException(
        message: e.toString(),
        code: 'EMAIL_SIGN_IN_ERROR',
      );
    }

    return _userFromFirebase(user);
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    User user;

    try {
      if (!kIsWeb) {
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
      } else {
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        user =
            (await FirebaseAuth.instance.signInWithPopup(googleProvider)).user;
      }
    } on FirebaseAuthException catch (e) {
      print('> FirebaseAuthRepository: ');
      print(e.code);
      print(e);

      throw PlatformException(
        message: _message[e.code],
        code: e.code,
        details: e.message,
      );
    } catch (e) {
      throw PlatformException(
        message: e.toString(),
        code: 'sign_in_error',
      );
    }

    return _userFromFirebase(user);
  }

  @override
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      print('> FirebaseAuthRepository: ');
      print(e.code);
      print(e);

      throw PlatformException(
        message: _message[e.code],
        code: e.code,
        details: e.message,
      );
    } catch (e) {
      print('exception');
      print(e);

      throw PlatformException(
        message: e.toString(),
        code: 'EMAIL_SIGN_IN_ERROR',
      );
    }
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
    } on FirebaseAuthException catch (e) {
      print('> FirebaseAuthRepository: ');
      print(e.code);
      print(e);

      throw PlatformException(
        message: _message[e.code],
        code: e.code,
        details: e.message,
      );
    } catch (e) {
      print('excpetion');
      print(e);

      throw PlatformException(
        message: e.toString(),
        code: 'EMAIL_SIGN_IN_ERROR',
      );
    }
  }

  Future _checkConnection() async {
    if (!kIsWeb) {
      try {
        if (!await CheckConnection.checkConnection()) {
          throw PlatformException(
            message: 'Sem conexão com a internet',
            code: 'error_connection',
          );
        }
      } on FirebaseAuthException catch (e) {
        print('> FirebaseAuthRepository: ');
        print(e.code);
        print(e);

        throw PlatformException(
          message: e.message,
          code: e.code,
        );
      } catch (e) {
        print('excpetion');
        print(e);

        throw PlatformException(
          message: e.toString(),
          code: 'EMAIL_SIGN_IN_ERROR',
        );
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

  @override
  void updateProfile(String name, Uint8List image) {
    print('set name: $name');
    if (name != null) _auth.currentUser.updateProfile(displayName: name);
    if (image != null) _setProfileImage(image);
  }

  @override
  void removeProfilePhoto() {
    _setProfileImage(null);
  }

  Future<void> _setProfileImage(Uint8List image) async {
    final storage = firebase_storage.FirebaseStorage.instance;

    if (image == null) {
      _auth.currentUser.updateProfile(photoURL: '');

      return;
    }

    final uid = _auth.currentUser.uid;

    final imagePath = 'users/$uid/profile/avatar.jpg';

    final imageRef = storage.ref().child(imagePath);

    try {
      final uploadTask = imageRef.putData(image);
      await uploadTask.whenComplete(() {
        _auth.currentUser.updateProfile(photoURL: imagePath);
      });
    } catch (error) {
      print('> upload error: $error');
    }
  }
}
