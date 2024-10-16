import 'package:flutter/material.dart';
import 'package:gymnastics_app/src/features/auth/login_register/login_page.dart';

class GymnasticsApp extends StatelessWidget {
  const GymnasticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: ExercisePage(),
      home: const LoginPage(),
    );
  }
}
