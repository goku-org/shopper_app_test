import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart' as log;
import 'package:shopper_app/app.dart';
import 'package:shopper_app/config/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Config.firestore.settings = const Settings(persistenceEnabled: true);
  await Hive.initFlutter();
  await Hive.openBox(Config.localDB);

  _setupLogging();
  runApp(const MyApp());
}

void _setupLogging() {
  log.Logger.root.level = log.Level.ALL;
  log.Logger.root.onRecord.listen((rec) {
    debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
