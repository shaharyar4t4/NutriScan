// lib/controllers/signup_controller.dart
import 'package:flutter/material.dart';

class SignUpController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void handleSignUp(BuildContext context) {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Example
    print('Name: $name, Email: $email, Password: $password');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Sign Up Successful")),
    );
  }
}
