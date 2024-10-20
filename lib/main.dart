import 'package:flutter/material.dart';
import 'package:gymnastics_app/core/services/firebase/firebase_service.dart';
import 'package:gymnastics_app/src/gymnastics_app.dart';

Future<void> main() async {
  await FirebaseService.init();
  runApp(const GymnasticsApp());
}
