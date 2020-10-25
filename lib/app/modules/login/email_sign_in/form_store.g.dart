// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FormStore on _FormStore, Store {
  Computed<bool> _$isEmailValidComputed;

  @override
  bool get isEmailValid =>
      (_$isEmailValidComputed ??= Computed<bool>(() => super.isEmailValid,
              name: '_FormStore.isEmailValid'))
          .value;
  Computed<bool> _$isPasswordValidComputed;

  @override
  bool get isPasswordValid =>
      (_$isPasswordValidComputed ??= Computed<bool>(() => super.isPasswordValid,
              name: '_FormStore.isPasswordValid'))
          .value;
  Computed<bool> _$canSubmitComputed;

  @override
  bool get canSubmit => (_$canSubmitComputed ??=
          Computed<bool>(() => super.canSubmit, name: '_FormStore.canSubmit'))
      .value;
  Computed<String> _$primaryButtonTextComputed;

  @override
  String get primaryButtonText => (_$primaryButtonTextComputed ??=
          Computed<String>(() => super.primaryButtonText,
              name: '_FormStore.primaryButtonText'))
      .value;
  Computed<String> _$secondaryButtonTextComputed;

  @override
  String get secondaryButtonText => (_$secondaryButtonTextComputed ??=
          Computed<String>(() => super.secondaryButtonText,
              name: '_FormStore.secondaryButtonText'))
      .value;

  final _$colorAtom = Atom(name: '_FormStore.color');

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

  final _$loadingAtom = Atom(name: '_FormStore.loading');

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

  final _$formTypeAtom = Atom(name: '_FormStore.formType');

  @override
  SignFormType get formType {
    _$formTypeAtom.reportRead();
    return super.formType;
  }

  @override
  set formType(SignFormType value) {
    _$formTypeAtom.reportWrite(value, super.formType, () {
      super.formType = value;
    });
  }

  final _$emailAtom = Atom(name: '_FormStore.email');

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

  final _$passwordAtom = Atom(name: '_FormStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$submitAsyncAction = AsyncAction('_FormStore.submit');

  @override
  Future<void> submit() {
    return _$submitAsyncAction.run(() => super.submit());
  }

  final _$_FormStoreActionController = ActionController(name: '_FormStore');

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateEmail(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateEmail');
    try {
      return super.validateEmail(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void toggleFormType() {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.toggleFormType');
    try {
      return super.toggleFormType();
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
color: ${color},
loading: ${loading},
formType: ${formType},
email: ${email},
password: ${password},
isEmailValid: ${isEmailValid},
isPasswordValid: ${isPasswordValid},
canSubmit: ${canSubmit},
primaryButtonText: ${primaryButtonText},
secondaryButtonText: ${secondaryButtonText}
    ''';
  }
}

mixin _$FormErrorState on _FormErrorState, Store {
  Computed<bool> _$hasErrorsComputed;

  @override
  bool get hasErrors =>
      (_$hasErrorsComputed ??= Computed<bool>(() => super.hasErrors,
              name: '_FormErrorState.hasErrors'))
          .value;

  final _$emailAtom = Atom(name: '_FormErrorState.email');

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

  final _$passwordAtom = Atom(name: '_FormErrorState.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  @override
  String toString() {
    return '''
email: ${email},
password: ${password},
hasErrors: ${hasErrors}
    ''';
  }
}
