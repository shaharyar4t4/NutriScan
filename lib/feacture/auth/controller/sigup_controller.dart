import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriscan/core/constants/app_colors.dart';
import 'package:nutriscan/feacture/auth/services/auth_services.dart';

class SignUpController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthServices _authServices = AuthServices();

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future<void> handleSignUp(BuildContext context) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final result = await _authServices.register(name, email, password);

    if (result == "success") {
      // ✅ AuthWrapper will redirect automatically
      Get.offAllNamed('/loginScreen');
      Get.snackbar(
        "Sign Up Successfully",
        "Now you can login",
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
