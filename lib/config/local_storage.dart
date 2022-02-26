import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopper_app/config/config.dart';

class LocalStorage {
  LocalStorage._();

    static Future<bool> passedOnBoarding() async {
    final Box box = await Hive.openBox(Config.localDB);
    await box.put('onboard', true);
    return true;
  }

  static bool isOnBoarding() {
    final Box box = Hive.box(Config.localDB);
    return box.get('onboard') != null;
  }
}