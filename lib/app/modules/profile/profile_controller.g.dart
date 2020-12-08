// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $ProfileController = BindInject(
  (i) => ProfileController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProfileController on _ProfileControllerBase, Store {
  final _$userAtom = Atom(name: '_ProfileControllerBase.user');

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

  final _$isOfflineAtom = Atom(name: '_ProfileControllerBase.isOffline');

  @override
  bool get isOffline {
    _$isOfflineAtom.reportRead();
    return super.isOffline;
  }

  @override
  set isOffline(bool value) {
    _$isOfflineAtom.reportWrite(value, super.isOffline, () {
      super.isOffline = value;
    });
  }

  final _$darkAtom = Atom(name: '_ProfileControllerBase.dark');

  @override
  bool get dark {
    _$darkAtom.reportRead();
    return super.dark;
  }

  @override
  set dark(bool value) {
    _$darkAtom.reportWrite(value, super.dark, () {
      super.dark = value;
    });
  }

  final _$logoutAsyncAction = AsyncAction('_ProfileControllerBase.logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$setDarkAsyncAction = AsyncAction('_ProfileControllerBase.setDark');

  @override
  Future<void> setDark(bool value) {
    return _$setDarkAsyncAction.run(() => super.setDark(value));
  }

  final _$_ProfileControllerBaseActionController =
      ActionController(name: '_ProfileControllerBase');

  @override
  void setOffline(bool value) {
    final _$actionInfo = _$_ProfileControllerBaseActionController.startAction(
        name: '_ProfileControllerBase.setOffline');
    try {
      return super.setOffline(value);
    } finally {
      _$_ProfileControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
isOffline: ${isOffline},
dark: ${dark}
    ''';
  }
}
