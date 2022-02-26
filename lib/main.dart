import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart' as log;
import 'package:shopper_app/app.dart';
import 'package:shopper_app/config/config.dart';
import 'package:shopper_app/repositories/auth_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  await Hive.openBox(Config.localDB);
  _setup();
  _setupLogging();
  runApp(const MyApp());
}

void _setupLogging() {
  log.Logger.root.level = log.Level.ALL;
  log.Logger.root.onRecord.listen((rec) {
    debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

void _setup() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<AuthRepositoryImpl>(AuthRepositoryImpl());
}
