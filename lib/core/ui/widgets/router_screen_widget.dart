import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gymnastics_app/src/features/auth/login_register/login_page.dart';
import 'package:gymnastics_app/src/features/home/home_page.dart';

class RouterScreenWidget extends StatelessWidget {
  const RouterScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // se chegar informação usuario logado
          return HomePage(
            user: snapshot.data!,
          );
        } else {
          // se for nullo usuario deslogado
          return const LoginPage();
        }
      },
    );
  }
}
