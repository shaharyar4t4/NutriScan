import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriscan/core/constants/app_colors.dart';
import 'package:nutriscan/feacture/splash/controller/splash_controller.dart';

class ViewSplashscreen extends StatelessWidget {
  ViewSplashscreen({super.key});

  final SplashController controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Background gradient
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              bg_up,
              bg_down,
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background image with opacity
            Positioned.fill(
              child: Opacity(
                opacity: 0.8,
                child: Image.asset(
                  'assets/images/bg_image.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // Centered logo
            Center(
              child: Image.asset(
                'assets/images/main_log.png',
                width: 250,
                height: 250,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
