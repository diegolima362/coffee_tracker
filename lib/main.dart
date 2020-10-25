import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:coffee_tracker/app/app_module.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(ModularApp(module: AppModule()));
}
