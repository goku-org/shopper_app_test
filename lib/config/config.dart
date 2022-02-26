import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class Config {
  Config._();

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static final itemCollection = Config.firestore.collection('items');

  static String localDB = kDebugMode ? 'shopper-dev' : 'shopper';
}
