import 'package:coffee_tracker/app/modules/login/components/sign_in_button.dart';
import 'package:coffee_tracker/app/modules/login/components/social_sign_in_button.dart';
import 'package:coffee_tracker/app/utils/platform_exception_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  Future<void> _googleSignIn() async {
    try {
      await controller.loginWithGoogle();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        exception: e,
        title: 'Erro ao fazer Login',
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).canvasColor,
      ),
      body: Observer(builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 100,
                child: _buildHeader(),
              ),
              SocialSignInButton(
                onPressed: controller.loading ? null : _googleSignIn,
                text: controller.loading ? 'Entrando' : 'Entrar com Google',
                assetName: 'images/google-logo.png',
              ),
              SizedBox(
                height: 30,
                child: Center(
                  child: Text(
                    'Ou',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SignInButton(
                text: 'Entrar com Email',
                onPressed:
                    controller.loading ? null : controller.loginWithEmail,
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeader() {
    if (controller.loading) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Text(
        'Entrar',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }
}
