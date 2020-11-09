import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app_controller.dart';

class AppWidget extends StatelessWidget {
  final AppController controller;

  const AppWidget({Key key, this.controller}) : super(key: key);

  SystemUiOverlayStyle _getStyle(bool darkMode) {
    return SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: darkMode ? Brightness.light : Brightness.dark,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: _getStyle(true),
        child: MaterialApp(
          navigatorKey: Modular.navigatorKey,
          title: 'Coffee Tracker',
          theme: controller.themeType,
          initialRoute: '/',
          onGenerateRoute: Modular.generateRoute,
        ),
      ),
    );
  }
}
