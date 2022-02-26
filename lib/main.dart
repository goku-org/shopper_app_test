import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopper_app/app.dart';

void main() async {
  await Firebase.initializeApp();
  runApp(const MyApp());
}
