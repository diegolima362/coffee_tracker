import 'package:coffee_tracker/app/shared/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class LandingPage extends StatefulWidget {
  final String title;
  const LandingPage({Key key, this.title = "Landing"}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  ReactionDisposer disposer;

  @override
  void initState() {
    super.initState();
    disposer = autorun((_) {
      final auth = Modular.get<AuthController>();
      if (auth.status == AuthStatus.loggedOn) {
        Modular.to.pushReplacementNamed('/home');
      } else if (auth.status == AuthStatus.loggedOut) {
        Modular.to.pushReplacementNamed('/login');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    disposer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
