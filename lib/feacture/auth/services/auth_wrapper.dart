import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutriscan/feacture/auth/view/view_loginscreen.dart';
import 'package:nutriscan/feacture/barcode/view_home.dart';
import 'package:nutriscan/feacture/splash/controller/splash_controller.dart';
import 'package:nutriscan/feacture/splash/views/view_splashscreen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If user is logged in
        if (snapshot.hasData) {
          return HomeScreen();
        }

        // If user is not logged in
        return ViewSplashscreen();
      },
    );
  }
}
