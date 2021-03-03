import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';

part 'login_controller.g.dart';

class FormErrorState = _FormErrorState with _$FormErrorState;

@Injectable()
class LoginController = _LoginControllerBase with _$LoginController;

enum SignFormType {
  signUp,
  signIn,
  reset,
}

abstract class _FormErrorState with Store {
  @observable
  String email;

  @observable
  String password;

  @computed
  bool get hasErrors => email != null || password != null;
}

abstract class _LoginControllerBase with Store {
  AuthController auth;

  @observable
  bool loading = false;

  @observable
  SignFormType formType = SignFormType.signIn;

  @observable
  String email = '';

  @observable
  String password = '';

  FormErrorState error;

  List<ReactionDisposer> _disposers;

  _LoginControllerBase() {
    auth = Modular.get();
    error = FormErrorState();
  }

  @computed
  bool get canSubmit =>
      (resetForm && isEmailValid) ||
      email.isNotEmpty && password.isNotEmpty && !error.hasErrors && !loading;

  @computed
  bool get isEmailValid => email != null && isEmail(email);

  bool get isEmailVerified => auth.isEmailVerified;

  @computed
  bool get isPasswordValid => password != null && password.length >= 6;

  @computed
  bool get resetForm => formType == SignFormType.reset;

  @computed
  bool get signInForm => formType == SignFormType.signIn;

  @computed
  bool get signUpForm => formType == SignFormType.signUp;

  void alertHandled() => auth.alertHandled();

  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  @action
  void editEmail(String value) => email = value;

  @action
  void editPassword(String value) => password = value;

  @action
  void loginWithEmail() {
    Modular.to.pushReplacementNamed('/login/email_sign_in', arguments: auth);
  }

  @action
  Future loginWithGoogle() async {
    print('login with google');
    loading = true;

    try {
      await auth.signInWithGoogle();

      loading = false;

      if (auth.status == AuthStatus.loggedOn) {
        // Modular.to.pushReplacementNamed('/home');
      }
    } on PlatformException {
      loading = false;
      rethrow;
    } catch (e) {
      loading = false;
      rethrow;
    }
  }

  @action
  Future<void> resetPassword() async {
    loading = true;

    try {
      await auth.requestResetPassword(email);
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

  @action
  void setFormType(SignFormType value) => formType = value;

  void setupValidations() {
    _disposers = [
      reaction((_) => email, validateEmail),
      reaction((_) => password, validatePassword)
    ];
  }

  @action
  Future<void> submit() async {
    loading = true;

    try {
      if (signInForm) {
        await auth.signInWithEmailPassword(
          email: email.trim(),
          password: password.trim(),
        );
      } else {
        await auth.signUpWithEmail(
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

  @action
  void toggleFormType() {
    formType =
        signInForm || resetForm ? SignFormType.signUp : SignFormType.signIn;

    password = '';
  }

  @action
  void validateEmail(String value) {
    error.email = isEmail(value) ? null : 'Email inválido';
  }

  @action
  void validatePassword(String value) {
    error.password = isNull(value) || value.isEmpty || value.length < 6
        ? 'Senha deve ter pelo menos seis caracteres'
        : null;
  }
}
