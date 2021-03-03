import 'package:coffee_tracker/app/shared/components/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'components/sign_in_card.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  final String title;

  const LoginPage({Key key, this.title = "Login"}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginController> {
  @override
  Widget build(BuildContext context) {
    final large = ResponsiveWidget.isLargeScreen(context);

    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      body: Center(
        child: Container(
          height: large ? 600 : double.infinity,
          width: large ? 800 : double.infinity,
          child: Card(
            elevation: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                large ? _image() : SizedBox.shrink(),
                SignInCard(controller: controller),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _image() {
    double w = 400;

    return Stack(
      children: <Widget>[
        Container(
          color: Colors.black12,
          width: w,
          height: double.infinity,
          child: Image.asset(
            'images/sign-up.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: Container(
            color: Colors.black,
            width: w,
          ),
        ),
      ],
    );
  }
}
