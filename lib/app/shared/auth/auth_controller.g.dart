// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $AuthController = BindInject(
  (i) => AuthController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthController on _AuthControllerBase, Store {
  final _$statusAtom = Atom(name: '_AuthControllerBase.status');

  @override
  AuthStatus get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(AuthStatus value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$userAtom = Atom(name: '_AuthControllerBase.user');

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$signInWithGoogleAsyncAction =
      AsyncAction('_AuthControllerBase.signInWithGoogle');

  @override
  Future<dynamic> signInWithGoogle() {
    return _$signInWithGoogleAsyncAction.run(() => super.signInWithGoogle());
  }

  final _$signInWithEmailPasswordAsyncAction =
      AsyncAction('_AuthControllerBase.signInWithEmailPassword');

  @override
  Future<dynamic> signInWithEmailPassword(
      {@required String email, @required String password}) {
    return _$signInWithEmailPasswordAsyncAction.run(
        () => super.signInWithEmailPassword(email: email, password: password));
  }

  final _$signUpWithEmailAsyncAction =
      AsyncAction('_AuthControllerBase.signUpWithEmail');

  @override
  Future<dynamic> signUpWithEmail(
      {@required String email, @required String password}) {
    return _$signUpWithEmailAsyncAction
        .run(() => super.signUpWithEmail(email: email, password: password));
  }

  final _$requestResetPasswordAsyncAction =
      AsyncAction('_AuthControllerBase.requestResetPassword');

  @override
  Future<dynamic> requestResetPassword(String email) {
    return _$requestResetPasswordAsyncAction
        .run(() => super.requestResetPassword(email));
  }

  final _$signOutAsyncAction = AsyncAction('_AuthControllerBase.signOut');

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  final _$_AuthControllerBaseActionController =
      ActionController(name: '_AuthControllerBase');

  @override
  void setUser(UserModel value) {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.setUser');
    try {
      return super.setUser(value);
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void alertHandled() {
    final _$actionInfo = _$_AuthControllerBaseActionController.startAction(
        name: '_AuthControllerBase.alertHandled');
    try {
      return super.alertHandled();
    } finally {
      _$_AuthControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status},
user: ${user}
    ''';
  }
}
