// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $SettingsController = BindInject(
  (i) => SettingsController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SettingsController on _SettingsControllerBase, Store {
  final _$darkAtom = Atom(name: '_SettingsControllerBase.dark');

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

  final _$setDarkAsyncAction = AsyncAction('_SettingsControllerBase.setDark');

  @override
  Future<void> setDark(bool dark) {
    return _$setDarkAsyncAction.run(() => super.setDark(dark));
  }

  final _$logoutAsyncAction = AsyncAction('_SettingsControllerBase.logout');

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  final _$_SettingsControllerBaseActionController =
      ActionController(name: '_SettingsControllerBase');

  @override
  void close() {
    final _$actionInfo = _$_SettingsControllerBaseActionController.startAction(
        name: '_SettingsControllerBase.close');
    try {
      return super.close();
    } finally {
      _$_SettingsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dark: ${dark}
    ''';
  }
}
