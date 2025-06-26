// lib/controllers/login_controller.dart
import 'package:flutter/material.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void handleRegister(BuildContext context) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Example validation (add actual logic here)
    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter all fields")),
      );
      return;
    }

    // TODO: Add your registration logic here
    print('Email: $email, Password: $password');
  }
}
