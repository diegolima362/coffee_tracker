import 'package:coffee_tracker/app/shared/components/alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../login_controller.dart';

class SignInCard extends StatefulWidget {
  final LoginController controller;

  SignInCard({Key key, @required this.controller}) : super(key: key);

  @override
  __SignInCardState createState() => __SignInCardState();
}

class __SignInCardState extends State<SignInCard> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _idFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  LoginController controller;

  String get _buttonText {
    if (controller.signInForm)
      return 'Entrar';
    else if (controller.resetForm)
      return 'Enviar link para email';
    else
      return 'Cadastrar';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Observer(builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTitle(),
                  SizedBox(height: 20.0),
                  SizedBox(height: 20.0),
                  _buildEmailTextField(),
                  if (!controller.resetForm) _buildPasswordTextField(),
                  SizedBox(height: 10.0),
                  _buildSubmitButton(),
                  SizedBox(height: 10.0),
                  if (!controller.resetForm) _buildResetPasswordButton(),
                  SizedBox(height: 4.0),
                  _buildChangeFormTypeButton(),
                  SizedBox(height: 10.0),
                  Text('ou'),
                  SizedBox(height: 10.0),
                  _buildSocialSignIn(),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _idFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = widget.controller;

    controller.setupValidations();
  }

  Widget _buildChangeFormTypeButton() {
    return Observer(builder: (_) {
      final text = controller.signUpForm
          ? 'Já tem uma conta? Conecte-se'
          : 'Não tem uma conta? Cadastre-se';

      return Container(
        height: 50,
        width: 300,
        child: TextButton(
          child: Text(text),
          onPressed: () => controller.toggleFormType(),
        ),
      );
    });
  }

  Widget _buildEmailTextField() {
    final label = 'Email';
    final hint = 'Insira seu email';

    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Container(
          width: 300,
          child: TextField(
            enabled: !widget.controller.loading,
            controller: _idController,
            focusNode: _idFocusNode,
            autocorrect: false,
            autofocus: false,
            enableSuggestions: true,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: label,
              hintText: hint,
              enabled: widget.controller.loading == false,
              prefixIcon: Icon(Icons.mail_outline),
              errorText: widget.controller.error.email,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(width: 3),
              ),
            ),
            onChanged: (value) => widget.controller.editEmail(value.trim()),
            onEditingComplete: () {
              FocusNode newFocus;
              if (widget.controller.isEmailValid) {
                newFocus = _passwordFocusNode;
              } else {
                newFocus = _idFocusNode;
              }
              FocusScope.of(context).requestFocus(newFocus);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Observer(
      builder: (_) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: Container(
          width: 300,
          child: TextField(
            enabled: !controller.loading,
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            onChanged: (value) => controller.editPassword(value.trim()),
            decoration: InputDecoration(
              labelText: 'Senha',
              hintText: 'Insira sua senha',
              errorText: controller.error.password,
              enabled: controller.loading == false,
              prefixIcon: Icon(Icons.lock_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(2),
                borderSide: BorderSide(width: 3),
              ),
            ),
            autocorrect: false,
            obscureText: true,
            textInputAction: TextInputAction.done,
            onEditingComplete: () async => await _submit(),
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordButton() {
    return Observer(
      builder: (_) {
        if (controller.signInForm) {
          return TextButton(
            child: Text('Esqueceu sua Senha?'),
            onPressed: () => !controller.loading
                ? controller.setFormType(SignFormType.reset)
                : null,
          );
        } else {
          return SizedBox(height: 20);
        }
      },
    );
  }

  Widget _buildSocialSignIn() {
    return Container(
      height: 50,
      width: 300,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Color(0xff1a1a1a),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'images/google-logo.png',
              width: 35,
              height: 35,
            ),
            Text('Entrar com Google'),
            SizedBox(width: 35),
          ],
        ),
        onPressed: _googleSignIn,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Observer(builder: (_) {
      return Container(
        height: 50,
        width: 300,
        child: ElevatedButton(
          child: Text(
            _buttonText,
            style: TextStyle(color: const Color(0xffffffff)),
          ),
          onPressed: controller.canSubmit
              ? () async =>
                  controller.resetForm ? await _reset() : await _submit()
              : null,
        ),
      );
    });
  }

  Widget _buildTitle() {
    return Text(
      'Coffee Tracker',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: -1,
      ),
    );
  }

  Future<void> _googleSignIn() async {
    try {
      await controller.loginWithGoogle();
    } catch (e) {
      print(e);
      print(e.code);

      if (e.code != 'ERROR_ABORTED_BY_USER' &&
          e.code != 'popup_closed_by_user') {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertWidget(
              title: "Erro ao fazer login",
              content: e.message,
            );
          },
        );
      }
    }
  }

  Future<void> _reset() async {
    try {
      await controller.resetPassword();
      await _showConfirmDialog();

      controller.toggleFormType();
    } catch (e) {
      print(e);
      print(e.code);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertWidget(
            title: 'Erro ao redefinir',
            content: e.message,
          );
        },
      );
    }
  }

  Future _showConfirmDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text('Email enviado'),
          content: Text(
              'Acesse o seu email e siga os passos para redefinir a sua senha'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }

  Future<void> _submit() async {
    final errorTitle = 'Erro ao fazer login';

    try {
      await controller.submit();

      if (controller.signUpForm) {
        await _verifyEmail();
        controller.toggleFormType();
      } else {
        if (!controller.isEmailVerified) await _verifyEmail();
      }
    } catch (e) {
      print(e);
      print(e.code);

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertWidget(
            title: errorTitle,
            content: e.message,
          );
        },
      );
    }
  }

  Future<void> _verifyEmail() async {
    final title = 'Email não verificado';
    final content = 'Acesse o seu email e siga os passos '
        'para validar o seu email.';

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertWidget(title: title, content: content);
      },
    );

    controller.alertHandled();
  }
}
