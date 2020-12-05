import 'package:coffee_tracker/app/shared/components/alert_widget.dart';
import 'package:coffee_tracker/app/shared/components/platform_alert_dialog.dart';
import 'package:coffee_tracker/app/shared/components/platform_exception_alert_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'form_store.dart';

class SignInForm extends StatefulWidget {
  const SignInForm();

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final FormStore store = FormStore();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    store.setupValidations();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: store.close,
        ),
      ),
      body: Observer(
        builder: (_) {
          if (store.loading)
            return _buildLoading();
          else
            return _buildContent();
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 10),
          Text('Carregando'),
        ],
      ),
    );
  }

  SingleChildScrollView _buildContent() {
    final ratio = MediaQuery.of(context).size.aspectRatio;
    final height = MediaQuery.of(context).size.height;
    final _width = ratio > 1 ? height : null;

    return SingleChildScrollView(
      child: Card(
        margin: EdgeInsets.all(8),
        child: Container(
          width: _width,
          child: Form(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildEmailTextField(),
                  _buildPasswordTextField(),
                  SizedBox(height: 16.0),
                  _buildSubmitButton(),
                  _buildToggleButton(),
                  _buildResetPasswordButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Observer _buildPasswordTextField() {
    return Observer(
      builder: (_) => TextField(
        enabled: !store.loading,
        controller: _passwordController,
        focusNode: _passwordFocusNode,
        onChanged: (value) => store.password = value,
        decoration: InputDecoration(
          labelText: 'Senha',
          hintText: 'Insira uma senha',
          errorText: store.error.password,
          enabled: store.loading == false,
        ),
        autocorrect: false,
        obscureText: true,
        textInputAction: TextInputAction.done,
        onEditingComplete: _submit,
      ),
    );
  }

  Observer _buildEmailTextField() {
    final label = 'Email';
    final hint = 'Insira um email';

    return Observer(
      builder: (_) => TextField(
        enabled: !store.loading,
        controller: _emailController,
        focusNode: _emailFocusNode,
        onChanged: (value) => store.email = value.trim(),
        autocorrect: false,
        autofocus: false,
        enableSuggestions: false,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          errorText: store.error.email,
          enabled: store.loading == false,
        ),
        onEditingComplete: () {
          var newFocus;
          if (store.isEmailValid) {
            newFocus = _passwordFocusNode;
          } else {
            newFocus = _emailFocusNode;
          }
          FocusScope.of(context).requestFocus(newFocus);
        },
      ),
    );
  }

  Observer _buildSubmitButton() {
    return Observer(
      builder: (_) {
        return RaisedButton(
          child: Text(store.primaryButtonText),
          onPressed: store.canSubmit ? _submit : null,
        );
      },
    );
  }

  Observer _buildToggleButton() {
    return Observer(
      builder: (_) {
        return FlatButton(
          child: Text(store.secondaryButtonText),
          onPressed: !store.loading ? _toggleFormType : null,
        );
      },
    );
  }

  Observer _buildResetPasswordButton() {
    return Observer(
      builder: (_) {
        if (store.formType == SignFormType.signIn) {
          return FlatButton(
            child: Text('Esqueceu sua Senha? Clique para redefinir'),
            onPressed: !store.loading ? _resetPassword : null,
          );
        } else {
          return SizedBox(height: 20);
        }
      },
    );
  }

  void _toggleFormType() {
    _emailController.clear();
    _passwordController.clear();
    store.toggleFormType();
  }

  Future<void> _submit() async {
    final errorTitle = 'Erro ao fazer login';

    try {
      await store.submit();

      if (store.formType == SignFormType.signUp) {
        await _verifyEmail();
      } else {
        if (!store.isEmailVerified) await _verifyEmail();
      }
    } on PlatformException catch (e) {
      if (!kIsWeb) {
        PlatformExceptionAlertDialog(
          title: errorTitle,
          exception: e,
        ).show(context);
      } else {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertWidget(title: errorTitle, content: e.toString());
          },
        );
      }
    }
  }

  Future<void> _verifyEmail() async {
    final title = 'Email não verificado';
    final content = 'Acesse o seu email e siga os passos '
        'para validar o seu email.';
    if (!kIsWeb) {
      await PlatformAlertDialog(
        title: title,
        content: content,
        defaultActionText: 'OK',
      ).show(context);

      store.alertHandled();
    } else {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertWidget(title: title, content: content);
        },
      );
      store.alertHandled();
    }
  }

  Future<void> _resetPassword() async {
    store.resetPassword();
  }
}
