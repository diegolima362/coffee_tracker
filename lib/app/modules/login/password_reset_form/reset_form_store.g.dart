// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ResetFormStore on _ResetFormStore, Store {
  Computed<bool> _$isEmailValidComputed;

  @override
  bool get isEmailValid =>
      (_$isEmailValidComputed ??= Computed<bool>(() => super.isEmailValid,
              name: '_ResetFormStore.isEmailValid'))
          .value;
  Computed<bool> _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(() => super.canSubmit,
              name: '_ResetFormStore.canSubmit'))
          .value;
  Computed<bool> _$canDissmissComputed;

  @override
  bool get canDissmiss =>
      (_$canDissmissComputed ??= Computed<bool>(() => super.canDissmiss,
              name: '_ResetFormStore.canDissmiss'))
          .value;

  final _$colorAtom = Atom(name: '_ResetFormStore.color');

  @override
  CustomColor get color {
    _$colorAtom.reportRead();
    return super.color;
  }

  @override
  set color(CustomColor value) {
    _$colorAtom.reportWrite(value, super.color, () {
      super.color = value;
    });
  }

  final _$loadingAtom = Atom(name: '_ResetFormStore.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$emailAtom = Atom(name: '_ResetFormStore.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$submitAsyncAction = AsyncAction('_ResetFormStore.submit');

  @override
  Future<void> submit() {
    return _$submitAsyncAction.run(() => super.submit());
  }

  final _$_ResetFormStoreActionController =
      ActionController(name: '_ResetFormStore');

  @override
  void validateEmail(String value) {
    final _$actionInfo = _$_ResetFormStoreActionController.startAction(
        name: '_ResetFormStore.validateEmail');
    try {
      return super.validateEmail(value);
    } finally {
      _$_ResetFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
color: ${color},
loading: ${loading},
email: ${email},
isEmailValid: ${isEmailValid},
canSubmit: ${canSubmit},
canDissmiss: ${canDissmiss}
    ''';
  }
}

mixin _$ResetFormErrorState on _ResetFormErrorState, Store {
  Computed<bool> _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_ResetFormErrorState.hasErrors'))
          .value;

  final _$emailAtom = Atom(name: '_ResetFormErrorState.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  @override
  String toString() {
    return '''
email: ${email},
hasErrors: ${hasErrors}
    ''';
  }
}
