import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'landing_controller.dart';

class LandingPage extends StatefulWidget {
  final String title;

  const LandingPage({Key key, this.title = "Landing"}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends ModularState<LandingPage, LandingController> {
  //use 'controller' variable to access controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
