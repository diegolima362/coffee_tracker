import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:coffee_tracker/app/utils/platform_exception_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:validators/validators.dart';

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
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Modular.to.pushReplacementNamed('/login'),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.all(8),
          child: Form(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Observer(
                    builder: (_) => TextField(
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      onChanged: (value) => store.email = value,
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
                  Observer(builder: (_) {
                    return RaisedButton(
                      child: Text(store.primaryButtonText),
                      onPressed: store.canSubmit ? _submit : null,
                    );
                  }),
                  SizedBox(height: 8.0),
                  Observer(builder: (_) {
                    return FlatButton(
                      child: Text(store.secondaryButtonText),
                      onPressed: !store.loading ? _toggleFormType : null,
                    );
                  }),
                ],
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
      if (store.auth.status == AuthStatus.loggedOn) {
        Modular.to.pushReplacementNamed('/home');
      }
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Erro no login',
        exception: e,
      ).show(context);
    }
  }
}
