// lib/controllers/login_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriscan/core/constants/app_colors.dart';
import 'package:nutriscan/feacture/auth/services/auth_services.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthServices _authServices = AuthServices();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> handleLogin(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final result = await _authServices.login(email, password);

    if (result == "success") {
      // ✅ AuthWrapper will redirect automatically
      Get.offAllNamed('/navbar');
      Get.snackbar(
        "Login Successfully",
        "Welcome back!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: bg_up,
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Error',
        result ?? 'Unknown error',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
