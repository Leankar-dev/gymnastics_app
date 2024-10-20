import 'package:flutter/material.dart';
import 'package:gymnastics_app/core/ui/widgets/router_screen_widget.dart';

class GymnasticsApp extends StatelessWidget {
  const GymnasticsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gymnastics App - LAS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: ExercisePage(),
      home: const RouterScreenWidget(),
    );
  }
}
