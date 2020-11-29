import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:coffee_tracker/app/shared/components/platform_alert_dialog.dart';
import 'package:coffee_tracker/app/shared/components/platform_exception_alert_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
    final ratio = MediaQuery.of(context).size.aspectRatio;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Modular.to.pushReplacementNamed('/login'),
        ),
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(8),
          child: Container(
            width: ratio > 1 ? height : null,
            child: Form(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Observer(
                      builder: (_) => TextField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        onChanged: (value) => store.email = value.trim(),
                        onEditingComplete: () => _emailEditingComplete(),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Insira um email',
                          errorText: store.error.email,
                          enabled: store.loading == false,
                        ),
                        autocorrect: false,
                        autofocus: false,
                        enableSuggestions: false,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    Observer(
                      builder: (_) => TextField(
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
                    ),
                    SizedBox(height: 16.0),
                    Observer(
                      builder: (_) {
                        return RaisedButton(
                          color: Color(0xFF274C77),
                          textColor: Color(0xFFE7ECEF),
                          child: Text(store.primaryButtonText),
                          onPressed: store.canSubmit ? _submit : null,
                        );
                      },
                    ),
                    Observer(
                      builder: (_) {
                        return FlatButton(
                          child: Text(
                            store.secondaryButtonText,
                          ),
                          onPressed: !store.loading ? _toggleFormType : null,
                        );
                      },
                    ),
                    Observer(
                      builder: (_) {
                        return store.formType == SignFormType.signIn
                            ? FlatButton(
                                child: Text(
                                  'Esqueceu sua Senha? Clique para redefinir.',
                                ),
                                onPressed: _resetPassword,
                              )
                            : SizedBox(height: 20);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _toggleFormType() {
    _emailController.clear();
    _passwordController.clear();
    store.toggleFormType();
  }

  void _emailEditingComplete() {
    final newFocus = store.isEmailValid ? _passwordFocusNode : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  Future<void> _submit() async {
    try {
      await store.submit();
      if (store.auth.status == AuthStatus.loggedOn && store.isEmailVerified) {
        Modular.to.pushReplacementNamed('/home');
      } else if (!store.isEmailVerified) {
        _validateEmail();
      }
    } on PlatformException catch (e) {
      if (!kIsWeb) {
        PlatformExceptionAlertDialog(
          title: 'Erro no login',
          exception: e,
        ).show(context);
      } else {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text('Erro no login'),
              content: Text(e.message),
              actions: [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Future<bool> _validateEmail() async {
    final title = 'Email não verificado';
    final content = 'Acesse o seu email e siga os passos '
        'para validar o seu email.';
    if (!kIsWeb) {
      return await PlatformAlertDialog(
        title: title,
        content: content,
        defaultActionText: 'OK',
      ).show(context);
    } else {
      return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              FlatButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _resetPassword() async {
    store.resetPassword();
  }
}
