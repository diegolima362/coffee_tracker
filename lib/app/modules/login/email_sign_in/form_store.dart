import 'dart:ui';

import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'form_store.g.dart';

enum SignFormType {
  signUp,
  signIn,
}

class CustomColor extends Color {
  CustomColor(int value) : super(value);
}

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  final FormErrorState error = FormErrorState();

  AuthController _auth = Modular.get();

  @observable
  CustomColor color;

  @observable
  bool loading = false;

  @observable
  SignFormType formType = SignFormType.signIn;

  @observable
  String email = '';

  @observable
  String password = '';

  @computed
  bool get isEmailValid => email != null && isEmail(email);

  @computed
  bool get isPasswordValid => password != null && password.length >= 6;

  @computed
  bool get canSubmit =>
      email.isNotEmpty && password.isNotEmpty && !error.hasErrors && !loading;

  @computed
  String get primaryButtonText {
    return formType == SignFormType.signIn ? 'Entrar' : 'Criar uma conta';
  }

  @computed
  String get secondaryButtonText {
    return formType == SignFormType.signIn
        ? 'Precisa de uma conta? Registrar-se'
        : 'Já tem uma conta? Entrar';
  }

  List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword)
    ];
  }

  @action
  void validatePassword(String value) {
    error.password = isNull(value) || value.isEmpty || value.length < 6
        ? 'Senha deve ter pelo menos seis caracteres'
        : null;
  }

  @action
  void validateEmail(String value) {
    error.email = isEmail(value) ? null : 'Email inválido';
  }

  @action
  void toggleFormType() {
    formType = this.formType == SignFormType.signIn
        ? SignFormType.signUp
        : SignFormType.signIn;

    email = '';
    password = '';
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validatePassword(password);
    validateEmail(email);
  }

  Future<void> close() async {
    print('> close email sign in form');
    await Modular.to.pushReplacementNamed('/login');
  }

  @action
  Future<void> submit() async {
    loading = true;

    try {
      if (this.formType == SignFormType.signIn) {
        await _auth.loginWithEmail(
          email: email.trim(),
          password: password.trim(),
        );
      } else {
        await _auth.signUpWithEmail(
          email: email.trim(),
          password: password.trim(),
        );
      }

      loading = false;
    } on VerifyEmailAlert {
      rethrow;
    } on PlatformException {
      loading = false;
      rethrow;
    } on Exception catch (e) {
      loading = false;
      throw PlatformException(
        code: 'ERROR_SIGN_IN',
        details: e.toString(),
      );
    }
  }

  bool get isEmailVerified => _auth.isEmailVerified;

  bool get loggedIn => _auth.status == AuthStatus.loggedOn;

  Future<bool> validateCode(String code) async =>
      await _auth.validateCode(code);

  void alertHandled() => _auth.alertHandled();

  void resetPassword() {
    Modular.link.pushReplacementNamed(
      'reset_password',
      arguments: _auth,
    );
  }
}

class FormErrorState = _FormErrorState with _$FormErrorState;

abstract class _FormErrorState with Store {
  @observable
  String email;

  @observable
  String password;

  @computed
  bool get hasErrors => email != null || password != null;
}
