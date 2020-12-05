import 'package:coffee_tracker/app/modules/login/components/sign_in_button.dart';
import 'package:coffee_tracker/app/modules/login/components/social_sign_in_button.dart';
import 'package:coffee_tracker/app/shared/components/alert_widget.dart';
import 'package:coffee_tracker/app/shared/components/platform_exception_alert_dialog.dart';
import 'package:flutter/foundation.dart';
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
      if (!kIsWeb) {
        PlatformExceptionAlertDialog(
          title: 'Erro no login',
          exception: e,
        ).show(context);
      } else {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              AlertWidget(title: 'Erro no login', content: null),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ratio = MediaQuery.of(context).size.aspectRatio;
    final width = MediaQuery.of(context).size.width;
    final buttonColor = Theme.of(context).buttonColor;

    return Scaffold(
      appBar: AppBar(),
      body: Observer(builder: (_) {
        return Center(
          child: Container(
            width: ratio > 1 ? width * .4 : width * .9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Observer(builder: (_) => _buildHeader()),
                const SizedBox(height: 20),
                SocialSignInButton(
                  color: buttonColor,
                  textColor: Color(0xFFE7ECEF),
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
                  color: buttonColor,
                  textColor: Color(0xFFE7ECEF),
                ),
              ],
            ),
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
