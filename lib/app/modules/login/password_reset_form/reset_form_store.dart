import 'dart:ui';

import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'reset_form_store.g.dart';

class CustomColor extends Color {
  CustomColor(int value) : super(value);
}

class ResetFormStore = _ResetFormStore with _$ResetFormStore;

abstract class _ResetFormStore with Store {
  final ResetFormErrorState error = ResetFormErrorState();

  AuthController auth = Modular.get();

  @observable
  CustomColor color;

  @observable
  bool loading = false;

  @observable
  String email = '';

  @computed
  bool get isEmailValid => email != null && isEmail(email);

  @computed
  bool get canSubmit => email.isNotEmpty && !error.hasErrors && !loading;

  @computed
  bool get canDissmiss => !loading;

  List<ReactionDisposer> _disposers;

  void setupValidations() {
    _disposers = [
      reaction((_) => email, validateEmail),
    ];
  }

  @action
  void validateEmail(String value) {
    error.email = isEmail(value) ? null : 'Email inválido';
  }

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  @action
  Future<void> submit() async {
    loading = true;

    try {
      await auth.resetPassword(email);
      loading = false;
    } on PlatformException {
      rethrow;
    } on Exception catch (e) {
      throw PlatformException(
        code: 'ERROR_SIGN_IN',
        details: e.toString(),
      );
    } finally {
      loading = false;
    }
  }

  bool get isEmailVerified => auth.isEmailVerified;

  Future<bool> validateCode(String code) async => await auth.validateCode(code);
}

class ResetFormErrorState = _ResetFormErrorState with _$ResetFormErrorState;

abstract class _ResetFormErrorState with Store {
  @observable
  String email;

  @computed
  bool get hasErrors => email != null;
}
