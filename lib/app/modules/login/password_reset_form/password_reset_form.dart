import 'package:coffee_tracker/app/shared/components/platform_exception_alert_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'reset_form_store.dart';

class PasswordResetForm extends StatefulWidget {
  const PasswordResetForm();

  @override
  _PasswordResetFormState createState() => _PasswordResetFormState();
}

class _PasswordResetFormState extends State<PasswordResetForm> {
  final ResetFormStore store = ResetFormStore();

  final TextEditingController _emailController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    store.setupValidations();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailFocusNode.dispose();
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Modular.to.pushReplacementNamed(
            '/login/email_sign_in',
          ),
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
                      onEditingComplete: _submit,
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
                  SizedBox(height: 16.0),
                  Observer(
                    builder: (_) {
                      return RaisedButton(
                        child: Text('Enviar'),
                        onPressed: store.canSubmit ? _submit : null,
                      );
                    },
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    try {
      if (store.canDissmiss) {
        await _showConfirmDialog();
        await store.submit();
        Modular.to.pushReplacementNamed('/login/email_sign_in');
      }
    } on PlatformException catch (e) {
      if (!kIsWeb) {
        PlatformExceptionAlertDialog(
          title: 'Erro ao enviar e-mail',
          exception: e,
        ).show(context);
      } else {
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text('Erro'),
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
