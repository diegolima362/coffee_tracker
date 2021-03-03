import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_tracker/app/app_module.dart';
import 'package:coffee_tracker/app/shared/repositories/local_storage/hive_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';

const bool USE_FIRE_STORE_EMULATOR = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting("pt_BR", null);

  await Firebase.initializeApp();

  await Hive.initFlutter();

  await HiveStorage.initDatabase();

  if (USE_FIRE_STORE_EMULATOR) {
    String host = defaultTargetPlatform == TargetPlatform.android
        ? '10.0.2.2:8080'
        : 'localhost:8080';
    FirebaseFirestore.instance.settings =
        Settings(host: host, sslEnabled: false, persistenceEnabled: false);
  }

  runApp(ModularApp(module: AppModule()));
}
